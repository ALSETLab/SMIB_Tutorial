from pf2rec import *

import argparse
import os

MODEL = 'SMIB'

parser = argparse.ArgumentParser()

parser.add_argument("--version", help = "OpenIPSL version for which the model has been created. Defaults to '1.5.0'")

args = parser.parse_args()

if __name__ == '__main__':

    _model = MODEL

    if args.version:
        _version = args.version
        if _version not in ['1.5.0', '2.0.0']:
            raise ValueError("OpenIPSL version could not be identified")
    else:
        _version = '1.5.0'

    if _version == '1.5.0':
        _model_lib = '_old'
    elif _version == '2.0.0':
        _model_lib = '_new'

    # Absolute path to the `.mo` file of the model
    data_path = os.path.abspath(os.path.join(os.getcwd(), "models", _model_lib, _model))

    path_mo_file = os.path.abspath(os.path.join(data_path, f"{_model}_Base_Case.mo"))

    create_pf_records(_model,
                      path_mo_file,
                      data_path,
                     openipsl_version = _version)
