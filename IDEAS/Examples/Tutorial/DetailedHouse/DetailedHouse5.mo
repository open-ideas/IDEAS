within IDEAS.Examples.Tutorial.DetailedHouse;
model DetailedHouse5 "New building model with two connected zones"
  extends Modelica.Icons.Example;

  replaceable package MediumAir = IDEAS.Media.Air "Air medium";
  parameter Modelica.Units.SI.Length l=8 "Zone length";
  parameter Modelica.Units.SI.Length w=4 "Zone width";
  parameter Modelica.Units.SI.Length h=2.8 "Zone height";

  inner IDEAS.BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  IDEAS.Buildings.Components.RectangularZoneTemplate recZon(
    redeclare package Medium = MediumAir,
    bouTypCei=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    aziA=IDEAS.Types.Azimuth.N,
    h=h,
    bouTypA=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    bouTypB=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    bouTypD=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    redeclare IDEAS.Buildings.Validation.Data.Constructions.HeavyWall conTypA,
    redeclare IDEAS.Buildings.Validation.Data.Constructions.HeavyWall conTypB,
    redeclare IDEAS.Buildings.Validation.Data.Constructions.HeavyWall conTypC,
    redeclare IDEAS.Buildings.Validation.Data.Constructions.HeavyWall conTypD,
    bouTypC=IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall,
    bouTypFlo=IDEAS.Buildings.Components.Interfaces.BoundaryType.SlabOnGround,
    l=w,
    w=l/2,
    hasWinA=true,
    A_winA=1.5*1.4,
    redeclare IDEAS.Buildings.Validation.Data.Constructions.LightRoof conTypCei,
    redeclare IDEAS.Buildings.Data.Glazing.Ins2Ar2020 glazingA,
    redeclare IDEAS.Buildings.Data.Constructions.FloorOnGround conTypFlo)
      "Northern part of the zone" annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  IDEAS.Buildings.Components.RectangularZoneTemplate recZon1(
    redeclare package Medium = MediumAir,
    aziA=IDEAS.Types.Azimuth.N,
    h=h,
    bouTypB=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    bouTypC=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    bouTypD=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    bouTypFlo=IDEAS.Buildings.Components.Interfaces.BoundaryType.SlabOnGround,
    bouTypCei=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    redeclare IDEAS.Buildings.Validation.Data.Constructions.HeavyWall conTypB,
    redeclare IDEAS.Buildings.Validation.Data.Constructions.HeavyWall conTypC,
    redeclare IDEAS.Buildings.Validation.Data.Constructions.HeavyWall conTypD,
    redeclare IDEAS.Buildings.Validation.Data.Constructions.LightRoof conTypCei,
    redeclare IDEAS.Buildings.Data.Constructions.FloorOnGround conTypFlo,
    bouTypA=IDEAS.Buildings.Components.Interfaces.BoundaryType.External,
    l=w,
    w=l/2,
    hasWinC=true,
    A_winC=1.5*1.4,
    redeclare IDEAS.Buildings.Data.Glazing.Ins2Ar2020 glazingC)
    "Southern part of the zone"
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
equation
  connect(recZon1.proBusA, recZon.proBusC) annotation (Line(
      points={{-6,-21},{-6,2},{6.8,2},{6.8,20.2}},
      color={255,204,51},
      thickness=0.5));
  annotation (Documentation(info="<html>
<p>
This example demonstrates the use of the <code>RectangularZoneTemplate</code>.
The one-zone implementation with one window of <a href=\"modelica://IDEAS.Examples.Tutorial.DetailedHouse.DetailedHouse1\">
IDEAS.Examples.Tutorial.DetailedHouse.DetailedHouse1</a> is replaced by 
a two-zone implementation with a north and a south-oriented window.
Note the different temperature responses of the zones. 
</p>
<h4>Required models</h4>
<ul>
<li>
<a href=\"modelica://IDEAS.BoundaryConditions.SimInfoManager\">
IDEAS.BoundaryConditions.SimInfoManager</a>
</li>
<li>
<a href=\"modelica://IDEAS.Buildings.Components.RectangularZoneTemplate\">
IDEAS.Buildings.Components.RectangularZoneTemplate</a>
</li>
<li>
Construction and glazing records from <a href=\"modelica://IDEAS.Examples.Tutorial.DetailedHouse.DetailedHouse1\">
IDEAS.Examples.Tutorial.DetailedHouse.DetailedHouse1</a>
</li>
</ul>
<h4>Connection instructions</h4>
<p>
The model consists of two <code>RectangularZoneTemplates</code> and a <code>SimInfoManager</code>. The required parameters are set in 
the templates, with careful attention to all tabs. The internal wall is defined in only one of the two 
templates, while an <i>external connection</i> is used for the other template. The <code>InternalWall</code> and 
<code>External</code> options cause a yellow bus connector to appear on each template, which must then be connected to each other.
The northern and southern wall both have a window of <i>1.5 m</i> by <i>1.4 m</i> (double glazing type <i>Saint Gobain Planitherm</i>).
</p>
<h4>Reference result</h4>
<p>
The figure below shows the operative zone temperatures of the zone with north oriented window (blue) and the zone with the south-oriented window (red). 
Note the large effect that the window placement has on the zone dynamics!
</p>
<p align=\"center\">
<img alt=\"Zone temperature for the zone with the north oriented window (blue) and the zone with the south
oriented window (red).\"
src=\"modelica://IDEAS/Resources/Images/Examples/Tutorial/DetailedHouse/DetailedHouse5.png\" width=\"700\"/>
</p>
</html>",
revisions="<html>
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
</html>"),
    experiment(
      StartTime=10000000,
      StopTime=11000000,
      __Dymola_NumberOfIntervals=5000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Examples/Tutorial/DetailedHouse/DetailedHouse5.mos"
        "Simulate and plot"));
end DetailedHouse5;
