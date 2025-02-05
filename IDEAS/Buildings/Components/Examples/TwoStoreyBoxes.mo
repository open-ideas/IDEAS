within IDEAS.Buildings.Components.Examples;
model TwoStoreyBoxes "Model with two zones on different floors, one zone above the other, with a large opening between these zones and stack-effect airflow enabled."
  extends Modelica.Icons.Example;

  inner BoundaryConditions.SimInfoManager sim(interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts,n50=1) annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  IDEAS.Buildings.Components.RectangularZoneTemplate Level(
    hFloor=5.25,
    T_start=291.15,
    bouTypA=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    bouTypB=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    bouTypC=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    bouTypD=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    bouTypFlo=IDEAS.Buildings.Components.Interfaces.BoundaryType.InternalWall,
    bouTypCei=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    aziOpt=3,
    l=5,
    w=5,
    h=5,
    A_winA=2,
    h_winA=2,
    redeclare Validation.Data.Constructions.LightRoof conTypCei,
    redeclare IDEAS.Buildings.Data.Constructions.ConcreteSlab conTypFlo,
    hasCavityFlo=true)
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));

  IDEAS.Buildings.Components.RectangularZoneTemplate Groundfloor(
    T_start=291.15,
    bouTypA=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    bouTypB=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    bouTypC=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    bouTypD=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
    bouTypFlo=IDEAS.Buildings.Components.Interfaces.BoundaryType.BoundaryWall,
    bouTypCei=IDEAS.Buildings.Components.Interfaces.BoundaryType.External,
    aziOpt=3,
    l=5,
    w=5,
    h=5,
    A_winA=2,
    h_winA=2,
    redeclare Validation.Data.Constructions.LightRoof conTypCei,
    redeclare Data.Constructions.FloorOnGround conTypFlo)
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));

  Modelica.Thermal.HeatTransfer.Celsius.FixedTemperature Tfix(T=18)
    annotation (Placement(transformation(extent={{62,20},{42,40}})));

  Modelica.Thermal.HeatTransfer.Components.ThermalConductor PerfectRadLevel(G=1e6)
    annotation (Placement(transformation(extent={{0,6},{20,26}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor PerfectRadGround(G=1e6)
    annotation (Placement(transformation(extent={{0,-52},{20,-32}})));
initial equation
  Level.gainCon.T=Tfix.port.T;
  Groundfloor.gainCon.T=Tfix.port.T;

equation
  connect(Groundfloor.proBusCei, Level.proBusFlo) annotation (Line(
      points={{-30.2,-24},{-30,-22},{-30,24}},
      color={255,204,51},
      thickness=0.5));
  connect(Tfix.port, Level.gainCon) annotation (Line(points={{42,30},{-16,30},{-16,
          27},{-20,27}}, color={191,0,0}));
  connect(PerfectRadLevel.port_a, Level.gainRad) annotation (Line(points={{0,16},
          {-14,16},{-14,24},{-20,24}}, color={191,0,0}));
  connect(PerfectRadLevel.port_b, Tfix.port) annotation (Line(points={{20,16},{32,
          16},{32,30},{42,30}}, color={191,0,0}));
  connect(PerfectRadGround.port_a, Groundfloor.gainRad) annotation (Line(points
        ={{0,-42},{-14,-42},{-14,-36},{-20,-36}}, color={191,0,0}));
  connect(Tfix.port, PerfectRadGround.port_b) annotation (Line(points={{42,30},{
          38,30},{38,-42},{20,-42}}, color={191,0,0}));
  connect(Tfix.port, Groundfloor.gainCon) annotation (Line(points={{42,30},{38,30},
          {38,-26},{-14,-26},{-14,-33},{-20,-33}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=1209600,
      Interval=3600.00288,
      Tolerance=1e-12,
      __Dymola_fixedstepsize=15,
      __Dymola_Algorithm="Dassl"),
    Documentation(revisions="<html>
<ul>
<li>
October 30, 2024, by Klaas De Jonge:<br/>
First implementation
</li>
</ul>
</html>", info="<html>
<p>Model with two zones on different floors, one zone above the other, with a large opening between these zones and stack-effect airflow enabled.</p>
</html>"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Buildings/Examples/TwoStoreyBoxes.mos"
        "Simulate and Plot"));
end TwoStoreyBoxes;
