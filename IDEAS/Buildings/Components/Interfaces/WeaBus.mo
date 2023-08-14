within IDEAS.Buildings.Components.Interfaces;
expandable connector WeaBus "Data bus that stores weather data"
  parameter Integer numSolBus;
  parameter Boolean outputAngles = true "Set to false when linearising in Dymola only";

  IDEAS.Buildings.Components.Interfaces.RealConnector solTim(
    final unit="s",
    final quantity="Time",
    start=1) "Solar time";
  IDEAS.Buildings.Components.Interfaces.SolBus[numSolBus] solBus(each outputAngles=outputAngles) annotation ();
  IDEAS.Buildings.Components.Interfaces.RealConnector Te(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    min = 0.0,
    start = 293.15,
    nominal = 300,
    displayUnit="degC") "Ambient sensible temperature" annotation ();
  IDEAS.Buildings.Components.Interfaces.RealConnector Tdes(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    min = 0.0,
    start = -8 + 273.15,
    nominal = 300,
    displayUnit="degC") "Design temperature?" annotation ();
  IDEAS.Buildings.Components.Interfaces.RealConnector TGroundDes(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    min = 0.0,
    start = 283.15,
    nominal = 300,
    displayUnit="degC")
    "Design ground temperature" annotation ();
  IDEAS.Buildings.Components.Interfaces.RealConnector Va(unit="m/s", start=0) "Wind speed" annotation ();
  IDEAS.Buildings.Components.Interfaces.RealConnector Vdir(unit="rad", start=0) "Wind direction" annotation ();

  IDEAS.Buildings.Components.Interfaces.RealConnector X_wEnv(start=0.01) "Environment air water mass fraction"
                                annotation ();
  IDEAS.Buildings.Components.Interfaces.RealConnector CEnv(start=1e-6) "Environment air trace substance mass fraction"
                                annotation ();
  IDEAS.Buildings.Components.Interfaces.RealConnector dummy(start=1)
    "Dummy variable of value 1 to include constant term in linearization (see SlabOnGround)"
    annotation ();
  IDEAS.Buildings.Components.Interfaces.RealConnector TskyPow4(start=273^4),TePow4(start=273^4), solGloHor(start=100), solDifHor(start=100), F1(start=0.1), F2(start=-0.1), angZen(start=1), angHou(start=1), angDec(start=1), solDirPer(start=1), phi(start=1);
  annotation (
    defaultComponentName="weaBus",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={Rectangle(
          extent={{-20,2},{22,-2}},
          lineColor={255,204,51},
          lineThickness=0.5),
          Rectangle(
            lineColor={255,204,51},
            lineThickness=0.5,
            extent={{-20,-2},{20,2}}),
          Polygon(
            fillColor={255,215,136},
            fillPattern=FillPattern.Solid,
            points={{-80,50},{80,50},{100,30},{80,-40},{60,-50},{-60,-50},{-80,-40},
              {-100,30}},
            smooth=Smooth.Bezier),
          Ellipse(
            fillPattern=FillPattern.Solid,
            extent={{-65,15},{-55,25}}),
          Ellipse(
            fillPattern=FillPattern.Solid,
            extent={{-5,15},{5,25}}),
          Ellipse(
            fillPattern=FillPattern.Solid,
            extent={{55,15},{65,25}}),
          Ellipse(
            fillPattern=FillPattern.Solid,
            extent={{-35,-25},{-25,-15}}),
          Ellipse(
            fillPattern=FillPattern.Solid,
            extent={{25,-25},{35,-15}})}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}})),
    Documentation(info="<html>
<p>
Connector that contains all environment information for many inclinations and tilt angles.
</p>
</html>",
   revisions="<html>
<ul>
<li>
April 20, 2023 by Jelger Jansen:<br/>
Make the connector expandable to avoid (pedantic check) warnings in Dymola 2022x.
See issue <a href=https://github.com/open-ideas/IDEAS/issues/1317>#1317</a>
</li>
<li>
November 28, 2019, by Ian Beausoleil-Morrison:<br/>
Removed hConExt from weather bus because it is not calculated in ExtConvForcedCoeff.mo and ExteriorConvection.mo.<br/>
Added wind speed and direction to weather bus.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1089\">
#1089</a>
</li>
<li>
March 27, 2018, by Filip Jorissen:<br/>
Added relative humidity to weather bus.
See issue <a href=https://github.com/open-ideas/IDEAS/issues/780>#780</a>
</li>
<li>
January 25, 2018 by Filip Jorissen:<br/>
Added <code>solTim</code> connections for revised azimuth computations.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/753\">
#753</a>.
</li>
<li>
March 21, 2017, by Filip Jorissen:<br/>
Changed Reals into connectors for JModelica compatibility.
Other compatibility changes. 
See issue <a href=https://github.com/open-ideas/IDEAS/issues/559>#559</a>.
</li>
<li>
October 22, 2016, by Filip Jorissen:<br/>
Revised documentation for IDEAS 1.0.
</li>
<li>
June 25, 2010, by Wangda Zuo:<br/>
First implementation.
</li>
</ul>
</html>"));
end WeaBus;
