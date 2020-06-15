within IDEAS.Examples.IBPSA;
model SingleZoneResidentialHydronicHeatPump
  "Single zone residential hydronic example using a heat pump as heating production system"
  extends Modelica.Icons.Example;
  package MediumWater = IDEAS.Media.Water "Water medium";
  package MediumAir = IDEAS.Media.Air "Air medium";
  package MediumGlycol = IDEAS.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15, X_a = 0.3) "Glycol medium";
  parameter Modelica.SIunits.Temperature TSetCooUno = 273.15+30 "Unoccupied cooling setpoint" annotation (Dialog(group="Setpoints"));
  parameter Modelica.SIunits.Temperature TSetCooOcc = 273.15+24 "Occupied cooling setpoint" annotation (Dialog(group="Setpoints"));
  parameter Modelica.SIunits.Temperature TSetHeaUno = 273.15+15 "Unoccupied heating setpoint" annotation (Dialog(group="Setpoints"));
  parameter Modelica.SIunits.Temperature TSetHeaOcc = 273.15+21 "Occupied heating setpoint" annotation (Dialog(group="Setpoints"));
  parameter Real scalingFactor = 5 "Factor to scale up the model area and occupancy";

  inner IDEAS.BoundaryConditions.SimInfoManager       sim
    "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{-180,160},{-160,180}})));

  IDEAS.Buildings.Validation.Cases.Case900Template case900Template(
    redeclare Buildings.Components.Occupants.Input occNum,
    redeclare Buildings.Components.OccupancyType.OfficeWork occTyp,
    mSenFac=1,
    n50=10,
    l=8*sqrt(scalingFactor),
    w=6*sqrt(scalingFactor),
    A_winA=24)
    "Case 900 BESTEST model"
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));

  Utilities.Time.CalendarTime calTim(zerTim=IDEAS.Utilities.Time.Types.ZeroTime.NY2019)
    annotation (Placement(transformation(extent={{-180,140},{-160,160}})));
  Modelica.Blocks.Sources.RealExpression yOcc(y=if (calTim.hour < 7 or calTim.hour >
        19) or calTim.weekDay > 5 then 1*scalingFactor else 0)
    "Fixed schedule of 1 occupant between 7 am and 8 pm"
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  IDEAS.Utilities.IO.SignalExchange.Overwrite oveHeaPumY(u(
      min=0,
      max=1,
      unit="1"), description="Heat pump modulating signal between 0 (not working) and 1 (working at maximum capacity)")
    "Block for overwriting heat pump modulating signal" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={10,150})));
  Modelica.Blocks.Sources.Constant offSet(k=0.2, y(unit="K"))
    "Offset above heating temperature setpoint to ensure comfort"
    annotation (Placement(transformation(extent={{-170,20},{-150,40}})));
  Utilities.IO.SignalExchange.Read reaPPumEmi(
    description="Emission circuit pump electrical power",
    KPIs=IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W"))
    "Block for reading the electrical power of the pump of the emission system"
    annotation (Placement(transformation(extent={{20,70},{40,90}})));

  Modelica.Blocks.Math.RealToInteger realToInteger
    annotation (Placement(transformation(extent={{50,100},{70,120}})));
  Utilities.IO.SignalExchange.Overwrite ovePumEmi(u(
      min=0,
      max=1,
      unit="1"), description="Integer signal to control the stage of the emission circuit pump either on or off")
    "Block for overwriting emission circuit pump control signal" annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={0,110})));

  Utilities.IO.SignalExchange.Read reaCO2RooAir(
    description="CO2 concentration in the zone",
    KPIs=IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.CO2Concentration,
    y(unit="ppm")) "Block for reading CO2 concentration in the zone"
    annotation (Placement(transformation(extent={{-60,-30},{-80,-10}})));

  Utilities.IO.SignalExchange.Overwrite oveTSetCoo(u(
      unit="K",
      min=273.15 + 23,
      max=273.15 + 30), description="Zone temperature setpoint for cooling")
    "Overwrite for zone cooling setpoint" annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-110,-50})));
  Utilities.IO.SignalExchange.Overwrite oveTSetHea(u(
      max=273.15 + 23,
      unit="K",
      min=273.15 + 15), description="Zone temperature setpoint for heating")
    "Overwrite for zone heating setpoint" annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-110,-80})));
  Utilities.IO.SignalExchange.Read reaTSetCoo(description=
        "Zone air temperature setpoint for cooling", y(unit="K"))
    "Read zone cooling setpoint"
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  Utilities.IO.SignalExchange.Read reaTSetHea(description=
        "Zone air temperature setpoint for heating", y(unit="K"))
    "Read zone cooling heating"
    annotation (Placement(transformation(extent={{-80,-90},{-60,-70}})));
  Modelica.Blocks.Sources.RealExpression TSetCoo(y=if yOcc.y > 0 then
        TSetCooOcc else TSetCooUno) "Cooling temperature setpoint with setback"
    annotation (Placement(transformation(extent={{-156,-60},{-136,-40}})));
  Modelica.Blocks.Sources.RealExpression TSetHea(y=if yOcc.y > 0 then
        TSetHeaOcc else TSetHeaUno) "Heating temperature setpoint with setback"
    annotation (Placement(transformation(extent={{-156,-90},{-136,-70}})));
  Utilities.IO.SignalExchange.Read reaHeaPumY(description="Block for reading the heat pump modulating signal",
      y(unit="1")) "Read heat pump modulating signal"
    annotation (Placement(transformation(extent={{40,140},{60,160}})));
  Utilities.IO.SignalExchange.Read reaPumEmi(description="Control signal for emission cirquit pump",
      y(unit="1")) "Read control signal for emission circuit pump"
    annotation (Placement(transformation(extent={{20,100},{40,120}})));
  Modelica.Blocks.Continuous.LimPID conPI(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=7000,
    yMax=1,
    yMin=0,
    initType=Modelica.Blocks.Types.InitPID.InitialState)
    "PI controller for the boiler supply water temperature"
    annotation (Placement(transformation(extent={{-60,140},{-40,160}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-130,0},{-110,20}})));
  Fluid.Movers.FlowControlled_dp       pumEmi(
    inputType=IDEAS.Fluid.Types.InputType.Stages,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    use_inputFilter=false,
    dp_nominal=20000,
    m_flow_nominal=0.5,
    redeclare package Medium = MediumWater,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
    "Circulation pump for emission system"
    annotation (Placement(transformation(extent={{40,30},{20,50}})));
  Fluid.Sensors.TemperatureTwoPort       senTemSup(
    redeclare package Medium = MediumWater,
    m_flow_nominal=pumEmi.m_flow_nominal,
    tau=0) "Supply water temperature sensor"
    annotation (Placement(transformation(extent={{80,50},{60,30}})));
  Fluid.HeatExchangers.RadiantSlab.EmbeddedPipe       floHea(
    redeclare package Medium = MediumWater,
    redeclare Fluid.HeatExchangers.RadiantSlab.BaseClasses.FH_Standard1
      RadSlaCha,
    allowFlowReversal=true,
    m_flow_nominal=pumEmi.m_flow_nominal,
    dp_nominal=pumEmi.dp_nominal/2,
    A_floor=case900Template.AZone) "Floor heating of the zone"
    annotation (Placement(transformation(extent={{0,-10},{-20,10}})));
  Fluid.Sensors.TemperatureTwoPort       senTemRet(
    redeclare package Medium = MediumWater,
    m_flow_nominal=pumEmi.m_flow_nominal,
    tau=0) "Return water temperature sensor"
    annotation (Placement(transformation(extent={{80,-10},{60,-30}})));
  Fluid.HeatPumps.ScrollWaterToWater       heaPum(
    redeclare package Medium1 = MediumWater,
    redeclare package Medium2 = MediumGlycol,
    scaling_factor=0.5,
    m2_flow_nominal=pumSou.m_flow_nominal,
    enable_variable_speed=true,
    m1_flow_nominal=pumEmi.m_flow_nominal,
    T1_start=293.15,
    T2_start=278.15,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    TEvaMin=273.15,
    dTHys=3,
    datHeaPum=
        IDEAS.Fluid.HeatPumps.Data.ScrollWaterToWater.Heating.Viessmann_BW301A21_28kW_5_94COP_R410A(),
    dp1_nominal=pumEmi.dp_nominal/2,
    dp2_nominal=pumSou.dp_nominal/2)
    "Heat pump model, rescaled for low thermal powers" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={130,10})));
  Fluid.Movers.FlowControlled_dp       pumSou(
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    inputType=IDEAS.Fluid.Types.InputType.Stages,
    use_inputFilter=false,
    dp_nominal=20000,
    m_flow_nominal=0.5,
    redeclare package Medium = MediumGlycol,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
    "Circulation pump at source side"
    annotation (Placement(transformation(extent={{212,30},{192,50}})));
  Fluid.Sources.Boundary_pT       bou(redeclare package Medium = MediumWater, nPorts=
       1)            "Expansion vessel" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={50,20})));
  Utilities.IO.SignalExchange.Read reaPPumSou(
    description="Source circuit pump electrical power",
    KPIs=IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W"))
    "Block for reading the electrical power of the pump at the heat pump source side"
    annotation (Placement(transformation(extent={{200,70},{220,90}})));

  Modelica.Blocks.Sources.RealExpression yPumEmi(y=if heaPum.com.isOn then 1
         else 0) "Control input signal to emission circuit pump"
    annotation (Placement(transformation(extent={{-42,100},{-22,120}})));
  Modelica.Blocks.Math.RealToInteger realToInteger1
    annotation (Placement(transformation(extent={{230,100},{250,120}})));
  Utilities.IO.SignalExchange.Overwrite ovePumSou(u(
      min=0,
      max=1,
      unit="1"), description="Integer signal to control the stage of the source circuit pump either on or off")
    "Block for overwriting source circuit pump control signal" annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={180,110})));
  Utilities.IO.SignalExchange.Read reaPumSou(description="Control signal for source cirquit pump",
      y(unit="1")) "Read control signal for source circuit pump"
    annotation (Placement(transformation(extent={{200,100},{220,120}})));
  Modelica.Blocks.Sources.RealExpression yPumSou(y=if heaPum.com.isOn then 1
         else 0) "Control input signal to source circuit pump"
    annotation (Placement(transformation(extent={{138,100},{158,120}})));
  Utilities.IO.SignalExchange.Read reaPHeaPum(
    description="Heat pump electrical power",
    KPIs=IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W")) "Block for reading the electrical power of the heat pump"
    annotation (Placement(transformation(extent={{140,70},{160,90}})));

  Utilities.IO.SignalExchange.Read       reaTZon(
    description="Operative zone temperature",
    KPIs=IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.OperativeZoneTemperature,
    y(unit="K")) "Block for reading the operative zone temperature"
    annotation (Placement(transformation(extent={{-32,70},{-12,90}})));

  Utilities.IO.SignalExchange.Read reaQFloHea(
    description="Floor heating thermal power released to the zone",
    KPIs=IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="W"))
    "Block for reading the floor heating thermal power released to the zone"
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  Utilities.IO.SignalExchange.Read reaQHeaPumEva(
    description="Heat pump thermal power exchanged in the evaporator",
    KPIs=IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="W"))
    "Block for reading the heat pump thermal power exchanged in the evaporator"
    annotation (Placement(transformation(extent={{160,0},{180,20}})));
  Utilities.IO.SignalExchange.Read reaQHeaPumCon(
    description="Heat pump thermal power exchanged in the condenser",
    KPIs=IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="W"))
    "Block for reading the heat pump thermal power exchanged in the condenser"
    annotation (Placement(transformation(extent={{100,0},{80,20}})));
  Utilities.IO.SignalExchange.Read reaTSup(description="Supply water temperature to emission system",
      y(unit="K")) "Read supply water temperature to emission system"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Utilities.IO.SignalExchange.Read reaTRet(description="Return water temperature from emission system",
      y(unit="K")) "Read return water temperature from emission system"
    annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
  Utilities.IO.SignalExchange.Read reaHeaPumCOP(description="Heat pump COP", y(
        unit="1")) "Read heat pump COP"
    annotation (Placement(transformation(extent={{200,-60},{220,-40}})));
  Modelica.Blocks.Sources.RealExpression heaPumCOP(y=heaPum.com.COP)
    "Substracts heat pump COP"
    annotation (Placement(transformation(extent={{164,-60},{184,-40}})));
  Fluid.HeatExchangers.DryCoilEffectivenessNTU hex(
    redeclare package Medium1 = MediumGlycol,
    redeclare package Medium2 = MediumAir,
    m1_flow_nominal=pumSou.m_flow_nominal,
    m2_flow_nominal=fan.m_flow_nominal,
    dp1_nominal=pumSou.m_flow_nominal/2,
    dp2_nominal=fan.m_flow_nominal,
    configuration=IDEAS.Fluid.Types.HeatExchangerConfiguration.CounterFlow,
    Q_flow_nominal=1000,
    T_a1_nominal=274.15,
    T_a2_nominal=288.15)                           "water-air heat exchanger"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={272,10})));
  Fluid.Sources.OutsideAir outAir(redeclare package Medium = MediumAir,
                                  nPorts=2) "Outside air"
    annotation (Placement(transformation(extent={{360,0},{340,20}})));
  Modelica.Blocks.Math.RealToInteger realToInteger2
    annotation (Placement(transformation(extent={{380,100},{400,120}})));
  Utilities.IO.SignalExchange.Overwrite oveFan(u(
      min=0,
      max=1,
      unit="1"), description="Integer signal to control the stage of the fan either on or off")
    "Block for overwriting fan control signal" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={330,110})));
  Utilities.IO.SignalExchange.Read reaFan(description="Control signal for fan",
      y(unit="1")) "Read control signal for fan"
    annotation (Placement(transformation(extent={{350,100},{370,120}})));
  Modelica.Blocks.Sources.RealExpression yFan(y=if heaPum.com.isOn then 1 else 0)
    "Control input signal to fan"
    annotation (Placement(transformation(extent={{288,100},{308,120}})));
  Fluid.Movers.FlowControlled_dp fan(
    redeclare package Medium = MediumAir,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    inputType=IDEAS.Fluid.Types.InputType.Stages,
    use_inputFilter=false,
    dp_nominal=50,
    m_flow_nominal=0.1,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
    "Fan to pump air through heat exchanger"
    annotation (Placement(transformation(extent={{320,30},{300,50}})));
  Fluid.Sources.Boundary_pT       bou1(redeclare package Medium = MediumGlycol,
      nPorts=1)      "Expansion vessel" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={230,20})));
  Utilities.IO.SignalExchange.Read reaHexEps(description="Heat exchanger effectiveness",
      y(unit="1")) "Read Heat exchanger effectiveness"
    annotation (Placement(transformation(extent={{280,-60},{300,-40}})));
  Modelica.Blocks.Sources.RealExpression hexEps(y=hex.eps)
    "Substracts heat exchanger effectiveness"
    annotation (Placement(transformation(extent={{244,-60},{264,-40}})));
  Utilities.IO.SignalExchange.Read reaPPumSou1(
    description="Source circuit pump electrical power",
    KPIs=IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W"))
    "Block for reading the electrical power of the pump at the heat pump source side"
    annotation (Placement(transformation(extent={{320,70},{340,90}})));

equation
  connect(case900Template.ppm, reaCO2RooAir.u) annotation (Line(points={{-59,10},
          {-54,10},{-54,-20},{-58,-20}},
                                    color={0,0,127}));
  connect(oveTSetCoo.y, reaTSetCoo.u)
    annotation (Line(points={{-99,-50},{-82,-50}}, color={0,0,127}));
  connect(oveTSetHea.y, reaTSetHea.u)
    annotation (Line(points={{-99,-80},{-82,-80}}, color={0,0,127}));
  connect(TSetCoo.y, oveTSetCoo.u)
    annotation (Line(points={{-135,-50},{-122,-50}}, color={0,0,127}));
  connect(TSetHea.y, oveTSetHea.u)
    annotation (Line(points={{-135,-80},{-122,-80}}, color={0,0,127}));
  connect(oveHeaPumY.y, reaHeaPumY.u)
    annotation (Line(points={{21,150},{38,150}}, color={0,0,127}));
  connect(ovePumEmi.y, reaPumEmi.u)
    annotation (Line(points={{11,110},{18,110}}, color={0,0,127}));
  connect(realToInteger.u, reaPumEmi.y)
    annotation (Line(points={{48,110},{41,110}}, color={0,0,127}));
  connect(conPI.y, oveHeaPumY.u)
    annotation (Line(points={{-39,150},{-2,150}}, color={0,0,127}));
  connect(offSet.y, add.u1) annotation (Line(points={{-149,30},{-140,30},{-140,16},
          {-132,16}},     color={0,0,127}));
  connect(add.y, conPI.u_s) annotation (Line(points={{-109,10},{-100,10},{-100,150},
          {-62,150}},    color={0,0,127}));
  connect(case900Template.TSensor, conPI.u_m) annotation (Line(points={{-60,13},
          {-50,13},{-50,138}},                  color={0,0,127}));
  connect(yOcc.y, case900Template.yOcc) annotation (Line(points={{-59,40},{-52,40},
          {-52,14},{-58,14}}, color={0,0,127}));
  connect(senTemSup.port_b,pumEmi. port_a)
    annotation (Line(points={{60,40},{40,40}},   color={0,127,255}));
  connect(bou.ports[1],pumEmi. port_a)
    annotation (Line(points={{50,30},{50,40},{40,40}},    color={0,127,255}));
  connect(heaPum.port_a2,pumSou. port_b)
    annotation (Line(points={{136,20},{136,40},{192,40}},color={0,127,255}));
  connect(heaPum.port_b1,senTemSup.port_a)  annotation (Line(points={{124,20},{124,
          40},{80,40}},               color={0,127,255}));
  connect(senTemRet.port_a,heaPum. port_a1) annotation (Line(points={{80,-20},{124,
          -20},{124,0}},        color={0,127,255}));
  connect(case900Template.gainEmb[1], floHea.heatPortEmb[1]) annotation (Line(
        points={{-60,1},{-40,1},{-40,20},{-10,20},{-10,10}}, color={191,0,0}));
  connect(pumEmi.port_b, floHea.port_a)
    annotation (Line(points={{20,40},{0,40},{0,0}}, color={0,127,255}));
  connect(floHea.port_b, senTemRet.port_b)
    annotation (Line(points={{-20,0},{-20,-20},{60,-20}}, color={0,127,255}));
  connect(pumEmi.P, reaPPumEmi.u) annotation (Line(points={{19,49},{0,49},{0,80},
          {18,80}}, color={0,0,127}));
  connect(pumSou.P, reaPPumSou.u) annotation (Line(points={{191,49},{180,49},{180,
          80},{198,80}}, color={0,0,127}));
  connect(reaHeaPumY.y, heaPum.y) annotation (Line(points={{61,150},{420,150},{420,
          -30},{127,-30},{127,-2}}, color={0,0,127}));
  connect(add.u2, reaTSetHea.u) annotation (Line(points={{-132,4},{-160,4},{-160,
          -94},{-92,-94},{-92,-80},{-82,-80}}, color={0,0,127}));
  connect(yPumEmi.y, ovePumEmi.u)
    annotation (Line(points={{-21,110},{-12,110}}, color={0,0,127}));
  connect(realToInteger.y, pumEmi.stage) annotation (Line(points={{71,110},{80,110},
          {80,60},{30,60},{30,52}}, color={255,127,0}));
  connect(ovePumSou.y, reaPumSou.u)
    annotation (Line(points={{191,110},{198,110}}, color={0,0,127}));
  connect(realToInteger1.u, reaPumSou.y)
    annotation (Line(points={{228,110},{221,110}}, color={0,0,127}));
  connect(yPumSou.y, ovePumSou.u)
    annotation (Line(points={{159,110},{168,110}}, color={0,0,127}));
  connect(realToInteger1.y, pumSou.stage) annotation (Line(points={{251,110},{260,
          110},{260,60},{202,60},{202,52}}, color={255,127,0}));
  connect(heaPum.P, reaPHeaPum.u)
    annotation (Line(points={{130,21},{130,80},{138,80}}, color={0,0,127}));
  connect(case900Template.TSensor, reaTZon.u) annotation (Line(points={{-60,13},
          {-46,13},{-46,80},{-34,80}}, color={0,0,127}));
  connect(floHea.QTot, reaQFloHea.u) annotation (Line(points={{-21,6},{-32,6},{-32,
          -50},{-22,-50}}, color={0,0,127}));
  connect(heaPum.QEva_flow, reaQHeaPumEva.u) annotation (Line(points={{139,21},{
          139,28},{150,28},{150,10},{158,10}}, color={0,0,127}));
  connect(heaPum.QCon_flow, reaQHeaPumCon.u) annotation (Line(points={{121,21},{
          121,28},{110,28},{110,10},{102,10}}, color={0,0,127}));
  connect(reaTSup.u, senTemSup.T) annotation (Line(points={{98,80},{90,80},{90,26},
          {70,26},{70,29}}, color={0,0,127}));
  connect(senTemRet.T, reaTRet.u)
    annotation (Line(points={{70,-31},{70,-50},{98,-50}}, color={0,0,127}));
  connect(heaPumCOP.y, reaHeaPumCOP.u)
    annotation (Line(points={{185,-50},{198,-50}}, color={0,0,127}));
  connect(pumSou.port_a, hex.port_b1)
    annotation (Line(points={{212,40},{266,40},{266,20}}, color={0,127,255}));
  connect(hex.port_a1, heaPum.port_b2) annotation (Line(points={{266,0},{266,-20},
          {136,-20},{136,0}}, color={0,127,255}));
  connect(hex.port_b2, outAir.ports[1]) annotation (Line(points={{278,0},{278,-20},
          {340,-20},{340,12}}, color={0,127,255}));
  connect(oveFan.y, reaFan.u)
    annotation (Line(points={{341,110},{348,110}}, color={0,0,127}));
  connect(realToInteger2.u, reaFan.y)
    annotation (Line(points={{378,110},{371,110}}, color={0,0,127}));
  connect(yFan.y, oveFan.u)
    annotation (Line(points={{309,110},{318,110}}, color={0,0,127}));
  connect(fan.port_b, hex.port_a2)
    annotation (Line(points={{300,40},{278,40},{278,20}}, color={0,127,255}));
  connect(fan.port_a, outAir.ports[2])
    annotation (Line(points={{320,40},{340,40},{340,8}}, color={0,127,255}));
  connect(realToInteger2.y, fan.stage) annotation (Line(points={{401,110},{410,110},
          {410,60},{310,60},{310,52}}, color={255,127,0}));
  connect(bou1.ports[1], hex.port_b1) annotation (Line(points={{230,30},{230,40},
          {266,40},{266,20}}, color={0,127,255}));
  connect(hexEps.y, reaHexEps.u)
    annotation (Line(points={{265,-50},{278,-50}}, color={0,0,127}));
  connect(fan.P, reaPPumSou1.u) annotation (Line(points={{299,49},{290,49},{290,
          80},{318,80}}, color={0,0,127}));
  annotation (
    experiment(
      StopTime=604800,
      __Dymola_NumberOfIntervals=5000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"),
    Documentation(info="<html>
This is a single zone residential hydronic system model 
for WP 1.2 of IBPSA project 1. 
<h3>Building Design and Use</h3>
<h4>Architecture</h4>
<p>
This building envelope model corresponds to the BESTEST case 900 test case. 
It consists of a single zone with a rectangular floor plan
of 6 by 8 meters and a height of 2.7 m. 
The zone further consists of two south-oriented windows of 6 m2 each, 
which are modelled using a single window of 12 m2.
</p>
<h4>Constructions</h4>
<p>
The walls consist of 10 cm thick concrete blocks and 6 cm of foam insulation.
For more details see <a href=\"modelica://IDEAS.Buildings.Validation.Data.Constructions.HeavyWall\">
IDEAS.Buildings.Validation.Data.Constructions.HeavyWall</a>.
The floor consists of 8 cm of concrete and 1 m of insulation,
representing a perfectly insulated floor.
The roof consists of a light construction and 11 cm of fibreglass.
</p>
<h4>Occupancy schedules</h4>
<p>
The zone is occupied by one person before 7 am and after 8 pm each weekday
and full time during weekends.
</p>
<h4>Internal loads and schedules</h4>
<p>
There are no internal loads other than the occupants.
</p>
<h4>Climate data</h4>
<p>
The model uses a climate file containing one year
of weather data for Uccle, Belgium.
</p>
<h3>HVAC System Design</h3>
<h4>Primary and secondary system designs</h4>
<p>
The model only has a primary heating system that
heats the zone using a single radiator
with thermostatic valve,
a circulation pump and a water heater.
The radiator nominal thermal power and heater maximum thermal 
power is 3 kW.
The thermostatic valve is fully closed when the operative
temperature reaches 21 degrees centigrade
and fully opened at 19 degrees centigrade.
The gas heater efficiency is computed using a polynomial curve and it uses
a PI controller to modulate supply water temperature between 20 and 80 degrees centigrade
to follow a reference that is set as a small offset above the heating setpoint of 0.2
degrees centigrade by default. 
</p>
<h4>Equipment specifications and performance maps</h4>
<p>
The heating system circulation pump has the default efficiency
of the pump model, which is 49 % at the time of writing.
The heater efficiency is computed using a polynomial curve.
</p>
<h4>Rule-based or local-loop controllers (if included)</h4>
<p>
The model assumes a pump with a constant head.
The resulting flow rate depends on the thermostatic valve
position. The supply water temperature of the boiler is modulated using a PI
controller that tracks indoor temperature to follow a reference defined as 
the heating setpoint plus a small offset of 0.2 degrees centigrade. 
</p>
<h3>Model IO's</h3>
<h4>Inputs</h4>
The model inputs are:
<ul>
<li>
<code>oveTSetHea_u</code> [K] [min=288.15, max=296.15]: Zone temperature setpoint for heating
</li>
<li>
<code>oveTSetCoo_u</code> [K] [min=296.15, max=303.15]: Zone temperature setpoint for cooling
</li>
<li>
<code>oveTSetSup_u</code> [K] [min=293.15, max=353.15]: Supply temperature setpoint of the heater
</li>
<li>
<code>ovePum_u</code> [1] [min=0.0, max=1.0]: Integer signal to control the stage of the pump either on or off
</li>
</ul>
<h4>Outputs</h4>
The model outputs are:
<ul>
<li>
<code>reaTSetHea_y</code> [K] [min=None, max=None]: Zone air temperature setpoint for heating
</li>
<li>
<code>reaTSetCoo_y</code> [K] [min=None, max=None]: Zone air temperature setpoint for cooling
</li>
<li>
<code>reaTSetSup_y</code> [K] [min=None, max=None]: Supply temperature setpoint of heater
</li>
<li>
<code>reaQHea_y</code> [W] [min=None, max=None]: Heating thermal power
</li>
<li>
<code>reaPum_y</code> [1] [min=None, max=None]: Control signal for pump
</li>
<li>
<code>reaPPum_y</code> [W] [min=None, max=None]: Pump electrical power
</li>
<li>
<code>reaCO2RooAir_y</code> [ppm] [min=None, max=None]: CO2 concentration in the zone
</li>
<li>
<code>reaTRoo_y</code> [K] [min=None, max=None]: Operative zone temperature
</li>
</ul>
<h3>Additional System Design</h3>
<h4>Lighting</h4>
<p>
No lighting model is included.
</p>
<h4>Shading</h4>
<p>
No shading model is included.
</p>
<h3>Model Implementation Details</h3>
<h4>Moist vs. dry air</h4>
<p>
The model uses moist air despite that
no condensation is modelled in any of the used components.
</p>
<h4>Pressure-flow models</h4>
<p>
A simple, single circulation loop is used to model the heating system.
</p>
<h4>Infiltration models</h4>
<p>
Fixed air infiltration corresponding to an n50 value of 10
is modelled.
</p>
<h3>Scenario Information</h3>
<h4>Energy Pricing</h4>

<p>
The <b>Constant Electricity Price</b> profile is:
<ul>
The constant electricity price scenario uses a constant price of 0.0535 EUR/kWh,
as obtained from the \"Easy Indexed\" deal for electricity (normal rate) in 
<a href=\"https://www.energyprice.be/products-list/Engie\">
https://www.energyprice.be/products-list/Engie</a> 
(accessed on June 2020). 
</ul>
</p>
<p>
The <b>Dynamic Electricity Price</b> profile is:
<ul>
The dynamic electricity price scenario uses a dual rate of 0.0666 EUR/kWh during day time and 0.0383 EUR/kWh during night time,
as obtained from the \"Easy Indexed\" deal for electricity (dual rate) in 
<a href=\"https://www.energyprice.be/products-list/Engie\">
https://www.energyprice.be/products-list/Engie</a> 
(accessed on June 2020). 
The on-peak daily period takes place between 7:00 a.m. and 10:00 p.m.
The off-peak daily period takes place between 10:00 p.m. and 7:00 a.m. 
</ul>
<p>
The <b>Highly Dynamic Electricity Price</b> profile is:
<ul>
The highly dynamic electricity price scenario is based on the the
Belgian day-ahead energy prices as determined by the BELPEX wholescale electricity market in the year 2019.
Obtained from:
<a href=\"https://my.elexys.be/MarketInformation/SpotBelpex.aspx\">
https://my.elexys.be/MarketInformation/SpotBelpex.aspx</a> 
</ul>
</p>
<p>
The <b>Gas Price</b> profile is:
<ul>
The gas price is assumed constant and of 0.0198 EUR/kWh 
as obtained from the \"Easy Indexed\" deal for gas
<a href=\"https://www.energyprice.be/products-list/Engie\">
https://www.energyprice.be/products-list/Engie</a> 
(accessed on June 2020). 
</ul>
<h4>Emission Factors</h4>
<p>
The <b>Electricity Emissions Factor</b> profile is:
<ul>
It is used a constant emission factor for electricity of 0.167 kgCO2/kWh 
which is the grid electricity emission factor reported by the Association of Issuing Bodies (AIB)
for year 2018. For reference, see:
 <a href=\"https://www.carbonfootprint.com/docs/2019_06_emissions_factors_sources_for_2019_electricity.pdf\">
https://www.carbonfootprint.com/docs/2019_06_emissions_factors_sources_for_2019_electricity.pdf</a> 

</ul>
</p>
<p>
The <b>Gas Emissions Factor</b> profile is:
<ul>

Based on the kgCO2 emitted per amount of natural gas burned in terms of 
energy content.  It is 0.18108 kgCO2/kWh (53.07 kgCO2/milBTU).
For reference,
see:
<a href=\"https://www.eia.gov/environment/emissions/co2_vol_mass.php\">
https://www.eia.gov/environment/emissions/co2_vol_mass.php</a> 
</ul>

</p>
</html>", revisions="<html>
<ul>
<li>June 12, 2020 by Javier Arroyo:</li>
<p>Implemented PI controller for boiler supply temperature. </p>
<li>June 2, 2020 by Javier Arroyo:<br>Implemented temperature setpoint setback. </li>
<li>March 21, 2019 by Filip Jorissen:<br>Revised implementation based on first review for <a href=\"https://github.com/open-ideas/IDEAS/issues/996\">#996</a>. </li>
<li>January 22nd, 2019 by Filip Jorissen:<br>Revised implementation by adding external inputs. </li>
<li>May 2, 2018 by Filip Jorissen:<br>First implementation. </li>
</ul>
</html>"),
    Diagram(coordinateSystem(extent={{-180,-100},{440,180}})),
    Icon(coordinateSystem(extent={{-180,-100},{440,180}})));
end SingleZoneResidentialHydronicHeatPump;
