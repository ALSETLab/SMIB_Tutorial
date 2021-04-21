within SMIB.PF_Data.Bus_Data;
record PF_Bus_SMIB_Time_Series_00004
extends SMIB.PF_Data.Bus_Data.Bus_Template(

// Bus: 'B01' (PV bus)
V1 = 1.0000000,
A1 = 0.0847221,

// Bus: 'B02' (slack bus)
V2 = 1.0000000,
A2 = 0.0000000,

// Bus: 'B03' (PQ bus)
V3 = 0.9970237,
A3 = 0.0020940,

// Bus: 'B04' (PQ bus)
V4 = 0.9940518,
A4 = 0.0042005

);
end PF_Bus_SMIB_Time_Series_00004;