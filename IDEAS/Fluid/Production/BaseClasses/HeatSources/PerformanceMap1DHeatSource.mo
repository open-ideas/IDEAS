within IDEAS.Fluid.Production.BaseClasses.HeatSources;
model PerformanceMap1DHeatSource "A heatsource based on a 1D performance map"

  //Extensions
  extends IDEAS.Fluid.Production.BaseClasses.PartialHeatSource(redeclare replaceable
      Data.PerformanceMaps.Boiler1D data);

  Modelica.Blocks.Tables.CombiTable1D combiTable1D(
     table=data.table,
     smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    columns={2})
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
equation
  //Calcualation of the heat powers
  QMax = QNom;

  eta = if on_internal then combiTable1D.y[1] else 0;

  connect(THxIn, combiTable1D.u[1]) annotation (Line(
      points={{-108,-40},{-42,-40}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end PerformanceMap1DHeatSource;
