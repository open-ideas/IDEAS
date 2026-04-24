within IDEAS.Fluid.HeatPumps.Interfaces;
partial model PartialDynamicHeaterWithLosses
  "Partial heater model incl dynamics and environmental losses"
  extends IDEAS.Fluid.Interfaces.TwoPortFlowResistanceParameters(
    dp_nominal = 0,
    final computeFlowResistance = (abs(dp_nominal) > Modelica.Constants.eps));
  extends IDEAS.Fluid.Interfaces.LumpedVolumeDeclarations(
    final mSenFac = 1 + cDry/(mWater*cp_default),
    final massDynamics = energyDynamics);

  constant Boolean homotopyInitialization=true "= true, use homotopy method"
    annotation(HideResult=true);

  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=QNom/cp_default/5
    "Nominal mass flow rate through the condensor"
    annotation (Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.Power QNom
    "Nominal thermal power of the heat pump"
    annotation (Dialog(group="Nominal condition"));

  parameter Modelica.Units.SI.Mass mWater=5
    "Mass of water in the condensor"
    annotation (Dialog(tab="Thermal capacity", enable=not (energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState)));
  parameter Modelica.Units.SI.HeatCapacity cDry=4800
    "Heat capacity of the dry material lumped to condensor"
    annotation (Dialog(tab="Thermal capacity", enable=not (energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState)));

  parameter Modelica.Units.SI.Time tauHeatLoss=7200/cp_default
    "Time constant of environmental heat losses"
    annotation (Dialog(tab="Environmental heat losses"));
  parameter Modelica.Units.SI.ThermalConductance UALoss=mWater*mSenFac*cp_default/tauHeatLoss
    "Thermal conductance, computed based on time constant and thermal mass"
    annotation (Dialog(tab="Environmental heat losses"));

  parameter Boolean allowFlowReversal=true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal. Used only if model has two ports."
    annotation (Dialog(tab="Flow resistance"));

  Modelica.Blocks.Interfaces.RealInput TSet "Temperature setpoint"
    annotation (Placement(
        transformation(extent={{-126,-20},{-86,20}}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-60,120})));
  Modelica.Blocks.Interfaces.RealOutput PEl "Electrical consumption"
    annotation (Placement(transformation(extent={{-94,46},{-114,66}}),
        iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-60,-100})));

  Modelica.Fluid.Interfaces.FluidPort_a port_a(
    redeclare final package Medium = Medium,
    m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
    p(start=Medium.p_default),
    h_outflow(
      start=Medium.h_default,
      nominal=Medium.h_default),
    Xi_outflow(each nominal=0.01))
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(
    redeclare final package Medium = Medium,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
    h_outflow(
      start = Medium.h_default,
      nominal = Medium.h_default),
    Xi_outflow(each nominal=0.01))
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    "Heat port for thermal losses to environment"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}}),
      iconTransformation(extent={{-10,-110},{10,-90}})));

  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalLosses(G=
        UALoss) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-70})));

  IDEAS.Fluid.MixingVolumes.MixingVolume vol(
    redeclare final package Medium = Medium,
    final nPorts=2,
    final V=mWater/rho_default,
    final m_flow_nominal=m_flow_nominal,
    final energyDynamics=energyDynamics,
    final massDynamics=massDynamics,
    final p_start=p_start,
    final T_start=T_start,
    final X_start=X_start,
    final C_start=C_start,
    final C_nominal=C_nominal,
    final mSenFac=mSenFac,
    final allowFlowReversal=allowFlowReversal)
    "Mixing volume for heat injection"
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,0})));

  IDEAS.Fluid.Sensors.TemperatureTwoPort Tin(
    redeclare final package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    tau=0,
    final allowFlowReversal=allowFlowReversal)
    "Inlet temperature"
    annotation (Placement(transformation(extent={{50,-70},{30,-50}})));
  IDEAS.Fluid.Sensors.MassFlowRate senMasFlo(
    redeclare final package Medium = Medium,
    final allowFlowReversal=allowFlowReversal)
    "Mass flow rate sensor"
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=270,
        origin={20,-30})));

  IDEAS.Fluid.FixedResistances.PressureDrop preDro(
    redeclare final package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    final deltaM=deltaM,
    final allowFlowReversal=allowFlowReversal,
    final show_T=false,
    final from_dp=from_dp,
    final linearized=linearizeFlowResistance,
    final homotopyInitialization=homotopyInitialization,
    final dp_nominal=dp_nominal) "Flow resistance"
    annotation (Placement(transformation(extent={{80,-70},{60,-50}})));

