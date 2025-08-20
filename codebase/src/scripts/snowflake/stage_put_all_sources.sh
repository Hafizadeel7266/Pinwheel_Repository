#!/usr/bin/env bash
set -euo pipefail
shopt -s globstar  # enables ** recursive globs in bash

# --- CONFIG ---
CONN="my_example_connection"
DATA_DIR="C:/Users/Administrator/OneDrive/Pinwheel_DB_Repository/Code/data"

# source path  ->  fully-qualified stage
declare -A JOBS=(
#   ["${DATA_DIR}/amazon_sales/**/*.csv"]="@DEV.AMAZON_SALES.AMAZON_SALES_STAGE"
#   ["${DATA_DIR}/chargify/**/*.csv"]="@DEV.CHARGIFY.CHARGIFY_STAGE"
#   ["${DATA_DIR}/fieldx/**/*.csv"]="@DEV.FIELDX.FIELDX_STAGE"
#   ["${DATA_DIR}/other_sources/**/*.csv"]="@DEV.OTHER_SOURCES.OTHER_SOURCES_STAGE"
#   ["${DATA_DIR}/rds/**/*.csv"]="@DEV.RDS.RDS_STAGE"
#   ["${DATA_DIR}/stripe_fivetran/**/*.csv"]="@DEV.STRIPE_FIVETRAN.STRIPE_FIVETRAN_STAGE"
  ["${DATA_DIR}/typeform_churn/**/*.csv"]="@DEV.TYPEFORM_CHURN.TYPEFORM_CHURN_STAGE"
)

# --- RUN ---
for pattern in "${!JOBS[@]}"; do
  stage="${JOBS[$pattern]}"
  echo "Uploading: ${pattern}  ->  ${stage}"
  snowsql -c "$CONN" -q \
    "PUT file://${pattern//\\//\/} ${stage} AUTO_COMPRESS=TRUE;"
done

echo "✅ All PUT jobs completed."
