within IDEAS.Utilities.IO;
model heatPortPrescribedHeatFlow

  Modelica.Blocks.Interfaces.RealInput Q_flow(unit="W")
    annotation (Placement(transformation(extent={{-128,50},{-88,90}})));
  Modelica.Blocks.Interfaces.RealOutput T(unit="K")
    annotation (Placement(transformation(extent={{-92,-90},{-132,-50}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port1
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Sources.RealExpression Q_flow_val(y=port1.T)
    annotation (Placement(transformation(extent={{20,-80},{0,-60}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-2,-10},{18,10}})));
equation
  connect(Q_flow_val.y, T) annotation (Line(
      points={{-1,-70},{-112,-70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(prescribedHeatFlow.port, port1) annotation (Line(
      points={{18,0},{100,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Q_flow, prescribedHeatFlow.Q_flow) annotation (Line(
      points={{-108,70},{-12,70},{-12,0},{-2,0}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(graphics={Text(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,0},
          textString="u = Q_flow
y = T"), Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0}),
        Text(
          extent={{-100,-100},{100,-120}},
          lineColor={0,0,255},
          textString="%name")}));
end heatPortPrescribedHeatFlow;
