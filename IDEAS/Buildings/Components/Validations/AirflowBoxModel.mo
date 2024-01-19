within IDEAS.Buildings.Components.Validations;
model AirflowBoxModel
  extends Modelica.Icons.Example;


  Box_Sim Energy_Only(sim(interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None)) annotation (Placement(transformation(rotation=0, extent={{-82,18},{-22,78}})));
  Box_Sim Energy_n50Corr(sim(interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None, unify_n50=true)) annotation (Placement(transformation(rotation=0,
          extent={{20,20},{80,80}})));
  Box_Sim IAQ_1port(sim(interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.OnePort), winD(
      use_trickle_vent=true,
      m_flow_nominal=50*1.2041/3600,
      dp_nominal=2))                                                                                     annotation (Placement(transformation(rotation=0,extent={{-80,-80},{-20,-20}})));
  Box_Sim IAQ_2Port(sim(interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts),
    use_operable_window=true,
    winD(crackOrOperableDoor(nCom=2),
      use_trickle_vent=true,
      m_flow_nominal=50*1.2041/3600,
      dp_nominal=2),
    winD_position(y=1),
    Con(G=10000000),
    Rad(G=10000000))                                                                                                                                                             annotation (Placement(transformation(rotation=0,
          extent={{20,-80},{80,-20}})));
protected
  model Box_Sim
    inner BoundaryConditions.SimInfoManager sim(interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts,
        n50=1)
      annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
      parameter Boolean use_operable_window=false
      "= true, to enable window control input";

    RectangularZoneTemplate BoxModel(
      T_start=291.15,
      bouTypA=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
      bouTypB=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
      bouTypC=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
      bouTypD=IDEAS.Buildings.Components.Interfaces.BoundaryType.External,
      bouTypFlo=IDEAS.Buildings.Components.Interfaces.BoundaryType.BoundaryWall,
      bouTypCei=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
      nExtD=2,
      hasWinC=true,
      aziOpt=3,
      l=5,
      w=5,
      h=5,
      A_winA=2,
      A_winB=2,
      A_winC=2,
      A_winD=2,
      h_winA=2,
      h_winB=2,
      h_winC=2,
      h_winD=2,
      redeclare IDEAS.Buildings.Validation.Data.Constructions.LightRoof
        conTypCei,
      redeclare IDEAS.Buildings.Data.Constructions.FloorOnGround conTypFlo,
      redeclare IDEAS.Buildings.Data.Glazing.Ins2Ar2020 glazingC,
      redeclare IDEAS.Buildings.Data.Frames.AluminumInsulated fraTypC)
      annotation (Placement(transformation(extent={{-80,40},{-60,60}})));

    Modelica.Thermal.HeatTransfer.Components.ThermalConductor Con(G=100000)
      annotation (Placement(transformation(extent={{-40,52},{-20,72}})));
    Modelica.Thermal.HeatTransfer.Celsius.FixedTemperature fixedTemperature(T=
          18) annotation (Placement(transformation(extent={{20,40},{0,60}})));
    Modelica.Thermal.HeatTransfer.Components.ThermalConductor Rad(G=100000)
      annotation (Placement(transformation(extent={{-40,26},{-20,46}})));
    OuterWall outD(
      redeclare IDEAS.Buildings.Data.Constructions.CavityWall constructionType,
      incOpt=1,
      aziOpt=2,
      A=23) annotation (Placement(transformation(extent={{-106,46},{-94,66}})));
    Window winD(
      redeclare IDEAS.Buildings.Data.Glazing.Ins2Ar2020 glazing,
      A=2,
      hWin=2,
      redeclare IDEAS.Buildings.Data.Frames.AluminumInsulated fraType,
      use_operable_window=use_operable_window)
      annotation (Placement(transformation(extent={{-106,22},{-94,42}})));
    Modelica.Blocks.Sources.RealExpression winD_position(y=0) if use_operable_window
      annotation (Placement(transformation(extent={{-140,0},{-120,20}})));

  equation
    connect(BoxModel.gainCon, Con.port_a) annotation (Line(points={{-60,47},{
            -46,47},{-46,62},{-40,62}}, color={191,0,0}));
    connect(fixedTemperature.port, Con.port_b) annotation (Line(points={{0,50},
            {-14,50},{-14,62},{-20,62}}, color={191,0,0}));
    connect(BoxModel.gainRad, Rad.port_a) annotation (Line(points={{-60,44},{
            -46,44},{-46,36},{-40,36}}, color={191,0,0}));
    connect(Rad.port_b, fixedTemperature.port) annotation (Line(points={{-20,36},
            {-14,36},{-14,50},{0,50}}, color={191,0,0}));
    connect(outD.propsBus_a, BoxModel.proBusD[1]) annotation (Line(
        points={{-95,58},{-88,58},{-88,42.5},{-79.6,42.5}},
        color={255,204,51},
        thickness=0.5));
    connect(winD.propsBus_a, BoxModel.proBusD[2]) annotation (Line(
        points={{-95,34},{-88,34},{-88,43.5},{-79.6,43.5}},
        color={255,204,51},
        thickness=0.5));
    connect(winD_position.y, winD.y_window)
      annotation (Line(points={{-119,10},{-102,10},{-102,22}}, color={0,0,127}));
    annotation (Icon(graphics={Rectangle(
            extent={{-60,60},{60,-60}},
            lineColor={28,108,200},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid), Text(
            extent={{-100,-60},{98,-100}},
            textColor={28,108,200},
            textString="%name")}));
  end Box_Sim;
  annotation (experiment(
      StopTime=1209600,
      Interval=3600.00288,
      Tolerance=1e-07,
      __Dymola_fixedstepsize=15,
      __Dymola_Algorithm="Dassl"), Documentation(info="<html>
This model runs the 4 possible interzonal airflow configurations of a simple box model. Temperature is kept constant at 18° degrees

</html>"));
end AirflowBoxModel;
