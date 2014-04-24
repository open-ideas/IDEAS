within IDEAS.Media.Examples;
model WaterProperties
  "Model that tests the implementation of the fluid properties"
  extends Modelica.Icons.Example;
  extends IDEAS.Media.Examples.BaseClasses.FluidProperties(
    redeclare package Medium = IDEAS.Media.Water,
    TMin=273.15,
    TMax=373.15);
equation
  // Check the implementation of the base properties
  basPro.state.p=p;
  basPro.state.T=T;
   annotation(Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
experiment(StopTime=1),
__Dymola_Commands(file="modelica://IDEAS/Resources/Scripts/Dymola/Media/Examples/WaterProperties.mos"
        "Simulate and plot"),
      Documentation(info="<html>
<p>
This example checks thermophysical properties of the medium.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 19, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end WaterProperties;
