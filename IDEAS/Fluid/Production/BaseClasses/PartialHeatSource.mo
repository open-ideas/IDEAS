within IDEAS.Fluid.Production.BaseClasses;
partial model PartialHeatSource

  //Extensions
   extends IDEAS.Fluid.Production.Interfaces.ModulationSecurity;

  //Packages
  replaceable package Medium=IDEAS.Media.Water;

  //Parameters
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal;

  parameter Modelica.SIunits.ThermalConductance UALoss;
  parameter Modelica.SIunits.ThermalConductance UALossE = UALoss;

  parameter Modelica.SIunits.Power QNom;
  parameter Modelica.SIunits.Power QNomRef;

  //Settings
  parameter Boolean heatPumpWaterWater = false;
  parameter Boolean modulating = true;
  parameter Boolean modulationInput = true;

  final parameter Real scaler = QNom/QNomRef;

  parameter Boolean useTinPrimary=false;
  parameter Boolean useToutPrimary=false;
  parameter Boolean useMassFlowPrimary=false;

  parameter Boolean useTinSecondary=false;
  parameter Boolean useToutSecondary=false;

  //Variables
  Modelica.SIunits.Power QLossesToCompensate
    "Compensation for the heat losses of the condensor";
  Modelica.SIunits.Power QLossesToCompensateE "Compensation for the heat losses of the evaporator if a water-water 
     heat pump is used";

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

  //Components
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
protected
  Modelica.Blocks.Interfaces.RealOutput TinSecondaryMock;
  Modelica.Blocks.Interfaces.RealOutput ToutSecondaryMock;
  Modelica.Blocks.Interfaces.RealOutput TinPrimaryMock;
  Modelica.Blocks.Interfaces.RealOutput ToutPrimaryMock;
  Modelica.Blocks.Interfaces.RealOutput massFlowPrimaryMock;

  Modelica.Blocks.Interfaces.RealOutput uModulationMock;

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortEMock;

  Boolean on_internal = on and on_security.y;
equation
  T_high = heatPort.T;
  //Conditional inputs
  if not useTinSecondary then
    TinSecondaryMock=0;
  end if;
  if not useToutSecondary then
    ToutSecondaryMock=0;
  end if;
  if not useMassFlowPrimary then
    massFlowPrimaryMock=0;
  end if;
  if not useTinPrimary then
    TinPrimaryMock=0;
  end if;
  if not useToutPrimary then
    ToutPrimaryMock=0;
  end if;

  if not modulationInput then
    uModulationMock=0;
  end if;

  if not heatPumpWaterWater then
    heatPortEMock.T=273.15;
  end if;

  connect(TinSecondary, TinSecondaryMock);
  connect(ToutSecondary, ToutSecondaryMock);
  connect(TinPrimary, TinPrimaryMock);
  connect(ToutPrimary, ToutPrimaryMock);
  connect(massFlowPrimary, massFlowPrimaryMock);
  connect(uModulation, uModulationMock);
  connect(heatPortE, heatPortEMock);

  if noEvent(massFlowSecondary > m_flow_nominal/10000) then
    QLossesToCompensate = UALoss*(heatPort.T -TEnvironment);
    QLossesToCompensateE = UALossE*(heatPortEMock.T - TEnvironment);
  else
    QLossesToCompensate= 0;
    QLossesToCompensateE = 0;
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
