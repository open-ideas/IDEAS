within IDEAS.Fluid.Production.BaseClasses.HeatSources;
model PerformanceMap1DHeatSource "A heatsource based on a 1D performance map"

  //Extensions
  extends IDEAS.Fluid.Production.BaseClasses.PartialHeatSource;

  //Parameters
  parameter Real table[:,2] "Data table for the 1D Combi Table";

  Modelica.Blocks.Tables.CombiTable1D combiTable1D(
     table=table,
     smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
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
