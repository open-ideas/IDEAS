within IDEAS.Buildings.Components.Validations;
model AirflowBoxModel
  extends Modelica.Icons.Example;


  Box_Sim Energy_Only(sim(interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None))
    annotation (Placement(transformation(rotation=0, extent={{-82,18},{-22,78}})));
  Box_Sim Energy_n50Corr(sim(interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None,
        unify_n50=true)) annotation (Placement(transformation(rotation=0,
          extent={{20,20},{80,80}})));
  Box_Sim IAQ_1port(sim(interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.OnePort,
        unify_n50=true)) annotation (Placement(transformation(rotation=0,
          extent={{-80,-80},{-20,-20}})));
  Box_Sim IAQ_2Port(sim(interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts,
        unify_n50=true)) annotation (Placement(transformation(rotation=0,
          extent={{20,-80},{80,-20}})));
protected
  model Box_Sim
    inner BoundaryConditions.SimInfoManager sim(interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts,
        n50=1)
      annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
    RectangularZoneTemplate BoxModel(
      T_start=291.15,
      bouTypA=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
      bouTypB=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
      bouTypC=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
      bouTypD=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
      bouTypFlo=IDEAS.Buildings.Components.Interfaces.BoundaryType.BoundaryWall,
      bouTypCei=IDEAS.Buildings.Components.Interfaces.BoundaryType.OuterWall,
      hasWinC=true,
      aziOpt=3,
      l=5,
      w=5,
      h=5,
      A_winA=2,
      A_winC=2,
      h_winA=2,
      h_winC=2,
      redeclare IDEAS.Buildings.Validation.Data.Constructions.LightRoof
        conTypCei,
      redeclare IDEAS.Buildings.Data.Constructions.FloorOnGround conTypFlo)
      annotation (Placement(transformation(extent={{-80,40},{-60,60}})));

    Modelica.Thermal.HeatTransfer.Components.ThermalConductor Con(G=100000)
      annotation (Placement(transformation(extent={{-40,52},{-20,72}})));
    Modelica.Thermal.HeatTransfer.Celsius.FixedTemperature fixedTemperature(T=
          18) annotation (Placement(transformation(extent={{20,40},{0,60}})));
    Modelica.Thermal.HeatTransfer.Components.ThermalConductor Rad(G=100000)
      annotation (Placement(transformation(extent={{-40,26},{-20,46}})));
  equation
    connect(BoxModel.gainCon, Con.port_a) annotation (Line(points={{-60,47},{
            -46,47},{-46,62},{-40,62}}, color={191,0,0}));
    connect(fixedTemperature.port, Con.port_b) annotation (Line(points={{0,50},
            {-14,50},{-14,62},{-20,62}}, color={191,0,0}));
    connect(BoxModel.gainRad, Rad.port_a) annotation (Line(points={{-60,44},{
            -46,44},{-46,36},{-40,36}}, color={191,0,0}));
    connect(Rad.port_b, fixedTemperature.port) annotation (Line(points={{-20,36},
            {-14,36},{-14,50},{0,50}}, color={191,0,0}));
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
