within IDEAS.Fluid.HeatExchangers.Radiators;
model FanCoilUnit
  "Fan coil unit with air- and water mass flow control in 3 steps"
  import Buildings;
  extends IDEAS.Fluid.HeatExchangers.Interfaces.EmissionTwoPort;
  extends IDEAS.Fluid.Interfaces.Partials.PartialTwoPort(
     final m=mMedium+mDry*cpDry/Medium.specificHeatCapacityCp(state_default),
     final m_flow_nominal=QNom/Medium.specificHeatCapacityCp(state_default)/(TInNom -TOutNom),
    vol(nPorts=2));

  extends IDEAS.Fluid.Interfaces.TwoPortFlowResistanceParameters(
    final computeFlowResistance=true, dp_nominal = 0);
  IDEAS.Fluid.FixedResistances.FixedResistanceDpM res(
    redeclare package Medium = Medium,
    final use_dh=false,
    final m_flow_nominal=m_flow_nominal,
    final deltaM=deltaM,
    final allowFlowReversal=allowFlowReversal,
    final show_T=false,
    final from_dp=from_dp,
    final linearized=linearizeFlowResistance,
    final homotopyInitialization=homotopyInitialization,
    final dp_nominal=dp_nominal)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  //Advanced settings: based on IDEAS.Fluid.Interfaces.TwoPortHeatMassExchanger

  parameter Boolean homotopyInitialization = true "= true, use homotopy method"
    annotation(Evaluate=true, Dialog(tab="Advanced"));
  parameter Modelica.SIunits.Temperature TInNom=75 + 273.15
    "Nominal inlet temperature";
  parameter Modelica.SIunits.Temperature TOutNom=65 + 273.15
    "Nominal outlet temperature";
  parameter Modelica.SIunits.Temperature TZoneNom=20 + 273.15
    "Nominal room temperature";
  parameter Modelica.SIunits.Power QNom=1000
    "Nominal thermal power at the specified conditions";
  parameter Real fraRad=0.35 "Fraction of radiation at Nominal power";
  parameter Real n=1.3 "Radiator coefficient according to EN 442-2";
  parameter Real powerFactor=1 "Size increase compared to design at 75/65/20";
  // For reference: 45/35/20 is 3.37; 50/40/20 is 2.5:
  // Source: http://www.radson.com/be/producten/paneelradiatoren/radson-compact.htm, accessed on 15/06/2011
  parameter Modelica.SIunits.Mass mMedium(start=1) = 0.0038*QNom*powerFactor
    "Mass of medium (water) in the radiator";
  parameter Modelica.SIunits.Mass mDry(start=1) = 0.018*QNom*powerFactor
    "Mass of dry material (steel/aluminium) in the radiator";
  // cpDry for steel: based on carbon steel, Polytechnisch zakboekje, E1/8
  parameter Modelica.SIunits.SpecificHeatCapacity cpDry=480
    "Specific heat capacity of the dry material, default is for steel";
  final parameter Real UA=QNom/(TOutNom - TZoneNom)^n;
  Modelica.SIunits.HeatFlowRate QTotal(start=0)
    "Total heat emission of the radiator";
  Modelica.SIunits.TemperatureDifference dTRadRoo;
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortCon
    "Convective heat transfer from radiators" annotation (Placement(
        transformation(extent={{40,90},{60,110}}),iconTransformation(extent={{40,90},
            {60,110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortRad
    "Radiative heat transfer from radiators" annotation (Placement(
        transformation(extent={{80,90},{100,110}}),iconTransformation(extent={{80,90},
            {100,110}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-18,36},{-38,56}})));
  Modelica.Blocks.Sources.RealExpression power_rad(y=QTotal)
    "Radiator power (amount of heat delivered)"
    annotation (Placement(transformation(extent={{14,36},{-6,56}})));

  parameter Real[4] posVal={0, 0.5, 0.75, 1}
    "Valve positions for FCU control 0, 1, 2 and 3";
  parameter Modelica.SIunits.TemperatureDifference[3] dTCon = {-1, 0, 1}
    "Control setpoints for the FCU, relative difference for TSet-TAir.  Corresponds to FCU control positions 0, 1, 2, 3";
protected
  constant Medium.ThermodynamicState state_default=Medium.setState_pTX(Medium.p_default, Medium.T_default, Medium.X_default);
public
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val(
    redeclare package Medium = Medium,
    m_flow_nominal=0.027,
    CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
    dpValve_nominal=400)
    annotation (Placement(transformation(extent={{32,10},{52,-10}})));
  Modelica.Blocks.Sources.RealExpression posValFromPosFCU(y=posVal[integer(
        posFCU_real.y) + 1])
    annotation (Placement(transformation(extent={{-2,-44},{30,-24}})));
  Modelica.Blocks.Interfaces.RealInput TSet "Set temperature in the room, in K"
    annotation (Placement(transformation(extent={{-126,-60},{-86,-20}})));
  Controls.ControlHeating.Control_FanCoilUnit posFCU_real(uBou=dTCon)
    "Control position of the FCU, controlled automatically based on TSet and TAct"
    annotation (Placement(transformation(extent={{-30,-44},{-10,-24}})));
  Modelica.Blocks.Math.Add add(k1=-1)
    annotation (Placement(transformation(extent={{-64,-44},{-44,-24}})));
  Modelica.Blocks.Sources.RealExpression TAir(y=heatPortCon.T)
    annotation (Placement(transformation(extent={{-100,-22},{-74,-6}})));
equation
  connect(res.port_b, port_b) annotation (Line(
      points={{80,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None));

  dTRadRoo = max(0, vol.heatPort.T - heatPortCon.T);
  // radiator equation
  QTotal = -UA*(dTRadRoo)^n;
  // negative for heat emission!
  heatPortCon.Q_flow = QTotal*(1 - fraRad);
  heatPortRad.Q_flow = QTotal*fraRad;
  connect(prescribedHeatFlow.port, vol.heatPort) annotation (Line(
      points={{-38,46},{-38,10},{-44,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(power_rad.y, prescribedHeatFlow.Q_flow) annotation (Line(
      points={{-7,46},{-18,46}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(vol.ports[2], val.port_a) annotation (Line(
      points={{-54,0},{32,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(val.port_b, res.port_a) annotation (Line(
      points={{52,0},{60,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(posValFromPosFCU.y, val.y) annotation (Line(
      points={{31.6,-34},{42,-34},{42,-12}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TSet, add.u2) annotation (Line(
      points={{-106,-40},{-66,-40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add.y, posFCU_real.u) annotation (Line(
      points={{-43,-34},{-32,-34}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TAir.y, add.u1) annotation (Line(
      points={{-72.7,-14},{-70,-14},{-70,-28},{-66,-28}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Documentation(info="<html>
<p><b>Description</b> </p>
<p>Simplified dynamic radiator model, not discretized, based on EN&nbsp;442-2. </p>
<p>The <u>thermal emission</u> of the radiator is based on three equations:</p>
<p><code>&nbsp;QTotal&nbsp;=&nbsp;-&nbsp;UA&nbsp;*&nbsp;(dTRadRoo)^n;<font style=\"color: #006400; \">&nbsp;//&nbsp;negative&nbsp;for&nbsp;heat&nbsp;emission!</font></code></p>
<pre> heatPortCon.Q_flow&nbsp;=&nbsp;QTotal&nbsp;*&nbsp;(1-fraRad);
&nbsp;heatPortRad.Q_flow&nbsp;=&nbsp;QTotal&nbsp;*&nbsp;fraRad;</pre>
<p>In these equations, the temperature difference between radiator and room is based on TMean, while the outlet temperature TOut can be different. When there is no flow rate, all temperatures are equal and follow TMean. The first equation is the so-called radiator equation according&nbsp;to&nbsp;EN&nbsp;442-2, with n the radiator exponent (~ 1.3 for normal radiators).</p>
<p>The&nbsp;<u>capacity&nbsp;of&nbsp;the&nbsp;radiator</u>&nbsp;is&nbsp;based&nbsp;on&nbsp;a&nbsp;calculation&nbsp;for&nbsp;one&nbsp;type&nbsp;of&nbsp;radiator&nbsp;from&nbsp;Radson.&nbsp;&nbsp;The&nbsp;headlines&nbsp;of&nbsp;the&nbsp;calculation:</p>
<p>&nbsp;&nbsp;-&nbsp;we&nbsp;suppose&nbsp;the&nbsp;normative&nbsp;75/65/20&nbsp;design&nbsp;conditions&nbsp;(this&nbsp;is&nbsp;a&nbsp;crucial&nbsp;parameter: InletTemperature/OutletTemperature/AmbientTemperature!!!) </p>
<p>&nbsp;&nbsp;-&nbsp;we&nbsp;take&nbsp;a&nbsp;type&nbsp;22&nbsp;radiator&nbsp;from&nbsp;the&nbsp;Radson&nbsp;Compact&nbsp;or&nbsp;Integra&nbsp;series</p>
<p>&nbsp;&nbsp;-&nbsp;we&nbsp;take&nbsp;a&nbsp;length&nbsp;of&nbsp;1.05m,&nbsp;height&nbsp;0.6m</p>
<p>&nbsp;&nbsp;-&nbsp;we&nbsp;get&nbsp;a&nbsp;power&nbsp;of&nbsp;1924W,&nbsp;a&nbsp;water&nbsp;content&nbsp;of&nbsp;7.24&nbsp;l&nbsp;and&nbsp;a&nbsp;steel&nbsp;weight&nbsp;of&nbsp;35.52&nbsp;kg</p>
<p>&nbsp;&nbsp;-&nbsp;water&nbsp;content:&nbsp;0.0038&nbsp;l/W&nbsp;</p>
<p>&nbsp;&nbsp;-&nbsp;steel&nbsp;weight:&nbsp;0.018&nbsp;kg/W</p>
<p>&nbsp;&nbsp;Resulting&nbsp;capacity:&nbsp;24.6&nbsp;J/K&nbsp;per&nbsp;Watt&nbsp;of&nbsp;nominal&nbsp;power</p>
<p>&nbsp;&nbsp;Redo&nbsp;this&nbsp;calculation&nbsp;for&nbsp;other&nbsp;design&nbsp;conditions. &nbsp;Example:&nbsp;for&nbsp;45/35/20&nbsp;we&nbsp;would&nbsp;get&nbsp;3.37&nbsp;times&nbsp;less&nbsp;power,&nbsp;&nbsp;so&nbsp;we&nbsp;have&nbsp;to&nbsp;increase&nbsp;the&nbsp;volume&nbsp;and&nbsp;weight&nbsp;per&nbsp;Watt&nbsp;by&nbsp;3.37</p>
<p><h4>Assumptions and limitations </h4></p>
<p><ol>
<li>Simplified model based on normed radiator equation</li>
<li>No discretization (use an array of Radiators to obtain discretization)</li>
</ol></p>
<p><h4>Model use</h4></p>
<p><ol>
<li>Set all the parameters specifying the nominal power of the radiator (temperatures, Nominal heating power, radiator coefficient n, ...)</li>
<li>Set the parameters specifying the inertia (water content and dry mass). First, the powerFactor is set according to the design temperatures (for&nbsp;reference:&nbsp;45/35/20&nbsp;is&nbsp;3.37;&nbsp;50/40/20&nbsp;is&nbsp;2.5; Source:&nbsp;http://www.radson.com/be/producten/paneelradiatoren/compact.htm,&nbsp;accessed&nbsp;on&nbsp;15/06/2011). In most cases, this will be sufficient. The default computation for mMedium and mDry can be overwritten if a specific design is known. </li>
<li>Connect<u><b> both the heatPortCon and heatPortRad, </b></u>connection only one of them will lead to WRONG RESULTS.</li>
</ol></p>
<p><h4>Validation </h4></p>
<p>Validation has not been performed, but different verification models have been made to verify the properties under different operating conditions.</p>
<p><ul>
<li>the energy balance is checked for different operating conditions in <a href=\"modelica://IDEAS.Thermal.Components.Examples.Radiator_EnergyBalance\">IDEAS.Thermal.Components.Examples.Radiator_EnergyBalance</a></li>
<li>cooling down behaviour is tested in<a href=\"modelica://IDEAS.Thermal.Components.Examples.Radiator_CoolingDown\"> IDEAS.Thermal.Components.Examples.Radiator_CoolingDown</a></li>
</ul></p>
<p><h4>Example (optional) </h4></p>
<p>Besides the validation models, an example of the use of the radiator can be found in <a href=\"modelica://IDEAS.Thermal.Components.Examples.RadiatorWithMixingValve\">IDEAS.Thermal.Components.Examples.RadiatorWithMixingValve</a>.</p>
</html>", revisions="<html>
<p><ul>
<li>2013 May, Roel De Coninck: documentation</li>
<li>2012 April, Roel De Coninck: rebasing on common Partial_Emission</li>
<li>2011, Roel De Coninck: first version</li>
</ul></p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(extent={{-52,-82},{-30,78}},  lineColor={135,135,135}),
        Rectangle(extent={{-22,-82},{0,78}},    lineColor={135,135,135}),
        Rectangle(extent={{8,-82},{30,78}},   lineColor={135,135,135}),
        Rectangle(extent={{38,-82},{60,78}},  lineColor={135,135,135})}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),graphics));
end FanCoilUnit;
