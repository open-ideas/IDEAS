within IDEAS.Airflow.Multizone;
model TrickleVent "Self regulating trickle vent"
  extends IDEAS.Fluid.BaseClasses.PartialResistance(
    final m_flow_turbulent = if computeFlowResistance then deltaM * m_flow_nominal_pos else 0,
    final from_dp=true,
    final homotopyInitialization=true);

  parameter Real deltaM(min=1E-6) = 0.3
    "Fraction of nominal mass flow rate where transition to turbulent occurs"
       annotation(Evaluate=true,
                  Dialog(group = "Transition to laminar",
                         enable = not linearized));

  final parameter Real k = if computeFlowResistance then
        m_flow_nominal_pos / sqrt(dp_nominal_pos) else 0
    "Flow coefficient, k=m_flow/sqrt(dp), with unit=(kg.m)^(1/2)";
protected
  final parameter Boolean computeFlowResistance=(dp_nominal_pos > Modelica.Constants.eps)
    "Flag to enable/disable computation of flow resistance"
   annotation(Evaluate=true);
  final parameter Real coeff=
    if linearized and computeFlowResistance
    then if from_dp then k^2/m_flow_nominal_pos else m_flow_nominal_pos/k^2
    else 0
    "Precomputed coefficient to avoid division by parameter";
initial equation
 if computeFlowResistance then
   assert(m_flow_turbulent > 0, "m_flow_turbulent must be bigger than zero.");
 end if;

 assert(m_flow_nominal_pos > 0, "m_flow_nominal_pos must be non-zero. Check parameters.");
equation
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
              k=k,
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
</html>", revisions="<html>
<ul>
<li>
September 21, 2021, by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
end TrickleVent;
