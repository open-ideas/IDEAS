within IDEAS.Examples.PPD12.Data;
record FanCurvePP12 "Curve with constant efficiency for PPD12 fans"
  extends IDEAS.Fluid.Movers.Data.Generic(
    powerOrEfficiencyIsHydraulic = true,
    etaHydMet=IDEAS.Fluid.Movers.BaseClasses.Types.HydraulicEfficiencyMethod.Efficiency_VolumeFlowRate,
    etaMotMet=IDEAS.Fluid.Movers.BaseClasses.Types.MotorEfficiencyMethod.Efficiency_VolumeFlowRate,
    motorEfficiency(V_flow={2},eta={0.95}),
    efficiency(V_flow={0, 150, 300}/3600*1.225,
          eta={0.25, 0.25, 0.25}),
    pressure(V_flow={0,150,300}/3600*1.225,
          dp={300,200,50}));

  annotation (
defaultComponentPrefixes="parameter",
defaultComponentName="per",
    Documentation(info="<html>
<p>
Curve with constant efficiency of 25 % for PPD12 model. 
The fan curve is not tuned to measurements since its value does not affect the electrical power use (constant efficiency).
</p>
</html>", revisions="<html>
<ul>
<li>
October 30, 2024, by Lucas Verleyen and Jelger Jansen:<br/>
Updates according to <a href=\"https://github.com/ibpsa/modelica-ibpsa/tree/8ed71caee72b911a1d9b5a76e6cb7ed809875e1e\">IBPSA</a>.<br/>
See <a href=\"https://github.com/open-ideas/IDEAS/pull/1383\">#1383</a> 
(and <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1704\">IBPSA, #1704</a>,
<a href=\"https://github.com/lbl-srg/modelica-buildings/pull/3845\">Buildings, #3845</a>, and
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2668\">Buildings, #2668</a>).
</li>
<li>
October 28, 2018, by Filip Jorissen:<br/>
First implementation for <a href=\"https://github.com/open-ideas/IDEAS/issues/942\">#942</a>.
</li>
</ul>
</html>"));
end FanCurvePP12;
