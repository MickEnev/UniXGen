#!/bin/bash

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

pyenv install 3.11
pyenv global 3.11

pyenv versions

pip install torch~=2.6.0 'torch_xla[tpu]~=2.6.0' torchvision \
  -f https://storage.googleapis.com/libtpu-releases/index.html \
  -f https://storage.googleapis.com/libtpu-wheels/index.html

echo 'export PJRT_DEVICE=TPU' >> $HOME/.bashrc

# Only lightning v2.5.1 has support for PyTorch 2.6
pip install lightning==2.5.1
