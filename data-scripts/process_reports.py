import glob
import os
from shutil import copyfile

import tqdm
import os

try:
    src_dir = os.environ["DATASET_DIR"]
except:
    src_dir = "/data/mimic-cxr-2.0.0.physionet.org"

reports_txt_dir = os.path.join(src_dir, "files")
dest_txt_dir = os.path.join(src_dir, "reports")

os.makedirs(dest_txt_dir, exist_ok=True)

for src_path in tqdm.tqdm(glob.glob(os.path.join(reports_txt_dir, "p*/p*/s*.txt"))):
    study_id_txt = os.path.basename(src_path)
    dst_path = os.path.join(dest_txt_dir, study_id_txt)
    # print('copying:', src_path, '->', dst_path)
    copyfile(src_path, dst_path)
