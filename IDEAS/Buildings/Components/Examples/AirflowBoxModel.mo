within IDEAS.Buildings.Components.Examples;
model AirflowBoxModel
  extends Modelica.Icons.Example;

  Box_Sim Energy_Only(sim(interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None))
    "Model not including a pressure network or n50 correction, the default IDEAS implementation."
                                                                                                        annotation (Placement(transformation(rotation=0, extent={{-110,30},
            {-50,90}})));
  Box_Sim Energy_n50Corr(sim(interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None, unify_n50=true))
    "Model not including a pressure network with n50 correction on building level."
                                                                                                                           annotation (Placement(transformation(rotation=0,
          extent={{-30,30},{30,90}})));
  Box_Sim IAQ_1port(sim(interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.OnePort))
    "Model including a 1-port pressure network."
    annotation (Placement(transformation(rotation=0, extent={{-110,-90},{-50,
            -30}})));
  Box_Sim IAQ_1port_trickle(sim(interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.OnePort),
      winD(
      use_trickle_vent=true,
      m_flow_nominal=0.0192656,
      dp_nominal=2))
    "Model including a 1-port pressure network and a tricklevent in the window"
                     annotation (Placement(transformation(rotation=0, extent={{-30,-90},
            {30,-30}})));
  Box_Sim IAQ_2Port(
    PerfectRad(G=10000000),
    sim(interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts),
    use_operable_window=true,
    winD(
      crackOrOperableDoor(nCom=2),
      use_trickle_vent=false,
      m_flow_nominal=0.0192656,
      dp_nominal=2),
    winD_position(y=0)) "Model including a 2-port pressure network."
                        annotation (Placement(transformation(rotation=0, extent
          ={{50,-90},{110,-30}})));

protected
  model Box_Sim
    inner BoundaryConditions.SimInfoManager sim(interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts,
        n50=1,
      HPres=10)
      annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
      parameter Boolean use_operable_window=false
      "= true, to enable window control input";

    IDEAS.Buildings.Components.RectangularZoneTemplate BoxModel(
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

    Modelica.Thermal.HeatTransfer.Celsius.FixedTemperature Tfix(T=18)
      annotation (Placement(transformation(extent={{20,40},{0,60}})));
    Modelica.Thermal.HeatTransfer.Components.ThermalConductor PerfectRad(G=1e6)
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

  initial equation
    BoxModel.gainCon.T=Tfix.port.T;

  equation
    connect(BoxModel.gainRad, PerfectRad.port_a) annotation (Line(points={{-60,
            44},{-46,44},{-46,36},{-40,36}}, color={191,0,0}));
    connect(PerfectRad.port_b, Tfix.port) annotation (Line(points={{-20,36},{-14,
            36},{-14,50},{0,50}}, color={191,0,0}));
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
    connect(Tfix.port, BoxModel.gainCon) annotation (Line(points={{0,50},{-56,
            50},{-56,47},{-60,47}}, color={191,0,0}));
    annotation (Icon(graphics={Rectangle(
            extent={{-60,60},{60,-60}},
            lineColor={28,108,200},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid), Text(
            extent={{-100,-60},{98,-100}},
            textColor={28,108,200},
            textString="%name"),
          Rectangle(
            extent={{-48,48},{48,-48}},
            lineColor={28,108,200},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}));
  end Box_Sim;
  annotation (experiment(
      StopTime=1209600,
      Interval=3600.00288,
      Tolerance=1e-07,
      __Dymola_fixedstepsize=15,
      __Dymola_Algorithm="Dassl"), Documentation(info="<html>
<p>This model runs 5 possible interzonal airflow configurations of a simple box model. Temperature is kept constant at 18&deg; degrees </p>
</html>", revisions="<html>
<ul>
<li>
October 30, 2024 by Klaas De Jonge:<br/>
First documented implementation.
</li>
</ul>
</html>"),
    Diagram(coordinateSystem(extent={{-120,-100},{120,100}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})),
        __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Buildings/Components/Examples/AirflowOptions.mos"
        "Simulate and plot"));
end AirflowBoxModel;
