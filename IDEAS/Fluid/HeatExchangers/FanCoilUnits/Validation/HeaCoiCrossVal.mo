within IDEAS.Fluid.HeatExchangers.FanCoilUnits.Validation;
model HeaCoiCrossVal
  "Cross validation using nominal conditions of highest temperature"
  extends HeaCoil(fcu55(
      deltaTHea_nominal=fcu80.deltaTHea_nominal,
      Q_flow_nominal=fcu80.Q_flow_nominal,
      T_a2_nominal=fcu80.T_a2_nominal), fcu35(
      deltaTHea_nominal=fcu80.deltaTHea_nominal,
      Q_flow_nominal=fcu80.Q_flow_nominal,
      T_a2_nominal=fcu80.T_a2_nominal));
  annotation (Documentation(revisions="<html>
<ul>
<li>
April 2, 2019, by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>This model cross-validat</p>
</html>"));
end HeaCoiCrossVal;
