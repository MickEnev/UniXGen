#!/bin/bash

set -eou pipefail

TPU_NAME="tpu-vm-v-four-eight"
TPU_ZONE="us-central2-b"
TOPOLOGY="2x2x1" # 2x2x4 # 2x2x1

GCP_PROJECT_ID="<project-id>"

# a spot (pre-emptible)  TPU in case on-demand is already full on capacity for the zone
# using `until` because TPUs are often out of capacity when retrying for a while helps!
until gcloud compute tpus tpu-vm create "${TPU_NAME}" --zone="${TPU_ZONE}" --version=tpu-vm-v4-pt-2.0 --topology="${TOPOLOGY}" --type v4; do echo; done # --spot

# # copy all scripts in the tpu-scripts/ dir
gcloud compute tpus tpu-vm scp --recurse --worker=all --zone="${TPU_ZONE}" './tpu-scripts/' swghosh@"${TPU_NAME}":~/

gcloud compute tpus tpu-vm ssh "${TPU_NAME}" --worker=all --zone="${TPU_ZONE}" --command="bash tpu-scripts/install-pyenv.sh"
gcloud compute tpus tpu-vm ssh "${TPU_NAME}" --worker=all --zone="${TPU_ZONE}" --command="bash tpu-scripts/install-torch.sh"
gcloud compute tpus tpu-vm ssh "${TPU_NAME}" --worker=all --zone="${TPU_ZONE}" --command="bash tpu-scripts/install-unixgen-deps.sh"

# # sanity check, if pytorch can use XLA TPU!
gcloud compute tpus tpu-vm ssh "${TPU_NAME}" --worker=all --zone="${TPU_ZONE}" --command="bash tpu-scripts/verify-torch-tpu.sh"

# SSD_NAME="${TPU_NAME}-pd-ssd"

# # create a 500GB/1TB disk for storing the dataset,
# # and attach to TPU
gcloud compute disks create "${SSD_NAME}" --size=1TB --type=pd-ssd --zone="${TPU_ZONE}"
gcloud compute tpus tpu-vm update --attach-disk source="projects/${GCP_PROJECT_ID}/zones/us-central2-b/disks/${SSD_NAME}",mode=read-write "${TPU_NAME}"

# make sure to ssh into the VM, init the disk and mount it to an empty directory
# before data-scripts/ can use it.
gcloud compute tpus tpu-vm scp --recurse --worker=all --zone="${TPU_ZONE}" './data-scripts/' swghosh@"${TPU_NAME}":~/
