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
transformers
git+https://github.com/swghosh/taming-transformers.git@master
EOF

# makes sure we stick to the right version of torch and xla
pip install torch~=2.6.0 'torch_xla[tpu]~=2.6.0' lightning==2.5.1 \
  -f https://storage.googleapis.com/libtpu-releases/index.html \
  -f https://storage.googleapis.com/libtpu-wheels/index.html \
  -r requirements.txt
