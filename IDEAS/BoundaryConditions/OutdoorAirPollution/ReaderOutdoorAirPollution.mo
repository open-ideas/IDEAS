within IDEAS.BoundaryConditions.OutdoorAirPollution;
model ReaderOutdoorAirPollution

  parameter Integer nC(min=1)  "Number of traces in the medium";
  parameter String fileName "Name of the file containing the pollutant concentrations" annotation (Dialog(loadSelector(caption="Select the file")));
  Modelica.Blocks.Sources.CombiTimeTable pollutantSchedule(
    tableOnFile=true,
    tableName="Poll",
    fileName=fileName,
    verboseRead=true,
    columns=2:nC + 1,
    smoothness=Modelica.Blocks.Types.Smoothness.ModifiedContinuousDerivative,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
  Modelica.Blocks.Interfaces.RealOutput pollutantsOutdoorAir[nC] annotation (
      Placement(transformation(extent={{92,-10},{112,10}}), iconTransformation(
          extent={{92,-10},{112,10}})));
equation
  connect(pollutantSchedule.y, pollutantsOutdoorAir)
    annotation (Line(points={{13,0},{102,0}}, color={0,0,127}));
  annotation (
    defaultComponentName="pollDat",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor={0,0,255}),
        Line(points={{-80,-70},{-80,70}}, color={95,95,95}),
        Line(points={{-80,-70},{80,-70}}, color={95,95,95}),
        Polygon(
          points={{-80,78},{-86,62},{-74,62},{-80,78}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{88,-70},{72,-64},{72,-76},{88,-70}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-80,-30},{-62,-18},{-44,26},{-26,40},{-8,8},{10,-8},{28,30},{46,44},{64,12},{76,-4}},
          color={28,108,200},
          thickness=0.5,
          smooth=Smooth.Bezier),
        Ellipse(
          extent={{30,-24},{42,-36}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{50,-40},{58,-48}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{10,-46},{18,-54}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-40,-42},{-30,-52}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-14,-28},{-8,-34}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-96,-74},{96,-96}},
          textColor={0,0,0},
          textString="%fileName")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
Block that reads in an outdoor air concentration pollution file
</html>",
revisions="<html>
<ul>
<li>
September 14, 2026, by Klaas De Jonge:<br/>
Initial implementation.
</li>
</ul>
</html>"));
end ReaderOutdoorAirPollution;
