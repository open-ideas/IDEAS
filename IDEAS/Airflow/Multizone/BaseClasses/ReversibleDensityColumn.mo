within IDEAS.Airflow.Multizone.BaseClasses;
model ReversibleDensityColumn
  "Vertical shaft with no friction and no storage of heat and mass, reversible because it can handle negative column heights"
  replaceable package Medium = IDEAS.Media.Air
  "Medium in the component"
   annotation (choices(
        choice(redeclare package Medium = IDEAS.Media.Air "Moist air")));
  parameter Modelica.Units.SI.Length h = 3 "Height of shaft";

  Modelica.Fluid.Interfaces.FluidPort_a port_a(
    redeclare package Medium = Medium,
    p(start=Medium.p_default))
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
annotation (Placement(transformation(extent={{-10,90},{10,110}}),
    iconTransformation(extent={{-10,90},{10,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(
    redeclare package Medium = Medium,
    p(start=Medium.p_default))
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
annotation (Placement(transformation(extent={{10,-110},{-10,-90}}), iconTransformation(extent={{10,-110},{-10,-90}})));

  Modelica.Units.SI.VolumeFlowRate V_flow = m_flow/Medium.density(sta_b)
    "Volume flow rate at inflowing port (positive when flow from port_a to port_b)";
  Modelica.Units.SI.MassFlowRate m_flow = port_a.m_flow
    "Mass flow rate from port_a to port_b (m_flow > 0 is design flow direction)";
  Modelica.Units.SI.PressureDifference dp(displayUnit="Pa") = port_a.p - port_b.p
    "Pressure difference between port_a and port_b";
  Modelica.Units.SI.Density rho = IDEAS.Utilities.Psychrometrics.Functions.density_pTX(
      p=Medium.p_default,
      T=Medium.temperature(Medium.setState_phX(
        port_b.p,
        inStream(port_b.h_outflow),
        Xi)),
      X_w=if Medium.nXi == 0 then 0 else Xi[1])
      "Density in medium column";

protected
  Medium.ThermodynamicState sta_b=Medium.setState_phX(
    port_b.p,
    actualStream(port_b.h_outflow),
    actualStream(port_b.Xi_outflow))
    "Medium properties in port_a";
  Medium.MassFraction Xi[Medium.nXi] = inStream(port_b.Xi_outflow)
    "Mass fraction used to compute density";

equation
  // Pressure difference between ports
  // Xi is computed first as it is used in two expression, and in one
  // of them only one component is used.
  // We test for Medium.nXi == 0 as Modelica.Media.Air.SimpleAir has no
  // moisture and hence Xi[1] is an illegal statement.
  // We first compute temperature and then invoke a density function that
  // takes temperature as an argument. Simply calling a density function
  // of a medium that takes enthalpy as an argument would be dangerous
  // as different media can have different datum for the enthalpy.

  dp=-h*rho*Modelica.Constants.g_n;

  // Isenthalpic state transformation (no storage and no loss of energy)
  port_a.h_outflow = inStream(port_b.h_outflow);
  port_b.h_outflow = inStream(port_a.h_outflow);

  // Mass balance (no storage)
  port_a.m_flow + port_b.m_flow = 0;

  // Transport of substances
  port_a.Xi_outflow = inStream(port_b.Xi_outflow);
  port_b.Xi_outflow = inStream(port_a.Xi_outflow);

  port_a.C_outflow = inStream(port_b.C_outflow);
  port_b.C_outflow = inStream(port_a.C_outflow);

  annotation (
Icon(graphics={
    Line(
      points={{0,100},{0,-100},{0,-98}}),
    Text(
      extent={{24,-78},{106,-100}},
      lineColor={0,0,127},
          textString="Zone/Amb"),
    Text(
      extent={{32,104},{98,70}},
      lineColor={0,0,127},
          textString="FlowElem"),
    Text(
      extent={{36,26},{88,-10}},
      lineColor={0,0,127},
      fillColor={255,0,0},
      fillPattern=FillPattern.Solid,
      textString="h=%h"),
    Rectangle(
      extent={{-16,80},{16,-80}},
      fillColor={255,0,0},
      fillPattern=FillPattern.Solid,
      pattern=LinePattern.None),
    Rectangle(
      visible=densitySelection == IDEAS.Airflow.Multizone.Types.densitySelection.fromTop,
      extent={{-16,80},{16,0}},
      fillColor={85,170,255},
      fillPattern=FillPattern.Solid,
      pattern=LinePattern.None,
      lineColor={0,0,0}),
    Rectangle(
      visible=densitySelection == IDEAS.Airflow.Multizone.Types.densitySelection.actual,
      extent={{-16,80},{16,54}},
      fillColor={85,170,255},
      fillPattern=FillPattern.Solid,
      pattern=LinePattern.None,
      lineColor={0,0,0}),
    Rectangle(
      visible=densitySelection == IDEAS.Airflow.Multizone.Types.densitySelection.fromBottom,
      extent={{-16,0},{16,-82}},
      fillColor={85,170,255},
      fillPattern=FillPattern.Solid,
      pattern=LinePattern.None,
      lineColor={0,0,0}),
    Rectangle(
      visible=densitySelection == IDEAS.Airflow.Multizone.Types.densitySelection.actual,
      extent={{-16,-55},{16,-80}},
      fillColor={85,170,255},
      fillPattern=FillPattern.Solid,
      pattern=LinePattern.None,
      lineColor={0,0,0})}),
  defaultComponentName="col",
  Documentation(info="<html>
<p>
This model describes the pressure difference of a vertical medium
column. It can be used to model the pressure difference caused by
stack effect.

It is a variation on IDEAS.Airflow.Multizone.MediumColumn.

</p>
</html>",
      revisions="<html>
<ul>
<li>
January 19, 2022, by Klaas De Jonge:<br/>
Adapted IDEAS.Airflow.Multizone.MediumColumn to obtain the current model where input of h can be negative and cleaned out the model as the density should always be set by port_b. 
This makes port_a not nececarilly always the top port.

</li>
</ul>
</html>"));
end ReversibleDensityColumn;
