within IDEAS.Fluid.Production.Interfaces.BaseClasses;
model IdealHeatSource
  //Extensions
  extends PartialHeatSource;

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Utilities.Math.Max       max(nin=2) "Maximum temperature"
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
equation
  connect(max.y,prescribedTemperature. T) annotation (Line(
      points={{-19,0},{-2,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(prescribedTemperature.port, heatPort) annotation (Line(
      points={{20,0},{100,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(TinPrimary, max.u[2]) annotation (Line(
      points={{-80,108},{-80,40},{-52,40},{-52,1},{-42,1}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(QAsked, max.u[1]) annotation (Line(
      points={{-110,30},{-56,30},{-56,-1},{-42,-1}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),      graphics));
end IdealHeatSource;
