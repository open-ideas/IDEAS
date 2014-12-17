within IDEAS.Fluid.Production;
model Boiler
  "Dynamic boiler model, based on interpolation in performance tables."
  extends BaseClasses.PartialProduction(
                                    redeclare replaceable
      BaseClasses.HeatSources.PerformanceMap3DHeatSource heatSource);
equation
    PEl = 7 + heatSource.modulation/100*(33 - 7);
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),
            graphics),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
         graphics),
    Documentation(info="<html>
<p><h4><font color=\"#008000\">Description </font></h4></p>
<p>Dynamic boiler model, based on interpolation in performance tables. The boiler has thermal losses to the environment which are often not mentioned in the performance tables. Therefore, the additional environmental heat losses are added to the heat production in order to ensure the same performance as in the manufacturers data, while still obtaining a dynamic model with heat losses (also when boiler is off). The heatSource will compute the required power and the environmental heat losses, and try to reach the set point. </p>
<p>See<a href=\"modelica://IDEAS.Fluid.Production.BaseClasses.PartialHeatSource\"> IDEAS.Fluid.Production.BaseClasses.PartialHeatSource</a> for more details about the heat losses and dynamics. </p>
<p><h4>Assumptions and limitations </h4></p>
<p><ol>
<li>Dynamic model based on water content and lumped dry capacity</li>
<li>Limited power (based on QNom and interpolation tables in heatSource) </li>
<li>Heat losses to environment which are compensated &apos;artifically&apos; to meet the manufacturers data in steady state conditions</li>
<li>No enforced min on or min off time; Hysteresis on start/stop thanks to different parameters for minimum modulation to start and stop the heat pump</li>
</ol></p>
<p><h4>Model use</h4></p>
<p>This model is based on performance tables of a specific boiler, as specified by the data in <a href=\"modelica://IDEAS.Fluid.Production.Data.PerformanceMaps.Boiler3D\">IDEAS.Fluid.Production.Data.PerformanceMaps.Boiler3D</a>. If a different gas boiler is to be simulated, use a different data file with the correct performance map.</p>
<p>See also<a href=\"modelica://IDEAS.Fluid.Production.BaseClasses.PartialProduction\"> IDEAS.Fluid.Production.BaseClasses.PartialProduction</a> for more details about the heat losses and dynamics. </p>
<p><h4>Validation </h4></p>
<p>The model has been verified in order to check if the &apos;artificial&apos; heat loss compensation still leads to correct steady state efficiencies according to the manufacturer data. This verification is integrated in the example model <a href=\"modelica://IDEAS.Thermal.Components.Examples.Boiler_validation\">IDEAS.Thermal.Components.Examples.Boiler_validation</a>.</p>
<p><h4>Example</h4></p>
<p>See validation.</p>
</html>", revisions="<html>
<p><ul>
<li>2014 March, Filip Jorissen, Annex60 compatibility</li>
<li>2013 May, Roel De Coninck: documentation</li>
<li>2011 August, Roel De Coninck: first version</li>
</ul></p>
</html>"));
end Boiler;
