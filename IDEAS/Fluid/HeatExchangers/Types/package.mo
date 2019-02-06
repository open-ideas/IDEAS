within IDEAS.Fluid.HeatExchangers;
package Types
  extends Modelica.Icons.TypesPackage;

  type HeatExchangerConfiguration = enumeration(
    ParallelFlow   "Parallel flow",
    CounterFlow   "Counter flow",
    CrossFlowUnmixed   "Cross flow, both streams unmixed",
    CrossFlowStream1MixedStream2Unmixed
        "Cross flow, stream 1 mixed, stream 2 unmixed",
    CrossFlowStream1UnmixedStream2Mixed
        "Cross flow, stream 1 unmixed, stream 2 mixed",
    ConstantTemperaturePhaseChange   "Constant temperature phase change in one stream")
    "Enumeration for heat exchanger construction"
  annotation(Documentation(info="<html>
<p>
 Enumeration that defines the heat exchanger construction.
</p>
<p>
The following heat exchanger configurations are available in this enumeration:
</p>
<table summary=\"summary\" border=\"1\">
<tr><th>Enumeration</th><th>Description</th></tr>
<tr><td>ParallelFlow</td><td>Parallel flow</td></tr>
<tr><td>CounterFlow</td><td>Counter flow</td></tr>
<tr><td>CrossFlowUnmixed</td><td>Cross flow, both streams unmixed</td></tr>
<tr><td>CrossFlowStream1MixedStream2Unmixed</td><td>Cross flow, stream 1 mixed, stream 2 unmixed</td></tr>
<tr><td>CrossFlowStream1UnmixedStream2Mixed</td><td>Cross flow, stream 1 unmixed, stream 2 mixed</td></tr>
<tr><td>ConstantTemperaturePhaseChange</td><td>Constant temperature phase change in one stream</td></tr>
</table>
<p>
Note that for a given heat exchanger, the
 <code>HeatExchangerConfiguration</code> is fixed. However, if the capacity
 flow rates change, then the
 <a href=\"modelica://Buildings.Fluid.Types.HeatExchangerFlowRegime\">
 Buildings.Fluid.Types.HeatExchangerFlowRegime</a> may change. For example,
 a counter flow heat exchanger has <code>HeatExchangerConfiguration=CounterFlow</code>,
 but the <a href=\"modelica://Buildings.Fluid.Types.HeatExchangerFlowRegime\">
 Buildings.Fluid.Types.HeatExchangerFlowRegime</a> can change to parallel flow if one of the two capacity flow rates reverts
 its direction.
 </p>
</html>", revisions=
          "<html>
<ul>
<li>
March 27, 2017, by Michael Wetter:<br/>
Added <code>ConstantTemperaturePhaseChange</code>.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/694\">
Buildings #694</a>.
</li>
<li>
February 18, 2009, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end Types;
