within IDEAS.Buildings.Components.Examples;
model RectangularZoneTemplateTwoPort
  "Example that compares a zone with internal wall and without internal wall"
  extends Modelica.Icons.Example;
  extends IDEAS.Buildings.Components.Examples.RectangularZoneTemplate(  sim(
        interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=604800,
      Tolerance=1e-006,
      __Dymola_Algorithm="Lsodar"),
    Documentation(info="<html>
<p>
This example illustrates the use of the RectangularZoneTemplate to model a room or building with the TwoPort interzonal airflow implementation activated
</p>
</html>", revisions="<html>
<ul>
<li>
2021 by Klaas de Jonge:<br/>
First implementation
</li>
</ul>
</html>"),
    __Dymola_Commands(file(inherit=true) = "Resources/Scripts/Dymola/Buildings/Components/Examples/RectangularZoneTemplateTwoPort.mos"
        "Simulate and Plot"));
end RectangularZoneTemplateTwoPort;
