within IDEAS.Fluid.Production.Interfaces;
partial model PartialHeater
  "Partial heater model incl dynamics and environmental losses"

  //Imports
  import IDEAS;
  replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium "Medium in the component"
      annotation (choicesAllMatching = true);
  //Extensions
  extends IDEAS.Fluid.Interfaces.OnOffInterface(use_onOffSignal=true);

  //Parameters
  //****************************************************************************

  //Heater Characteristics
  //**********************
  parameter Modelica.SIunits.Power QNom "Nominal power";
  parameter Modelica.SIunits.Time tauHeatLoss=7200
    "Time constant of environmental heat losses";
  parameter Modelica.SIunits.Mass mWater=5 "Mass of water in the condensor";
  parameter Modelica.SIunits.HeatCapacity cDry=4800
    "Capacity of dry material lumped to condensor";

  //Heater settings
  //***************
  parameter Boolean useQSet=false "Set to true to use Q as an input";
  parameter Boolean modulating=true
    "Set to true if the heater is able to modulate";
  parameter Boolean modulationInput=true
    "Set to true to use modulation as an input";

  //Fluid settings
  //**************
  final parameter Modelica.SIunits.ThermalConductance UALoss=(cDry + mWater*
      Medium.specificHeatCapacityCp(Medium.setState_pTX(Medium.p_default, Medium.T_default,Medium.X_default)))/tauHeatLoss;

  //Intefaces
  //*********
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    "heatPort for thermal losses to environment" annotation (Placement(
        transformation(extent={{-10,-110},{10,-90}}),  iconTransformation(
          extent={{-10,-110},{10,-90}})));
  Modelica.Blocks.Interfaces.RealInput u if not modulationInput
    "Input for the heater. Can be T or Q" annotation (Placement(transformation(
          extent={{20,-20},{-20,20}},
        rotation=90,
        origin={20,108}),                iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=90,
        origin={20,108})));
  Modelica.Blocks.Interfaces.RealInput uModulation if modulationInput
    "modulation input"
    annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=90,
        origin={-60,108}), iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=90,
        origin={-60,108})));
  Modelica.Blocks.Interfaces.RealOutput PFuelOrEl
    "Electrical or fuel consumption"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,-106}),
        iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-80,-30})));

  //Components
  //**********
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalLosses(
    G=UALoss) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-36,-42})));

  replaceable IDEAS.Fluid.Production.BaseClasses.PartialHeatSource heatSource(
    UALoss=UALoss,
    QNom=QNom,
    modulating=modulating,
    modulationInput=modulationInput)
    annotation (Placement(transformation(extent={{-4,42},{-24,22}})));
  IDEAS.Fluid.Production.BaseClasses.QAsked qAsked
    annotation (Placement(transformation(extent={{30,6},{10,26}})));
  Modelica.Blocks.Sources.RealExpression mFlowSecondary
    annotation (Placement(transformation(extent={{62,0},{42,20}})));

  Modelica.Blocks.Sources.RealExpression hIn
    annotation (Placement(transformation(extent={{62,14},{42,34}})));

  Modelica.Blocks.Sources.BooleanExpression OnOff(y=on_internal)
    annotation (Placement(transformation(extent={{28,22},{8,42}})));

  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TEnvironment
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor ToutSecondary
    annotation (Placement(transformation(extent={{-36,22},{-56,42}})));

  parameter Boolean use_modulation_security=false
    "Set to true if power modulation should be used to avoid exceeding temperature."
                                                                                     annotation(dialog(tab="Advanced",group="Events"));
