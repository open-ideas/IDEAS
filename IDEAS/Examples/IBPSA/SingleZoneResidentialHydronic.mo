within IDEAS.Examples.IBPSA;
model SingleZoneResidentialHydronic
  "Single zone residential hydronic example model"
  extends Modelica.Icons.Example;
  inner IDEAS.BoundaryConditions.SimInfoManager       sim
    "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  package Medium = IDEAS.Media.Water;
  IDEAS.Buildings.Validation.Cases.Case900Template case900Template(
    redeclare Buildings.Components.Occupants.Input occNum,
    redeclare Buildings.Components.OccupancyType.OfficeWork occTyp,
    mSenFac=1,
    n50=10)
    "Case 900 BESTEST model"
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));

  IDEAS.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad(
    redeclare package Medium = Medium,
    T_a_nominal=273.15 + 70,
    T_b_nominal=273.15 + 50,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    Q_flow_nominal=3000,
    dp_nominal=0)
    "Radiator"               annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-30,10})));
  IDEAS.Fluid.HeatExchangers.Heater_T hea(
    redeclare package Medium = Medium,
    m_flow_nominal=pump.m_flow_nominal,
    dp_nominal=0,
    QMax_flow=3000) "Ideal heater - pressure drop merged into radiator"
    annotation (Placement(transformation(extent={{20,20},{0,40}})));
  Fluid.Movers.FlowControlled_dp           pump(
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    addPowerToMedium=false,
    use_inputFilter=false,
    redeclare package Medium = Medium,
    m_flow_nominal=rad.m_flow_nominal,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    dp_nominal=100000)
    "Hydronic pump"
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  IDEAS.Fluid.Sources.Boundary_pT bou(
    nPorts=1,
    redeclare package Medium = Medium)
    "Absolute pressure boundary"
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Modelica.Blocks.Interfaces.RealOutput Q(unit="W")
    "Thermal power use of heater"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput TZone(unit="K")
    "Zone operative temperature"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Utilities.Time.CalendarTime calTim(zerTim=IDEAS.Utilities.Time.Types.ZeroTime.NY2019)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Modelica.Blocks.Sources.RealExpression yOcc(y=if calTim.hour < 7 or calTim.hour
         > 19 then 1 else 0)
    "Fixed schedule of 1 occupant between 7 am and 8 pm"
    annotation (Placement(transformation(extent={{-20,40},{-40,60}})));
  IDEAS.Utilities.IO.SignalExchange.Read outputT(description=
        "Operative temperature of the zone", KPIs=IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.OperativeZoneTemperature)
    "Block for reading the zone temperature"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  IDEAS.Utilities.IO.SignalExchange.Overwrite TSetExt(
    u(min=273.15+20, max=273.15+80, unit="K"),
    description="Supply temperature set point of the heater")
    "Block for overwriting control signal" annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={10,80})));
  Modelica.Blocks.Sources.Constant TSetConst(k=273.15 + 60)
    "Constant supply temperature set point"
    annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
  Utilities.IO.SignalExchange.Read outputQ(description="Thermal power", KPIs=
        IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.GasPower)
    "Block for outputting the thermal power"
    annotation (Placement(transformation(extent={{60,50},{80,70}})));
  Utilities.IO.SignalExchange.Read outputP(description="Pump electrical power",
      KPIs=IDEAS.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower)
    "Block for reading the pump electrical power"
    annotation (Placement(transformation(extent={{60,20},{80,40}})));
  Fluid.Actuators.Valves.TwoWayTRV val(
    redeclare package Medium = Medium,
    m_flow_nominal=rad.m_flow_nominal,
    dpValve_nominal=20000,
    dpFixed_nominal=80000,
    from_dp=true)
    annotation (Placement(transformation(extent={{-8,20},{-28,40}})));
