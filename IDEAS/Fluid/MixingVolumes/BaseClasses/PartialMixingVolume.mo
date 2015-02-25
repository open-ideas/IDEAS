within IDEAS.Fluid.MixingVolumes.BaseClasses;
partial model PartialMixingVolume
  "Partial mixing volume with inlet and outlet ports (flow reversal is allowed)"

  extends IDEAS.Fluid.Interfaces.LumpedVolumeDeclarations;
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal(min=0)
    "Nominal mass flow rate"
    annotation(Dialog(group = "Nominal condition"));
  // Port definitions
  parameter Integer nPorts=0 "Number of ports"
    annotation(Evaluate=true, Dialog(connectorSizing=true, tab="General",group="Ports"));
  parameter Modelica.SIunits.MassFlowRate m_flow_small(min=0) = 1E-4*abs(m_flow_nominal)
    "Small mass flow rate for regularization of zero flow"
    annotation(Dialog(tab = "Advanced"));
  parameter Boolean allowFlowReversal = true
    "= true to allow flow reversal in medium, false restricts to design direction (ports[1] -> ports[2]). Used only if model has two ports."
    annotation(Dialog(tab="Assumptions"), Evaluate=true);
  parameter Modelica.SIunits.Volume V "Volume";
  parameter Boolean prescribedHeatFlowRate=false
    "Set to true if the model has a prescribed heat flow at its heatPort"
   annotation(Evaluate=true, Dialog(tab="Assumptions",
      enable=use_HeatTransfer,
      group="Heat transfer"));
  parameter Boolean initialize_p = not Medium.singleState
    "= true to set up initial equations for pressure";
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports[nPorts](
      redeclare each package Medium = Medium) "Fluid inlets and outlets"
    annotation (Placement(transformation(extent={{-40,-10},{40,10}},
      origin={0,-100})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    "Heat port for sensible heat input"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.SIunits.Temperature T "Temperature of the fluid";
  Modelica.SIunits.Pressure p "Pressure of the fluid";
  Modelica.SIunits.MassFraction Xi[Medium.nXi]
    "Species concentration of the fluid";
  Medium.ExtraProperty C[Medium.nC](nominal=C_nominal)
    "Trace substance mixture content";
   // Models for the steady-state and dynamic energy balance.
protected
  IDEAS.Fluid.Interfaces.StaticTwoPortConservationEquation steBal(
    sensibleOnly = true,
    redeclare final package Medium=Medium,
    final m_flow_nominal = m_flow_nominal,
    final allowFlowReversal = allowFlowReversal,
    final m_flow_small = m_flow_small) if
        useSteadyStateTwoPort "Model for steady-state balance if nPorts=2"
        annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  IDEAS.Fluid.Interfaces.ConservationEquation dynBal(
    redeclare final package Medium = Medium,
    final energyDynamics=energyDynamics,
    final massDynamics=massDynamics,
    final p_start=p_start,
    final T_start=T_start,
    final X_start=X_start,
    final C_start=C_start,
    final C_nominal=C_nominal,
    final fluidVolume = V,
    final initialize_p = initialize_p,
    m(start=V*rho_start),
    nPorts=nPorts,
    U(start=V*rho_start*Medium.specificInternalEnergy(state_start) + (T_start -
          Medium.reference_T)*dynBal.CSen),
    final mSenFac=mSenFac) if
        not useSteadyStateTwoPort "Model for dynamic energy balance"
    annotation (Placement(transformation(extent={{40,0},{60,20}})));

  // Density at start values, used to compute initial values and start guesses
  parameter Modelica.SIunits.Density rho_start=Medium.density(
   state=state_start) "Density, used to compute start and guess values";
  final parameter Medium.ThermodynamicState state_default = Medium.setState_pTX(
      T=Medium.T_default,
      p=Medium.p_default,
      X=Medium.X_default[1:Medium.nXi]) "Medium state at default values";
  // Density at medium default values, used to compute the size of control volumes
  final parameter Modelica.SIunits.Density rho_default=Medium.density(
    state=state_default) "Density, used to compute fluid mass";
  final parameter Medium.ThermodynamicState state_start = Medium.setState_pTX(
      T=T_start,
      p=p_start,
      X=X_start[1:Medium.nXi]) "Medium state at start values";
  final parameter Boolean useSteadyStateTwoPort=(nPorts == 2) and
      prescribedHeatFlowRate and (
      energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState) and (
      massDynamics == Modelica.Fluid.Types.Dynamics.SteadyState) and (
      substanceDynamics == Modelica.Fluid.Types.Dynamics.SteadyState) and (
      traceDynamics == Modelica.Fluid.Types.Dynamics.SteadyState)
    "Flag, true if the model has two ports only and uses a steady state balance"
    annotation (Evaluate=true);
  // Outputs that are needed to assign the medium properties
  Modelica.Blocks.Interfaces.RealOutput hOut_internal(unit="J/kg")
    "Internal connector for leaving temperature of the component";
  Modelica.Blocks.Interfaces.RealOutput XiOut_internal[Medium.nXi](each unit="1")
    "Internal connector for leaving species concentration of the component";
  Modelica.Blocks.Interfaces.RealOutput COut_internal[Medium.nC](each unit="1")
    "Internal connector for leaving trace substances of the component";

  Modelica.Blocks.Sources.RealExpression QSen_flow(y=heatPort.Q_flow)
    "Block to set sensible heat input into volume"
    annotation (Placement(transformation(extent={{-60,78},{-40,98}})));

equation
  ///////////////////////////////////////////////////////////////////////////
  // asserts
  if not allowFlowReversal then
    assert(ports[1].m_flow > -m_flow_small,
"Model has flow reversal, but the parameter allowFlowReversal is set to false.
  m_flow_small    = " + String(m_flow_small) + "
  ports[1].m_flow = " + String(ports[1].m_flow) + "
");
  end if;
  // Actual definition of port variables.
  //
  // If the model computes the energy and mass balances as steady-state,
  // and if it has only two ports,
  // then we use the same base class as for all other steady state models.
  if useSteadyStateTwoPort then
  connect(steBal.port_a, ports[1]) annotation (Line(
      points={{-20,10},{-22,10},{-22,-60},{0,-60},{0,-100}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(steBal.port_b, ports[2]) annotation (Line(
      points={{5.55112e-16,10},{8,10},{8,10},{8,-88},{0,-88},{0,-100}},
      color={0,127,255},
      smooth=Smooth.None));

    connect(hOut_internal,  steBal.hOut);
    connect(XiOut_internal, steBal.XiOut);
    connect(COut_internal,  steBal.COut);
  else
      connect(dynBal.ports, ports) annotation (Line(
      points={{50,-5.55112e-16},{50,-34},{2.22045e-15,-34},{2.22045e-15,-100}},
      color={0,127,255},
      smooth=Smooth.None));

    connect(hOut_internal,  dynBal.hOut);
    connect(XiOut_internal, dynBal.XiOut);
    connect(COut_internal,  dynBal.COut);
  end if;
  // Medium properties
  p = if nPorts > 0 then ports[1].p else p_start;
  T = Medium.temperature_phX(p=p, h=hOut_internal, X=cat(1,Xi,{1-sum(Xi)}));
  Xi = XiOut_internal;
  C = COut_internal;
  // Port properties
  heatPort.T = T;

  annotation (
defaultComponentName="vol",
Documentation(info="<html>
<p>
This is a partial model of an instantaneously mixed volume.
It is used as the base class for all fluid volumes of the package
<a href=\"modelica://IDEAS.Fluid.MixingVolumes\">
IDEAS.Fluid.MixingVolumes</a>.
</p>

<h4>Implementation</h4>
<p>
If the model is operated in steady-state and has two fluid ports connected,
then the same energy and mass balance implementation is used as in
steady-state component models, i.e., the use of <code>actualStream</code>
is not used for the properties at the port.
</p>
<p>
For simple models that uses this model, see
<a href=\"modelica://IDEAS.Fluid.MixingVolumes\">
IDEAS.Fluid.MixingVolumes</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
October 29, 2014, by Michael Wetter:<br/>
Made assignment of <code>mFactor</code> final, and changed computation of
density to use default medium states as are also used to compute the
specific heat capacity.
</li>
<li>
October 21, 2014, by Filip Jorissen:<br/>
Added parameter <code>mFactor</code> to increase the thermal capacity.
</li>
<li>
July 3, 2014, by Michael Wetter:<br/>
Added parameter <code>initialize_p</code>. This is required
to enable the coil models to initialize the pressure in the first
volume, but not in the downstream volumes. Otherwise,
the initial equations will be overdetermined, but consistent.
This change was done to avoid a long information message that appears
when translating models.
</li>
<li>
May 29, 2014, by Michael Wetter:<br/>
Removed undesirable annotation <code>Evaluate=true</code>.
</li>
<li>
February 11, 2014 by Michael Wetter:<br/>
Removed <code>Q_flow</code> and added <code>QSen_flow</code>.
This was done to clarify what is sensible and total heat flow rate
as part of the correction of issue
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/197\">#197</a>.
</li>
<li>
October 8, 2013 by Michael Wetter:<br/>
Removed propagation of <code>show_V_flow</code>
to instance <code>steBal</code> as it has no longer this parameter.
</li>
<li>
September 13, 2013 by Michael Wetter:<br/>
Renamed <code>rho_nominal</code> to <code>rho_start</code>
because this quantity is computed using start values and not
nominal values.
</li>
<li>
April 18, 2013 by Michael Wetter:<br/>
Removed the check of multiple connections to the same element
of a fluid port, as this check required the use of the deprecated
<code>cardinality</code> function.
</li>
<li>
February 7, 2012 by Michael Wetter:<br/>
Revised base classes for conservation equations in <code>IDEAS.Fluid.Interfaces</code>.
</li>
<li>
September 17, 2011 by Michael Wetter:<br/>
Removed instance <code>medium</code> as this is already used in <code>dynBal</code>.
Removing the base properties led to 30% faster computing time for a solar thermal system
that contains many fluid volumes.
</li>
<li>
September 13, 2011 by Michael Wetter:<br/>
Changed in declaration of <code>medium</code> the parameter assignment
<code>preferredMediumStates=true</code> to
<code>preferredMediumStates= not (energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState)</code>.
Otherwise, for a steady-state model, Dymola 2012 may differentiate the model to obtain <code>T</code>
as a state. See ticket Dynasim #13596.
</li>
<li>
July 26, 2011 by Michael Wetter:<br/>
Revised model to use new declarations from
<a href=\"IDEAS.Fluid.Interfaces.LumpedVolumeDeclarations\">
IDEAS.Fluid.Interfaces.LumpedVolumeDeclarations</a>.
</li>
<li>
July 14, 2011 by Michael Wetter:<br/>
Added start values for mass and internal energy of dynamic balance
model.
</li>
<li>
May 25, 2011 by Michael Wetter:<br/>
<ul>
<li>
Changed implementation of balance equation. The new implementation uses a different model if
exactly two fluid ports are connected, and in addition, the model is used as a steady-state
component. For this model configuration, the same balance equations are used as were used
for steady-state component models, i.e., instead of <code>actualStream(...)</code>, the
<code>inStream(...)</code> formulation is used.
This changed required the introduction of a new parameter <code>m_flow_nominal</code> which
is used for smoothing in the steady-state balance equations of the model with two fluid ports.
This implementation also simplifies the implementation of
<a href=\"modelica://IDEAS.Fluid.MixingVolumes.BaseClasses.PartialMixingVolumeWaterPort\">
IDEAS.Fluid.MixingVolumes.BaseClasses.PartialMixingVolumeWaterPort</a>,
which now uses the same equations as this model.
</li>
<li>
Another revision was the removal of the parameter <code>use_HeatTransfer</code> as there is
no noticable overhead in always having the <code>heatPort</code> connector present.
</li>
</ul>
</li>
<li>
July 30, 2010 by Michael Wetter:<br/>
Added nominal value for <code>mC</code> to avoid wrong trajectory
when concentration is around 1E-7.
See also <a href=\"https://trac.modelica.org/Modelica/ticket/393\">
https://trac.modelica.org/Modelica/ticket/393</a>.
</li>
<li>
February 7, 2010 by Michael Wetter:<br/>
Simplified model and its base classes by removing the port data
and the vessel area.
Eliminated the base class <code>PartialLumpedVessel</code>.
</li>
<li>
October 12, 2009 by Michael Wetter:<br/>
Changed base class to
<a href=\"modelica://IDEAS.Fluid.MixingVolumes.BaseClasses.ClosedVolume\">
IDEAS.Fluid.MixingVolumes.BaseClasses.ClosedVolume</a>.
</li>
</ul>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={Ellipse(
          extent={{-100,98},{100,-102}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={170,213,255}), Text(
          extent={{-58,14},{58,-18}},
          lineColor={0,0,0},
          textString="V=%V"),         Text(
          extent={{-152,100},{148,140}},
          textString="%name",
          lineColor={0,0,255})}));
end PartialMixingVolume;
