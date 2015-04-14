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
  parameter Boolean measurePower=false "Set to true to measure the power";

  //Fluid settings
  //**************
  final parameter Modelica.SIunits.ThermalConductance UALoss=(cDry + mWater*
      Medium.specificHeatCapacityCp(Medium.setState_pTX(Medium.p_default, Medium.T_default,Medium.X_default)))/tauHeatLoss;

  //Variables
  Modelica.SIunits.Power PFuel "Fuel consumption in watt";

  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalLosses(G=
        UALoss) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={-20,-80})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    "heatPort for thermal losses to environment" annotation (Placement(
        transformation(extent={{-40,-110},{-20,-90}}), iconTransformation(
          extent={{-40,-110},{-20,-90}})));

  Modelica.Blocks.Interfaces.RealInput u "Input for the heater. Can be T or Q"
                                          annotation (Placement(transformation(
          extent={{20,-20},{-20,20}},
        rotation=90,
        origin={30,106}),                iconTransformation(
        extent={{18,-18},{-18,18}},
        rotation=90,
        origin={40,110})));
  Modelica.Blocks.Interfaces.RealOutput PEl "Electrical consumption"
    annotation (Placement(transformation(extent={{-252,10},{-232,30}}),
        iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-74,-100})));

  //Components
  replaceable IDEAS.Fluid.Production.Interfaces.BaseClasses.PartialHeatSource
    heatSource(
    UALoss=UALoss,
    calculatePower=measurePower,
    QNom=QNom)
    annotation (Placement(transformation(extent={{10,34},{-10,14}})));
  IDEAS.Fluid.Production.Interfaces.BaseClasses.QAsked
                                qAsked
    annotation (Placement(transformation(extent={{40,10},{20,18}})));
  Modelica.Blocks.Sources.RealExpression m_flow_val
          annotation (Placement(transformation(extent={{78,-4},{54,12}})));

  Modelica.Blocks.Sources.RealExpression h_in_val
          annotation (Placement(transformation(extent={{80,10},{50,26}})));
  Modelica.Blocks.Sources.RealExpression TEnv_val(y=heatPort.T)
    annotation (Placement(transformation(extent={{40,26},{20,40}})));

  Modelica.Blocks.Sources.BooleanExpression on_val(y=on_internal)
    annotation (Placement(transformation(extent={{40,16},{20,30}})));

equation
  connect(thermalLosses.port_b, heatPort) annotation (Line(
      points={{-20,-86},{-20,-94},{-30,-94},{-30,-100}},
      color={191,0,0},
      smooth=Smooth.None));

  connect(heatSource.TEnvironment, TEnv_val.y) annotation (Line(
      points={{10,28},{14,28},{14,33},{19,33}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(on_val.y, heatSource.on) annotation (Line(
      points={{19,23},{20,23},{20,24},{10,24}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(qAsked.y, heatSource.QAsked) annotation (Line(
      points={{19.5,14.04},{20,14.04},{20,14},{14,14},{14,20},{10,20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(u, qAsked.u) annotation (Line(
      points={{30,106},{30,68},{84,68},{84,13.96},{40.9,13.96}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(h_in_val.y, qAsked.h_in) annotation (Line(
      points={{48.5,18},{46,18},{46,17.64},{40.9,17.64}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(m_flow_val.y, qAsked.m_flow) annotation (Line(
      points={{52.8,4},{48,4},{48,10.76},{40.9,10.76}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(m_flow_val.y, heatSource.massFlowSecondary) annotation (Line(
      points={{52.8,4},{0,4},{0,13.8}},
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
