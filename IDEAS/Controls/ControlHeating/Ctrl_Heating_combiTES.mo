within IDEAS.Controls.ControlHeating;
model Ctrl_Heating_combiTES
  "Heating curve control for heating based on a combi tank (DHW + heating)"
  extends Interfaces.Partial_Ctrl_Heating_TES;

  input Modelica.SIunits.Temperature TTankEmiOut
    "Tank temperature at outlet to emission";
  Modelica.SIunits.Temperature TTankEmiOutSet
    "Setpoint for the tank layer at outlet to emission";

equation
  TTopSet = max(TDHWSet, heatingCurve.TSup) + dTSafetyTop;
  TBotSet = max(TDHWSet, heatingCurve.TSup) + dTSafetyBot;
  TTankEmiOutSet = heatingCurve.TSup + dTSafetyTop;
  THPSet = TTopSet + dTHPTankSet;

  if noEvent((TTankTop < TTopSet or TTankEmiOut < TTankEmiOutSet) and TTankBot
       < (TBotSet - dTSafetyBot)) then
    // top or emi-layer too cold, system MUST be on except if bottom is still very hot (temp inversion?)
    onOff = 1;
  elseif noEvent(TTankBot < TBotSet and onOff > 0.5) then
    // HP running, top is fine, bottom too cold: keep running
    onOff = 1;
  else
    // all other cases: shut down
    onOff = 0;
  end if;

  connect(heatingCurve.TSup, THeaCur) annotation (Line(
      points={{1,56},{12,56},{12,-40},{104,-40}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(graphics), Documentation(info="<html>
<p><b>Description</b> </p>
<p>Heating curve based control of a heater + TES charging control. The set point temperature for the heater is higher than the heating curve output in order to make sure that the heating curve temperature is met also when thermal losses are present in the circuit. The heater set temperature is the maximum of the requirements for space heating and DHW: if tank charging is occurring, the DHW temperture requirements will normally be higher than for space heating. </p>
<p>This controller tries to limit and even avoid the creating of events.</p>
<p><h4>Model use</h4></p>
<p><ol>
<li>Use this controller in a heating system with a combi storage tank where you want to follow a heating curve for space heating.</li>
</ol></p>
<p><h4>Validation </h4></p>
<p>No validation performed.</p>
<p><h4>Example </h4></p>
<p>This controller is used in <a href=\"modelica://IDEAS.Thermal.HeatingSystems.Heating_Embedded_DHW_STS\">IDEAS.Thermal.HeatingSystems.Heating_Embedded_DHW_STS</a>.</p>
</html>", revisions="<html>
<p><ul>
<li>2013 May, Roel De Coninck: documentation</li>
<li>2011, Roel De Coninck: first version and validation</li>
</ul></p>
</html>"));
end Ctrl_Heating_combiTES;
