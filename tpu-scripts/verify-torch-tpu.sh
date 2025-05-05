#!/bin/bash

"$HOME/.pyenv/bin/pyenv" versions

export PJRT_DEVICE="TPU"

/home/swghosh/.pyenv/shims/python3 -c "import torch_xla.core.xla_model as xm; print(xm.get_xla_supported_devices(\"TPU\"))"

/home/swghosh/.pyenv/shims/python3 - << EOF 
import torch
import torch_xla.core.xla_model as xm

dev = xm.xla_device()
t1 = torch.randn(3,3,device=dev)
t2 = torch.randn(3,3,device=dev)
print(t1 + t2)
EOF
