within IDEAS.Examples.Tutorial.DetailedHouse;
model DetailedHouse1 "First example model of a one-zone building"
  extends Modelica.Icons.Example;
  package MediumAir = IDEAS.Media.Air "Air medium";

  parameter Modelica.Units.SI.Length l=8 "Zone length";
  parameter Modelica.Units.SI.Length w=4 "Zone width";
  parameter Modelica.Units.SI.Length h=zon.hZone "Zone height (Default)";

  // SimInfoManager must be 'inner' at the top level
  inner IDEAS.BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  IDEAS.Buildings.Components.Zone zon(
    redeclare package Medium = MediumAir,
    nSurf=7,
    V=l*h*w)
    "Zone model" annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  IDEAS.Buildings.Components.OuterWall outWalWes(
    redeclare IDEAS.Buildings.Validation.Data.Constructions.HeavyWall
      constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.W,
    A=l*h) "Western outer wall model"
    annotation (Placement(transformation(extent={{-60,10},{-48,30}})));
  IDEAS.Buildings.Components.OuterWall outWalEas(
    redeclare IDEAS.Buildings.Validation.Data.Constructions.HeavyWall
      constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.E,
    A=l*h) "Eastern outer wall model"
    annotation (Placement(transformation(extent={{40,0},{28,20}})));
  IDEAS.Buildings.Components.OuterWall outWalNor(
    redeclare IDEAS.Buildings.Validation.Data.Constructions.HeavyWall
      constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.N,
    A=w*h) "Northern outer wall model"
     annotation (Placement(transformation(
        extent={{6,-10},{-6,10}},
        rotation=90,
        origin={-10,54})));
  IDEAS.Buildings.Components.OuterWall outWalSou(
    redeclare IDEAS.Buildings.Validation.Data.Constructions.HeavyWall
      constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S,
    A=w*h - win.A) "Southern outer wall model"
     annotation (Placement(transformation(
        extent={{-6,-10},{6,10}},
        rotation=90,
        origin={-10,-34})));
  IDEAS.Buildings.Components.Window win(
    inc=IDEAS.Types.Tilt.Wall,
    A=3*1.4,
    azi=IDEAS.Types.Azimuth.S,
    redeclare IDEAS.Buildings.Data.Glazing.Ins2Ar2020 glazing)
    "Window model" annotation (Placement(transformation(extent={{-6,-10},{6,10}},
        rotation=0,
        origin={-54,-10})));

  IDEAS.Buildings.Components.SlabOnGround slaOnGro(
    redeclare IDEAS.Buildings.Data.Constructions.FloorOnGround constructionType,
    inc=IDEAS.Types.Tilt.Floor,
    azi=IDEAS.Types.Azimuth.S,
    A=l*w) "Floor model" annotation (Placement(transformation(
        extent={{-6,-11},{6,11}},
        rotation=90,
        origin={30,-35})));
  IDEAS.Buildings.Components.OuterWall cei(
    redeclare IDEAS.Buildings.Validation.Data.Constructions.LightRoof
      constructionType,
    inc=IDEAS.Types.Tilt.Ceiling,
    A=w*l) "Ceiling model" annotation (Placement(transformation(
        extent={{6,-10},{-6,10}},
        rotation=90,
        origin={30,54})));
equation
  connect(outWalWes.propsBus_a, zon.propsBus[1]) annotation (Line(
      points={{-49,22},{-30,22},{-30,14},{-20,14},{-20,13.1429}},
      color={255,204,51},
      thickness=0.5));
  connect(zon.propsBus[2], outWalNor.propsBus_a) annotation (Line(
      points={{-20,13.4286},{-22,13.4286},{-22,30},{-12,30},{-12,49}},
      color={255,204,51},
      thickness=0.5));
  connect(zon.propsBus[3], outWalEas.propsBus_a) annotation (Line(
      points={{-20,13.7143},{-20,14},{-22,14},{-22,30},{20,30},{20,12},{29,12}},
      color={255,204,51},
      thickness=0.5));
  connect(outWalSou.propsBus_a, zon.propsBus[4]) annotation (Line(
      points={{-12,-29},{-12,-10},{-20,-10},{-20,14}},
      color={255,204,51},
      thickness=0.5));
  connect(win.propsBus_a, zon.propsBus[5]) annotation (Line(
      points={{-49,-8},{-30,-8},{-30,14},{-20,14},{-20,14.2857}},
      color={255,204,51},
      thickness=0.5));
  connect(slaOnGro.propsBus_a, zon.propsBus[6]) annotation (Line(
      points={{27.8,-30},{28,-30},{28,-10},{-20,-10},{-20,14.5714}},
      color={255,204,51},
      thickness=0.5));
  connect(cei.propsBus_a, zon.propsBus[7]) annotation (Line(
      points={{28,49},{28,30},{-22,30},{-22,14.8571},{-20,14.8571}},
      color={255,204,51},
      thickness=0.5));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StartTime=10000000,
      StopTime=11000000,
      __Dymola_NumberOfIntervals=5000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Examples/Tutorial/DetailedHouse/DetailedHouse1.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
