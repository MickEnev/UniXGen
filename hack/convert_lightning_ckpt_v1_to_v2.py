# This often happens in Lightning version >= 1.6,
# where the checkpoint loading process tries to migrate
# or process trainer states (not just model weights) 
# and expects those keys to be present.

# We're training on PyTorch Lightning 2.0, authors used 1.x

import torch

# Load your PyTorch checkpoint
ckpt = torch.load("unixgen.ckpt", map_location="cpu")

# Wrap it in Lightning format
lightning_ckpt = {
    "state_dict": ckpt, 
    "epoch": 0,
    "global_step": 0,
    "pytorch-lightning_version": "2.0.0",
}

torch.save(lightning_ckpt, "patched_lightning_ckpt.ckpt")
