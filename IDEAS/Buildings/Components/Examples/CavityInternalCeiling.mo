within IDEAS.Buildings.Components.Examples;
model CavityInternalCeiling
  "Illustration of an internal ceiling with a cavity"
  extends IDEAS.Buildings.Examples.ZoneExample(
    sim(interZonalAirFlowType= IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts),internalWall(
      redeclare parameter IDEAS.Buildings.Validation.Data.Constructions.LightWall constructionType,
      incOpt=3,
      hasCavity = true),
    zone1(hFloor=zone.hFloor + zone.hZone + 0.195));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=108000,
      Interval=720,
      Tolerance=0.001,
      __Dymola_Algorithm="Dassl"),
    __Dymola_Commands(file="Resources/Scripts/Dymola/Buildings/Components/Examples/CavityInternalCeiling.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
This example contains an example use of an opening in an internal ceiling. 
Note that it requires TwoPorts interzonal air flow (<code>interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts</code>).
</p>
</html>", revisions="<html>
<ul>
<li>
August 13, 2025, by Klaas De Jonge:<br/>
Updated construction type of Internal floor to <a href=modelica://IDEAS.Buildings.Validation.Data.Constructions.LightWall>
IDEAS.Buildings.Validation.Data.Constructions.LightWall</a>
</li>
<li>
February 05 2025, Klaas De Jonge<br>
First implementation.
</li>
</ul>
</html>"),
    __Dymola_experimentSetupOutput,
    __Dymola_experimentFlags(
      Advanced(
        EvaluateAlsoTop=false,
        GenerateAnalyticJacobian=true,
        OutputModelicaCode=false),
      Evaluate=true,
      OutputCPUtime=true,
      OutputFlatModelica=false));
end CavityInternalCeiling;
