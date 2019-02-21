within IDEAS.Fluid.HeatExchangers.FanCoilUnits.BaseClasses;
model CooCoil "Cooling coil taking into account condensation"

  replaceable package MediumAir = IDEAS.Media.Air
    "Air medium";
  replaceable package MediumWater = IDEAS.Media.Water
    "Water medium";

  parameter Real r_nominal
    "Ratio between air-side and water-side convective heat transfer (hA-value) at nominal condition" annotation (Dialog(group="Nominal conditions"));
  parameter Modelica.SIunits.MassFlowRate mAir_flow_nominal
    "Nominal mass flow rate" annotation (Dialog(group="Nominal conditions"));
  parameter Modelica.SIunits.MassFlowRate mWat_flow_nominal
    "Nominal mass flow rate" annotation (Dialog(group="Nominal conditions"));
  parameter Modelica.SIunits.PressureDifference dpAir_nominal=100000 "Pressure difference" annotation (Dialog(group="Nominal conditions"));
  parameter Modelica.SIunits.PressureDifference dpWat_nominal=dpWat_nominal
    "Pressure difference" annotation (Dialog(group="Nominal conditions"));
  parameter Boolean use_Q_flow_nominal
    "Set to true to specify Q_flow_nominal and temperatures, or to false to specify effectiveness" annotation (Dialog(group="Nominal thermal performance"));
  parameter Modelica.SIunits.HeatFlowRate Q_flow_nominal
    "Nominal heat transfer" annotation (Dialog(group="Nominal thermal performance"));
  parameter Modelica.SIunits.Temperature T_a1_nominal
    "Nominal temperature at port a1" annotation (Dialog(group="Nominal thermal performance"));
  parameter Modelica.SIunits.Temperature T_a2_nominal
    "Nominal temperature at port a2" annotation (Dialog(group="Nominal thermal performance"));
  parameter Real eps_nominal "Nominal heat transfer effectiveness" annotation (Dialog(group="Nominal thermal performance"), enable=not use_Q_flow_nominal);
  parameter Boolean allowFlowReversal1=false
    "= false to simplify equations, assuming, but not enforcing, no flow reversal for medium 1";
  parameter Boolean allowFlowReversal2=false
    "= false to simplify equations, assuming, but not enforcing, no flow reversal for medium 2";

  Modelica.Fluid.Interfaces.FluidPort_a port_a1(
    redeclare package Medium = MediumAir)
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(
    redeclare package Medium = MediumAir)
    "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{110,50},{90,70}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a2(
    redeclare package Medium = MediumWater)
    "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b2(
    redeclare package Medium = MediumWater)
    "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{-90,-70},{-110,-50}})));
  IDEAS.Fluid.Sources.Boundary_pT bouAir(
    nPorts=1,
    redeclare package Medium = MediumAir)
    "Air sink" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={60,30})));
  IDEAS.Fluid.Sources.Boundary_pT bouWat(
    redeclare package Medium = MediumWater,
    nPorts=1)
    "Water sink"     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,-30})));
  IDEAS.Fluid.BaseClasses.MassFlowRateMultiplier waterMultiplier(
    k=2,
    redeclare package Medium = MediumWater)
    "Water multiplier, used to distribute the same actual flow between each heat exchanger"
    annotation (Placement(transformation(extent={{80,-70},{60,-50}})));
  IDEAS.Fluid.BaseClasses.MassFlowRateMultiplier airMultiplier(
    k=2,
    redeclare package Medium = MediumAir)
    "Air multiplier, used to distribute the same actual flow between each heat exchanger"
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  IDEAS.Fluid.HeatExchangers.WetCoilEffectivenessNTU wcond(
    configuration=IDEAS.Fluid.Types.HeatExchangerConfiguration.CrossFlowUnmixed,
    m1_flow_nominal=mAir_flow_nominal,
    m2_flow_nominal=mWat_flow_nominal,
    dp2_nominal=dpWat_nominal,
    use_Q_flow_nominal=use_Q_flow_nominal,
    Q_flow_nominal=Q_flow_nominal,
    T_a1_nominal=T_a1_nominal,
    T_a2_nominal=T_a2_nominal,
    show_T=true,
    dp1_nominal=dpAir_nominal,
    eps_nominal=eps_nominal,
    r_nominal=r_nominal,
    allowFlowReversal1=allowFlowReversal1,
    allowFlowReversal2=allowFlowReversal2,
    redeclare package Medium1 = MediumAir,
    redeclare package Medium2 = MediumWater)
    "Cooling coil taking into account condensation"
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));

  IDEAS.Fluid.HeatExchangers.WetCoilEffectivenessNTU wocond(
    configuration=IDEAS.Fluid.Types.HeatExchangerConfiguration.CrossFlowUnmixed,
    m1_flow_nominal=mAir_flow_nominal,
    m2_flow_nominal=mWat_flow_nominal,
    dp2_nominal=dpWat_nominal,
    use_Q_flow_nominal=use_Q_flow_nominal,
    Q_flow_nominal=Q_flow_nominal,
    T_a1_nominal=T_a1_nominal,
    T_a2_nominal=T_a2_nominal,
    show_T=true,
    dp1_nominal=dpAir_nominal,
    eps_nominal=eps_nominal,
    r_nominal=r_nominal,
    allowFlowReversal1=allowFlowReversal1,
    allowFlowReversal2=allowFlowReversal2,
    redeclare package Medium1 = MediumAir,
    redeclare package Medium2 = MediumWater)
    "Cooling coil not taking into account condensation"
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));

equation
  connect(port_a1, airMultiplier.port_a)
    annotation (Line(points={{-100,60},{-80,60}}, color={0,127,255}));
  connect(airMultiplier.port_b, wcond.port_a1) annotation (Line(points={{-60,60},
          {-50,60},{-50,6},{-40,6}}, color={0,127,255}));
  connect(wcond.port_b1, port_b1) annotation (Line(points={{-20,6},{-6,6},{-6,60},
          {100,60}}, color={0,127,255}));
  connect(wocond.port_b1, bouAir.ports[1])
    annotation (Line(points={{40,6},{60,6},{60,20}}, color={0,127,255}));
  connect(airMultiplier.port_b,wocond. port_a1) annotation (Line(points={{-60,60},
          {-50,60},{-50,16},{12,16},{12,6},{20,6}}, color={0,127,255}));
  connect(port_a2, waterMultiplier.port_a)
    annotation (Line(points={{100,-60},{80,-60}}, color={0,127,255}));
  connect(waterMultiplier.port_b, wocond.port_a2) annotation (Line(points={{60,
          -60},{46,-60},{46,-6},{40,-6}}, color={0,127,255}));
  connect(wocond.port_b2, port_b2) annotation (Line(points={{20,-6},{10,-6},{10,
          -60},{-100,-60}}, color={0,127,255}));
  connect(wcond.port_b2, bouWat.ports[1])
    annotation (Line(points={{-40,-6},{-50,-6},{-50,-20}}, color={0,127,255}));
  connect(waterMultiplier.port_b, wcond.port_a2) annotation (Line(points={{60,
          -60},{46,-60},{46,-18},{-20,-18},{-20,-6}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-70,80},{70,-80}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,65},{101,55}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,-55},{101,-65}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
                              Rectangle(
          extent={{-70,78},{70,-80}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
                              Rectangle(
          extent={{-70,78},{70,-82}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
                                 Text(
          extent={{-151,147},{149,107}},
          lineColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255},
          textString="%name")}),            Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end CooCoil;
