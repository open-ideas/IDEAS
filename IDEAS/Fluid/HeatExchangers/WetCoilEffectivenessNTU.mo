within IDEAS.Fluid.HeatExchangers;
model WetCoilEffectivenessNTU
  "Heat exchanger with effectiveness - NTU relation and no moisture condensation"
  extends IDEAS.Fluid.HeatExchangers.BaseClasses.PartialEffectivenessNTUWet3(UA=
       1/(1/hA.hA_1 + 1/hA.hA_2));

  parameter Real r_nominal(
    min=0,
    max=1) = 2/3
    "Ratio between air-side and water-side convective heat transfer (hA-value) at nominal condition";

  IDEAS.Fluid.HeatExchangers.BaseClasses.HADryCoil hA(
    final r_nominal=r_nominal,
    final UA_nominal=UA_nominal,
    final m_flow_nominal_w=m1_flow_nominal,
    final m_flow_nominal_a=m2_flow_nominal,
    waterSideTemperatureDependent=false,
    airSideTemperatureDependent=false)
    "Model for convective heat transfer coefficient";


equation
  // Convective heat transfer coefficient
  hA.m1_flow = m1_flow;
  hA.m2_flow = m2_flow;
  hA.T_1 = T_in1;
  hA.T_2 = T_in2;

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={Rectangle(
          extent={{-70,78},{70,-82}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid)}),
    preferredView="info",
defaultComponentName="hex",
    Documentation(info="<html>
<p>
This model is analog to 
<a href=\"modelica://IDEAS.Fluid.HeatExchangers.DryCoilEffectivenessNTU\">
IDEAS.Fluid.HeatExchangers.DryCoilEffectivenessNTU</a> 
but includes humidity condensation by using the Braun-Lebrun model.
</p>
<p>
More detailed information in 
<a href=\"modelica://IDEAS.Fluid.HeatExchangers.BaseClasses.PartialEffectivenessNTUWet\">
IDEAS.Fluid.HeatExchangers.BaseClasses.PartialEffectivenessNTUWet</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
February 25, 2019 by Iago Cupeiro:<br/>
First implementation
</li>
</ul>
</html>"));
end WetCoilEffectivenessNTU;
