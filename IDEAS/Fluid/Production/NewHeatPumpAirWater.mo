within IDEAS.Fluid.Production;
model NewHeatPumpAirWater
  //Extensions
  extends Interfaces.PartialHeater(
    redeclare Interfaces.HeatSources.HeatPumpAirWater heatSource(
      redeclare replaceable
        IDEAS.Fluid.Production.Interfaces.Data.HeatPumpAirWaterData data,
      final heatPumpWaterWater=false));

  Interfaces.BaseClasses.QAsked qAsked(redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{84,-50},{64,-30}})));
  inner SimInfoManager sim
    annotation (Placement(transformation(extent={{-74,72},{-54,92}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=sim.Te)
    annotation (Placement(transformation(extent={{38,46},{18,66}})));
  Sensors.TemperatureTwoPort senTem(redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{44,-50},{24,-30}})));
equation
  PFuel = 0;
  PEl = 0;

  connect(port_a, qAsked.port_a) annotation (Line(
      points={{100,-60},{92,-60},{92,-40},{84,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(qAsked.port_b, senTem.port_a) annotation (Line(
      points={{64,-40},{44,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(massFlowRate.port_a, senTem.port_b) annotation (Line(
      points={{10,-40},{24,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(u, qAsked.u) annotation (Line(
      points={{20,-110},{20,-72},{88,-72},{88,-26},{76.1,-26},{76.1,-33.1}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(senTem.T, heatSource.TinPrimary) annotation (Line(
      points={{34,-29},{34,0},{8,0},{8,11.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qAsked.y, heatSource.QAsked) annotation (Line(
      points={{71.9,-33.1},{71.9,18},{10,18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(condensor.port_b, port_b) annotation (Line(
      points={{-34,10},{-34,60},{100,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(realExpression.y, heatSource.TinSecondary) annotation (Line(
      points={{17,56},{8,56},{8,32.2}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Polygon(
          points={{-40,100},{-20,100},{-20,80},{40,80},{40,-80},{10,-80},{10,-72},
              {0,-80},{-10,-72},{-10,-80},{-40,-80},{-40,100}},
          smooth=Smooth.None,
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Ellipse(extent={{-70,50},{-10,-10}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-88,20},{-58,20},{-30,32},{-50,8},{-22,20},{-10,20}},
          color={0,127,255},
          smooth=Smooth.None),
        Ellipse(extent={{10,-10},{70,-70}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{10,-40},{22,-40},{50,-28},{30,-52},{52,-44},{52,-60}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{-10,20},{0,20},{-20,-40},{-88,-40}},
          color={0,127,255},
          smooth=Smooth.None),
        Line(
          points={{10,-40},{-6,-40},{28,60},{90,60}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{-10,-72},{-10,-88},{10,-72},{10,-88},{-10,-72}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-40,-10},{-40,-80},{-10,-80}},
          smooth=Smooth.None,
          color={0,0,0}),
        Line(
          points={{10,-80},{40,-80},{40,-70}},
          smooth=Smooth.None,
          color={0,0,0}),
        Line(
          points={{-40,50},{-40,100},{-20,100}},
          smooth=Smooth.None,
          color={0,0,0}),
        Line(
          points={{40,-10},{40,80},{20,80}},
          smooth=Smooth.None,
          color={0,0,0}),
        Line(
          points={{52,-60},{80,-60}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{-68,20},{-148,20},{-148,0},{-88,0},{-88,-20},{-148,-20},{-148,
              -40},{-68,-40}},
          color={0,127,255},
          smooth=Smooth.None),
        Line(
          points={{80,-60},{90,-60}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-140,34},{-140,-48}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-130,34},{-130,-48}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-120,34},{-120,-48}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-110,34},{-110,-48}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-100,34},{-100,-48}},
          color={0,0,0},
          smooth=Smooth.None)}));
end NewHeatPumpAirWater;
