within IDEAS.Fluid.Production;
model IdealHeaterNew

  //Extensions
  extends IDEAS.Fluid.Interfaces.TwoPortFlowResistanceParameters(
    final computeFlowResistance=true, dp_nominal = 0);
  extends IDEAS.Fluid.Interfaces.LumpedVolumeDeclarations(T_start=293.15);

  parameter Modelica.SIunits.Power QNom = 1
  annotation(Dialog(group = "Nominal condition"));
  parameter Modelica.SIunits.Time tauHeatLoss=7200
    "Time constant of environmental heat losses";
  parameter Modelica.SIunits.Mass mWater = 50 "Mass of water in the boiler";
  parameter Modelica.SIunits.HeatCapacity cDry=5000
    "Capacity of dry material lumped to condensor";

  final parameter Modelica.SIunits.ThermalConductance UALoss=(cDry + mWater*
      Medium.specificHeatCapacityCp(Medium.setState_pTX(Medium.p_default, Medium.T_default,Medium.X_default)))/tauHeatLoss;

  parameter SI.MassFlowRate m_flow_nominal "Nominal mass flow rate"
  annotation(Dialog(group = "Nominal condition"));
  parameter SI.Pressure dp_nominal=0 "Pressure drop";

  parameter Boolean dynamicBalance=true
    "Set to true to use a dynamic balance, which often leads to smaller systems of equations"
    annotation (Dialog(tab="Flow resistance"));
  parameter Boolean homotopyInitialization=true "= true, use homotopy method";

  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalLosses(
    G=UALoss) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-30,-68})));
  Sensors.TemperatureTwoPort Tin(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal) "Inlet temperature"
    annotation (Placement(transformation(extent={{60,30},{40,50}})));
  FixedResistances.Pipe_HeatPort             pipe_HeatPort(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=dp_nominal,
    m=mWater,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    p_start=p_start,
    T_start=T_start,
    X_start=X_start,
    C_start=C_start,
    C_nominal=C_nominal,
    dynamicBalance=dynamicBalance,
    from_dp=from_dp,
    linearizeFlowResistance=linearizeFlowResistance,
    deltaM=deltaM,
    homotopyInitialization=homotopyInitialization,
    mFactor=if mWater > Modelica.Constants.eps then 1 + cDry/
        Medium.specificHeatCapacityCp(Medium.setState_pTX(
        Medium.p_default,
        Medium.T_default,
        Medium.X_default))/mWater else 0)
         annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,0})));
  Modelica.Blocks.Interfaces.RealInput TSet "Temperature setpoint"
                           annotation (Placement(
        transformation(extent={{-20,-20},{20,20}},
        rotation=270,
        origin={60,104}),                             iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={40,104})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    "heatPort for thermal losses to environment" annotation (Placement(
        transformation(extent={{-40,-108},{-20,-88}}), iconTransformation(
          extent={{-50,-110},{-30,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(
    redeclare package Medium = Medium) "Fluid inlet"
    annotation (Placement(transformation(extent={{90,30},{110,50}}),
        iconTransformation(extent={{90,30},{110,50}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(
    redeclare package Medium = Medium) "Fluid outlet"
    annotation (Placement(transformation(extent={{90,-50},{110,-30}}),
        iconTransformation(extent={{90,-50},{110,-30}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{-48,12},{-28,32}})));
  Utilities.Math.Max max(nin=2) "Maximum temperature"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-18,58})));
equation
  connect(thermalLosses.port_b,heatPort)  annotation (Line(
      points={{-30,-78},{-30,-98}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(thermalLosses.port_a,pipe_HeatPort. heatPort) annotation (Line(
      points={{-30,-58},{-30,0},{-10,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(port_a, Tin.port_a) annotation (Line(
      points={{100,40},{60,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe_HeatPort.port_b, port_b) annotation (Line(
      points={{0,-10},{0,-40},{100,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(Tin.port_b, pipe_HeatPort.port_a) annotation (Line(
      points={{40,40},{0,40},{0,10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(max.y,prescribedTemperature. T) annotation (Line(
      points={{-18,47},{-18,42},{-62,42},{-62,22},{-50,22}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TSet, max.u[1]) annotation (Line(
      points={{60,104},{60,78},{-18,78},{-18,70},{-19,70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Tin.T, max.u[2]) annotation (Line(
      points={{50,51},{50,76},{-17,76},{-17,70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(prescribedTemperature.port, pipe_HeatPort.heatPort) annotation (Line(
      points={{-28,22},{-10,22},{-10,0}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                                               graphics={
        Rectangle(extent={{-100,60},{60,-60}},lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{98,40},{18,40},{38,20},{18,0},{38,-20},{18,-40},{98,-40}},
          color={0,0,255},
          smooth=Smooth.None),
      Polygon(
        origin={47.533,-20.062},
        lineColor={0,255,128},
        fillColor={0,255,128},
        fillPattern=FillPattern.Solid,
        points = {{-40,-90},{-20,-70},{0,-90},{0,-50},{-20,-30},{-40,-50},{-40,-90}},
          rotation=270),
        Text(
          extent={{-100,100},{100,60}},
          lineColor={0,0,255},
          textString="%name")}));
end IdealHeaterNew;