equation
  connect(rad.heatPortCon, case900Template.gainCon) annotation (Line(points={{-37.2,
          12},{-48,12},{-48,7},{-60,7}}, color={191,0,0}));
  connect(rad.heatPortRad, case900Template.gainRad) annotation (Line(points={{-37.2,
          8},{-46,8},{-46,4},{-60,4}}, color={191,0,0}));
  connect(pump.port_a, rad.port_b)
    annotation (Line(points={{0,-10},{-30,-10},{-30,0}}, color={0,127,255}));
  connect(pump.port_b, hea.port_a) annotation (Line(points={{20,-10},{40,-10},{40,
          30},{20,30}}, color={0,127,255}));
  connect(bou.ports[1], pump.port_a)
    annotation (Line(points={{-20,-30},{0,-30},{0,-10}}, color={0,127,255}));
  connect(case900Template.yOcc, yOcc.y)
    annotation (Line(points={{-58,14},{-58,50},{-41,50}},color={0,0,127}));
  connect(hea.TSet, TSetExt.y)
    annotation (Line(points={{22,38},{21,38},{21,80}}, color={0,0,127}));
  connect(case900Template.TSensor, outputT.u) annotation (Line(points={{-60,13},
          {46,13},{46,0},{58,0}}, color={0,0,127}));
  connect(outputT.y, TZone)
    annotation (Line(points={{81,0},{110,0}}, color={0,0,127}));
  connect(TSetConst.y, TSetExt.u)
    annotation (Line(points={{-19,80},{-2,80}}, color={0,0,127}));
  connect(hea.Q_flow, outputQ.u)
    annotation (Line(points={{-1,38},{0,38},{0,60},{58,60}}, color={0,0,127}));
  connect(outputQ.y, Q)
    annotation (Line(points={{81,60},{110,60}}, color={0,0,127}));
  connect(outputP.u, pump.P) annotation (Line(points={{58,30},{46,30},{46,20},{
          26,20},{26,-1},{21,-1}}, color={0,0,127}));
  connect(hea.port_b, val.port_a)
    annotation (Line(points={{0,30},{-8,30}}, color={0,127,255}));
  connect(val.port_b, rad.port_a)
    annotation (Line(points={{-28,30},{-30,30},{-30,20}}, color={0,127,255}));
  connect(case900Template.TSensor, val.T) annotation (Line(points={{-60,13},{
          -50,13},{-50,42},{-18,42},{-18,40.6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=31500000,
      __Dymola_NumberOfIntervals=5000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"),
    Documentation(info="<html>
This is a single zone hydronic system model 
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
The zone is occupied by one person before 7 am and after 8 pm each day.
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
The gas heater efficiency is assumed to be 100 % and by default it uses
a fixed supply temperature set point of 60 degrees centigrade.
</p>
<h4>Equipment specifications and performance maps</h4>
<p>
The heating system circulation pump has the default efficiency
of the pump model, which is 49 % at the time of writing.
No efficiency is computed for the heater.
</p>
<h4>Rule-based or local-loop controllers (if included)</h4>
<p>
The model assumes a pump with a constant head.
The resulting flow rate depends on the thermostatic valve
position.
</p>
<h3>Model IO's</h3>
<h4>Inputs</h4>
The model inputs are, through the signal exchange block:
<ul>
<li>
<code>TSup</code> [K]: The supply water temperature of the heater. 
By default a fixed temperature of 60 degrees centigrade is assumed.
The minimum and maximum values of the input are 20 and 80 degrees centigrade.
</li>
</ul>
<h4>Outputs</h4>
The model outputs are:
<ul>
<li>
<code>Q</code> [W]: The thermal heating power of the heater.
</li>
<li>
<code>TZone</code> [K]: The zone operative temperature.
</li>
<li>
<code>P</code> [W]: The pump electrical power.
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
We assume a constant heating (gas) price of 0.04 EUR/kWh (or 0.04 USD/kWh).
</p>
<h4>Emission Factors</h4>
<p>
We assume a constant emission factor for gas of 200 g CO2/kWh.
</p>
</html>", revisions="<html>
<ul>
<li>
March 21, 2019 by Filip Jorissen:<br/>
Revised implementation based on first review for 
<a href=\"https://github.com/open-ideas/IDEAS/issues/996\">#996</a>.
</li>
<li>
January 22nd, 2019 by Filip Jorissen:<br/>
Revised implementation by adding external inputs.
</li>
<li>
May 2, 2018 by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
end SingleZoneResidentialHydronic;
