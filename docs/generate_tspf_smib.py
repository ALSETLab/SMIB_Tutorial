from pf2rec import *
from GridCal.Engine import *

import pandas as pd

_version = '2.0.0'
data_path = os.path.abspath(os.path.join(os.getcwd(), "SMIB"))

# Loading time series power flow input
load_p = pd.read_csv('hourly_basis/N.Y.C._03232020.csv')
load_q = pd.read_csv('hourly_basis/CAPITL_03232020.csv')
_time_stamps = len(load_p['Unnamed: 0'].values)
_p_load_values = load_p['0'].values/max(load_p['0'].values)
_q_load_values = load_q['0'].values/max(load_q['0'].values)

grid = None

# Grid model in GridCal
file_handler = FileOpen(os.path.abspath(os.path.join(data_path,
                                                     "PSSE_Files",
                                                     "SMIB_Base_Case.raw")))

# Creating grid object
grid = file_handler.open()
grid.format_profiles(range(_time_stamps))

for load in grid.get_loads():
    load.P_prof = load.P * _p_load_values
    load.Q_prof = load.Q * _q_load_values
    print("P_prof: ", load.P_prof)
    print("Q_prof: ", load.Q_prof)
    break

# Power flow options
options = PowerFlowOptions(SolverType.NR,
                           verbose = True,
                           initialize_with_existing_solution = False,
                           multi_core = False,
                           tolerance = 1e-12,
                          max_iter = 99,
                          control_q = ReactivePowerControlMode.Direct)

pf = PowerFlowDriver(grid, options)

for n_ts, _ in enumerate(grid.time_profile):

    # Changing load set point
    for load in grid.get_loads():
        load.P = load.P_prof[n_ts]
        load.Q = load.Q_prof[n_ts]

    pf.run()

    gridcal2rec(grid = grid, pf = pf, model_name = 'SMIB',
                data_path = data_path,
                pf_num = n_ts + 1, export_pf_results = False,
                is_time_series = True, ts_name = 'SMIB_Time_Series',
                openipsl_version = '2.0.0')
