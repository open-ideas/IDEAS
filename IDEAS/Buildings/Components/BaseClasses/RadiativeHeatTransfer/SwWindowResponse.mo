within IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer;
model SwWindowResponse "Shortwave window respone"
  parameter Integer nLay(min=1)
    "Number of layers of the window";
  parameter Real[:, nLay + 1] SwAbs
    "Absorbed solar radiation for each layer for look-up table as function of angle of incidence";
  parameter Real[:, 2] SwTrans
    "Transmitted solar radiation for look-up table as function of angle of incidence";
  parameter Real[nLay] SwAbsDif
    "Absorbed solar radiation for each layer for look-up table as function of angle of incidence";
  parameter Real SwTransDif
    "Transmitted solar radiation for look-up table as function of angle of incidence";

  final parameter Integer[nLay] columns=
    if (nLay == 1)
    then {2}
    else integer(
      linspace(
      2,
      nLay + 1,
      nLay));

  Modelica.Blocks.Interfaces.RealInput solDir
    "Direct solar irradiation"
    annotation (Placement(transformation(extent={{-120,40},{-80,80}})));
  Modelica.Blocks.Interfaces.RealInput solDif
    "Diffuse solar irradiation"
    annotation (Placement(transformation(extent={{-120,0},{-80,40}})));
  Modelica.Blocks.Interfaces.RealInput angInc
    "Angle of incidence"
    annotation (Placement(transformation(extent={{-120,-60},{-80,-20}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nLay] iSolAbs
    "Port for absorbed solar irradiation"
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a iSolDir
    "Transmitted direct solar radiation through the glazing"
    annotation (Placement(transformation(extent={{-30,-110},{-10,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a iSolDif
    "Transmitted diffuse solar radiation through the glazing"
    annotation (Placement(transformation(extent={{10,-110},{30,-90}})));
  Modelica.Blocks.Math.Gain radToDeg(final k=180/Modelica.Constants.pi)
    "Conversion of radians to degrees"
    annotation (Placement(visible = true, transformation(origin = {-20, 0}, extent = {{-60, -50}, {-40, -30}}, rotation = 0)));
  Modelica.Blocks.Tables.CombiTable1Ds SwAbsDir(
    final table=SwAbs,
    final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    final columns=columns) "lookup table for AOI dependent absorptance"
    annotation (Placement(visible = true, transformation(origin = {-39, -29}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Modelica.Blocks.Tables.CombiTable1Ds SwTransDir(
    final table=SwTrans,
    final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    final columns={2}) "lookup table for AOI dependent transmittance"
    annotation (Placement(visible = true, transformation(origin = {-39, -61}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow[nLay] Abs_flow
    "Solar absorptance in the panes source" annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=90,
        origin={-8.88178e-016,78})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Dir_flow
    "Transmitted direct solar radiation source" annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={-20,-78})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Dif_flow
    "Transmitted diffuse solar radiation source" annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={20,-78})));
  Modelica.Blocks.Math.Product[nLay] SwAbsDirProd annotation (Placement(
        visible = true, transformation(origin = {-9, 31}, extent = {{-7, -7}, {7, 7}}, rotation = 90)));
  Modelica.Blocks.Math.Product SwTransDirProd annotation (Placement(
        visible = true, transformation(origin = {-20, -28}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
  Modelica.Blocks.Math.Add[nLay] add annotation (Placement(visible = true, transformation(origin = {4.44089e-16, 54}, extent = {{6, -6}, {-6, 6}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput y
    "Window opening, y=0 is closed" annotation(
    Placement(visible = true, transformation(origin = {0, -40}, extent = {{-120, -60}, {-80, -20}}, rotation = 0), iconTransformation(origin = {0, -40}, extent = {{-120, -60}, {-80, -20}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression[nLay] SwAbsDirExp(y = { (1 - y)*SwAbsDir.y[i]  for i in 1:nLay})  
    "Shortwave direct absorptance only when window is not fully open" annotation(
    Placement(visible = true, transformation(origin = {-70, -2}, extent = {{-30, -10}, {30, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression SwTransDirExp(y = (1 - y)*SwTransDir.y[1] + y )  
    "Shortwave transmission increases when window is open" annotation(
    Placement(visible = true, transformation(origin = {-70, -10}, extent = {{-30, 10}, {30, -10}}, rotation = 0)));
  Modelica.Blocks.Math.Product[nLay] SwAbsDifProd annotation(
    Placement(visible = true, transformation(origin = {11, 31}, extent = {{-7, -7}, {7, 7}}, rotation = 90)));
  Modelica.Blocks.Sources.RealExpression[nLay] SwAbsDifExp(y = {(1 - y)*SwAbsDif[i] for i in 1:nLay})
    "Shortwave diffuse absorption" annotation(
    Placement(visible = true, transformation(origin = {70, 16}, extent = {{30, -10}, {-30, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression SwTransDifExp(y = (1 - y)*SwTransDif + y)
    "Shortwave diffuse transmission increases when window is open" annotation(
    Placement(visible = true, transformation(origin = {70, -16}, extent = {{30, 10}, {-30, -10}}, rotation = 0)));
  Modelica.Blocks.Math.Product SwTransDifProd
    "Shortwave transmission product" annotation(
    Placement(visible = true, transformation(origin = {20, -28}, extent = {{6, 6}, {-6, -6}}, rotation = 90)));
equation
  connect(Abs_flow.port, iSolAbs) annotation(
    Line(points = {{4.89859e-016, 86}, {0, 86}, {0, 100}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(Dir_flow.port, iSolDir) annotation(
    Line(points = {{-20, -86}, {-20, -100}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(Dif_flow.port, iSolDif) annotation(
    Line(points = {{20, -86}, {20, -100}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(solDir, SwTransDirProd.u1) annotation(
    Line(points = {{-100, 60}, {-60, 60}, {-60, 13}, {-17.5, 13}, {-17.5, -21}, {-16, -21}}, color = {0, 0, 127}));
  for i in 1:nLay loop
   connect(SwAbsDirProd[i].u1, solDir) annotation(
    Line(points = {{-38, 18}, {-38, 14}, {-60, 14}, {-60, 60}, {-100, 60}}, color = {0, 0, 127}));
    connect(SwAbsDifProd[i].u1, solDif) annotation(
      Line(points = {{14, 18}, {16, 18}, {16, 8}, {-62, 8}, {-62, 20}, {-100, 20}}, color = {0, 0, 127}));
  end for;
  connect(SwTransDirProd.y, Dir_flow.Q_flow) annotation(
    Line(points = {{-20, -35}, {-20, -70}}, color = {0, 0, 127}));
  connect(SwAbsDirProd.y, add.u2) annotation(
    Line(points = {{-9, 39}, {-9, 38.5}, {-4, 38.5}, {-4, 47}}, color = {0, 0, 127}));
  connect(add.y, Abs_flow.Q_flow) annotation(
    Line(points = {{0, 61}, {0, 70}}, color = {0, 0, 127}));
  connect(radToDeg.u, angInc) annotation(
    Line(points = {{-82, -40}, {-100, -40}}, color = {0, 0, 127}));
  connect(radToDeg.y, SwAbsDir.u) annotation(
    Line(points = {{-59, -40}, {-50, -40}, {-50, -29}}, color = {0, 0, 127}));
  connect(radToDeg.y, SwTransDir.u) annotation(
    Line(points = {{-59, -40}, {-50, -40}, {-50, -61}}, color = {0, 0, 127}));
  connect(SwAbsDirExp.y, SwAbsDirProd.u2) annotation(
    Line(points = {{-37, -2}, {-37, -1.5}, {-4, -1.5}, {-4, 21}, {-5.5, 21}, {-5.5, 23}, {-5, 23}}, color = {0, 0, 127}));
  connect(SwTransDirExp.y, SwTransDirProd.u2) annotation(
    Line(points = {{-37, -10}, {-37, -15.5}, {-24, -15.5}, {-24, -21}}, color = {0, 0, 127}));
  connect(SwAbsDifProd.y, add.u1) annotation(
    Line(points = {{11, 39}, {11, 47}, {4, 47}}, color = {0, 0, 127}, thickness = 0.5));
  connect(SwAbsDifExp.y, SwAbsDifProd.u2) annotation(
    Line(points = {{37, 16}, {37, 15.5}, {15, 15.5}, {15, 23}}, color = {0, 0, 127}));
  connect(SwTransDifExp.y, SwTransDifProd.u1) annotation(
    Line(points = {{37, -16}, {24, -16}, {24, -21}}, color = {0, 0, 127}));
  connect(SwTransDifProd.u2, solDif) annotation(
    Line(points = {{16, -21}, {16, 8}, {-62, 8}, {-62, 20}, {-100, 20}}, color = {0, 0, 127}));
  connect(Dif_flow.Q_flow, SwTransDifProd.y) annotation(
    Line(points = {{20, -70}, {20, -35}}, color = {0, 0, 127}));
   annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),
    Icon(graphics = {Rectangle(fillColor = {192, 192, 192}, pattern = LinePattern.None, fillPattern = FillPattern.Backward, extent = {{-80, 90}, {80, 70}}), Line(points = {{-80, 70}, {80, 70}}, pattern = LinePattern.None, thickness = 0.5), Line(points = {{44, 40}, {44, -50}}, color = {127, 0, 0}), Line(points = {{44, 40}, {38, 30}}, color = {127, 0, 0}), Line(points = {{44, 40}, {50, 30}}, color = {127, 0, 0}), Line(points = {{14, 40}, {14, -50}}, color = {127, 0, 0}), Line(points = {{14, 40}, {8, 30}}, color = {127, 0, 0}), Line(points = {{14, 40}, {20, 30}}, color = {127, 0, 0}), Line(points = {{-16, 40}, {-16, -50}}, color = {127, 0, 0}), Line(points = {{-16, 40}, {-22, 30}}, color = {127, 0, 0}), Line(points = {{-16, 40}, {-10, 30}}, color = {127, 0, 0}), Line(points = {{-46, 40}, {-46, -50}}, color = {127, 0, 0}), Line(points = {{-46, 40}, {-52, 30}}, color = {127, 0, 0}), Line(points = {{-46, 40}, {-40, 30}}, color = {127, 0, 0})}, coordinateSystem(extent = {{-100, -100}, {100, 100}})),
    Documentation(info = "<html>
<p>The properties for absorption by and transmission through the glazingare taken into account depending on the angle of incidence of solar irradiation and are based on the output of the <a href=\"IDEAS.Buildings.UsersGuide.References\">[WINDOW 6.3]</a> software, i.e. the shortwave properties itselves based on the layers in the window are not calculated in the model but are input parameters. </p>
</html>"));
end SwWindowResponse;