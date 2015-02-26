within IDEAS.Fluid.Production;
model IdealHeater "Ideal heater, no losses to environment, unlimited power"
  extends IDEAS.Fluid.Production.Interfaces.PartialHeater(
    final QNom=1,
    final cDry=0.1,
    final mWater=0,
    redeclare Interfaces.BaseClasses.IdealHeatSource heatSource(
      QNomRef=QNom,
      useToutPrimary=false,
      useTinSecondary=false,
      useToutSecondary=false,
      useMassFlowSecondary=false));

    parameter Real eta = 1 "Boiler efficiency for calculating fuel consumption";
  Sensors.TemperatureTwoPort senTem(redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{54,-50},{34,-30}})));
equation
  // Electricity consumption for electronics and fan only.  Pump is covered by pumpHeater;
  // This data is taken from Viessmann VitoDens 300W, smallest model.  So only valid for
  // very small household condensing gas boilers.
  PEl = 0;
  PFuel = 0;
  connect(condensor.port_b, port_b) annotation (Line(
      points={{-34,10},{-34,60},{100,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem.port_b, massFlowRate.port_a) annotation (Line(
      points={{34,-40},{10,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem.port_a, port_a) annotation (Line(
      points={{54,-40},{70,-40},{70,-60},{100,-60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem.T, heatSource.TinPrimary) annotation (Line(
      points={{44,-29},{44,0},{8,0},{8,11.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(u, heatSource.QAsked) annotation (Line(
      points={{20,-110},{20,18},{10,18}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),
            graphics),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),
         graphics={
        Ellipse(
          extent={{-60,60},{58,-60}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={95,95,95}),
        Ellipse(extent={{-48,46},{46,-46}}, lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-32,34},{30,-34}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{100,60},{44,60}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{44,60},{34,48}},
          color={0,0,127},
          smooth=Smooth.None),
        Polygon(
          points={{10,-25},{30,35},{-10,-25},{10,-25}},
          lineColor={0,255,128},
          smooth=Smooth.None,
          fillColor={0,255,128},
          fillPattern=FillPattern.Solid,
          origin={-25,-10},
          rotation=90),
        Polygon(
          points={{0,-30},{20,30},{-20,-30},{0,-30}},
          lineColor={0,255,128},
          smooth=Smooth.None,
          fillColor={0,255,128},
          fillPattern=FillPattern.Solid,
          origin={30,0},
          rotation=270),
        Line(
          points={{44,-60},{34,-48}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash),
        Line(
          points={{100,-60},{44,-60}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash)}),
    Documentation(info="<html>
<p><h4><font color=\"#008000\">Description </font></h4></p>
<p>Ideal&nbsp;heater,&nbsp;will&nbsp;always&nbsp;make&nbsp;sure&nbsp;to&nbsp;reach&nbsp;the&nbsp;setpoint (no power limitation). This heater has thermal losses to the environment but an energy conversion efficiency of one. The IdealHeatSource will compute the required power and the environmental heat losses, and deliver exactly this heat flux to the heatedFluid so it will reach the set point. </p>
<p>The dynamics have been largely removed from this model by setting a final mWater=0.1 and final cDry=0.1. This ensures that the setpoint is reached at all operating conditions, also when these operating conditions change very rapidly.</p>
<p>See<a href=\"modelica://IDEAS.Thermal.Components.Production.Interfaces.PartialDynamicHeaterWithLosses\"> IDEAS.Thermal.Components.Production.Interfaces.PartialDynamicHeaterWithLosses</a> for more details about the heat losses and dynamics. </p>
<p><h4>Assumptions and limitations </h4></p>
<p><ol>
<li>&apos;pseudo&apos; dynamic model because water content and lumped dry capacity are extremely small</li>
<li>Ideal heater, so unlimited power and will always reach setpoint</li>
<li>Heat losses to environment</li>
</ol></p>
<p><h4>Model use</h4></p>
<p><ol>
<li>Specify medium and initial temperature (of the water + dry mass)</li>
<li>Connect TSet, the flowPorts and the heatPort to environment. </li>
</ol></p>
<p>See also<a href=\"modelica://IDEAS.Thermal.Components.Production.Interfaces.PartialDynamicHeaterWithLosses\"> IDEAS.Thermal.Components.Production.Interfaces.PartialDynamicHeaterWithLosses</a> for more details about the heat losses and dynamics. </p>
<p><h4>Validation </h4></p>
<p>No validation.</p>
<p><h4>Example</h4></p>
<p>An example of this model can be found in <a href=\"modelica://IDEAS.Thermal.Components.Examples.IdealHeater\">IDEAS.Thermal.Components.Examples.IdealHeater</a>.</p>
</html>", revisions="<html>
<p><ul>
<li>March 2014, Filip Jorissen, Annex60 compatibility and simplified implementation</li>
<li>2013 May, Roel De Coninck: removing dynamics to improve setpoint reaching. Removing unused parameters</li>
<li>2012 September, Roel De Coninck, first version</li>
</ul></p>
</html>"));
end IdealHeater;
