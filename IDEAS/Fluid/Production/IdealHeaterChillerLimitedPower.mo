within IDEAS.Fluid.Production;
model IdealHeaterChillerLimitedPower
  "Ideal heater and chiller with limited power"
  extends IDEAS.Fluid.Production.Interfaces.PartialDynamicHeaterWithLosses(
    final heaterType=IDEAS.Fluid.Production.BaseClasses.HeaterType.Boiler,
    final QNom=1,
    final cDry=0.1,
    final mWater=0);
  parameter Modelica.SIunits.Power QHea_nominal(min=0) "Nominal heating power";
  parameter Modelica.SIunits.Power QCoo_nominal(min=0) "Nominal cooling power";

  parameter Modelica.SIunits.Efficiency effBoi = 1
    "Boiler efficiency for calculating fuel consumption";
  parameter Modelica.SIunits.Efficiency effChi = 1
    "Chiller efficiency for calculating electrical consumption";

  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-12,30},{8,50}})));
  Utilities.Math.SmoothLimit smoothLim(
    upper=QHea_nominal,
    lower=-QCoo_nominal,
    deltaX=max(QHea_nominal, QCoo_nominal)/100) "Maximum temperature"
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Modelica.Blocks.Sources.RealExpression QAsked_val(y=QAsked)
    annotation (Placement(transformation(extent={{-92,30},{-56,50}})));
protected
  Real QAsked = IDEAS.Utilities.Math.Functions.spliceFunction(pos=port_a.m_flow*(Medium.specificEnthalpy_pTX(port_a.p,TSet,inStream(port_a.Xi_outflow)) - inStream(port_a.h_outflow)),
                                                              neg=port_b.m_flow*(Medium.specificEnthalpy_pTX(port_b.p,TSet,inStream(port_b.Xi_outflow)) - inStream(port_b.h_outflow)),
                                                              x=port_a.m_flow,
                                                              deltax=m_flow_nominal/50);
equation
  PEl = if QAsked < 0 then QAsked/effChi else 0;
  PFuel = if QAsked > 0 then QAsked/effBoi else 0;

  connect(prescribedHeatFlow.port, pipe_HeatPort.heatPort) annotation (Line(
      points={{8,40},{28,40},{28,-6}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(smoothLim.y, prescribedHeatFlow.Q_flow) annotation (Line(
      points={{-19,40},{-12,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(QAsked_val.y, smoothLim.u) annotation (Line(
      points={{-54.2,40},{-42,40}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,120}}),
            graphics),
    Icon(graphics={
        Ellipse(
          extent={{-60,60},{58,-60}},
          lineColor={127,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255}),
        Ellipse(extent={{-48,46},{46,-46}}, lineColor={95,95,95}),
        Line(
          points={{-32,34},{30,-34}},
          color={95,95,95},
          smooth=Smooth.None),
        Line(
          points={{98,20},{42,20}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{100,-40},{68,-40},{68,-80},{-2,-80},{-2,-46}},
          color={0,0,127},
          smooth=Smooth.None),
        Text(
          extent={{-100,120},{100,80}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="%name")}),
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
end IdealHeaterChillerLimitedPower;
