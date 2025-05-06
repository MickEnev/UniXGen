# Notes

Adhering to https://www.cs.mcgill.ca/~ksinha4/practices_for_reproducibility/:

- Config Management: omegaconf, python's argparse
- Checkpoint Management: PyTorch Lightning
- Logging: Tensorboard (WanDB dint work although was originally present)
- Seed: set to 42 across pytorch, python and numpy
- Experiment Management:  PyTorch Lightning
- Versioning: GitHub
- Data Management: None (we used Google Cloud Storage bucket from Physionet and downloaded the dataset to a SSD disk on the VM)
- Data analysis:	Jupyter Notebook (for experimentation)
- Reporting: Matplotlib (used as a visualization library)
- Dependency Management:	pip
- Open Source Release: None
- Test and Validate: GCP (VMs and Cloud TPU accelerators used)
