within SMIB.PF_Data.Bus_Data;
record PF_Bus_SMIB_Time_Series_00008
extends SMIB.PF_Data.Bus_Data.Bus_Template(

// Bus: 'B01' (PV bus)
V1 = 1.0000000,
A1 = 0.0779662,

// Bus: 'B02' (slack bus)
V2 = 1.0000000,
A2 = 0.0000000,

// Bus: 'B03' (PQ bus)
V3 = 0.9965319,
A3 = -0.0013107,

// Bus: 'B04' (PQ bus)
V4 = 0.9930656,
A4 = -0.0026305

);
end PF_Bus_SMIB_Time_Series_00008;