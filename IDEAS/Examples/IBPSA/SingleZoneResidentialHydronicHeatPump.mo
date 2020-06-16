within IDEAS.Examples.IBPSA;
model SingleZoneResidentialHydronicHeatPump
  "Single zone residential hydronic example using a heat pump as heating production system"
  extends Modelica.Icons.Example;
  package MediumWater = IDEAS.Media.Water "Water medium";
  package MediumAir = IDEAS.Media.Air "Air medium";
  package MediumGlycol = IDEAS.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15, X_a = 0.5) "Glycol medium";
  parameter Modelica.SIunits.Temperature TSetCooUno = 273.15+30 "Unoccupied cooling setpoint" annotation (Dialog(group="Setpoints"));
  parameter Modelica.SIunits.Temperature TSetCooOcc = 273.15+24 "Occupied cooling setpoint" annotation (Dialog(group="Setpoints"));
  parameter Modelica.SIunits.Temperature TSetHeaUno = 273.15+15 "Unoccupied heating setpoint" annotation (Dialog(group="Setpoints"));
  parameter Modelica.SIunits.Temperature TSetHeaOcc = 273.15+21 "Occupied heating setpoint" annotation (Dialog(group="Setpoints"));
  parameter Real scalingFactor = 5 "Factor to scale up the model area and occupancy";

  inner IDEAS.BoundaryConditions.SimInfoManager       sim
    "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{-240,160},{-220,180}})));

  IDEAS.Buildings.Validation.Cases.Case900Template case900Template(
    redeclare Buildings.Components.Occupants.Input occNum,
    redeclare Buildings.Components.OccupancyType.OfficeWork occTyp,
    mSenFac=1,
    n50=10,
    bouTypFlo=IDEAS.Buildings.Components.Interfaces.BoundaryType.SlabOnGround,
    l=8*sqrt(scalingFactor),
    w=6*sqrt(scalingFactor),
    A_winA=24,
    redeclare IDEAS.Buildings.Data.Constructions.InsulatedFloorHeating
      conTypFlo(mats={IDEAS.Buildings.Data.Materials.Concrete(d=0.15),
          IDEAS.Buildings.Data.Insulation.Pur(d=0.2),
          IDEAS.Buildings.Data.Materials.Screed(d=0.05),
          IDEAS.Buildings.Data.Materials.Tile(d=0.01)}),
    hasEmb=true)
    "Case 900 BESTEST model"
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));

  Utilities.Time.CalendarTime calTim(zerTim=IDEAS.Utilities.Time.Types.ZeroTime.NY2019)
    annotation (Placement(transformation(extent={{-240,140},{-220,160}})));
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
        origin={90,150})));
  Modelica.Blocks.Sources.Constant offSetOcc(k=0.2, y(unit="K"))
    "Offset above heating temperature setpoint during occupied hours to ensure comfort"
    annotation (Placement(transformation(extent={{-200,142},{-180,162}})));
  Utilities.IO.SignalExchange.Read reaPPumEmi(
    description="Emission circuit pump electrical power",
    KPIs=IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W"))
    "Block for reading the electrical power of the pump of the emission system"
    annotation (Placement(transformation(extent={{20,70},{40,90}})));

  Modelica.Blocks.Math.RealToInteger realToInteger
    annotation (Placement(transformation(extent={{52,100},{72,120}})));
  Utilities.IO.SignalExchange.Overwrite ovePumEmi(u(
      min=0,
      max=1,
      unit="1"), description="Integer signal to control the stage of the emission circuit pump either on or off")
    "Block for overwriting emission circuit pump control signal" annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={2,110})));

  Utilities.IO.SignalExchange.Read reaCO2RooAir(
    description="CO2 concentration in the zone",
    KPIs=IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.CO2Concentration,
    y(unit="ppm")) "Block for reading CO2 concentration in the zone"
    annotation (Placement(transformation(extent={{-60,-60},{-80,-40}})));

  Utilities.IO.SignalExchange.Overwrite oveTSetCoo(u(
      unit="K",
      min=273.15 + 23,
      max=273.15 + 30), description="Zone temperature setpoint for cooling")
    "Overwrite for zone cooling setpoint" annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-170,10})));
  Utilities.IO.SignalExchange.Overwrite oveTSetHea(u(
      max=273.15 + 23,
      unit="K",
      min=273.15 + 15), description="Zone temperature setpoint for heating")
    "Overwrite for zone heating setpoint" annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-170,-30})));
  Utilities.IO.SignalExchange.Read reaTSetCoo(description=
        "Zone air temperature setpoint for cooling", y(unit="K"))
    "Read zone cooling setpoint"
    annotation (Placement(transformation(extent={{-140,0},{-120,20}})));
  Utilities.IO.SignalExchange.Read reaTSetHea(description=
        "Zone air temperature setpoint for heating", y(unit="K"))
    "Read zone cooling heating"
    annotation (Placement(transformation(extent={{-140,-40},{-120,-20}})));
  Modelica.Blocks.Sources.RealExpression TSetCoo(y=if yOcc.y > 0 then
        TSetCooOcc else TSetCooUno) "Cooling temperature setpoint with setback"
    annotation (Placement(transformation(extent={{-220,0},{-200,20}})));
  Modelica.Blocks.Sources.RealExpression TSetHea(y=if yOcc.y > 0 then
        TSetHeaOcc else TSetHeaUno) "Heating temperature setpoint with setback"
    annotation (Placement(transformation(extent={{-220,-40},{-200,-20}})));
  Utilities.IO.SignalExchange.Read reaHeaPumY(description="Block for reading the heat pump modulating signal",
      y(unit="1")) "Read heat pump modulating signal"
    annotation (Placement(transformation(extent={{120,140},{140,160}})));
  Utilities.IO.SignalExchange.Read reaPumEmi(description="Control signal for emission cirquit pump",
      y(unit="1")) "Read control signal for emission circuit pump"
    annotation (Placement(transformation(extent={{22,100},{42,120}})));
  Modelica.Blocks.Continuous.LimPID conPI(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.6,
    Ti=8000,
    yMax=1,
    yMin=0,
    initType=Modelica.Blocks.Types.InitPID.InitialState)
    "PI controller for the boiler supply water temperature"
    annotation (Placement(transformation(extent={{20,140},{40,160}})));
  Modelica.Blocks.Math.Add addOcc
    annotation (Placement(transformation(extent={{-160,120},{-140,140}})));
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
    annotation (Placement(transformation(extent={{0,0},{-20,20}})));
  Fluid.Sensors.TemperatureTwoPort       senTemRet(
    redeclare package Medium = MediumWater,
    m_flow_nominal=pumEmi.m_flow_nominal,
    tau=0) "Return water temperature sensor"
    annotation (Placement(transformation(extent={{80,-10},{60,-30}})));
  Fluid.HeatPumps.ScrollWaterToWater       heaPum(
    redeclare package Medium1 = MediumWater,
    redeclare package Medium2 = MediumGlycol,
    scaling_factor=0.6,
    m2_flow_nominal=pumSou.m_flow_nominal,
    enable_variable_speed=true,
    m1_flow_nominal=pumEmi.m_flow_nominal,
    T1_start=293.15,
    T2_start=278.15,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    TEvaMin=253.15,
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
    annotation (Placement(transformation(extent={{200,30},{180,50}})));
  Fluid.Sources.Boundary_pT bouWat(redeclare package Medium = MediumWater,
      nPorts=1) "Expansion vessel" annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={50,10})));
  Utilities.IO.SignalExchange.Read reaPPumSou(
    description="Source circuit pump electrical power",
    KPIs=IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W"))
    "Block for reading the electrical power of the pump at the heat pump source side"
    annotation (Placement(transformation(extent={{180,70},{200,90}})));

  Modelica.Blocks.Sources.RealExpression yPumEmi(y=if heaPum.com.isOn then 1
         else 0) "Control input signal to emission circuit pump"
    annotation (Placement(transformation(extent={{-40,100},{-20,120}})));
  Modelica.Blocks.Math.RealToInteger realToInteger1
    annotation (Placement(transformation(extent={{212,100},{232,120}})));
  Utilities.IO.SignalExchange.Overwrite ovePumSou(u(
      min=0,
      max=1,
      unit="1"), description="Integer signal to control the stage of the source circuit pump either on or off")
    "Block for overwriting source circuit pump control signal" annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={162,110})));
  Utilities.IO.SignalExchange.Read reaPumSou(description="Control signal for source cirquit pump",
      y(unit="1")) "Read control signal for source circuit pump"
    annotation (Placement(transformation(extent={{182,100},{202,120}})));
  Modelica.Blocks.Sources.RealExpression yPumSou(y=if heaPum.com.isOn then 1
         else 0) "Control input signal to source circuit pump"
    annotation (Placement(transformation(extent={{120,100},{140,120}})));
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
    annotation (Placement(transformation(extent={{160,-60},{180,-40}})));
  Fluid.HeatExchangers.DryCoilEffectivenessNTU hex(
    redeclare package Medium1 = MediumGlycol,
    redeclare package Medium2 = MediumAir,
    m1_flow_nominal=pumSou.m_flow_nominal,
    m2_flow_nominal=fan.m_flow_nominal,
    dp1_nominal=pumSou.m_flow_nominal/2,
    dp2_nominal=fan.m_flow_nominal,
    configuration=IDEAS.Fluid.Types.HeatExchangerConfiguration.CounterFlow,
    Q_flow_nominal=3000,
    T_a1_nominal=258.15,
    T_a2_nominal=288.15)                           "water-air heat exchanger"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={272,10})));
  Fluid.Sources.OutsideAir outAir(redeclare package Medium = MediumAir,
                                  nPorts=2) "Outside air"
    annotation (Placement(transformation(extent={{360,0},{340,20}})));
  Modelica.Blocks.Math.RealToInteger realToInteger2
    annotation (Placement(transformation(extent={{352,100},{372,120}})));
  Utilities.IO.SignalExchange.Overwrite oveFan(u(
      min=0,
      max=1,
      unit="1"), description="Integer signal to control the stage of the fan either on or off")
    "Block for overwriting fan control signal" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={302,110})));
  Utilities.IO.SignalExchange.Read reaFan(description="Control signal for fan",
      y(unit="1")) "Read control signal for fan"
    annotation (Placement(transformation(extent={{322,100},{342,120}})));
  Modelica.Blocks.Sources.RealExpression yFan(y=if heaPum.com.isOn then 1 else 0)
    "Control input signal to fan"
    annotation (Placement(transformation(extent={{260,100},{280,120}})));
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
  Fluid.Sources.Boundary_pT bouGly(redeclare package Medium = MediumGlycol,
      nPorts=1) "Expansion vessel" annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={210,10})));
  Utilities.IO.SignalExchange.Read reaHexEps(description="Heat exchanger effectiveness",
      y(unit="1")) "Read Heat exchanger effectiveness"
    annotation (Placement(transformation(extent={{280,-60},{300,-40}})));
  Modelica.Blocks.Sources.RealExpression hexEps(y=hex.eps)
    "Substracts heat exchanger effectiveness"
    annotation (Placement(transformation(extent={{240,-60},{260,-40}})));
  Utilities.IO.SignalExchange.Read reaPFan(
    description=
        "Electrical power of the fan insuflating air through the heat exchanger",

    KPIs=IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,

    y(unit="W"))
    "Block for reading the electrical power of the fan insuflating air through the heat exchanger"
    annotation (Placement(transformation(extent={{320,70},{340,90}})));

  Utilities.IO.SignalExchange.Read reaHexQ(description=
        "Heat that the heat exchanger introduces into the heat pump evaporator circuit from the environment",
      y(unit="W"))
    "Read the heat that the heat exchanger introduces into the heat pump evaporator circuit"
    annotation (Placement(transformation(extent={{360,-60},{380,-40}})));
  Modelica.Blocks.Sources.RealExpression hexQ(y=hex.Q1_flow)
    "Substracts heat introduced into heat pump evaporator circuit"
    annotation (Placement(transformation(extent={{320,-60},{340,-40}})));
  Modelica.Blocks.Math.Add addUno
    annotation (Placement(transformation(extent={{-160,40},{-140,60}})));
  Modelica.Blocks.Sources.Constant offSetUno(k=4.5, y(unit="K"))
    "Offset above heating temperature setpoint during unoccupied hours to ensure comfort"
    annotation (Placement(transformation(extent={{-200,60},{-180,80}})));
  Modelica.Blocks.Logical.Greater greater
    annotation (Placement(transformation(extent={{-80,100},{-60,80}})));
  Modelica.Blocks.Logical.Switch switch1(y(unit="K"))
    annotation (Placement(transformation(extent={{-20,140},{0,160}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-114,110},{-94,130}})));
  Fluid.Sensors.TemperatureTwoPort senTemGly(
    redeclare package Medium = MediumGlycol,
    m_flow_nominal=pumSou.m_flow_nominal,
    tau=0) "Temperature sensor for glycol"
    annotation (Placement(transformation(extent={{240,50},{220,30}})));
