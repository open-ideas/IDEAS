within IDEAS.Fluid.Production.Interfaces.BaseClasses;
partial model PartialHeatSource

  //Extensions

  //Packages
  replaceable package Medium=IDEAS.Media.Water.Simple;

  //Parameters
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal;

  parameter Modelica.SIunits.ThermalConductance UALoss;
  parameter Modelica.SIunits.ThermalConductance UALossE = UALoss if heatPumpWaterWater;

  parameter Modelica.SIunits.Power QNom;
  parameter Modelica.SIunits.Power QNomRef;

  //Settings
  parameter Boolean heatPumpWaterWater = true;
  parameter Boolean modulating=true;
  parameter Boolean modulationInput=true if modulating;

  final parameter Real scaler = QNom/QNomRef;

  parameter Boolean useTinPrimary=true;
  parameter Boolean useToutPrimary=true;
  parameter Boolean useMassFlowPrimary=true;

  parameter Boolean useTinSecondary=true;
  parameter Boolean useToutSecondary=true;

  //Variables
  Modelica.SIunits.Power QLossesToCompensate = if noEvent(massFlowSecondary > m_flow_nominal/10000) then UALoss*(heatPort.T -
    TEnvironment) else 0 "Compensation for the heat losses of the condensor";
  Modelica.SIunits.Power QLossesToCompensateE = if noEvent(massFlowSecondary > m_flow_nominal/10000) then UALossE*(heatPortE.T -
    TEnvironment) else 0 if heatPumpWaterWater
    "Compensation for the heat losses of the evaporator if water-water heat pump is used";

  //Components

  //Interfaces
  Modelica.Blocks.Interfaces.RealInput TinSecondary if useTinSecondary annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-80,108}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,102})));
  Modelica.Blocks.Interfaces.RealInput ToutSecondary if useToutSecondary
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-40,108}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,102})));
  Modelica.Blocks.Interfaces.RealInput massFlowSecondary annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,108}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,102})));
  Modelica.Blocks.Interfaces.RealInput TinPrimary if useTinPrimary
    annotation (Placement(transformation(
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
  Modelica.Blocks.Interfaces.RealInput ToutPrimary if useToutPrimary
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-40,-110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-102})));
  Modelica.Blocks.Interfaces.RealInput massFlowPrimary if useMassFlowPrimary
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,-102})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    "heatPort connection to water in condensor"
    annotation (Placement(transformation(extent={{90,-10},{110,10}}),
        iconTransformation(extent={{90,-10},{110,10}})));
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
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortE if heatPumpWaterWater
    "heatPort connection to water in the evaporator in case of a HP"
    annotation (Placement(transformation(extent={{90,-50},{110,-30}}),
        iconTransformation(extent={{90,-50},{110,-30}})));

  Modelica.Blocks.Interfaces.RealOutput power
    annotation (Placement(transformation(extent={{96,30},{116,50}})));
  Modelica.Blocks.Interfaces.RealInput uModulation "modulation input"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={60,-110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,-102})));
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
