within IDEAS.Fluid.Taps;
model Tap
  "Model for a DHW tap, reading the DHW demand via a RealInput connector."
  extends IDEAS.Fluid.Taps.BaseClasses.PartialTap;

  Modelica.Blocks.Interfaces.RealInput mFloSet(final quantity="MassFlowRate", unit="kg/s")
    "Mass flowrate of DHW at TSet in kg/s"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120}),
        iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,100})));

equation
  mFloSet = m_flow_set;

   annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<p><b>Description</b></p>
<p>Model of a domestic hot water (DHW) tap. The tap is modelled as a thermostatic 
mixing valve.</p>
<p>The input <i>mDHWSet</i> is a RealInput to connect the prescribed DHW mass 
flow rate (in [kg/s]) at the desired <i>TSet</i> temperature.</p>
<p>See <a href=\"IDEAS.Fluid.Taps.BaseClasses.PartialTap\">IDEAS.Fluid.Taps.BaseClasses.PartialTap</a> 
for more information.</p>
</html>", revisions="<html>
<ul>
<li>March 26, 2024, by Lucas Verleyen:<br>
First implementation, adopted from depreciated model.<br>
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1287\">#1287</a> for 
more information. </li>
</ul>
</html>"));
end Tap;
