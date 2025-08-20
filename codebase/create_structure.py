import os
from pathlib import Path

# Define the folder structure
structure = {
    "snowflake_dev_project": {
        "sql": {
            "00_setup": [
                "01_warehouse_setup.sql",
                "02_database_setup.sql",
                "03_roles_permissions.sql"
            ],
            "01_schemas": [
                "01_typeform_churn_schema.sql",
                "02_rds_schema.sql",
                "03_fieldx_schema.sql",
                "04_chargify_schema.sql",
                "05_amazon_sales_schema.sql",
                "06_stripe_fivetran_schema.sql",
                "07_other_sources_schema.sql",
                "08_monitoring_schema.sql"
            ],
            "02_tables": [
                "monitoring_tables.sql",
                "README.md"
            ],
            "03_procedures": [
                "list_stage_files_proc.sql",
                "load_csv_from_stage_proc.sql",
                "utility_procedures.sql"
            ],
            "04_file_formats": [
                "csv_formats.sql",
                "json_formats.sql",
                "other_formats.sql"
            ],
            "05_stages": [
                "internal_stages.sql"
            ],
            "06_utilities": [
                "verification_queries.sql",
                "data_quality_checks.sql"
            ],
            "snowflake_dev_database_setup.sql": None
        },
        "scripts": {
            "python": [
                "redshift_exporter.py",
                "snowflake_loader.py",
                "requirements.txt"
            ],
            "bash": [
                "upload_to_stage.sh",
                "run_setup.sh"
            ]
        },
        "config": [
            ".env.example",
            "snowflake_config.json",
            "connection_config.yml"
        ],
        "data": {
            "exports": {
                "typeform_churn": [],
                "rds": [],
                "fieldx": [],
                "chargify": [],
                "amazon_sales": [],
                "stripe_fivetran": [],
                "other_sources": []
            },
            "staging": []
        },
        "docs": [
            "README.md",
            "SETUP_GUIDE.md",
            "DATA_DICTIONARY.md",
            "LOADING_PROCEDURES.md"
        ],
        "tests": [
            "test_connections.sql",
            "test_data_loads.sql",
            "validate_schemas.sql"
        ],
        ".gitignore": None,
        "README.md": None,
        "Makefile": None
    }
}

def create_structure(base_path, structure):
    for name, content in structure.items():
        current_path = Path(base_path) / name
        
        if isinstance(content, dict):
            # Create directory and recurse
            current_path.mkdir(parents=True, exist_ok=True)
            create_structure(current_path, content)
        elif isinstance(content, list):
            # Create directory and files
            current_path.mkdir(parents=True, exist_ok=True)
            for item in content:
                if isinstance(item, str):
                    (current_path / item).touch()
                elif isinstance(item, dict):
                    create_structure(current_path, item)
        elif content is None:
            # Create file
            current_path.touch()

# Create the structure in the current directory
create_structure(".", structure)

print("Folder structure created successfully!")