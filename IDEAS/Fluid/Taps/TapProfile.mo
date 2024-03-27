within IDEAS.Fluid.Taps;
model TapProfile
  "Model for a DHW tap, reading the DHW demand profile via a CombiTimeTable."
  extends IDEAS.Fluid.Taps.BaseClasses.PartialTap;

  Modelica.Blocks.Math.Gain conversion(k=1/60)
    "Conversion from l/min to kg/s using density = 1000 kg/m3"
                                    annotation (Placement(visible=true,
      transformation(extent={{70,46},{90,66}}, rotation=0)));

  Modelica.Blocks.Sources.RealExpression DHW_profile(y=occSim.occBus.DHWdem)
    "DHW demand profile input [l/min]"
    annotation (Placement(transformation(extent={{40,46},{60,66}})));
equation
  conversion.y = mFloSet;
  connect(DHW_profile.y, conversion.u)
    annotation (Line(points={{61,56},{68,56}}, color={0,0,127}));
   annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
   Polygon(
  points={{-80,-78},{-72,-78},{-72,-90},{-54,-90},{-54,-82},{-46,-82},{-46,-34},
              {-40,-34},{-40,-90},{-28,-90},{-28,-68},{-18,-68},{-18,-90},{-6,
              -90},{-6,-42},{-2,-42},{-2,-90},{6,-90},{6,-26},{10,-26},{10,-90},
              {30,-90},{30,-82},{36,-82},{36,-42},{44,-42},{44,-90},{58,-90},{
              58,-70},{68,-70},{68,-90},{-80,-90},{-80,-78}},
  lineColor={244,125,35},
  lineThickness=0.5,
  fillColor={230,230,230},
  fillPattern=FillPattern.Backward),
   Polygon(
  points={{10,4},{-2,1.46957e-15},{10,-4},{10,4}},
  lineColor={28,108,200},
  lineThickness=1,
  origin={-80,-36},
  rotation=270,
  fillColor={28,108,200},
  fillPattern=FillPattern.Solid),
   Line(
  points={{-80,-42},{-80,-90}},
  color={28,108,200},
  thickness=1),
   Line(
  points={{76,-90},{-80,-90}},
  color={28,108,200},
  thickness=1),
   Polygon(
  points={{10,4},{-2,1.46957e-15},{10,-4},{10,4}},
  lineColor={28,108,200},
  lineThickness=1,
  origin={84,-90},
  rotation=180,
  fillColor={28,108,200},
  fillPattern=FillPattern.Solid)}),                               Diagram(
        coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<p><b>Description</b></p>
<p>Model of a domestic hot water (DHW) tap. The tap is modelled as a thermostatic mixing valve.</p>
<p>The flow rate at the tap is read from a CombiTimeTable. The model requires a flow rate in [kg/s] (or [l/s]), but DHW flow rates are usually expressed in [l/min]. Therefore, an additional parameter has been added to convert the units of the profile into [kg/s].</p>
<p>See <a href=\"IDEAS.Fluid.Taps.BaseClasses.PartialTap\">IDEAS.Fluid.Taps.BaseClasses.PartialTap</a> for more information.</p>
</html>", revisions="<html>
<ul>
<li>March 27, 2024, by Lucas Verleyen:<br>
Initial implementation.<br>
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1287\">#1287</a> for more information.</li> 
</ul>
</html>"));
end TapProfile;