This first example instantiates a simple building model that consists of one zone, four walls,
a window, a floor and a ceiling.  The zone dimensions are <i>8 m</i> (with walls oriented 
north and south) by <i>4 m</i>, and the window measures <i>3 m</i> by <i>1.4 m</i>. Use the default 
zone height of <i>2.8 m</i>. Apply double glazing and a heavy wall, which provide high thermal mass.
</p>
<h4>Required models</h4>
<ul>
<li>
<a href=\"modelica://IDEAS.BoundaryConditions.SimInfoManager\">
IDEAS.BoundaryConditions.SimInfoManager</a>
</li>
<li>
<a href=\"modelica://IDEAS.Buildings.Components.Zone\">
 IDEAS.Buildings.Components.Zone</a>
</li>
<li>
<a href=\"modelica://IDEAS.Buildings.Components.OuterWall\">
IDEAS.Buildings.Components.OuterWall</a>
</li>
<li>
<a href=\"modelica://IDEAS.Buildings.Components.Window\">
IDEAS.Buildings.Components.Window</a>
</li>
<li>
<a href=\"modelica://IDEAS.Buildings.Components.SlabOnGround\">
IDEAS.Buildings.Components.SlabOnGround</a>
</li>
</ul>
<h4>Connection instructions</h4>
<p>
Each yellow bus connector of a surface (<code>Window</code>, <code>OuterWall</code>
or <code>SlabOnGround</code>) has to be connected to exactly one zone bus connector. 
To support multiple connections, the zone has an array of bus connectors with size 
<code>nSurf</code>, where <code>nSurf</code> is a parameter of <code>Zone</code>, 
which has to be set by the user. It is the user’s responsibility to ensure that each 
element of this array is connected to exactly one surface and that there is a total 
of <code>nSurf</code> connections to the zone.
</p>
<p>
In addition to connecting each surface, the parameters of each component have to be set. Components typically
have many default values that are appropriate for many purposes. When a parameter does not have a default
value, it must be set by the user. Notable examples are the dimensions and orientation of the zone, walls
and windows. The surface orientation can be set using the parameters <code>incOpt</code>, which automatically sets the
inclination depending on the type of outer wall (wall, floor, ceiling), and <code>aziOpt</code>, which automatically sets the
azimuth (north, east, south, west). Furthermore, the zone Medium must be set to <a href=\"modelica://IDEAS.Media.Air\">
IDEAS.Media.Air</a>. Glazing and wall types must also be specified. This example uses the <i>BESTEST Heavy Wall</i> for the
walls, the <i>FloorOnGround</i> construction type for the floor, the <i>BESTEST light roof</i> for the roof and the double glazing
type <i>Saint Gobain Planitherm</i> and a south orientation for the window.
</p>
<p>
The <code>SimInfoManager</code> by default has the modifier <code>inner</code> in its declaration. All IDEAS building components
have the modifier <code>outer</code> in their respective declarations of the <code>SimInfoManager</code>. This causes the component
declarations to point towards the higher level <code>SimInfoManager</code> declaration. This way all model equations for
the weather data have to be generated only once, instead of for each surface.
</p>
<h4>Reference result</h4>
<p>
This model is simulated with the following settings:
</p>
<ol>
<li>Dassl as the solver with tolerance = 1e-06 </li>
<li>Start time = 1e7,</li>
<li>Stop time = 1.1e7,</li>
<li>Number of intervals = 5000.</li>
</ol>
<p>
The simulation starts 10<sup>7</sup> seconds after New Year and ends 10<sup>6</sup> seconds later, covering a period of 11.6 days. 
The figure below shows the operative zone temperature, <code>zon.TSensor</code>, 
which represents the mean of the air temperature and the mean radiative temperature of all surfaces.
</p>
<p align=\"center\">
<img alt=\"Zone temperature as function of time.\"
src=\"modelica://IDEAS/Resources/Images/Examples/Tutorial/DetailedHouse/DetailedHouse1.png\" width=\"700\"/>
</p>
</html>", revisions="<html>
<ul>
<li>
April 14, 2025, by Anna Dell'Isola and Lone Meertens:<br/>
Update and restructure IDEAS tutorial models.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1374\">#1374</a> 
and <a href=\"https://github.com/open-ideas/IDEAS/issues/1389\">#1389</a>.
</li>
<li>
September 18, 2019 by Filip Jorissen:<br/>
First implementation for the IDEAS crash course.
</li>
</ul>
</html>"));
end DetailedHouse1;
