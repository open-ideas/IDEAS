within IDEAS.Fluid.HeatExchangers.FanCoilUnits.Examples;
model TwoPipeCooExample
  extends Modelica.Icons.Example
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));

  TwoPipeCoo twoPipeCoo(
    mAir_flow_nominal=0.12,
    dpWat_nominal(displayUnit="Pa") = 10000,
    use_Q_flow_nominal=true,
    eps_nominal=1,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    deltaTCoo_nominal=5,
    Q_flow_nominal=2000,
    allowFlowReversal=false,
    T_a1_nominal=300.15,
    T_a2_nominal=280.15) "Fan coil unit model"
    annotation (Placement(transformation(extent={{50,-6},{74,18}})));
  SensibleCooler_T
           coo(
    m_flow_nominal=twoPipeCoo.mWat_flow_nominal,
    dp_nominal=0,
    redeclare package Medium = IDEAS.Media.Water,
    QMin_flow=-5000) "Cooler component"
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  IDEAS.Fluid.Sources.Boundary_pT bou(
    nPorts=1,
    redeclare package Medium = IDEAS.Media.Water,
    p=200000) "Water boundary"
    annotation (Placement(transformation(extent={{-90,-36},{-70,-16}})));
  Movers.FlowControlled_m_flow pump(
    redeclare package Medium = IDEAS.Media.Water,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    allowFlowReversal=false,
    addPowerToMedium=false,
    tau=60,
    use_inputFilter=false,
    m_flow_nominal=twoPipeCoo.mWat_flow_nominal,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
    "Water mover component"
    annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
  Modelica.Blocks.Sources.Ramp     TSet(
    duration=3600*12,
    startTime=3600,
    height=-9,
    offset=273.15 + 16) "Set point of the cooler"
    annotation (Placement(transformation(extent={{-90,0},{-70,20}})));
  Modelica.Blocks.Sources.Constant TAir(k=273.15 + 27)
    "Air temperature of the zone"
    annotation (Placement(transformation(extent={{-32,40},{-12,60}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{6,-16},{28,6}})));
  Modelica.Blocks.Sources.Constant phi(k=0.4) "Humidity of the zone"
    annotation (Placement(transformation(extent={{-32,8},{-12,28}})));
equation
  connect(twoPipeCoo.port_b,coo. port_a) annotation (Line(points={{59.6,-6},{
          59.6,-24},{-60,-24},{-60,-40},{-40,-40}},
                                               color={0,127,255}));
  connect(bou.ports[1], coo.port_a) annotation (Line(points={{-70,-26},{-68,-26},
          {-68,-40},{-40,-40}}, color={0,127,255}));
  connect(coo.port_b, pump.port_a)
    annotation (Line(points={{-20,-40},{0,-40}}, color={0,127,255}));
  connect(pump.port_b,twoPipeCoo. port_a) annotation (Line(points={{20,-40},{
          64.4,-40},{64.4,-6}},
                          color={0,127,255}));
  connect(TSet.y,coo. TSet) annotation (Line(points={{-69,10},{-54,10},{-54,-32},
          {-42,-32}}, color={0,0,127}));
  connect(TAir.y, twoPipeCoo.TAir) annotation (Line(points={{-11,50},{58.16,50},
          {58.16,15.6}}, color={0,0,127}));
  connect(prescribedTemperature.port, twoPipeCoo.port_heat) annotation (Line(
        points={{28,-5},{32,-5},{32,-3.6},{50,-3.6}}, color={191,0,0}));
  connect(prescribedTemperature.T, TAir.y) annotation (Line(points={{3.8,-5},{
          -4,-5},{-4,50},{-11,50}}, color={0,0,127}));
  connect(phi.y, twoPipeCoo.phi) annotation (Line(points={{-11,18},{20,18},{20,
          15.6},{52.64,15.6}}, color={0,0,127}));
  annotation (__Dymola_Commands(file=
          "Resources/Scripts/Dymola/Fluid/HeatExchangers/FanCoilUnits/Examples/TwoPipeCooExample.mos"),
    experiment(
      StopTime=50000,
      __Dymola_NumberOfIntervals=5000,
      Tolerance=1e-06,
      __Dymola_fixedstepsize=10,
      __Dymola_Algorithm="Euler"),
    __Dymola_experimentSetupOutput,
    __Dymola_experimentFlags(
      Advanced(
        EvaluateAlsoTop=false,
        GenerateVariableDependencies=false,
        OutputModelicaCode=false,
        InlineMethod=0,
        InlineOrder=2,
        InlineFixedStep=0.001),
      Evaluate=true,
      OutputCPUtime=true,
      OutputFlatModelica=false),
    Documentation(revisions="<html>
<ul>
<li>
February 25, 2019 by Iago Cupeiro:<br/>
First implementation
</li>
</ul>
</html>", info="<html>
<p>Example model of a two-pipe fan-coil unit (heating)</p>
</html>"));
end TwoPipeCooExample;
