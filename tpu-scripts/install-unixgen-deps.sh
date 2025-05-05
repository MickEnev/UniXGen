#!/bin/bash

cat << EOF > requirements.txt
tqdm
matplotlib
nltk
tokenizers
numpy
Pillow
scipy
torchxrayvision
scikit-image
albumentations
einops
omegaconf
axial-positional-embedding
torchvision
EOF

# makes sure we stick to the right version of torch and xla
pip install torch~=2.6.0 'torch_xla[tpu]~=2.6.0'  \
  -f https://storage.googleapis.com/libtpu-releases/index.html \
  -f https://storage.googleapis.com/libtpu-wheels/index.html \
  -r requirements.txt

# patch the code to avoid ModuleNotFound: torch._six
# also, avoids import issue for torch distribute rank_zero
git clone --branch master http://github.com/swghosh/taming-transformers.git
pip install -e ./taming-transformers
