within IDEAS.Fluid.Production.BaseClasses.HeatSources;
partial model PerformanceMap2DHeatSource
  "A heatsource based on a 2D performance map"

  //Extensions
  extends IDEAS.Fluid.Production.BaseClasses.PartialHeatSource;

  //Parameters
  parameter Real[:,:] table "Data table for the 2D Combi Table";

  Modelica.Blocks.Tables.CombiTable2D combiTable2D(
     table=table,
     smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
end PerformanceMap2DHeatSource;
