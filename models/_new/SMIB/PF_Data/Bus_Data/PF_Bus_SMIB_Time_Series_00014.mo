within SMIB.PF_Data.Bus_Data;
record PF_Bus_SMIB_Time_Series_00014
extends SMIB.PF_Data.Bus_Data.Bus_Template(

// Bus: 'B01' (PV bus)
V1 = 1.0000000,
A1 = 0.0708763,

// Bus: 'B02' (slack bus)
V2 = 1.0000000,
A2 = 0.0000000,

// Bus: 'B03' (PQ bus)
V3 = 0.9960944,
A3 = -0.0048736,

// Bus: 'B04' (PQ bus)
V4 = 0.9922126,
A4 = -0.0097855

);
end PF_Bus_SMIB_Time_Series_00014;