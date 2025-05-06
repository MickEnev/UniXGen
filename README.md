# ViewXGen Unified Transformer Model on Cloud TPUs

View-Specific Chest X-ray Generation model training and inference on Cloud TPU v4.

This repo contains our work of reproducing some parts of the published work "Vision-Language Generative Model for View-Specific Chest X-ray Generation".

```
Lee, H., Lee, D. Y., Kim, W., Kim, J. H., Kim, T., Kim, J., Sunwoo, L., & Choi, E. (2024).

Vision-Language Generative Model for View-Specific Chest X-ray Generation.

Proceedings of Machine Learning Research, 248, 280-296.
```

[arXiv](https://arxiv.org/abs/2302.12172) | [Scopus](https://www.scopus.com/record/display.uri?eid=2-s2.0-85203836270&origin=inward&txGid=05d022ccd2c395a6353770faec614bba)

<br>

<img width="1626" alt="nbme_architecture" src="https://user-images.githubusercontent.com/123858584/226160635-ff47d23a-e35f-45ec-aeb0-06a823f50e5d.png">

<br>

Implementation of the paper have been done using PyTorch (v2.6) XLA (torch-xla 2.6) using [Lightning](https://github.com/Lightning-AI/pytorch-lightning) (v2.5.1) Trainer. The hardware requirements were supported by the [TPU Research Cloud (TRC)](https://www.tensorflow.org/tfrc) program which provides [Google Cloud TPUs](https://cloud.google.com/tpu/), used as accelerators for the transformer models (opposed to the NVIDIA CUDA GPUs used in the original published work).

Steps to reproduce model training on TPU:

1. Run [create-n-setup-tpu-vm.sh](./create-n-setup-tpu-vm.sh) script
2. Run unified_main.py