equation
  connect(thermalLosses.port_b, heatPort) annotation (Line(
      points={{-36,-52},{-36,-100},{0,-100}},
      color={191,0,0},
      smooth=Smooth.None));

  connect(OnOff.y, heatSource.on) annotation (Line(
      points={{7,32},{-4,32}},
      color={255,0,255},
      smooth=Smooth.None));

  if modulationInput then
    qAsked.u=0;
  else
    connect(u, qAsked.u) annotation (Line(
      points={{20,108},{20,21.2}},
      color={0,0,127},
      smooth=Smooth.None));
  end if;
  connect(qAsked.y, heatSource.QAsked) annotation (Line(
      points={{9,16},{4,16},{4,28},{-4,28}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(hIn.y, qAsked.h_in) annotation (Line(
      points={{41,24},{36,24},{36,18},{30.8,18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(mFlowSecondary.y, heatSource.massFlowSecondary) annotation (Line(
      points={{41,10},{-14,10},{-14,21.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qAsked.m_flow, heatSource.massFlowSecondary) annotation (Line(
      points={{30.8,14},{36,14},{36,10},{-14,10},{-14,21.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TEnvironment.port, heatPort) annotation (Line(
      points={{40,-40},{32,-40},{32,-76},{-36,-76},{-36,-100},{0,-100}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(TEnvironment.T, heatSource.TEnvironment) annotation (Line(
      points={{60,-40},{76,-40},{76,42},{4,42},{4,36},{-4,36}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatSource.heatPort, thermalLosses.port_a) annotation (Line(
      points={{-24,32},{-36,32},{-36,-32}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heatSource.heatPort, ToutSecondary.port) annotation (Line(
      points={{-24,32},{-36,32}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(ToutSecondary.T, heatSource.ToutSecondary) annotation (Line(
      points={{-56,32},{-60,32},{-60,16},{-10,16},{-10,21.8}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(heatSource.power, PFuelOrEl) annotation (Line(
      points={{-24.6,28},{-32,28},{-32,6},{20,6},{20,-106}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(uModulation, heatSource.uModulation) annotation (Line(
      points={{-60,108},{-60,86},{-20,86},{-20,42.2}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},
          preserveAspectRatio=false), graphics),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=false),
                    graphics),
    Documentation(info="<html>
<p><b>Description</b> </p>
<p>This is a partial model from which most heaters (boilers, heat pumps) will extend. This model is <u>dynamic</u> (there is a water content in the heater and a dry mass lumped to it) and it has <u>thermal losses to the environment</u>. To complete this model and turn it into a heater, a <u>heatSource</u> has to be added, specifying how much heat is injected in the heatedFluid pipe, at which efficiency, if there is a maximum power, etc. HeatSource models are grouped in <a href=\"modelica://IDEAS.Thermal.Components.Production.BaseClasses\">IDEAS.Thermal.Components.Production.BaseClasses.</a></p>
<p>The set temperature of the model is passed as a realInput.The model has a realOutput PEl for the electricity consumption.</p>
<p>See the extensions of this model for more details.</p>
<p><h4>Assumptions and limitations </h4></p>
<p><ol>
<li>the temperature of the dry mass is identical as the outlet temperature of the heater </li>
<li>no pressure drop</li>
</ol></p>
<p><h4>Model use</h4></p>
<p>Depending on the extended model, different parameters will have to be set. Common to all these extensions are the following:</p>
<p><ol>
<li>the environmental heat losses are specified by a <u>time constant</u>. Based on the water content, dry capacity and this time constant, the UA value of the heat transfer to the environment will be set</li>
<li>set the heaterType (useful in post-processing)</li>
<li>connect the set temperature to the TSet realInput connector</li>
<li>connect the flowPorts (flowPort_b is the outlet) </li>
<li>if heat losses to environment are to be considered, connect heatPort to the environment.  If this port is not connected, the dry capacity and water content will still make this a dynamic model, but without heat losses to environment,.  IN that case, the time constant is not used.</li>
</ol></p>
<p><h4>Validation </h4></p>
<p>This partial model is based on physical principles and is not validated. Extensions may be validated.</p>
<p><h4>Examples</h4></p>
<p>See the extensions, like the <a href=\"modelica://IDEAS.Thermal.Components.Production.IdealHeater\">IdealHeater</a>, the <a href=\"modelica://IDEAS.Thermal.Components.Production.Boiler\">Boiler</a> or <a href=\"modelica://IDEAS.Thermal.Components.Production.HP_AWMod_Losses\">air-water heat pump</a></p>
</html>", revisions="<html>
<ul>
<li>2014 March, Filip Jorissen, Annex60 compatibility</li>
</ul>
</html>"));
end PartialHeater;
