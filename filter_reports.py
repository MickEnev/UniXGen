import glob
import os
from shutil import copyfile

import tqdm

reports_txt_dir = "/ssd/mimic-cxr-2.0.0.physionet.org/files"
dest_txt_dir = "/ssd/mimic-cxr-2.0.0.physionet.org/reports"

os.makedirs(dest_txt_dir, exist_ok=True)

for src_path in tqdm.tqdm(glob.glob(os.path.join(reports_txt_dir, "p*/p*/s*.txt"))):
    study_id_txt = os.path.basename(src_path)
    dst_path = os.path.join(dest_txt_dir, study_id_txt)
    # print('copying:', src_path, '->', dst_path)
    copyfile(src_path, dst_path)
