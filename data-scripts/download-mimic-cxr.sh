#!/bin/bash

DATASET_DIR="/data"

mkdir -p "${DATASET_DIR}"

gsutil -m cp -r gs://mimic-cxr-jpg-2.0.0.physionet.org "${DATASET_DIR}"/

mkdir -p "${DATASET_DIR}"/mimic-cxr-2.0.0.physionet.org
gsutil -m cp -r gs://mimic-cxr-2.0.0.physionet.org/mimic-cxr-reports.zip "${DATASET_DIR}"/mimic-cxr-2.0.0.physionet.org/

unzip -d "${DATASET_DIR}"/mimic-cxr-2.0.0.physionet.org/ "${DATASET_DIR}"/mimic-cxr-2.0.0.physionet.org/mimic-cxr-reports.zip

python3 process_reports.py
