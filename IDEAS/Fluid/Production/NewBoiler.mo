within IDEAS.Fluid.Production;
model NewBoiler
  //Extensions
  extends Interfaces.PartialHeater(redeclare Interfaces.HeatSources.Boiler
      heatSource(
      useToutPrimary=false,
      useTinSecondary=false,
      useToutSecondary=false,
      useMassFlowSecondary=false));

  Interfaces.BaseClasses.QAsked qAsked(redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{76,-50},{56,-30}})));
  inner SimInfoManager sim
    annotation (Placement(transformation(extent={{-74,72},{-54,92}})));
  Sensors.TemperatureTwoPort senTem(redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{44,-50},{24,-30}})));
equation
  PFuel = 0;
  PEl = 0;

  connect(port_a, qAsked.port_a) annotation (Line(
      points={{100,-40},{76,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(qAsked.port_b, senTem.port_a) annotation (Line(
      points={{56,-40},{44,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(massFlowRate.port_a, senTem.port_b) annotation (Line(
      points={{10,-40},{24,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(u, qAsked.u) annotation (Line(
      points={{20,-110},{20,-68},{80,-68},{80,-28},{68.1,-28},{68.1,-33.1}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatSource.QAsked, qAsked.y) annotation (Line(
      points={{10,18},{63.9,18},{63.9,-33.1}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatSource.TinPrimary, senTem.T) annotation (Line(
      points={{8,11.8},{8,-12},{34,-12},{34,-29}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(condensor.port_b, port_b) annotation (Line(
      points={{-34,10},{-34,40},{100,40}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Ellipse(
          extent={{-60,56},{58,-64}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={95,95,95}),
        Ellipse(extent={{-48,42},{46,-50}}, lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-32,30},{30,-38}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{100,40},{58,40}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{58,40},{48,28}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{62,-40},{52,-28}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash),
        Line(
          points={{100,-40},{62,-40}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash)}));
end NewBoiler;
