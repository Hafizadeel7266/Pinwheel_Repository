import pandas as pd
from sqlalchemy import create_engine, inspect
from dotenv import load_dotenv
import os
import logging
from pathlib import Path
from typing import List, Optional

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def get_redshift_connection():
    """Create and return a Redshift connection engine"""
    load_dotenv()
    conn_string = (
        f"postgresql+psycopg2://"
        f"{os.getenv('REDSHIFT_USER')}:{os.getenv('REDSHIFT_PASSWORD')}@"
        f"{os.getenv('REDSHIFT_HOST')}:{os.getenv('REDSHIFT_PORT')}/"
        f"{os.getenv('REDSHIFT_DB')}"
    )
    return create_engine(conn_string, connect_args={'sslmode': 'prefer'})

def get_all_tables(engine, schema: str) -> List[str]:
    """Get list of all tables in specified schema"""
    inspector = inspect(engine)
    return inspector.get_table_names(schema=schema)

def save_table_to_csv(engine, schema: str, table: str, base_path: str = "data"):
    """Save a single table to CSV in structured directory, creating empty file if table is empty"""
    try:
        # Create directory structure
        table_dir = Path(base_path) / schema / table
        table_dir.mkdir(parents=True, exist_ok=True)
        
        # File path
        csv_path = table_dir / f"{table}.csv"
        
        # Query and save data
        query = f"SELECT * FROM {schema}.{table} limit 10000"  # Test with LIMIT
        df = pd.read_sql(query, engine)
        
        # Get column names even if table is empty
        if len(df) == 0:
            # Get just the column names
            col_query = f"SELECT * FROM {schema}.{table} WHERE 1=0"
            df = pd.read_sql(col_query, engine)
            
        # Write to CSV (will create file with just headers if empty)
        df.to_csv(csv_path, index=False)
        
        if len(df) > 0:
            logger.info(f"✅ Saved {len(df)} rows to {csv_path}")
        else:
            logger.info(f"ℹ️ Created empty file for {schema}.{table} with columns: {list(df.columns)}")
            
        return True
            
    except Exception as e:
        logger.error(f"❌ Error processing {schema}.{table}: {str(e)}")
        return False

def export_schema_tables(schema: str):
    """Export all tables from a schema to CSV files"""
    engine = get_redshift_connection()
    try:
        tables = get_all_tables(engine, schema)
        logger.info(f"📊 Found {len(tables)} tables in schema {schema}")
        
        results = []
        for table in tables:
            success = save_table_to_csv(engine, schema, table)
            results.append((table, success))
            
        # Print summary
        successful = sum(1 for _, success in results if success)
        logger.info(f"\n🎯 Results: {successful}/{len(tables)} tables exported successfully")
        
        return results
    finally:
        engine.dispose()

if __name__ == "__main__":
    # Example usage - replace with your schema name
    schema_name = "typeform_churn"  # Change this to your schema name
    export_schema_tables(schema_name)
# ----------------------------------------------------------------------------------
# if __name__ == "__main__":
#     schemas = [
#         "stripe_fivetran",
#         "amazon_sales",
#         "other_sources",
#         "rds",
#         "fieldx",
#         "chargify",
#         "typeform_churn",
#     ]

#     for schema in schemas:
#         print(f"Exporting tables from schema: {schema}")
#         try:
#             export_schema_tables(schema)
#         except Exception as e:
#             print(f"[ERROR] {schema}: {e}")
