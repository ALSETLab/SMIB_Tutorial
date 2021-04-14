SMIB Tutorial: OpenIPSL Model Assembly and Power Flow Integration with GridCal
===================================

**Authors:** Sergio A. Dorado-Rojas (sergio.dorado.rojas@gmail.com), Giuseppe Laera, Marcelo de Castro Fernandes and Luigi Vanfretti (luigi.vanfretti@gmail.com)

**Accompanying Material:**

- The slides of our tutorial can be found [here](https://docs.google.com/presentation/d/1EKeKHnyoLQeC1HwLtGGRk25ST2qX4dB5cxsqEz3dwW0/edit?usp=sharing).
- A detailed step-by-step guideline for setting up the Single Machine Infinite Bus (SMIB) model can be checked [here](https://docs.google.com/document/d/1uB3e-KXT6zUqG7W-FEdlMiI31R2jPnAmmRVvjmAHoT8/edit?usp=sharing).

``` (add as citation)
This work has been submitted to the International Modelica Conference 2021
```

### Part 1: GridCal Installation inside a Miniconda Environment

### Part 2: OpenIPSL Model Assembly

### Part 3: Power Flow Records Creation and Integration

(embed video)

### Part 4: Power Flow Generation and Testing


The code for the base case power flow generation is shown below:

```python
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
```

The code for the time series power flow example is provided below:

```python
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
```
