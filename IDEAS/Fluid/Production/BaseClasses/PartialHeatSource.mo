within IDEAS.Fluid.Production.BaseClasses;
partial model PartialHeatSource "Partial model for a heatsource"

  //Extensions
   extends IDEAS.Fluid.Production.Interfaces.ModulationSecurity;

  //Packages
  replaceable package Medium=IDEAS.Media.Water;

  //Parameters
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal
    "Nominal mass flow in the primary circuit";
  parameter Modelica.SIunits.ThermalConductance UALoss1=UALoss2
    "Thermal conductance of the primary circuit";
  parameter Modelica.SIunits.ThermalConductance UALoss2
    "Thermal conductance of the secondary circuit";

  parameter Modelica.SIunits.Power QNom "Nominal power of the heater";
  parameter Modelica.SIunits.Power QNomRef
    "Nominal power of the heater which was used to create the performance data";

  //Settings
  parameter Boolean heatPumpWaterWater = false
    "Set to true if the heater is a water water heat pump";
  parameter Boolean modulating = true
    "Set to true if the heater is able to modulate";
  parameter Boolean modulationInput = true
    "Set to true to use the modulation as an input";

  final parameter Real scaler = QNom/QNomRef
    "Scaler to scale the power of the model according to the power of the heater used to create the performance data";

  parameter Boolean useTin2=false
    "Set to true if the inlet temperature of the secondary circuit is used in the performance data";
  parameter Boolean useTout2=false
    "Set to true if the outlet temperature of the secondary circuit is used in the performance data";

  parameter Boolean useTin1=false
    "Set to true if the inlet temperature of the primary circuit is used in the performance data";
  parameter Boolean useTout1=false
    "Set to true if the outlet temperature of the primary circuit is used in the performance data";
  parameter Boolean useMassFlow1=false
    "Set to true if the massflow rate of the secondary circuit is used in the performance data";

  //Variables
  Modelica.SIunits.Power QLossesToCompensate1
    "Compensation for the heat losses in the primary circuit";
  Modelica.SIunits.Power QLossesToCompensate2 "Compensation for the heat losses in the secondary circuit if a water-water 
     heat pump is used";

  //Interfaces
  Modelica.Blocks.Interfaces.RealInput Tin1 if         useTin1 annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-80,108}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,102})));
  Modelica.Blocks.Interfaces.RealInput Tout1 if         useTout1 annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-40,108}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,102})));
  Modelica.Blocks.Interfaces.RealInput m_flow1 if         useMassFlow1 annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,108}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,102})));
  Modelica.Blocks.Interfaces.RealInput Tin2 if       useTin2 annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-80,-110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,-102})));
  Modelica.Blocks.Interfaces.RealInput QAsked annotation (Placement(
        transformation(extent={{-130,10},{-90,50}}),  iconTransformation(extent={{-10,-10},
            {10,10}},
        rotation=0,
        origin={-100,40})));
  Modelica.Blocks.Interfaces.RealInput Tout2 if       useTout2
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-40,-110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-102})));
  Modelica.Blocks.Interfaces.RealInput m_flow2
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,-102})));

  //Components
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort1 if heatPumpWaterWater
    "heatPort connection to water in primary circuit"
    annotation (Placement(transformation(extent={{90,-50},{110,-30}}),
        iconTransformation(extent={{90,-50},{110,-30}})));
  Modelica.Blocks.Interfaces.BooleanInput on
    annotation (Placement(
        transformation(extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-110,0}),                            iconTransformation(extent={{-10,-10},
            {10,10}},
        rotation=0,
        origin={-100,0})));
  Modelica.Blocks.Interfaces.RealInput TEnvironment annotation (Placement(
        transformation(extent={{-130,-70},{-90,-30}}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-100,-40})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort2
    "heatPort connection to water in the secondary circuit"
    annotation (Placement(transformation(extent={{90,-10},{110,10}}),
        iconTransformation(extent={{90,-10},{110,10}})));

  Modelica.Blocks.Interfaces.RealOutput power
    annotation (Placement(transformation(extent={{96,30},{116,50}})));
  Modelica.Blocks.Interfaces.RealInput uModulation if modulationInput
    "modulation input"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={60,-110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,-102})));

  //Input mocks
  Modelica.Blocks.Interfaces.RealOutput Tin1Mock;
  Modelica.Blocks.Interfaces.RealOutput Tout1Mock;
  Modelica.Blocks.Interfaces.RealOutput massFlow1Mock;

  Modelica.Blocks.Interfaces.RealOutput Tin2Mock;
  Modelica.Blocks.Interfaces.RealOutput Tout2Mock;

  Modelica.Blocks.Interfaces.RealOutput uModulationMock;

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort1Mock;

  Boolean on_internal = on; //and on_security.y;
equation
  T_high = heatPort2.T;

  //Conditional inputs
  if not useTin1 then
    Tin1Mock=0;
  end if;
  if not useTout1 then
    Tout1Mock=0;
  end if;
  if not useMassFlow1 then
    massFlow1Mock=0;
  end if;
  if not useTin2 then
    Tin2Mock=0;
  end if;
  if not useTout2 then
    Tout2Mock=0;
  end if;

  if not modulationInput then
    uModulationMock=0;
  end if;

  if not heatPumpWaterWater then
    heatPort1Mock.T=273.15;
  end if;

  connect(Tin1, Tin1Mock);
  connect(Tout1, Tout1Mock);
  connect(Tin2, Tin2Mock);
  connect(Tout2, Tout2Mock);
  connect(m_flow1, massFlow1Mock);
  connect(uModulation, uModulationMock);
  connect(heatPort1, heatPort1Mock);

  //Apply compensating heat losses if fluid is flowing
  if noEvent(m_flow2 > m_flow_nominal/10000) then
    QLossesToCompensate1 = UALoss1*(heatPort1Mock.T - TEnvironment);
    QLossesToCompensate2 = UALoss2*(heatPort2.T -TEnvironment);
  else
    QLossesToCompensate1= 0;
    QLossesToCompensate2 = 0;
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Line(
          points={{-70,-20},{30,-20}},
          color={191,0,0},
          thickness=0.5),
        Line(
          points={{-70,20},{30,20}},
          color={191,0,0},
          thickness=0.5),
        Line(
          points={{-90,0},{-70,-20}},
          color={191,0,0},
          thickness=0.5),
        Line(
          points={{-90,0},{-70,20}},
          color={191,0,0},
          thickness=0.5),
        Polygon(
          points={{30,0},{30,40},{60,20},{30,0}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{30,-40},{30,0},{60,-20},{30,-40}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{60,40},{80,-40}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={135,135,135})}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics));
end PartialHeatSource;
