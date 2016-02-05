within IDEAS.Buildings.Components.Interfaces;
expandable connector WeaBus "Data bus that stores weather data"
  extends Modelica.Icons.SignalBus;
  parameter Integer numSolBus;
  parameter Boolean outputAngles = true "Set to false when linearising only";

  IDEAS.Buildings.Components.Interfaces.SolBus[numSolBus] solBus(each outputAngles=outputAngles) annotation ();
  Modelica.SIunits.Temperature Te(start = 293.15)
    "Ambient sensible temperature"                                               annotation ();

  Real hConExt(unit="W/(m2.K)", start = 18.3)
    "Exterior convective heat transfer coefficient"                                           annotation ();

  Real dummy(start=1)
    "Dummy variable of value 1 to include constant term in linearization (see SlabOnGround)"
    annotation ();
  Modelica.SIunits.Temperature TGroundDes(start=283.15)
    "Design ground temperature" annotation ();
  annotation (
    defaultComponentName="weaBus",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={Rectangle(
          extent={{-20,2},{22,-2}},
          lineColor={255,204,51},
          lineThickness=0.5)}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}})),
    Documentation(info="<html>
<p>
This component is an expandable connector that is used to implement a bus that contains the weather data.
</p>
</html>
", revisions="<html>
<ul>
<li>
June 25, 2010, by Wangda Zuo:<br/>
First implementation.
</li>
</ul>
</html>"));
end WeaBus;
