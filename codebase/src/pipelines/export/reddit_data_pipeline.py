import pandas as pd
from sqlalchemy import create_engine
from dotenv import load_dotenv
import os
import logging
from typing import Optional  # <-- Add this import

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def load_redshift_data() -> Optional[pd.DataFrame]:
    """
    Extract data from the stripe_fivetran.account table in Redshift
    """
    try:
        # Load environment variables
        load_dotenv()
        
        # Construct connection string using standard PostgreSQL dialect
        conn_string = (
            f"postgresql+psycopg2://"
            f"{os.getenv('REDSHIFT_USER')}:{os.getenv('REDSHIFT_PASSWORD')}@"
            f"{os.getenv('REDSHIFT_HOST')}:{os.getenv('REDSHIFT_PORT')}/"
            f"dev"  # Using the dev database as shown in your image
        )

        # Create engine with connection timeout
        engine = create_engine(conn_string, connect_args={
            'sslmode': 'prefer',
            'connect_timeout': 10
        })
        
        # Query the specific table shown in your image
        query = "SELECT * FROM stripe_fivetran.account"
        
        logger.info(f"Executing query: {query}")
        with engine.connect() as conn:
            df = pd.read_sql(query, conn)
        
        logger.info(f"Successfully loaded {len(df)} rows")
        return df

    except Exception as e:
        logger.error(f"Database error: {str(e)}", exc_info=True)
        return None

if __name__ == "__main__":
    # Load data from the correct table
    df = load_redshift_data()
    
    if df is not None:
        print("\nFirst 5 rows of stripe_fivetran.account:")
        print(df.head())
        
        # Optionally save to CSV
        df.to_csv('stripe_account_data/stripe_account_data.csv', index=False)
        print("\nData saved to stripe_account_data.csv")