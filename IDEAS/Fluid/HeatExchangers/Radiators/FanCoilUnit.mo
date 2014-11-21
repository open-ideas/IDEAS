within IDEAS.Fluid.HeatExchangers.Radiators;
model FanCoilUnit
  "Fan coil unit with air- and water mass flow control in 3 steps"
  import Buildings;
  import IDEAS;
  extends IDEAS.Fluid.HeatExchangers.Interfaces.EmissionTwoPort;
  extends IDEAS.Fluid.Interfaces.Partials.PartialTwoPort(
     final m=mMedium+mDry*cpDry/Medium.specificHeatCapacityCp(state_default),
     final m_flow_nominal=QNom/Medium.cp_const/(TInNom -TOutNom),
    vol(nPorts=2));
  extends IDEAS.Fluid.Interfaces.TwoPortFlowResistanceParameters(
    final computeFlowResistance=true, dp_nominal = 0);
  replaceable package Air = IDEAS.Media.Air;
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortCon
    "Convective heat transfer from radiators" annotation (Placement(
        transformation(extent={{40,90},{60,110}}),iconTransformation(extent={{40,90},
            {60,110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortRad
    "Radiative heat transfer from radiators" annotation (Placement(
        transformation(extent={{80,90},{100,110}}),iconTransformation(extent={{80,90},
            {100,110}})));
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
  parameter Modelica.SIunits.Mass mMedium = 1.3
    "Mass of medium (water) in the FCU";
  parameter Modelica.SIunits.Mass mDry = 3
    "Mass of dry material (steel/aluminium) in the FCU";
  parameter Modelica.SIunits.SpecificHeatCapacity cpDry=480
    "Specific heat capacity of the dry material, default is for steel";
  constant Real[4] posFCU={0, 1, 2, 3} "Possible FCU control positions";
  parameter Real[4] posVal={0, 0.45, 0.7, 1}
    "Valve positions for FCU control 0, 1, 2 and 3";
  constant Real[4] mFloAirFCU={0, 0.195*1.2, 0.265*1.2, 0.39*1.2}
    "Air flow over FCU heat exchanger for positions 0, 1, 2, 3";
  parameter Modelica.SIunits.TemperatureDifference[3] dTCon = {-2, 0, 1}
    "Control setpoints for the FCU, relative difference for TSet-TAir.  Corresponds to FCU control positions 0, 1, 2, 3"
                                                                                                        annotation(evaluate=false);
  Real posValSet(start=0) = Modelica.Math.Vectors.interpolate(posFCU, posVal, posFCU_real.y)
    "Effective set point for valve position";
  Real mFloAirSet(start=0) = Modelica.Math.Vectors.interpolate(posFCU, mFloAirFCU, posFCU_real.y)
    "Effective set point for air flow rate";
protected
  final parameter Modelica.SIunits.TemperatureDifference dTNatConNom = 3.076*QNom/1000*(TInNom-TZoneNom)/(m_flow_nominal*4180)
    "Temperature drop of the water after natural convection";
   constant Medium.ThermodynamicState state_default=Medium.setState_pTX(Medium.p_default, Medium.T_default, Medium.X_default);
public
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
    dpValve_nominal=800)
    annotation (Placement(transformation(extent={{32,10},{52,-10}})));
  Modelica.Blocks.Interfaces.RealInput TSet "Set temperature in the room, in K"
    annotation (Placement(transformation(extent={{-126,-60},{-86,-20}})));
  IDEAS.Controls.ControlHeating.Ctrl_FanCoilUnit
                                              posFCU_real(uBou=dTCon,
      enableRelease=true)
    "Control position of the FCU, controlled automatically based on TSet and TAct"
    annotation (Placement(transformation(extent={{-30,-44},{-10,-24}})));
  Modelica.Blocks.Math.Add add(k1=-1)
    annotation (Placement(transformation(extent={{-64,-44},{-44,-24}})));
  Modelica.Blocks.Sources.RealExpression TAir(y=heatPortCon.T)
    annotation (Placement(transformation(extent={{-100,-22},{-74,-6}})));
  Modelica.Blocks.Interfaces.RealInput release "if < 0.5, the FCU is OFF"
    annotation (Placement(transformation(extent={{-126,-100},{-86,-60}})));
  Buildings.Fluid.HeatExchangers.DryEffectivenessNTU hexFCU(
    redeclare package Medium1 = Air,
    redeclare package Medium2 = Medium,
    m1_flow_nominal=mFloAirFCU[4],
    m2_flow_nominal=m_flow_nominal,
    dp1_nominal=0,
    dp2_nominal=0,
    Q_flow_nominal=QNom-QNom/1000*3.076*(TInNom-TZoneNom),
    configuration=Buildings.Fluid.Types.HeatExchangerConfiguration.CrossFlowUnmixed,
    T_a1_nominal=TZoneNom,
    T_a2_nominal=TInNom - dTNatConNom)
    "Air/water heat exchanger.  Nominal conditions are for FCU position 3 (maximum power)"
    annotation (Placement(transformation(extent={{10,-4},{-10,16}})));
                                                           // compensation for natural convection
  Sources.MassFlowSource_T airFCUIn(
    use_m_flow_in=true,
    use_T_in=true,
    redeclare package Medium = Air,
    nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={76,46})));
  IDEAS.Buildings.Components.BaseClasses.InteriorConvection naturalConvection(
    final A=QNom/1000,
    fixed=true,
    inc=1.5707963267949) "Natural convection from coil to room"
    annotation (Placement(transformation(extent={{-28,74},{-8,94}})));
                       // educated guess value, should scale with sizing.
  IDEAS.Fluid.Sensors.EnthalpyFlowRate senEntFlo(redeclare package Medium = Air,
      m_flow_nominal=0.39*1.2) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={40,46})));
  IDEAS.Fluid.Sensors.EnthalpyFlowRate senEntFlo1(redeclare package Medium =
        Air, m_flow_nominal=0.39*1.2) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-20,28})));
  IDEAS.Fluid.Sources.Boundary_pT airBou(nPorts=1, redeclare package Medium =
        Air) annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=270,
        origin={-21,55})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={63,77})));
  Modelica.Blocks.Math.Add forcedConvection(k1=1, k2=-1)
    annotation (Placement(transformation(extent={{18,66},{28,76}})));
  Modelica.Blocks.Sources.RealExpression posVal_expr(y=posValSet)
    annotation (Placement(transformation(extent={{10,-44},{30,-24}})));
  Modelica.Blocks.Sources.RealExpression mFloAir_expr(y=mFloAirSet)
    annotation (Placement(transformation(extent={{54,10},{74,30}})));
