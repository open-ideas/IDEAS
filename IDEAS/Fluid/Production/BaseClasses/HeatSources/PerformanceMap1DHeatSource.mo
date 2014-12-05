within IDEAS.Fluid.Production.BaseClasses.HeatSources;
model PerformanceMap1DHeatSource "A heatsource based on a 1D performance map"

  //Extensions
  extends IDEAS.Fluid.Production.BaseClasses.PartialHeatSource;

  //Parameters
  parameter Real[ :,:] table "Data table for the 1D CombiTalbe";

  //Components
  Modelica.Blocks.Tables.CombiTable1Ds combiTable1D(
    table=table,
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  //Final heat power of the heat source
  eta = combiTable1D.y;
  heatPort.Q_flow = -eta/etaRef*QNom - QLossesToCompensate;
  PFuel = if noEvent(release < 0.5) and noEvent(eta>Modelica.Constants.eps) then -heatPort.Q_flow/eta else 0;

  connect(THxIn, combiTable1D.u) annotation (Line(
      points={{-108,-40},{-60,-40},{-60,0},{-12,0}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end PerformanceMap1DHeatSource;
