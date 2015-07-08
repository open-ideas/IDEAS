within IDEAS.Fluid.BaseCircuits.Interfaces;
model CircuitInterface

  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium in the component"
    annotation (__Dymola_choicesAllMatching=true);

  //Extensions
  extends IDEAS.Fluid.Interfaces.FourPort(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    final allowFlowReversal1 = allowFlowReversal,
    final allowFlowReversal2 = allowFlowReversal);
  extends IDEAS.Fluid.Interfaces.LumpedVolumeDeclarations(
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState);

  //----Fluid parameters
  parameter Boolean dynamicBalance=true
    "Set to true to use a dynamic balance, which often leads to smaller systems of equations"
    annotation(Dialog(tab="Dynamics", group="Equations"));
  parameter Boolean allowFlowReversal=true
    "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
    annotation(Dialog(tab="Assumptions"));
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal
    "Nominal mass flow rate"
    annotation(Dialog(group = "Nominal condition"));
  parameter Modelica.SIunits.MassFlowRate m_flow_small(min=0) = 1E-4*abs(m_flow_nominal)
    "Small mass flow rate for regularization of zero flow";

  annotation (Icon(graphics={  Line(
          points={{-100,-60},{100,-60}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash),
                                   Line(
          points={{-100,60},{100,60}},
          color={0,0,127},
          smooth=Smooth.None),
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={135,135,135})}));
end CircuitInterface;
