within SMIB;
model SMIB_Base_Case
  Generation_Units.Gen01 gen01_1(
    P_0=pf.powerflow.machines.PG1,
    Q_0=pf.powerflow.machines.QG1,
    v_0=pf.powerflow.bus.V1,
    angle_0=pf.powerflow.bus.A1, displayPF=true)
    annotation (Placement(transformation(extent={{-94,-10},{-74,10}})));
  Generation_Units.Gen02 gen02_1(
    P_0=pf.powerflow.machines.PG2,
    Q_0=pf.powerflow.machines.QG2,
    v_0=pf.powerflow.bus.V2,
    angle_0=pf.powerflow.bus.A2, displayPF=true) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={86,0})));
  OpenIPSL.Electrical.Buses.Bus B01(
    v_0=pf.powerflow.bus.V1,
    angle_0=pf.powerflow.bus.A1,    displayPF=true)
    annotation (Placement(transformation(extent={{-66,-10},{-46,10}})));
  OpenIPSL.Electrical.Buses.Bus B03(
    v_0=pf.powerflow.bus.V3,
    angle_0=pf.powerflow.bus.A3,    displayPF=true)
    annotation (Placement(transformation(extent={{-32,-10},{-12,10}})));
  OpenIPSL.Electrical.Buses.Bus B02(
    v_0=pf.powerflow.bus.V2,
    angle_0=pf.powerflow.bus.A2,    displayPF=true)
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  OpenIPSL.Electrical.Buses.Bus B04(
    v_0=pf.powerflow.bus.V4,
    angle_0=pf.powerflow.bus.A4,    displayPF=true)
    annotation (Placement(transformation(extent={{8,-40},{28,-20}})));
  OpenIPSL.Electrical.Branches.PwLine line_01(
    R=0.0010,
    X=0.2000,
    G=0.0000,
    B=0.0000)
    annotation (Placement(transformation(extent={{-48,-10},{-28,10}})));
  OpenIPSL.Electrical.Branches.PwLine line_02(
    R=0.0100,
    X=0.2000,
    G=0.0000,
    B=0.0000) annotation (Placement(transformation(extent={{6,18},{26,38}})));
  OpenIPSL.Electrical.Branches.PwLine line_03(
    R=0.0005,
    X=0.1000,
    G=0.0000,
    B=0.0000)
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  OpenIPSL.Electrical.Branches.PwLine line_04(
    R=0.0005,
    X=0.1000,
    G=0.0000,
    B=0.0000) annotation (Placement(transformation(extent={{26,-40},{46,-20}})));
  OpenIPSL.Electrical.Loads.PSSE.Load load(
    P_0=pf.powerflow.loads.PL1,
    Q_0=pf.powerflow.loads.QL1,
    v_0=pf.powerflow.bus.V3,
    angle_0=pf.powerflow.bus.A3)
    annotation (Placement(transformation(extent={{-26,-62},{-6,-42}})));
  OpenIPSL.Electrical.Events.PwFault pwFault(
    R=0.01,
    X=0.1,
    t1=1,
    t2=1.1) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={30,-60})));
  inner OpenIPSL.Electrical.SystemBase SysData
    annotation (Placement(transformation(extent={{-90,70},{-20,94}})));
  PF_Data.Power_Flow pf(redeclare record PowerFlow = PF_Data.PF_00000)
    annotation (Placement(transformation(extent={{-70,42},{-50,62}})));
equation
  connect(gen01_1.pwPin, B01.p)
    annotation (Line(points={{-73,0},{-56,0}}, color={0,0,255}));
  connect(line_01.p, B01.p)
    annotation (Line(points={{-47,0},{-56,0}}, color={0,0,255}));
  connect(line_01.n, B03.p)
    annotation (Line(points={{-29,0},{-22,0}}, color={0,0,255}));
  connect(line_02.p, B03.p) annotation (Line(points={{7,28},{-16,28},{-16,0},{
          -22,0}}, color={0,0,255}));
  connect(line_02.n, B02.p)
    annotation (Line(points={{25,28},{48,28},{48,0},{60,0}}, color={0,0,255}));
  connect(line_03.p, B03.p) annotation (Line(points={{-9,-30},{-16,-30},{-16,0},
          {-22,0}}, color={0,0,255}));
  connect(line_03.n, B04.p)
    annotation (Line(points={{9,-30},{18,-30}}, color={0,0,255}));
  connect(line_04.p, B04.p)
    annotation (Line(points={{27,-30},{18,-30}}, color={0,0,255}));
  connect(line_04.n, B02.p) annotation (Line(points={{45,-30},{48,-30},{48,0},{
          60,0}}, color={0,0,255}));
  connect(load.p, B03.p)
    annotation (Line(points={{-16,-42},{-16,0},{-22,0}}, color={0,0,255}));
  connect(pwFault.p, B04.p) annotation (Line(points={{30,-53},{30,-42},{22,-42},
          {22,-30},{18,-30}}, color={0,0,255}));
  connect(gen02_1.pwPin, B02.p)
    annotation (Line(points={{75,0},{60,0}}, color={0,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SMIB_Base_Case;
