within IDEAS.Fluid.Production;
model HeatPumpAirWater
  //Extensions
  extends Interfaces.PartialHeaterTwoPort(
    mWater = heatSource.data.m2,
    QNom = heatSource.data.QNomRef,
    m_flow_nominal = heatSource.data.m2_flow_nominal,
    redeclare BaseClasses.HeatSources.HeatPumpAirWater heatSource(useTinPrimary
        =true, useTinSecondary=false));

  inner SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.RealExpression TAmbient(y=sim.Te)
    annotation (Placement(transformation(extent={{26,50},{6,70}})));
equation

  connect(TAmbient.y, heatSource.TinPrimary) annotation (Line(
      points={{5,60},{-6,60},{-6,42.2}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Ellipse(extent={{-40,40},{40,-40}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{72,30},{-34,30},{-34,10},{-2,10},{-2,-10},{-34,-10},{-34,-30},
              {72,-30}},
          color={0,127,255},
          smooth=Smooth.None,
          origin={0,60},
          rotation=270),
        Line(
          points={{3,40},{3,-40}},
          color={0,0,0},
          smooth=Smooth.None,
          origin={0,81},
          rotation=90),
        Line(
          points={{1,40},{1,-40}},
          color={0,0,0},
          smooth=Smooth.None,
          origin={0,71},
          rotation=90),
        Line(
          points={{1,40},{1,-40}},
          color={0,0,0},
          smooth=Smooth.None,
          origin={0,77},
          rotation=90),
        Line(
          points={{-1,40},{-1,-40}},
          color={0,0,0},
          smooth=Smooth.None,
          origin={0,67},
          rotation=90),
        Line(
          points={{-30,-12},{10,8},{-6,-26},{30,-12}},
          color={0,127,0},
          smooth=Smooth.None)}));
end HeatPumpAirWater;