equation
  connect(case900Template.ppm, reaCO2RooAir.u) annotation (Line(points={{-59,10},
          {-54,10},{-54,-50},{-58,-50}},
                                    color={0,0,127}));
  connect(oveTSetCoo.y, reaTSetCoo.u)
    annotation (Line(points={{-159,10},{-142,10}}, color={0,0,127}));
  connect(oveTSetHea.y, reaTSetHea.u)
    annotation (Line(points={{-159,-30},{-142,-30}},
                                                   color={0,0,127}));
  connect(TSetCoo.y, oveTSetCoo.u)
    annotation (Line(points={{-199,10},{-182,10}},   color={0,0,127}));
  connect(TSetHea.y, oveTSetHea.u)
    annotation (Line(points={{-199,-30},{-182,-30}}, color={0,0,127}));
  connect(ovePumEmi.y, reaPumEmi.u)
    annotation (Line(points={{13,110},{20,110}}, color={0,0,127}));
  connect(realToInteger.u, reaPumEmi.y)
    annotation (Line(points={{50,110},{43,110}}, color={0,0,127}));
  connect(yOcc.y, case900Template.yOcc) annotation (Line(points={{-59,40},{-52,
          40},{-52,14},{-58,14}},
                              color={0,0,127}));
  connect(senTemSup.port_b,pumEmi. port_a)
    annotation (Line(points={{60,40},{40,40}},   color={0,127,255}));
  connect(bouWat.ports[1], pumEmi.port_a)
    annotation (Line(points={{50,20},{50,40},{40,40}}, color={0,127,255}));
  connect(heaPum.port_a2,pumSou. port_b)
    annotation (Line(points={{136,20},{136,40},{180,40}},color={0,127,255}));
  connect(heaPum.port_b1,senTemSup.port_a)  annotation (Line(points={{124,20},{124,
          40},{80,40}},               color={0,127,255}));
  connect(senTemRet.port_a,heaPum. port_a1) annotation (Line(points={{80,-20},{124,
          -20},{124,0}},        color={0,127,255}));
  connect(case900Template.gainEmb[1], floHea.heatPortEmb[1]) annotation (Line(
        points={{-60,1},{-40,1},{-40,20},{-10,20}},          color={191,0,0}));
  connect(pumEmi.port_b, floHea.port_a)
    annotation (Line(points={{20,40},{0,40},{0,10}},color={0,127,255}));
  connect(floHea.port_b, senTemRet.port_b)
    annotation (Line(points={{-20,10},{-20,-20},{60,-20}},color={0,127,255}));
  connect(pumEmi.P, reaPPumEmi.u) annotation (Line(points={{19,49},{0,49},{0,80},
          {18,80}}, color={0,0,127}));
  connect(pumSou.P, reaPPumSou.u) annotation (Line(points={{179,49},{172,49},{
          172,80},{178,80}},
                         color={0,0,127}));
  connect(reaHeaPumY.y, heaPum.y) annotation (Line(points={{141,150},{400,150},
          {400,-26},{127,-26},{127,-2}},
                                    color={0,0,127}));
  connect(yPumEmi.y, ovePumEmi.u)
    annotation (Line(points={{-19,110},{-10,110}}, color={0,0,127}));
  connect(realToInteger.y, pumEmi.stage) annotation (Line(points={{73,110},{80,
          110},{80,60},{30,60},{30,52}},
                                    color={255,127,0}));
  connect(ovePumSou.y, reaPumSou.u)
    annotation (Line(points={{173,110},{180,110}}, color={0,0,127}));
  connect(realToInteger1.u, reaPumSou.y)
    annotation (Line(points={{210,110},{203,110}}, color={0,0,127}));
  connect(yPumSou.y, ovePumSou.u)
    annotation (Line(points={{141,110},{150,110}}, color={0,0,127}));
  connect(realToInteger1.y, pumSou.stage) annotation (Line(points={{233,110},{
          240,110},{240,60},{190,60},{190,52}},
                                            color={255,127,0}));
  connect(heaPum.P, reaPHeaPum.u)
    annotation (Line(points={{130,21},{130,80},{138,80}}, color={0,0,127}));
  connect(case900Template.TSensor, reaTZon.u) annotation (Line(points={{-60,13},
          {-46,13},{-46,80},{-34,80}}, color={0,0,127}));
  connect(floHea.QTot, reaQFloHea.u) annotation (Line(points={{-21,16},{-32,16},
          {-32,-50},{-22,-50}},
                           color={0,0,127}));
  connect(heaPum.QEva_flow, reaQHeaPumEva.u) annotation (Line(points={{139,21},{
          139,28},{150,28},{150,10},{158,10}}, color={0,0,127}));
  connect(heaPum.QCon_flow, reaQHeaPumCon.u) annotation (Line(points={{121,21},{
          121,28},{110,28},{110,10},{102,10}}, color={0,0,127}));
  connect(reaTSup.u, senTemSup.T) annotation (Line(points={{98,80},{90,80},{90,26},
          {70,26},{70,29}}, color={0,0,127}));
  connect(senTemRet.T, reaTRet.u)
    annotation (Line(points={{70,-31},{70,-50},{98,-50}}, color={0,0,127}));
  connect(heaPumCOP.y, reaHeaPumCOP.u)
    annotation (Line(points={{181,-50},{198,-50}}, color={0,0,127}));
  connect(hex.port_a1, heaPum.port_b2) annotation (Line(points={{266,0},{266,-20},
          {136,-20},{136,0}}, color={0,127,255}));
  connect(hex.port_b2, outAir.ports[1]) annotation (Line(points={{278,0},{278,-20},
          {340,-20},{340,12}}, color={0,127,255}));
  connect(oveFan.y, reaFan.u)
    annotation (Line(points={{313,110},{320,110}}, color={0,0,127}));
  connect(realToInteger2.u, reaFan.y)
    annotation (Line(points={{350,110},{343,110}}, color={0,0,127}));
  connect(yFan.y, oveFan.u)
    annotation (Line(points={{281,110},{290,110}}, color={0,0,127}));
  connect(fan.port_b, hex.port_a2)
    annotation (Line(points={{300,40},{278,40},{278,20}}, color={0,127,255}));
  connect(fan.port_a, outAir.ports[2])
    annotation (Line(points={{320,40},{340,40},{340,8}}, color={0,127,255}));
  connect(realToInteger2.y, fan.stage) annotation (Line(points={{373,110},{380,
          110},{380,60},{310,60},{310,52}},
                                       color={255,127,0}));
  connect(hexEps.y, reaHexEps.u)
    annotation (Line(points={{261,-50},{278,-50}}, color={0,0,127}));
  connect(fan.P, reaPFan.u) annotation (Line(points={{299,49},{290,49},{290,80},
          {318,80}}, color={0,0,127}));
  connect(hexQ.y, reaHexQ.u)
    annotation (Line(points={{341,-50},{358,-50}}, color={0,0,127}));
  connect(offSetOcc.y, addOcc.u1) annotation (Line(points={{-179,152},{-170,152},
          {-170,136},{-162,136}}, color={0,0,127}));
  connect(offSetUno.y, addUno.u1) annotation (Line(points={{-179,70},{-172,70},
          {-172,56},{-162,56}}, color={0,0,127}));
  connect(oveTSetHea.y, addOcc.u2) annotation (Line(points={{-159,-30},{-154,
          -30},{-154,-50},{-228,-50},{-228,124},{-162,124}}, color={0,0,127}));
  connect(oveTSetHea.y, addUno.u2) annotation (Line(points={{-159,-30},{-154,
          -30},{-154,-50},{-228,-50},{-228,44},{-162,44}}, color={0,0,127}));
  connect(oveHeaPumY.y, reaHeaPumY.u)
    annotation (Line(points={{101,150},{118,150}}, color={0,0,127}));
  connect(greater.y, switch1.u2) annotation (Line(points={{-59,90},{-52,90},{
          -52,150},{-22,150}}, color={255,0,255}));
  connect(case900Template.TSensor, conPI.u_m) annotation (Line(points={{-60,13},
          {-46,13},{-46,130},{30,130},{30,138}}, color={0,0,127}));
  connect(conPI.y, oveHeaPumY.u)
    annotation (Line(points={{41,150},{78,150}}, color={0,0,127}));
  connect(switch1.y, conPI.u_s)
    annotation (Line(points={{1,150},{18,150}}, color={0,0,127}));
  connect(addOcc.y, switch1.u1) annotation (Line(points={{-139,130},{-128,130},
          {-128,158},{-22,158}}, color={0,0,127}));
  connect(addUno.y, switch1.u3) annotation (Line(points={{-139,50},{-120,50},{
          -120,142},{-22,142}}, color={0,0,127}));
  connect(const.y, greater.u2) annotation (Line(points={{-93,120},{-90,120},{
          -90,98},{-82,98}}, color={0,0,127}));
  connect(yOcc.y, greater.u1) annotation (Line(points={{-59,40},{-52,40},{-52,
          60},{-100,60},{-100,90},{-82,90}}, color={0,0,127}));
  connect(pumSou.port_a, senTemGly.port_b)
    annotation (Line(points={{200,40},{220,40}}, color={0,127,255}));
  connect(senTemGly.port_a, hex.port_b1)
    annotation (Line(points={{240,40},{266,40},{266,20}}, color={0,127,255}));
  connect(bouGly.ports[1], senTemGly.port_b)
    annotation (Line(points={{210,20},{210,40},{220,40}}, color={0,127,255}));
  annotation (
    experiment(
      StopTime=31500000,
      __Dymola_NumberOfIntervals=5000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"),
    Documentation(info="<html>
<p>This is a single zone residential hydronic system model with an air-source heat pump for WP 1.2 of IBPSA project 1. </p>
<p><b><span style=\"font-size: 10pt;\">Building Design and Use</span></b></p>
<h4>Architecture</h4>
<p>This model represents a residential dwelling for a family of 5 members. The building envelope model is based on the BESTEST case 900 test case. The envelope model is therefore similar to the one used in <a href=\"modelica://IDEAS.Examples.IBPSA.SingleZoneResidentialHydronic\">IDEAS.Examples.IBPSA.SingleZoneResidentialHydronic</a>. but scaled up to have an area 5 times larger. Particularly, the model consists of a single zone with a rectangular floor plan of 13.4 by 17.9 meters and a height of 2.7 m. The zone further consists of several south-oriented windows, which are modelled using a single window of 24 m2. </p>
<h4>Constructions</h4>
<p>The walls consist of 10 cm thick concrete blocks and 6 cm of foam insulation. For more details see <a href=\"modelica://IDEAS.Buildings.Validation.Data.Constructions.HeavyWall\">IDEAS.Buildings.Validation.Data.Constructions.HeavyWall</a>. The floor is modeled as a slab on the ground: <a href=\"modelica://IDEAS.Buildings.Components.Interfaces.BoundaryType.SlabOnGround\">IDEAS.Buildings.Components.Interfaces.BoundaryType.SlabOnGround</a> consisting on the following layers: </p>
<p><b>Floor</b> </p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
<td><p align=\"center\"><h4>Name</h4></p></td>
<td><p align=\"center\"><h4>Thickness [m]</h4></p></td>
<td><p align=\"center\"><h4>Thermal Conductivity [W/m-K]</h4></p></td>
<td><p align=\"center\"><h4>Specific Heat Capacity [J/kg-K]</h4></p></td>
<td><p align=\"center\"><h4>Density [kg/m3]</h4></p></td>
</tr>
<tr>
<td><p>Layer 1 (concrete)</p></td>
<td><p>0.15</p></td>
<td><p>1.4</p></td>
<td><p>840</p></td>
<td><p>2100</p></td>
</tr>
<tr>
<td><p>Layer 2 (insulation)</p></td>
<td><p>0.20</p></td>
<td><p>0.02</p></td>
<td><p>1470</p></td>
<td><p>30</p></td>
</tr>
<tr>
<td><p>Layer 3 (screed)</p></td>
<td><p>0.05</p></td>
<td><p>0.6</p></td>
<td><p>840</p></td>
<td><p>1100</p></td>
</tr>
<tr>
<td><p>Layer 4 (tile)</p></td>
<td><p>0.01</p></td>
<td><p>1.4</p></td>
<td><p>840</p></td>
<td><p>2100</p></td>
</tr>
</table>
<p><br><br><br><br><br><br><br><br>The roof consists of a light construction and 11 cm of fibreglass. </p>
<h4>Occupancy schedules</h4>
<p>The zone is occupied by 5 people before 7 am and after 8 pm each weekday and full time during weekends. </p>
<h4>Internal loads and schedules</h4>
<p>There are no internal loads other than the occupants. </p>
<h4>Climate data</h4>
<p>The model uses a climate file containing one year of weather data for Uccle, Belgium. </p>
<p><b><span style=\"font-size: 10pt;\">HVAC System Design</span></b></p>
<h4>Primary and secondary system designs</h4>
<p>An air-source modulating heat pump of 12.6 kW nominal thermal capacity substracts energy from the ambient air to heat up the floor heating emission circuit. A fan blows 0.1 kg/s of ambient air through a counter-flow heat exchanger when the heat pump is working to exchange heat between the ambient and the evaporator circuit of the heat pump. Such circuit works with a glycol - water mixture at 50&percnt; concentration. The glycol circuit works with a pump that moves the fluid at a rate of 0.5 kg/s when the heat pump is working. The floor heating presents heat injection between Layer 2 (insulation) and Layer 3 (screed), with water as working fluid which is also moved at a rate of 0.5 kg/s when the heat pump is working. </p>
<h4>Equipment specifications and performance maps</h4>
<p>The heat exchanger utilizes a model of a coil with effectiveness - NTU relation without humidity condensation. This model transfers heat in the amount of </p>
<p align=\"center\"><i>Q̇ = Q̇<sub>max</sub> &epsilon;</i></p>
<p align=\"center\">&epsilon; = f(NTU, Z, flowRegime), </p>
<p>where Q̇<sub>max</sub> is the maximum heat that can be transferred, &epsilon; is the heat transfer effectiveness, NTU is the Number of Transfer Units, Z is the ratio of minimum to maximum capacity flow rate and flowRegime is the heat exchanger flow regime. The convective heat transfer coefficients scale proportional to <i>(ṁ/ṁ<sub>0</sub>)<sup>n</i></sup>, where ṁ is the mass flow rate, ṁ<sub>0</sub> is the nominal mass flow rate, and n=0.8 on the air-side and n=0.85 on the water side. For this particular implementation, the computed nominal NTU is of 4.45, with a counter flow regime, and the resulting effectiveness is approximately constant and of 0.37. </p>
<p>The floor heating system circulation pump as well as the heat pump evaporator circuit have the default efficiency of the pump model, which is 49 &percnt; at the time of writing. Also the fan that blows ambient air through the heat exchanger uses this default efficiency of 49&percnt;.</p>
<p>A water to water heat pump with a scroll compressor is used. The heat pump is modeled as described by: </p>
<p>H. Jin. <i>Parameter estimation based models of water source heat pumps. </i>PhD Thesis. Oklahoma State University. Stillwater, Oklahoma, USA. 2012. </p>
<p>The rate of heat transferred to the evaporator is given by: </p>
<p align=\"center\"><i>Q̇<sub>Eva</sub> = ṁ<sub>ref</sub> ( h<sub>Vap</sub>(T<sub>Eva</sub>) - h<sub>Liq</sub>(T<sub>Con</sub>) ). </i></p>
<p>The power consumed by the compressor is given by a linear efficiency relation: </p>
<p align=\"center\"><i>P = P<sub>Theoretical</sub> / &eta; + P<sub>Loss,constant</sub>. </i></p>
<p>Heat transfer in the evaporator and condenser is calculated using an &epsilon;-NTU method, assuming constant refrigerant temperature and constant heat transfer coefficient between fluid and refrigerant. </p>
<p>Variable speed is achieved by multiplying the full load suction volume flow rate by the normalized compressor speed. The power and heat transfer rates are forced to zero if the resulting heat pump state has higher evaporating pressure than condensing pressure. </p>
<p>The model parameters are obtained by calibration of the heat pump model to manufacturer performance data. This implementation uses the performance data from <a href=\"modelica://IDEAS.Fluid.HeatPumps.Data.ScrollWaterToWater.Heating.Viessmann_BW301A21_28kW_5_94COP_R410A\">IDEAS.Fluid.HeatPumps.Data.ScrollWaterToWater.Heating.Viessmann_BW301A21_28kW_5_94COP_R410A</a>. </p>
<p>Parameters <span style=\"font-family: Courier New;\">TConMax</span> and <span style=\"font-family: Courier New;\">TEvaMin</span> are used to set an upper and lower bound for the condenser and evaporator. The compressor is disabled when these conditions are not satisfied, or when the evaporator temperature is larger than the condenser temperature. This mimics the temperature protection of the heat pump. </p>
<p>The compression process is assumed isentropic. The thermal energy of superheating is ignored in the evaluation of the heat transferred to the refrigerant in the evaporator. There is no supercooling. </p>
<h4>Rule-based or local-loop controllers (if included)</h4>
<p>A baseline controller is implemented to procure comfort within the building zone. A PI controller is tuned so that the heat pump modulating signal for compressor frequency is the control variable and the indoor air temperature is the controlled variable. The control variable is limited between 0 and 1, and it is computed to drive the indoor temperature to follow the heating comfort set-point plus an offset which varies depending on the occupancy schedule: during occupied periods the offset is set to only 0.2 degrees Celsius and is meant to avoid discomfort from slight oscilations around the set-point; during unoccupied periods the offset is set to 4.5 degrees Celsius and is meant to compensate for the large setback used during these periods. The latter offset prevents from abrubpt changes in the indoor temperature that can not be accomplished because of the large thermal inertia of the floor heating system and which would consecuently cause importante levels of discomfort. </p>
<p><b><span style=\"font-size: 10pt;\">Model IO&apos;s</span></b></p>
<h4>Inputs</h4>
<p>The model inputs are: </p>
<ul>
<li></li>
</ul>
<h4>Outputs</h4>
<p>The model outputs are: </p>
<ul>
<li></li>
</ul>
<p><b><span style=\"font-size: 10pt;\">Additional System Design</span></b></p>
<h4>Lighting</h4>
<p>No lighting model is included. </p>
<h4>Shading</h4>
<p>No shading model is included. </p>
<p><b><span style=\"font-size: 10pt;\">Model Implementation Details</span></b></p>
<h4>Moist vs. dry air</h4>
<p>The model uses moist air despite that no condensation is modelled in any of the used components. </p>
<h4>Pressure-flow models</h4>
<p>A simple, single circulation loop is used to model the heating system. </p>
<h4>Infiltration models</h4>
<p>Fixed air infiltration corresponding to an n50 value of 10 is modelled. </p>
<p><b><span style=\"font-size: 10pt;\">Scenario Information</span></b></p>
<p><b>Energy Pricing</b> </p>
<p>The <b>Constant Electricity Price</b> profile is: </p>
<p>The constant electricity price scenario uses a constant price of 0.0535 EUR/kWh, as obtained from the &quot;Easy Indexed&quot; deal for electricity (normal rate) in <a href=\"https://www.energyprice.be/products-list/Engie\">https://www.energyprice.be/products-list/Engie</a> (accessed on June 2020). </p>
<p>The <b>Dynamic Electricity Price</b> profile is: </p>
<p>The dynamic electricity price scenario uses a dual rate of 0.0666 EUR/kWh during day time and 0.0383 EUR/kWh during night time, as obtained from the &quot;Easy Indexed&quot; deal for electricity (dual rate) in <a href=\"https://www.energyprice.be/products-list/Engie\">https://www.energyprice.be/products-list/Engie</a> (accessed on June 2020). The on-peak daily period takes place between 7:00 a.m. and 10:00 p.m. The off-peak daily period takes place between 10:00 p.m. and 7:00 a.m. </p>
<p>The <b>Highly Dynamic Electricity Price</b> profile is: </p>
<p>The highly dynamic electricity price scenario is based on the the Belgian day-ahead energy prices as determined by the BELPEX wholescale electricity market in the year 2019. Obtained from: <a href=\"https://my.elexys.be/MarketInformation/SpotBelpex.aspx\">https://my.elexys.be/MarketInformation/SpotBelpex.aspx</a> </p>
<p>The <b>Gas Price</b> profile is: </p>
<p>The gas price is assumed constant and of 0.0198 EUR/kWh as obtained from the &quot;Easy Indexed&quot; deal for gas <a href=\"https://www.energyprice.be/products-list/Engie\">https://www.energyprice.be/products-list/Engie</a> (accessed on June 2020). </p>
<h4>Emission Factors</h4>
<p>The <b>Electricity Emissions Factor</b> profile is: </p>
<p>It is used a constant emission factor for electricity of 0.167 kgCO2/kWh which is the grid electricity emission factor reported by the Association of Issuing Bodies (AIB) for year 2018. For reference, see: <a href=\"https://www.carbonfootprint.com/docs/2019_06_emissions_factors_sources_for_2019_electricity.pdf\">https://www.carbonfootprint.com/docs/2019_06_emissions_factors_sources_for_2019_electricity.pdf</a> </p>
<p>The <b>Gas Emissions Factor</b> profile is: </p>
<p>Based on the kgCO2 emitted per amount of natural gas burned in terms of energy content. It is 0.18108 kgCO2/kWh (53.07 kgCO2/milBTU). For reference, see: <a href=\"https://www.eia.gov/environment/emissions/co2_vol_mass.php\">https://www.eia.gov/environment/emissions/co2_vol_mass.php</a> </p>
</html>", revisions="<html>
<ul>
<li>Jun 16, 2020 by Javier Arroyo:<br>First implementation. </li>
</ul>
</html>"),
    Diagram(coordinateSystem(extent={{-240,-80},{420,180}}, preserveAspectRatio
          =false)),
    Icon(coordinateSystem(extent={{-100,-80},{100,100}})));
end SingleZoneResidentialHydronicHeatPump;
