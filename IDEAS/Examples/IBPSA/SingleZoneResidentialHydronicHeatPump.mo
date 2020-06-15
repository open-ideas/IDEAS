within IDEAS.Examples.IBPSA;
model SingleZoneResidentialHydronicHeatPump
  "Single zone residential hydronic example using a heat pump as heating production system"
  extends Modelica.Icons.Example;
  package MediumWater = IDEAS.Media.Water "Water medium";
  parameter Modelica.SIunits.Temperature TSetCooUno = 273.15+30 "Unoccupied cooling setpoint" annotation (Dialog(group="Setpoints"));
  parameter Modelica.SIunits.Temperature TSetCooOcc = 273.15+24 "Occupied cooling setpoint" annotation (Dialog(group="Setpoints"));
  parameter Modelica.SIunits.Temperature TSetHeaUno = 273.15+15 "Unoccupied heating setpoint" annotation (Dialog(group="Setpoints"));
  parameter Modelica.SIunits.Temperature TSetHeaOcc = 273.15+21 "Occupied heating setpoint" annotation (Dialog(group="Setpoints"));

  inner IDEAS.BoundaryConditions.SimInfoManager       sim
    "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{-180,120},{-160,140}})));

  IDEAS.Buildings.Validation.Cases.Case900Template case900Template(
    redeclare Buildings.Components.Occupants.Input occNum,
    redeclare Buildings.Components.OccupancyType.OfficeWork occTyp,
    mSenFac=1,
    n50=10)
    "Case 900 BESTEST model"
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));

  Utilities.Time.CalendarTime calTim(zerTim=IDEAS.Utilities.Time.Types.ZeroTime.NY2019)
    annotation (Placement(transformation(extent={{-180,100},{-160,120}})));
  Modelica.Blocks.Sources.RealExpression yOcc(y=if (calTim.hour < 7 or calTim.hour
         > 19) or calTim.weekDay > 5 then 1 else 0)
    "Fixed schedule of 1 occupant between 7 am and 8 pm"
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  IDEAS.Utilities.IO.SignalExchange.Overwrite oveTSetSup(u(
      min=273.15 + 20,
      max=273.15 + 80,
      unit="K"), description="Supply temperature setpoint of the heater")
    "Block for overwriting supply temperature control signal" annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-30,110})));
  Modelica.Blocks.Sources.Constant offSet(k=0.2, y(unit="K"))
    "Offset above heating temperature setpoint to ensure comfort"
    annotation (Placement(transformation(extent={{-170,20},{-150,40}})));
  Utilities.IO.SignalExchange.Read reaPPumEmi(
    description="Emission circuit pump electrical power",
    KPIs=IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W"))
    "Block for reading the electrical power of the pump of the emission system"
    annotation (Placement(transformation(extent={{20,60},{40,80}})));

  Modelica.Blocks.Math.RealToInteger realToInteger
    annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
  Controls.Discrete.HysteresisRelease       con(revert=true)
    "Hysteresis controller for emission system "
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
  Utilities.IO.SignalExchange.Overwrite ovePum(u(
      min=0,
      max=1,
      unit="1"), description=
        "Integer signal to control the stage of the pump either on or off")
    "Block for overwriting pump control signal" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={10,-70})));

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
    annotation (Placement(transformation(extent={{-90,-60},{-70,-40}})));
  Utilities.IO.SignalExchange.Read reaTSetHea(description=
        "Zone air temperature setpoint for heating", y(unit="K"))
    "Read zone cooling heating"
    annotation (Placement(transformation(extent={{-90,-90},{-70,-70}})));
  Modelica.Blocks.Sources.RealExpression TSetCoo(y=if yOcc.y > 0 then
        TSetCooOcc else TSetCooUno) "Cooling temperature setpoint with setback"
    annotation (Placement(transformation(extent={{-156,-60},{-136,-40}})));
  Modelica.Blocks.Sources.RealExpression TSetHea(y=if yOcc.y > 0 then
        TSetHeaOcc else TSetHeaUno) "Heating temperature setpoint with setback"
    annotation (Placement(transformation(extent={{-156,-90},{-136,-70}})));
  Utilities.IO.SignalExchange.Read reaTSetSup(description=
        "Supply temperature setpoint of heater", y(unit="K"))
    "Read supply temperature setpoint of heater"
    annotation (Placement(transformation(extent={{0,100},{20,120}})));
  Utilities.IO.SignalExchange.Read reaPum(description="Control signal for pump",
      y(unit="1")) "Read control signal for pump"
    annotation (Placement(transformation(extent={{30,-80},{50,-60}})));
  Modelica.Blocks.Continuous.LimPID conPI(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=100,
    Ti=300,
    yMax=1,
    yMin=0,
    initType=Modelica.Blocks.Types.InitPID.InitialState)
    "PI controller for the boiler supply water temperature"
    annotation (Placement(transformation(extent={{-80,100},{-60,120}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-130,0},{-110,20}})));
  Fluid.Movers.FlowControlled_dp       pumEmi(
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    use_inputFilter=false,
    dp_nominal=20000,
    m_flow_nominal=0.2,
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
    redeclare package Medium2 = MediumWater,
    scaling_factor=0.9,
    m2_flow_nominal=pumSou.m_flow_nominal,
    enable_variable_speed=true,
    m1_flow_nominal=pumEmi.m_flow_nominal,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    datHeaPum=
        IDEAS.Fluid.HeatPumps.Data.ScrollWaterToWater.Heating.Viessmann_BW301A21_28kW_5_94COP_R410A(),
    dp1_nominal=pumEmi.dp_nominal/2,
    dp2_nominal=pumSou.dp_nominal)
    "Heat pump model, rescaled for low thermal powers" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={110,10})));
  Fluid.Sources.Boundary_pT bou1(
    redeclare package Medium = MediumWater,
    nPorts=2,
    T=283.15) "Cold water source for heat pump"
              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={230,10})));
  Fluid.Movers.FlowControlled_dp       pumSou(
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    use_inputFilter=false,
    dp_nominal=20000,
    m_flow_nominal=0.2,
    redeclare package Medium = MediumWater,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
    "Circulation pump at source side"
    annotation (Placement(transformation(extent={{200,30},{180,50}})));
  Fluid.Sources.Boundary_pT       bou(redeclare package Medium = MediumWater, nPorts=
       1)            "Expansion vessel" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={50,10})));
  Utilities.IO.SignalExchange.Read reaPPumSou(
    description="Source circuit pump electrical power",
    KPIs=IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W"))
    "Block for reading the electrical power of the pump at the heat pump source side"
    annotation (Placement(transformation(extent={{180,60},{200,80}})));

equation
  connect(con.y, ovePum.u)
    annotation (Line(points={{-19,-70},{-2,-70}}, color={0,0,127}));
  connect(case900Template.ppm, reaCO2RooAir.u) annotation (Line(points={{-59,10},
          {-54,10},{-54,-20},{-58,-20}},
                                    color={0,0,127}));
  connect(oveTSetCoo.y, reaTSetCoo.u)
    annotation (Line(points={{-99,-50},{-92,-50}}, color={0,0,127}));
  connect(oveTSetHea.y, reaTSetHea.u)
    annotation (Line(points={{-99,-80},{-92,-80}}, color={0,0,127}));
  connect(reaTSetCoo.y, con.uHigh) annotation (Line(points={{-69,-50},{-60,-50},
          {-60,-74},{-42,-74}}, color={0,0,127}));
  connect(reaTSetHea.y, con.uLow) annotation (Line(points={{-69,-80},{-60,-80},{
          -60,-78},{-42,-78}},  color={0,0,127}));
  connect(TSetCoo.y, oveTSetCoo.u)
    annotation (Line(points={{-135,-50},{-122,-50}}, color={0,0,127}));
  connect(TSetHea.y, oveTSetHea.u)
    annotation (Line(points={{-135,-80},{-122,-80}}, color={0,0,127}));
  connect(oveTSetSup.y, reaTSetSup.u)
    annotation (Line(points={{-19,110},{-2,110}},
                                               color={0,0,127}));
  connect(ovePum.y, reaPum.u)
    annotation (Line(points={{21,-70},{28,-70}}, color={0,0,127}));
  connect(realToInteger.u, reaPum.y)
    annotation (Line(points={{58,-70},{51,-70}}, color={0,0,127}));
  connect(conPI.y, oveTSetSup.u)
    annotation (Line(points={{-59,110},{-42,110}},
                                                 color={0,0,127}));
  connect(TSetHea.y, add.u2) annotation (Line(points={{-135,-80},{-132,-80},{
          -132,-60},{-164,-60},{-164,4},{-132,4}}, color={0,0,127}));
  connect(offSet.y, add.u1) annotation (Line(points={{-149,30},{-140,30},{-140,
          16},{-132,16}}, color={0,0,127}));
  connect(add.y, conPI.u_s) annotation (Line(points={{-109,10},{-100,10},{-100,110},
          {-82,110}},    color={0,0,127}));
  connect(case900Template.TSensor, conPI.u_m) annotation (Line(points={{-60,13},
          {-50,13},{-50,90},{-70,90},{-70,98}}, color={0,0,127}));
  connect(yOcc.y, case900Template.yOcc) annotation (Line(points={{-59,40},{-52,40},
          {-52,14},{-58,14}}, color={0,0,127}));
  connect(case900Template.TSensor, con.u) annotation (Line(points={{-60,13},{-50,
          13},{-50,-70},{-42,-70}}, color={0,0,127}));
  connect(senTemSup.port_b,pumEmi. port_a)
    annotation (Line(points={{60,40},{40,40}},   color={0,127,255}));
  connect(bou.ports[1],pumEmi. port_a)
    annotation (Line(points={{50,20},{50,40},{40,40}},    color={0,127,255}));
  connect(heaPum.port_a2,pumSou. port_b)
    annotation (Line(points={{116,20},{116,40},{180,40}},color={0,127,255}));
  connect(heaPum.port_b2,bou1. ports[1]) annotation (Line(points={{116,0},{116,
          -20},{212,-20},{212,8},{220,8}},     color={0,127,255}));
  connect(pumSou.port_a,bou1. ports[2]) annotation (Line(points={{200,40},{212,
          40},{212,12},{220,12}}, color={0,127,255}));
  connect(heaPum.port_b1,senTemSup.port_a)  annotation (Line(points={{104,20},{
          104,40},{80,40}},           color={0,127,255}));
  connect(senTemRet.port_a,heaPum. port_a1) annotation (Line(points={{80,-20},{
          104,-20},{104,0}},    color={0,127,255}));
  connect(case900Template.gainEmb[1], floHea.heatPortEmb[1]) annotation (Line(
        points={{-60,1},{-40,1},{-40,20},{-10,20},{-10,10}}, color={191,0,0}));
  connect(pumEmi.port_b, floHea.port_a)
    annotation (Line(points={{20,40},{0,40},{0,0}}, color={0,127,255}));
  connect(floHea.port_b, senTemRet.port_b)
    annotation (Line(points={{-20,0},{-20,-20},{60,-20}}, color={0,127,255}));
  connect(pumEmi.P, reaPPumEmi.u) annotation (Line(points={{19,49},{0,49},{0,70},
          {18,70}}, color={0,0,127}));
  connect(pumSou.P, reaPPumSou.u) annotation (Line(points={{179,49},{160,49},{
          160,70},{178,70}},
                         color={0,0,127}));
  connect(reaTSetSup.y, heaPum.y) annotation (Line(points={{21,110},{254,110},{
          254,-70},{107,-70},{107,-2}}, color={0,0,127}));
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
    Diagram(coordinateSystem(extent={{-180,-100},{260,140}})),
    Icon(coordinateSystem(extent={{-180,-100},{260,140}})));
end SingleZoneResidentialHydronicHeatPump;
