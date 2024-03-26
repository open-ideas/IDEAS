within IDEAS.Fluid.Taps;
model Tap "Model for a DHW tap, reading the DHW demand via a Real input."
  extends MoPED.Thermal.DomesticHotWater.PartialTap;

  Modelica.Blocks.Interfaces.RealInput mDHWSet(final quantity="MassFlowRate", unit="kg/s")
    "Mass flowrate of DHW at 60 degC in kg/s"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120}),
        iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={3.55271e-15,100})));
equation
  mDHWSet = mFloSet;

   annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<p><b>Description</b></p>
<p>Model of a domestic hot water (DHW) tap. The tap is modelled as a thermostatic mixing valve.</p>
<p>See <a href=\"MoPED.Thermal.DomesticHotWater.PartialTap\">MoPED.Thermal.DomesticHotWater.PartialTap</a> for more information.</p>
</html>", revisions="<html>
<ul>
<li>March 26, 2024, by Lucas Verleyen:<br>First implementation, adopted from depreciated model.<br>See <a href=\"https://github.com/open-ideas/IDEAS/issues/1287\">#1287</a> for more information. </li>
</ul>
</html>"));
end Tap;