protected
  parameter Medium.ThermodynamicState sta_default = Medium.setState_pTX(
    p=Medium.p_default,
    T=Medium.T_default,
    X=Medium.X_default[1:Medium.nXi])
    "Medium state at default properties";
  parameter Modelica.Units.SI.Density rho_default = Medium.density(sta_default)
    "Density at default properties";
  parameter Modelica.Units.SI.SpecificHeatCapacity cp_default =
    Medium.specificHeatCapacityCp(sta_default)
    "Specific heat capacity at default properties";

initial equation
  assert(homotopyInitialization, "In " + getInstanceName() +
    ": The constant homotopyInitialization has been modified from its default value. This constant will be removed in future releases.",
    level = AssertionLevel.warning);

equation
  connect(vol.heatPort, thermalLosses.port_a) annotation (Line(
      points={{10,-10},{0,-10},{0,-60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Tin.port_b, senMasFlo.port_a) annotation (Line(
      points={{30,-60},{20,-60},{20,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(thermalLosses.port_b, heatPort) annotation (Line(
      points={{-1.77636e-015,-80},{-1.77636e-015,-100},{0,-100}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(vol.ports[1], senMasFlo.port_b)
    annotation (Line(points={{20,-1},{20,-20}},  color={0,127,255}));
  connect(vol.ports[2], port_b)
    annotation (Line(points={{20,1},{20,60},{100,60}},  color={0,127,255}));
  connect(preDro.port_a, port_a) annotation (Line(points={{80,-60},{100,-60}}, color={0,127,255}));
  connect(preDro.port_b, Tin.port_a) annotation (Line(points={{60,-60},{50,-60}}, color={0,127,255}));
 annotation (
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},
          preserveAspectRatio=false)),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=false)),
    Documentation(info="<html>
<p><b>Description</b> </p>
<p>This is a partial model from which most heaters (boilers, heat pumps) will extend. This model is <u>dynamic</u> (there is a water content in the heater and a dry mass lumped to it) and it has <u>thermal losses to the environment</u>. To complete this model and turn it into a heater, a <u>heatSource</u> has to be added, specifying how much heat is injected in the heatedFluid pipe, at which efficiency, if there is a maximum power, etc. HeatSource models are grouped in <a href=\"modelica://IDEAS.Thermal.Components.Production.BaseClasses\">IDEAS.Thermal.Components.Production.BaseClasses.</a></p>
<p>The set temperature of the model is passed as a realInput.The model has a realOutput PEl for the electricity consumption.</p>
<p>See the extensions of this model for more details.</p>
<h4>Assumptions and limitations </h4>
<ol>
<li>the temperature of the dry mass is identical as the outlet temperature of the heater </li>
<li>no pressure drop</li>
</ol>
<h4>Model use</h4>
<p>Depending on the extended model, different parameters will have to be set. Common to all these extensions are the following:</p>
<ol>
<li>the environmental heat losses are specified by a <u>time constant</u>. Based on the water content, dry capacity and this time constant, the UA value of the heat transfer to the environment will be set</li>
<li>set the heaterType (useful in post-processing)</li>
<li>connect the set temperature to the TSet realInput connector</li>
<li>connect the flowPorts (flowPort_b is the outlet) </li>
<li>if heat losses to environment are to be considered, connect heatPort to the environment.  If this port is not connected, the dry capacity and water content will still make this a dynamic model, but without heat losses to environment,.  IN that case, the time constant is not used.</li>
</ol>
<h4>Validation </h4>
<p>This partial model is based on physical principles and is not validated. Extensions may be validated.</p>
<h4>Examples</h4>
<p>See the extensions, like the <a href=\"modelica://IDEAS.Thermal.Components.Production.IdealHeater\">IdealHeater</a>, the <a href=\"modelica://IDEAS.Thermal.Components.Production.Boiler\">Boiler</a> or <a href=\"modelica://IDEAS.Thermal.Components.Production.HP_AWMod_Losses\">air-water heat pump</a></p>
</html>", revisions="<html>
<ul>
<li>
February 4, 2025, by Jelger Jansen:<br/>
Added <code>Modelica.Units.</code> to one or multiple parameter(s) due to the removal of <code>import</code> in IDEAS/package.mo.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1415\">#1415</a> .
</li>
<li>
June 5, 2018 by Filip Jorissen:<br/>
Cleaned up implementation for
<a href=\"https://github.com/open-ideas/IDEAS/issues/821\">#821</a>.
</li>
<li>
March, 2014, by Filip Jorissen:<br/>
Annex60 compatibility
</li>
</ul>
</html>"));
end PartialDynamicHeaterWithLosses;
