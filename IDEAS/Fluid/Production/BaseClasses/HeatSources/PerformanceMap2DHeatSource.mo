within IDEAS.Fluid.Production.BaseClasses.HeatSources;
model PerformanceMap2DHeatSource "A heatsource based on a 2D performance map"

  //Extensions
  extends IDEAS.Fluid.Production.BaseClasses.PartialHeatSource(redeclare replaceable
      Data.PerformanceMaps.Boiler2D data);

  Modelica.Blocks.Tables.CombiTable2D combiTable2D(
     table=data.table,
     smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
    annotation (Placement(transformation(extent={{-22,-52},{-2,-32}})));
equation
  //Calcualation of the heat powers
  QMax = QNom;

  eta = if on_internal then combiTable2D.y else 0;

  connect(m_flow, combiTable2D.u1) annotation (Line(
      points={{-108,40},{-46,40},{-46,-36},{-24,-36}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(THxIn, combiTable2D.u2) annotation (Line(
      points={{-108,-40},{-60,-40},{-60,-48},{-24,-48}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end PerformanceMap2DHeatSource;
