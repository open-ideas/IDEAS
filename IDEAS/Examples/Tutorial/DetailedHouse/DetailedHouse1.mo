within IDEAS.Examples.Tutorial.DetailedHouse;
model DetailedHouse1 "First example model containing one zone"
  extends Modelica.Icons.Example;
  package Medium = IDEAS.Media.Air "Air medium";

  parameter Modelica.Units.SI.Length l=8 "Zone length";
  parameter Modelica.Units.SI.Length w=4 "Zone width";
  parameter Modelica.Units.SI.Length h=zone.hZone "Zone height (Default)";

  //SimInfoManager must be 'inner' at the top level
  inner IDEAS.BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  IDEAS.Buildings.Components.Zone zone(
    redeclare package Medium = Medium,
    nSurf=6,
    V=l*h*w)
    "Zone model" annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  IDEAS.Buildings.Components.OuterWall outerWall(
    redeclare IDEAS.Buildings.Validation.Data.Constructions.HeavyWall
      constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.W,
    A=l*h)
    "Outer wall model"
    annotation (Placement(transformation(extent={{-56,0},{-44,20}})));
  IDEAS.Buildings.Components.OuterWall outerWall1(
    redeclare IDEAS.Buildings.Validation.Data.Constructions.HeavyWall
      constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.E,
    A=l*h)
    "Outer wall model"
    annotation (Placement(transformation(extent={{36,0},{24,20}})));
  IDEAS.Buildings.Components.OuterWall outerWall2(
    redeclare IDEAS.Buildings.Validation.Data.Constructions.HeavyWall
      constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.N,
    A=w*h)
    "Outer wall model"
     annotation (Placement(transformation(
        extent={{6,-10},{-6,10}},
        rotation=90,
        origin={-10,52})));
  IDEAS.Buildings.Components.OuterWall outerWall3(
    redeclare IDEAS.Buildings.Validation.Data.Constructions.HeavyWall
      constructionType,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S,
    A=w*h - window.A)
    "Outer wall model"
     annotation (Placement(transformation(
        extent={{-6,-10},{6,10}},
        rotation=90,
        origin={-10,-30})));
  IDEAS.Buildings.Components.Window window(
    inc=IDEAS.Types.Tilt.Wall,
    A=3*1.4,
    azi=IDEAS.Types.Azimuth.S,
    redeclare TwinHouses.BaseClasses.Data.Materials.Glazing glazing)
    "Window model" annotation (Placement(transformation(extent={{-6,-10},{6,10}},
        rotation=90,
        origin={-36,-30})));

  Buildings.Components.SlabOnGround slabOnGround(
    redeclare Buildings.Validation.Data.Constructions.HeavyFloor
      constructionType,
    inc=IDEAS.Types.Tilt.Floor,
    azi=IDEAS.Types.Azimuth.S,
    A=l*w) annotation (Placement(transformation(extent={{74,-32},{86,-10}})));
equation
  connect(outerWall.propsBus_a, zone.propsBus[1]) annotation (Line(
      points={{-45,12},{-38.5,12},{-38.5,13.1429},{-20,13.1429}},
      color={255,204,51},
      thickness=0.5));
  connect(zone.propsBus[2], outerWall2.propsBus_a) annotation (Line(
      points={{-20,13.4286},{-22,13.4286},{-22,47},{-12,47}},
      color={255,204,51},
      thickness=0.5));
  connect(zone.propsBus[3], outerWall1.propsBus_a) annotation (Line(
      points={{-20,13.7143},{-20,28},{25,28},{25,12}},
      color={255,204,51},
      thickness=0.5));
  connect(outerWall3.propsBus_a, zone.propsBus[4]) annotation (Line(
      points={{-12,-25},{-12,-6},{-20,-6},{-20,14}},
      color={255,204,51},
      thickness=0.5));
  connect(window.propsBus_a, zone.propsBus[5]) annotation (Line(
      points={{-38,-25},{-38,14},{-20,14},{-20,14.2857}},
      color={255,204,51},
      thickness=0.5));
  connect(slabOnGround.propsBus_a, zone.propsBus[6]) annotation (Line(
      points={{85,-18.8},{94,-18.8},{94,-6},{-20,-6},{-20,14.8333}},
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
      __Dymola_Algorithm="Lsodar"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Examples/Tutorial/DetailedHouse/DetailedHouse1.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
This first example file instantiates a simple building model that consists of one zone, four walls,
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
<a href=\"modelica://IDEAS.Buildings.Components.InternalWall\">
IDEAS.Buildings.Components.InternalWall</a>
</li>
</ul>
<h4>Connection instructions</h4>
<p>
Each yellow bus connector of a surface (<code>Window</code>, <code>OuterWall</code>
or <code>InternalWall</code>) has to be connected to exactly one zone bus connector. 
To support multiple connections, the zone has an array of bus connectors with size 
<code>nSurf</code>, where <code>nSurf</code> is a parameter of <code>Zone</code>, 
which has to be set by the user. It is the user’s responsibility to ensure that each 
element of this array is connected to exactly one surface and that there is a total 
of <code>nSurf</code> connections to the zone.
</p>
<p>
In addition to connecting each surface, the parameters of each component have to be set. Components typically
have many default values that are appropriate for many purposes. When parameters do not have a default
value, it must be set by the user. Notable examples are the dimensions and orientation of the zone, walls
and windows. The surface orientation can be set using the parameters <code>incOpt</code>, which automatically sets the
inclination depending on the type of outer wall (wall, floor, ceiling), and <code>aziOpt</code>, which automatically sets the
azimuth (north, east, south, west). Furthermore, the zone Medium must be set to <a href=\"modelica://IDEAS.Media.Air\">
IDEAS.Media.Air</a>. Glazing and wall types must also be specified. This example uses the <i>BESTEST Heavy Wall</i> for the
walls, the <i>BESTEST Heavy Floor</i> for the floor, the <i>BESTEST ligth roof</i> for the roof and the double glazing
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
<li>Start time = 1e7,</li>
<li>Stop time = 1.1e7,</li>
<li>Number of intervals = 5000.</li>
</ol>
<p>
The simulation starts 10<sup>7</sup> seconds after New Year and ends 10<sup>6</sup> seconds later, covering a period of 11.6 days. 
The zone temperature, <code>zone.TSensor</code>, is plotted, which represents the mean of the air temperature and the mean radiative temperature of all surfaces. The results are shown in the figure below.
</p>
<p align=\"center\">
<img alt=\"Zone temperature as function of time.\"
src=\"modelica://IDEAS/Resources/Images/Examples/Tutorial/DetailedHouse/DetailedHouse1.png\" width=\"700\"/>
</p>
</html>", revisions="<html>
<ul>
<li>
September 18, 2019 by Filip Jorissen:<br/>
First implementation for the IDEAS crash course.
</li>
</ul>
</html>"));
end DetailedHouse1;
