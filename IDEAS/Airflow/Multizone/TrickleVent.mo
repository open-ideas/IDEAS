within IDEAS.Airflow.Multizone;
model TrickleVent "Self regulating trickle vent"
  extends IDEAS.Fluid.BaseClasses.PartialResistance(
    final m_flow_turbulent = if computeFlowResistance then deltaM * m_flow_nominal_pos else 0,
    final from_dp=true,
    final homotopyInitialization=true);

  parameter Real l(min=1e-10, max=1) = 0.0001
    "Valve leakage, l=Kv(y=0)/Kv(y=1)";
  parameter Real deltaM(min=1E-6) = 0.3
    "Fraction of nominal mass flow rate where transition to turbulent occurs"
       annotation(Evaluate=true,
                  Dialog(group = "Transition to laminar",
                         enable = not linearized));
  parameter Boolean use_y = false 
    "=true, to enable control input"
    annotation(Evaluate=true, Dialog(group="Control"));
  final parameter Real k = if computeFlowResistance then
        m_flow_nominal_pos / sqrt(dp_nominal_pos) else 0
    "Flow coefficient, k=m_flow/sqrt(dp), with unit=(kg.m)^(1/2)";
  Modelica.Blocks.Interfaces.RealInput y(min=0,max=1) if use_y "Control input for trickle vent Kv value" annotation(
    Placement(visible = true, transformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
protected
  final parameter Boolean computeFlowResistance=(dp_nominal_pos > Modelica.Constants.eps)
    "Flag to enable/disable computation of flow resistance"
   annotation(Evaluate=true);
  final parameter Real coeff=
    if linearized and computeFlowResistance
    then if from_dp then k^2/m_flow_nominal_pos else m_flow_nominal_pos/k^2
    else 0
    "Precomputed coefficient to avoid division by parameter";
    Modelica.Blocks.Interfaces.RealInput y_internal "Internal variable for conditional variables";
initial equation
 if computeFlowResistance then
   assert(m_flow_turbulent > 0, "m_flow_turbulent must be bigger than zero.");
 end if;

 assert(m_flow_nominal_pos > 0, "m_flow_nominal_pos must be non-zero. Check parameters.");
equation
  connect(y, y_internal);
  if not use_y then
    y_internal = 1;
  end if;
  // Pressure drop calculation
  if computeFlowResistance then
    if linearized then
      m_flow = dp*coeff;
    else
      m_flow=
            IDEAS.Utilities.Math.Functions.smoothMin(
            m_flow_nominal,
            IDEAS.Fluid.BaseClasses.FlowModels.basicFlowFunction_dp(
              dp=dp,
              k=k*(l + (1-l)*y_internal),
              m_flow_turbulent=m_flow_turbulent),
            m_flow_nominal/10);
    end if; // linearized
  else // do not compute flow resistance
    dp = 0;
  end if;  // computeFlowResistance

  annotation (defaultComponentName="vent",
Documentation(info="<html>
<p>
Model of a self regulating trickle vent.
The positive mass flow rate is limited to <code>m_flow_nominal</code>
at a pressure difference of <code>dp_nominal</code>.
For negative pressure differences the mass flow rate is not limited.
</p>
<p>
An optional control input can be enabled, which reduces the flow rate for the same
pressure difference, but which does not affect the maximum flow rate.
</p>
</html>", revisions="<html>
<ul>
<li>
July 9, 2023, by Filip Jorissen:<br/>
Add control input.
</li>
<li>
September 21, 2021, by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
end TrickleVent;