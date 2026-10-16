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




  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
Block that reads in an outdoor air concentration pollution file
</html>",
revisions="<html>
<ul>
<li>
September 14, 2026, by Klaas De Jonge:<br/>
Initial implementation.
<li>
</ul>
</html>"));
end ReaderOutdoorAirPollution;