equation
  connect(res.port_b, port_b) annotation (Line(
      points={{80,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None));
  heatPortRad.Q_flow = 0;
  connect(val.port_b, res.port_a) annotation (Line(
      points={{52,0},{60,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(posVal_expr.y, val.y) annotation (Line(
      points={{31,-34},{42,-34},{42,-12}},
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
  connect(posFCU_real.release, release) annotation (Line(
      points={{-20,-46},{-20,-80},{-106,-80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(vol.ports[2], hexFCU.port_a2) annotation (Line(
      points={{-54,0},{-10,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(hexFCU.port_b2, val.port_a) annotation (Line(
      points={{10,0},{32,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(naturalConvection.port_b, heatPortCon) annotation (Line(
      points={{-8,84},{50,84},{50,100}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(naturalConvection.port_a, vol.heatPort) annotation (Line(
      points={{-28,84},{-38,84},{-38,10},{-44,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(airFCUIn.ports[1], senEntFlo.port_a) annotation (Line(
      points={{66,46},{50,46}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(hexFCU.port_a1, senEntFlo.port_b) annotation (Line(
      points={{10,12},{26,12},{26,46},{30,46}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(hexFCU.port_b1, senEntFlo1.port_a) annotation (Line(
      points={{-10,12},{-20,12},{-20,18}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senEntFlo1.port_b, airBou.ports[1]) annotation (Line(
      points={{-20,38},{-20,48},{-21,48}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TAir.y, airFCUIn.T_in) annotation (Line(
      points={{-72.7,-14},{6,-14},{6,-18},{96,-18},{96,42},{88,42}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatPortCon, prescribedHeatFlow.port) annotation (Line(
      points={{50,100},{50,84},{63,84}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(senEntFlo1.H_flow, forcedConvection.u1) annotation (Line(
      points={{-9,28},{-4,28},{-4,30},{0,30},{0,74},{17,74}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(senEntFlo.H_flow, forcedConvection.u2) annotation (Line(
      points={{40,57},{40,62},{10,62},{10,68},{17,68}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(forcedConvection.y, prescribedHeatFlow.Q_flow) annotation (Line(
      points={{28.5,71},{48,71},{48,60},{63,60},{63,70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(mFloAir_expr.y, airFCUIn.m_flow_in) annotation (Line(
      points={{75,20},{92,20},{92,38},{86,38}},
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
