within IDEAS.Fluid.Sources.Examples;
model OutsideAirFile
  "Test model for source and sink with outside weather data and coupling with sim reading in an outdoor pollution file"
  extends Modelica.Icons.Example;
  package Medium = IDEAS.Media.Air(extraPropertiesNames={"CO2"}) "Medium model for air";

  parameter Modelica.Units.SI.Angle incAngSurNor[:]=
    {0, 45, 90, 135, 180, 225, 270, 315}*2*Modelica.Constants.pi/360
    "Wind incidence angles";
  parameter Real Cp[:] = {0.4, 0.1, -0.3, -0.35, -0.2, -0.35, -0.3, 0.1}
    "Cp values";
  IDEAS.Fluid.Sources.OutsideAir     west(
    redeclare package Medium = Medium,
    azi=IDEAS.Types.Azimuth.W) "Model with outside conditions"
    annotation (Placement(transformation(extent={{-42,0},{-22,20}})));
  inner BoundaryConditions.SimInfoManager sim(
    use_sim_Cs=true,
    usePollutantSchedule=true,
    outdoorFileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://IDEAS/Resources/outdoorpollutiondata/outsideAir_simple.csv"),
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
      StartTime=1.728e+07,
      StopTime=1.78848e+07,
      Tolerance=1e-6));
end OutsideAirFile;
