within IDEAS.Fluid.Production.BaseClasses.HeatSources;
model PerformanceMap2DHeatSource "A heatsource based on a 2D performance map"

  //Extensions
  extends IDEAS.Fluid.Production.BaseClasses.PartialHeatSource(
    use_onOffSignal=true);

  //Parameters
  parameter Real[:,:] table "Data table for the 2D Combi Table";

  Modelica.Blocks.Tables.CombiTable2D combiTable2D(
     table=table,
     smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
equation
  //Final heat power of the heat source
  release = if noEvent(m_flow > Modelica.Constants.eps) then 0.0 else 1.0;
  eta = if on then combiTable2D.y else 0;
  heatPort.Q_flow = if on then -eta/etaRef*QNom - QLossesToCompensate else 0;
  PFuel = if noEvent(release < 0.5) and noEvent(eta>Modelica.Constants.eps) then -heatPort.Q_flow/eta else 0;
  QLossesToCompensate = if noEvent(eta > Modelica.Constants.eps) then UALoss*(heatPort.T - sim.Te) else 0;

  connect(m_flow, combiTable2D.u1) annotation (Line(
      points={{-108,40},{-46,40},{-46,6},{-22,6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(THxIn, combiTable2D.u2) annotation (Line(
      points={{-108,-40},{-46,-40},{-46,-6},{-22,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end PerformanceMap2DHeatSource;
