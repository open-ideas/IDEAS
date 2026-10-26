within IDEAS.Fluid.Sources.Examples;
model OutsideAirFile
  "Test model for source and sink with outside weather data and coupling with sim reading in an outdoor pollution file"
  extends Modelica.Icons.Example;
  package Medium = IDEAS.Media.Air(extraPropertiesNames={"CO2"}) "Medium model for air";

  IDEAS.Fluid.Sources.OutsideAir     west(
    redeclare package Medium = Medium,
    azi=IDEAS.Types.Azimuth.W) "Model with outside conditions"
    annotation (Placement(transformation(extent={{-42,0},{-22,20}})));
  inner BoundaryConditions.SimInfoManager sim(
    use_sim_Cs=true,
    usePollutantSchedule=true,
    outdoorFileName=ModelicaServices.ExternalReferences.loadResource("modelica://IDEAS/Resources/outdoorpollutiondata/outsideAir_simple.mos"),
    nC=Medium.nC)
    annotation (Placement(transformation(extent={{-102,78},{-82,98}})));
  annotation (__Dymola_Commands(file="modelica://IDEAS/Resources/Scripts/Dymola/Fluid/Sources/Examples/OutsideAir.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
This model demonstrates the use of a source for ambient conditions that computes
the wind pressure on a facade of a building using a user-defined wind pressure profile and uses an outdoor pollution file as input.
<br/>
Data is obtained from the from the SimInfoManager.
</p>
</html>", revisions="<html>
<ul>
<li>
September 14, 2026, by Klaas De Jonge:<br/>
First implementation.
</li>
</ul>
</html>"),
    experiment(
      StopTime=86400,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"));
end OutsideAirFile;
