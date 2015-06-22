within IDEAS.Fluid.Production;
model Boiler
  //Extensions
  extends Interfaces.PartialHeaterTwoPort(
    mWater = heatSource.data.m2,
    QNom = heatSource.data.QNomRef,
    m_flow_nominal = heatSource.data.m2_flow_nominal,
    dp_nominal = heatSource.data.dp2_nominal,
    final modulating=true,
    redeclare BaseClasses.HeatSources.Boiler heatSource(redeclare replaceable
        IDEAS.Fluid.Production.Data.BoilerData data));

  inner SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
equation

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Ellipse(
          extent={{-58,60},{60,-60}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={95,95,95}),
        Ellipse(extent={{-46,46},{48,-46}}, lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-30,34},{32,-34}},
          color={0,0,0},
          smooth=Smooth.None)}));
end Boiler;
