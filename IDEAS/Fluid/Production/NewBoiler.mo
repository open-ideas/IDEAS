within IDEAS.Fluid.Production;
model NewBoiler
  //Extensions
  extends Interfaces.PartialHeaterTwoPort(
    redeclare Interfaces.HeatSources.Boiler
      heatSource(
        redeclare replaceable IDEAS.Fluid.Production.Interfaces.Data.BoilerData
                                                            data));

  inner SimInfoManager sim
    annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
equation
  PFuel = 0;
  PEl = 0;

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
          smooth=Smooth.None),
        Line(
          points={{90,60},{60,60}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{60,60},{42,42}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{60,-60},{44,-44}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash),
        Line(
          points={{90,-60},{60,-60}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash)}));
end NewBoiler;
