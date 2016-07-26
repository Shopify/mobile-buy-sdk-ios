#!/bin/bash

mogenerator="${PROJECT_DIR}/../Scripts/mogenerator"

MODEL_PATH="${PROJECT_DIR}/Mobile Buy SDK/Models/Mobile Buy SDK.xcdatamodeld"
CLASS_PATH="${PROJECT_DIR}/Mobile Buy SDK/Models"

PERSISTENT_PATH="${CLASS_PATH}/Persistent"
TRANSIENT_PATH="${CLASS_PATH}/Transient"

mkdir "${PERSISTENT_PATH}" 2>/dev/null
mkdir "${TRANSIENT_PATH}" 2>/dev/null

# Generate persistent classes
"${mogenerator}" --v2 --model "${MODEL_PATH}" --output-dir "${PERSISTENT_PATH}" --base-class BUYCachedObject --configuration persistent --template-path "Templates/Persistent"

# Generate transient classes
"${mogenerator}" --v2 --model "${MODEL_PATH}" --output-dir "${TRANSIENT_PATH}" --base-class BUYObject --configuration transient --template-path "Templates/Transient"
