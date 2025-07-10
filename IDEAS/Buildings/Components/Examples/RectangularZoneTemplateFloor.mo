within IDEAS.Buildings.Components.Examples;
model RectangularZoneTemplateFloor
  "This example illustrates and compares the use of SlabOnGround and OuterWall 
  as floor model in a room or building, using the RectangularZoneTemplate."
  extends Modelica.Icons.Example;
  inner BoundaryConditions.SimInfoManager sim "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  model Zone
    extends IDEAS.Buildings.Components.RectangularZoneTemplate(
      redeclare package Medium = IDEAS.Media.Air,
      h=2.7,
      l=8,
      w=6,
      aziA=IDEAS.Types.Azimuth.S,
      T_start=293.15,
      bouTypA=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
      redeclare IDEAS.Buildings.Validation.Data.Constructions.HeavyWall conTypA,
      bouTypB=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
      redeclare IDEAS.Buildings.Validation.Data.Constructions.HeavyWall conTypB,
      bouTypC=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
      redeclare IDEAS.Buildings.Validation.Data.Constructions.HeavyWall conTypC,
      bouTypD=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
      redeclare IDEAS.Buildings.Validation.Data.Constructions.HeavyWall conTypD,
      bouTypCei=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
      redeclare IDEAS.Buildings.Validation.Data.Constructions.LightRoof conTypCei,
      hasWinA=true,
      A_winA=12,
      fracA=0,
      redeclare IDEAS.Buildings.Validation.Data.Glazing.GlaBesTest glazingA,
      redeclare IDEAS.Buildings.Components.Shading.Interfaces.ShadingProperties shaTypA,
      hasWinB=false,
      hasWinC=false,
      hasWinD=false,
      hasWinCei=false);
  end Zone;

  Zone zonOutWal(
    bouTypFlo=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    redeclare IDEAS.Buildings.Data.Constructions.FloorOnGround conTypFlo)
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Zone zonSlaOnGro(
    bouTypFlo=IDEAS.Buildings.Components.Interfaces.BoundaryType.SlabOnGround,
    redeclare IDEAS.Buildings.Data.Constructions.FloorOnGround conTypFlo)
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=864000,
      Interval=60,
      Tolerance=1e-04,
      __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
<p>
This example illustrates and compares the use of <a href=modelica://IDEAS.Buildings.Components.SlabOnGround>SlabOnGround</a> 
and <a href=modelica://IDEAS.Buildings.Components.OuterWall>OuterWall</a> 
as floor model in a room or building, using the <a href=modelica://IDEAS.Buildings.Components.RectangularZoneTemplate>RectangularZoneTemplate</a>.
Both zones have identical settings, except for their floor type <code>bouTypFlo</code>, 
which is set as <code>SlabOnGround</code> and <code>OuterWall</code>, respectively.
As floor construction <code>conTypFlo</code>, the <code>UninsulatedFloor</code> construction has been chosen 
to see a bigger impact of the ground temperature <code>Tground</code> and the air temperature <code>Te</code> on the zone temperature <code>TSensor</code>.
</p>
</html>", revisions="<html>
<ul>
<li>
June 20, 2025, by Lucas Verleyen:<br>
Initial implementation. See <a href=\"https://github.com/open-ideas/IDEAS/pull/1431\">#1431</a>.
</li>
</ul>
</html>"));
end RectangularZoneTemplateFloor;
