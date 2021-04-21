within SMIB.Generation_Units;
model Gen01
  extends OpenIPSL.Interfaces.Generator;
  OpenIPSL.Electrical.Machines.PSSE.GENROE gENROE(
    P_0=P_0,
    Q_0=Q_0,
    v_0=v_0,
    angle_0=angle_0,
    M_b=100000000,
    Tpd0=5.0000,
    Tppd0=0.0700,
    Tppq0=0.0900,
    H=4.2800,
    D=0.0000,
    Xd=1.8400,
    Xq=1.7500,
    Xpd=0.4100,
    Xppd=0.2000,
    Xppq=0.2000,
    Xl=0.1200,
    S10=0.1100,
    S12=0.3900,
    R_a=0.0000,
    Xpq=0.6000,
    Tpq0=0.9000)
    annotation (Placement(transformation(extent={{-54,-42},{56,42}})));
equation
  connect(gENROE.p, pwPin)
    annotation (Line(points={{56,0},{110,0}}, color={0,0,255}));
  connect(gENROE.PMECH0, gENROE.PMECH) annotation (Line(points={{61.5,21},{80,
          21},{80,74},{-92,74},{-92,21},{-65,21}}, color={0,0,127}));
  connect(gENROE.EFD0, gENROE.EFD) annotation (Line(points={{61.5,-21},{80,-21},
          {80,-76},{-90,-76},{-90,-21},{-65,-21}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Gen01;
