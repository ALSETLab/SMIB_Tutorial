from pf2rec import *
import os

__version = '2.0.0'

data_path = os.path.abspath(os.path.join(os.getcwd(), "SMIB"))
path_mo_file = os.path.abspath(os.path.join(data_path, "SMIB_Base_Case.mo"))

create_pf_records("SMIB",
                 path_mo_file,
                 data_path,
                 openipsl_version = __version)
