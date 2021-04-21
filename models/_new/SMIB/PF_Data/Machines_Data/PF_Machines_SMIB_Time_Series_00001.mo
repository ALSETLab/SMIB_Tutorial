within SMIB.PF_Data.Machines_Data;
record PF_Machines_SMIB_Time_Series_00001
extends SMIB.PF_Data.Machines_Data.Machines_Template(

// MACHINE: '1_1'
// Bus: B01'
PG1 = 1e06*(40.0000000),
QG1 = 1e06*(4.4806316),

// MACHINE: '2_1'
// Bus: B02'
PG2 = 1e06*(-1.3646215),
QG2 = 1e06*(6.1476818)

);
end PF_Machines_SMIB_Time_Series_00001;