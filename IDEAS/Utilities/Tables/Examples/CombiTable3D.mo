within IDEAS.Utilities.Tables.Examples;
model CombiTable3D "Example of CombiTable3D"
  import IDEAS;
  extends Modelica.Icons.Example;
  IDEAS.Utilities.Tables.CombiTable3D combiTable3D(
    table1={{0,1},{2,3}},
    table2={{1,2},{3,4}},
    nDim1=2,
    nDim2=2,
    nDim3=2,
    indicesDim1={2,3},
    indicesDim2={2,3},
    indicesDim3={2,3})
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=0.45,
    freqHz=1,
    offset=2.5)
    annotation (Placement(transformation(extent={{-80,42},{-60,62}})));
  Modelica.Blocks.Sources.Sine sine1(
    amplitude=0.45,
    freqHz=1,
    offset=2.5,
    phase=1) annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  Modelica.Blocks.Sources.Sine sine2(
    amplitude=0.45,
    freqHz=1,
    offset=2.5,
    phase=2)
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
equation
  connect(sine.y, combiTable3D.u1) annotation (Line(points={{-59,52},{-46,52},{
          -46,16},{-22,16}}, color={0,0,127}));
  connect(sine1.y, combiTable3D.u2)
    annotation (Line(points={{-59,10},{-40,10},{-22,10}}, color={0,0,127}));
  connect(sine2.y, combiTable3D.u3) annotation (Line(points={{-59,-30},{-46,-30},
          {-46,4},{-22,4}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CombiTable3D;
