within IDEAS.Buildings.Components.Interfaces;
expandable connector ZoneBus
  replaceable package Medium =
    Modelica.Media.Interfaces.PartialMedium "Medium in the component";
  parameter Integer numIncAndAziInBus
    "Number of calculated azimuth angles, set to sim.numIncAndAziInBus";
  parameter Boolean outputAngles = true "Set to false when linearising in Dymola only";
  parameter Boolean use_port_1 = false;
  parameter Boolean use_port_2 = false;

  IDEAS.Buildings.Components.Interfaces.RealConnector QTra_design(
    final quantity="Power",
    final unit="W") annotation ();
  IDEAS.Buildings.Components.Interfaces.RealConnector area(
    final quantity="Area",
    final unit="m2") annotation ();
  IDEAS.Buildings.Components.Interfaces.RealConnector epsLw(
    final quantity="Emissivity",
    final unit="1") annotation ();
  IDEAS.Buildings.Components.Interfaces.RealConnector epsSw(
    final quantity="Emissivity",
    final unit="1") annotation ();
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a surfCon annotation ();
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b surfRad annotation ();
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a iSolDir annotation ();
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b iSolDif annotation ();
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b Qgai
    "Heat gains in model" annotation ();
  Modelica.Fluid.Interfaces.FluidPort_a port_1(
    redeclare package Medium = Medium)
    if use_port_1
    "Port for interzonal air flow";
  Modelica.Fluid.Interfaces.FluidPort_a port_2(
    redeclare package Medium = Medium)
    if use_port_2
    "Port for detailed interzonal air flow";
  Modelica.Fluid.Interfaces.FluidPort_a port_3(
    redeclare package Medium = Medium)
    if use_port_2
    "Port for trickle vents etc. when using detailed interzonal air flow";
  IDEAS.Buildings.Components.BaseClasses.ConservationOfEnergy.EnergyPort E
    "Internal energy in model" annotation ();
  IDEAS.Buildings.Components.Interfaces.RealConnector inc(
    final quantity="Angle",
    final unit="rad",
    displayUnit="deg") annotation ();
  IDEAS.Buildings.Components.Interfaces.RealConnector azi(
    final quantity="Angle",
    final unit="rad",
    displayUnit="deg") annotation ();
  IDEAS.Buildings.Components.Interfaces.RealConnector v50(final unit="m3/h") "v50 if the surface has a custome q50 value" annotation ();
  IDEAS.Buildings.Components.Interfaces.RealConnector q50_zone(final unit="m3/(h.m2)") "v50 of the surface" annotation ();
  IDEAS.Buildings.Components.Interfaces.BooleanConnector use_custom_q50 "true if custome q50 value is assigned to surface" annotation ();
  IDEAS.Buildings.Components.Interfaces.BooleanConnector use_custom_n50 "true if the zone n50 is a custom value" annotation ();
  IDEAS.Buildings.Components.Interfaces.RealConnector hzone(final unit="m") "Zone height: distance between floor and ceiling" annotation ();
  IDEAS.Buildings.Components.Interfaces.RealConnector hfloor(final unit="m") "Absolute height of zone floor" annotation ();


  annotation (Documentation(info="<html>
<p>
Connector that contains a weather bus and further
contains variables and connectors for exchanging 
heat and information between a zone and a surface.
</p>
</html>", revisions="<html>
<ul>
<li>
Februari 18, 2024, by Filip Jorissen:<br/>
Modifications for supporting trickle vents and interzonal airflow.
</li>
<li>
April 20, 2023 by Jelger Jansen:<br/>
Make the connector expandable to avoid (pedantic check) warnings in Dymola 2022x.
See issue <a href=https://github.com/open-ideas/IDEAS/issues/1317>#1317</a>
</li>
<li>
August 10, 2020, by Filip Jorissen:<br/>
Modifications for supporting interzonal airflow.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1066\">
#1066</a>
</li>
<li>
April 26, 2020, by Filip Jorissen:<br/>
Refactored <code>SolBus</code> to avoid many instances in <code>PropsBus</code>.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1131\">
#1131</a>
</li>
<li>
March 21, 2017, by Filip Jorissen:<br/>
Changed Reals into connectors for JModelica compatibility.
Other compatibility changes. 
See issue <a href=https://github.com/open-ideas/IDEAS/issues/559>#559</a>.
</li>
<li>
October 22, 2016, by Filip Jorissen:<br/>
Revised documentation for IDEAS 1.0.
</li>
</ul>
</html>"), Icon(graphics={
          Rectangle(
            lineColor={255,204,51},
            lineThickness=0.5,
            extent={{-20,-2},{20,2}}),
          Polygon(
            fillColor={255,215,136},
            fillPattern=FillPattern.Solid,
            points={{-80,50},{80,50},{100,30},{80,-40},{60,-50},{-60,-50},{-80,-40},
              {-100,30}},
            smooth=Smooth.Bezier),
          Ellipse(
            fillPattern=FillPattern.Solid,
            extent={{-65,15},{-55,25}}),
          Ellipse(
            fillPattern=FillPattern.Solid,
            extent={{-5,15},{5,25}}),
          Ellipse(
            fillPattern=FillPattern.Solid,
            extent={{55,15},{65,25}}),
          Ellipse(
            fillPattern=FillPattern.Solid,
            extent={{-35,-25},{-25,-15}}),
          Ellipse(
            fillPattern=FillPattern.Solid,
            extent={{25,-25},{35,-15}})}));
end ZoneBus;
