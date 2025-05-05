#!/bin/bash

set -eou pipefail

TPU_NAME="tpu-vm-v-four-eight"
TPU_ZONE="us-central2-b"
TOPOLOGY="2x2x1" # 2x2x4 # 2x2x1

# a spot (pre-emptible)  TPU in case on-demand is already full on capacity for the zone
gcloud compute tpus tpu-vm create "${TPU_NAME}" --zone="${TPU_ZONE}" --version=tpu-vm-v4-pt-2.0 --topology="${TOPOLOGY}" --type v4 # --spot

# copy all scripts in the tpu-scripts/ dir
gcloud compute tpus tpu-vm scp --recurse --worker=all --zone="${TPU_ZONE}" './tpu-scripts/*.sh' swghosh@"${TPU_NAME}":~/

gcloud compute tpus tpu-vm ssh "${TPU_NAME}" --worker=all --zone="${TPU_ZONE}" --command="bash tpu-scripts/install-pyenv.sh"
gcloud compute tpus tpu-vm ssh "${TPU_NAME}" --worker=all --zone="${TPU_ZONE}" --command="bash tpu-scripts/install-torch.sh"
gcloud compute tpus tpu-vm ssh "${TPU_NAME}" --worker=all --zone="${TPU_ZONE}" --command="bash tpu-scripts/install-unixgen-deps.sh"

# sanity check, if pytorch can use XLA TPU!
gcloud compute tpus tpu-vm ssh "${TPU_NAME}" --worker=all --zone="${TPU_ZONE}" --command="bash tpu-scripts/verify-torch-tpu.sh"
