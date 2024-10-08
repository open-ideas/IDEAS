within IDEAS.Buildings.Components.Validations;
model TwoStoreyBoxes
  extends Modelica.Icons.Example;

  inner BoundaryConditions.SimInfoManager sim(interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts,
      n50=1)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  RectangularZoneTemplate Level(
    redeclare package Medium = IDEAS.Media.Specialized.Air.PerfectGas,
    hFloor=5,
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

  RectangularZoneTemplate Groundfloor(
    redeclare package Medium = IDEAS.Media.Specialized.Air.PerfectGas,
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

  Modelica.Thermal.HeatTransfer.Components.ThermalConductor Con[2](each G=
        100000)
    annotation (Placement(transformation(extent={{0,32},{20,52}})));
  Modelica.Thermal.HeatTransfer.Celsius.FixedTemperature fixedTemperature[2](each T=
        18)
    annotation (Placement(transformation(extent={{60,20},{40,40}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor Rad[2](each G=
        100000)
    annotation (Placement(transformation(extent={{0,6},{20,26}})));


equation
  connect(Groundfloor.proBusCei, Level.proBusFlo) annotation (Line(
      points={{-30.2,-24},{-30,-22},{-30,24}},
      color={255,204,51},
      thickness=0.5));
  connect(Level.gainCon, Con[1].port_a) annotation (Line(points={{-20,27},{-6,27},
          {-6,42},{0,42}}, color={191,0,0}));
  connect(Groundfloor.gainCon, Con[2].port_a) annotation (Line(points={{-20,-33},
          {-20,-34},{-10,-34},{-10,28},{-6,28},{-6,42},{0,42}}, color={191,0,0}));
  connect(Level.gainRad, Rad[1].port_a) annotation (Line(points={{-20,24},{-4,24},
          {-4,16},{0,16}}, color={191,0,0}));
  connect(Groundfloor.gainRad, Rad[2].port_a) annotation (Line(points={{-20,-36},
          {-6,-36},{-6,16},{0,16}}, color={191,0,0}));
  connect(fixedTemperature.port, Con.port_b) annotation (Line(points={{40,30},{26,
          30},{26,42},{20,42}}, color={191,0,0}));
  connect(fixedTemperature.port, Rad.port_b) annotation (Line(points={{40,30},{26,
          30},{26,16},{20,16}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=1209600,
      Interval=3600.00288,
      Tolerance=1e-12,
      __Dymola_fixedstepsize=15,
      __Dymola_Algorithm="Dassl"));
end TwoStoreyBoxes;
