from pf2rec import *
import os

from GridCal.Engine import *

_version = '2.0.0'

# Absolute path to the folder containing the model information
data_path = os.path.abspath(os.path.join(os.getcwd(), "SMIB"))

grid = None

# Grid model in GridCal
file_handler = FileOpen(os.path.abspath(os.path.join(data_path,
                                                     "PSSE_Files",
                                                     "SMIB_Base_Case.raw")))

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

gridcal2rec(grid = grid, pf = pf, model_name = 'SMIB',
    data_path = data_path,
    pf_num = 0, export_pf_results = False,
    is_time_series = False, openipsl_version = _version)
