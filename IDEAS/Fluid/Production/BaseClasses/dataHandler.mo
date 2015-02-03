within IDEAS.Fluid.Production.BaseClasses;
partial model dataHandler
  "Partial model to handle common aspects for heater data"

  extends IDEAS.Fluid.Interfaces.PartialTwoPortInterface;

  //Parameters and constants
  //****************************************************************************
  parameter Modelica.SIunits.Power QNom "Nominal power of the heater";
  final parameter Types.MassFlow mUnit=data.mUnit
    "Unit of massflow for the input";
  final parameter Types.Temperature TUnit=data.TUnit
    "Unit of temperature for the input";
  constant Real m3ps2kgps=1000 "Conversion from m3/s to kg/s";
  constant Real kgps2lph=3600/Medium.density(Medium.setState_pTX(Medium.p_default, Medium.T_default, Medium.X_default))*m3ps2kgps
    "Conversion from kg/s to l/h";

  //Variables
  //****************************************************************************
  Real m_flow_scaled = IDEAS.Utilities.Math.Functions.smoothMax(
    x1=m_flow,
    x2=0,
    deltaX=m_flow_nominal/10000)*QNom/data.QNomRef "Mass flow rate, scaled with the original and the actual nominal power of 
    the boiler";
  Real m_flow_eff "Massflow as input for the efficiency calculation";
  Real T_eff "Temperat as input for the efficiency calculation";

  //Components
  //****************************************************************************
  replaceable DataInterface data "Data of the heater"
    annotation (Placement(transformation(extent={{-98,-98},{-78,-78}})));
  Sensors.TemperatureTwoPort senTem
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));

equation
  //Use the right massflow conversion
  if mUnit == Types.MassFlow.m3ps then
    m_flow_eff = m_flow_scaled;
  end if;
  if mUnit == Types.MassFlow.kgps then
    m_flow_eff = m_flow_scaled*m3ps2kgps;
  end if;
  if mUnit == Types.MassFlow.lph then
    m_flow_eff = m_flow_scaled*m3ps2kgps*kgps2lph;
  end if;

  //Use the right temperature conversion
  if TUnit == Types.Temperature.C then
    T_eff = senTem.T - 273.15;
  end if;
  if TUnit == Types.Temperature.K then
    T_eff = senTem.T;
  end if;

  connect(port_a, senTem.port_a) annotation (Line(
      points={{-100,0},{-60,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem.port_b, port_b) annotation (Line(
      points={{-40,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end dataHandler;
