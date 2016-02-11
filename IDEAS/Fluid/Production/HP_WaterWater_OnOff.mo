within IDEAS.Fluid.Production;
model HP_WaterWater_OnOff
  "A water (or brine) to water heat pump with on/off input"
  extends IDEAS.Fluid.Production.BaseClasses.PartialHeatPump(final use_TSet = false, vol2(V=
          heatPumpData.m2/rho2_nominal));

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(graphics={
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={135,135,135})}),
    Documentation(revisions="<html>
<ul>
<li>November 2014 by Filip Jorissen:<br/> 
Added documentation
</li>
<li>March 2014 by Filip Jorissen:<br/> 
Initial version
</li>
</ul>
</html>", info="<html>
<p>This model implements a heat pump as described in<a href=\"modelica://IDEAS.Fluid.Production.BaseClasses.PartialHeatPump\"> IDEAS.Fluid.Production.BaseClasses.PartialHeatPump</a>. The heat pump can be switching on or off using an external control signal.</p>
</html>"));
end HP_WaterWater_OnOff;
