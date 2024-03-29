from pf2rec import *

import numpy as np
import pandas as pd

from GridCal.Engine import *
from GridCal.Engine.IO.file_handler import FileOpen
from GridCal.Engine.Devices.shunt import Shunt
from GridCal.Engine.Simulations.PowerFlow.time_series_driver import TimeSeries
from GridCal.Engine.Simulations.PowerFlow.power_flow_driver import PowerFlowDriver

import argparse
import os

parser = argparse.ArgumentParser()

parser.add_argument("--model", help = "Name of the package containing the target OpenIPSL model. Defaults to `SMIB`")
parser.add_argument("--version", help = "OpenIPSL version for which the model has been created. Defaults to `1.5.0`")

args = parser.parse_args()

if __name__ == '__main__':

    if args.model:
        _model = args.model
    else:
        _model = 'SMIB'

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

    # Absolute path to the data directory of the model
    data_path = os.path.abspath(os.path.join(os.getcwd(), "models", _model_lib, _model))

    grid = None

    # Grid model in GridCal
    file_handler = FileOpen(os.path.abspath(os.path.join(data_path,
                                                         "PSSE_Files",
                                                         f"{_model}_Base_Case.raw")))

    # Creating grid object
    grid = file_handler.open()

    # Power flow options
    options = PowerFlowOptions(SolverType.NR,
                               verbose = True,
                               initialize_with_existing_solution = False,
                               multi_core = False,
                               tolerance = 1e-12,
                              max_iter = 99,
                              control_q = ReactivePowerControlMode.Direct)

    pf = PowerFlowDriver(grid, options)

    pf.run()

    gridcal2rec(grid = grid, pf = pf, model_name = _model,
        data_path = data_path,
        pf_num = 0, export_pf_results = False,
        is_time_series = False, openipsl_version = _version)
