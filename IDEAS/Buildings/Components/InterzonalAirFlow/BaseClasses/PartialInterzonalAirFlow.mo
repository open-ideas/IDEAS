within IDEAS.Buildings.Components.InterzonalAirFlow.BaseClasses;
partial model PartialInterzonalAirFlow "Partial for interzonal air flow"
  outer IDEAS.BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  replaceable package Medium = IDEAS.Media.Air "Air medium";

  parameter Integer nPorts "Number of ports for connection to zone air volume";
  parameter Integer nSurf(min=2) "Number of ports for connection to zone air volume";
  parameter Modelica.SIunits.Volume V "Zone air volume for n50 computation";
  parameter Real n50 = sim.n50 "n50 value";
  parameter Real n50toAch = 20
    "Conversion fractor from n50 to Air Change Rate"
    annotation(Dialog(tab="Advanced"));
  constant Boolean defaultBoundary = true
    "= false, to remove default pressure boundaries for infiltration and interzonal air exchange";
  Modelica.Fluid.Interfaces.FluidPort_b port_b_interior(
    redeclare package Medium = Medium)
    "Port a connection to zone air model ports"
    annotation (Placement(transformation(extent={{50,-110},{70,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_interior(
    redeclare package Medium = Medium)
    "Port b connection to zone air model ports"
    annotation (Placement(transformation(extent={{-70,-110},{-50,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_exterior(
    redeclare package Medium = Medium)
    "Port a connection to model exterior ports"
    annotation (Placement(transformation(extent={{10,90},{30,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_exterior(
    redeclare package Medium = Medium)
    "Port b connection to model exterior ports"
    annotation (Placement(transformation(extent={{-30,90},{-10,110}})));
  Modelica.Fluid.Interfaces.FluidPorts_a[nPorts] ports(
    redeclare each package Medium = Medium)
    "Ports connector for multiple ports"                                         annotation (Placement(
        transformation(
        extent={{-10,40},{10,-40}},
        rotation=90,
        origin={2,-100})));
  Modelica.Fluid.Interfaces.FluidPorts_a[nSurf] portsInf(
    redeclare each package Medium = Medium)
    "Ports for air infiltration through the building facade" annotation (
      Placement(transformation(
        extent={{-10,40},{10,-40}},
        rotation=180,
        origin={-100,0})));
  Modelica.Fluid.Interfaces.FluidPorts_b[nSurf] portsItz(
    redeclare each package Medium = Medium)
    "Ports for interzonal air exchange within building facade" annotation (
      Placement(transformation(
        extent={{-10,40},{10,-40}},
        rotation=180,
        origin={100,0})));
protected
  IDEAS.Fluid.Sources.Boundary_pT bouInf(
    nPorts=nSurf,
    redeclare package Medium = Medium) if defaultBoundary;
  IDEAS.Fluid.Sources.Boundary_pT bouItz(
    nPorts=nSurf,
    redeclare package Medium = Medium) if defaultBoundary;

equation
  connect(portsItz, bouItz.ports);
  connect(portsInf, bouInf.ports);
   annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-15,80},{15,-80}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward,
          pattern=LinePattern.None,
          origin={-19,86},
          rotation=90),
        Rectangle(
          extent={{-70,100},{-100,40}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward,
          pattern=LinePattern.None),
        Line(
          points={{57.5,0},{-11,-0.5}},
          color={0,128,255},
          visible=not allowFlowReversal,
          origin={-20.5,31},
          rotation=90),
        Line(
          points={{57.5,0},{-13,-0.5}},
          color={0,128,255},
          visible=not allowFlowReversal,
          origin={19.5,33},
          rotation=90),
        Rectangle(
          extent={{-70,0},{-100,-60}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward,
          pattern=LinePattern.None),
        Polygon(
          points={{-11,10},{20,0},{-11,-10},{-11,10}},
          lineColor={0,128,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          visible=not allowFlowReversal,
          origin={20,41},
          rotation=270),
        Line(
          points={{60,70},{-70,70},{-70,-60}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Polygon(
          points={{-11,10},{20,0},{-11,-10},{-11,10}},
          lineColor={0,128,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          visible=not allowFlowReversal,
          origin={-20,69},
          rotation=90)}),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li>
April 27, 2018 by Filip Jorissen:<br/>
First version.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/796\">#796</a>.
</li>
</ul>
</html>"));
end PartialInterzonalAirFlow;
