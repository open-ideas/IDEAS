within IDEAS.Buildings.Linearisation.Examples;
model linCase900Comparison
  extends Modelica.Icons.Example;

  linCase900SSM ssm
    annotation (Placement(transformation(extent={{-40,30},{-20,10}})));
  linCase900 modelica
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  Modelica.Blocks.Math.Add eps_lin_ssm(k2=-1)
    annotation (Placement(transformation(extent={{20,-30},{40,-10}})));
  Modelica.Blocks.Math.Add eps_nonLin_lin(k2=-1)
    annotation (Placement(transformation(extent={{20,-40},{40,-60}})));
  Modelica.Blocks.Math.Add eps_lin_rom10(k1=-1, k2=1)
    annotation (Placement(transformation(extent={{20,10},{40,30}})));
  Modelica.Blocks.Math.Add eps_lin_rom5(k1=-1, k2=1)
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
equation
  connect(ssm.y_ssm[1], eps_lin_ssm.u1) annotation (Line(points={{-19,14.6},{-6,
          14.6},{-6,-14},{18,-14}}, color={0,0,127}));
  connect(modelica.y_linear, eps_lin_ssm.u2) annotation (Line(points={{-19.4,
          -35.2},{-6,-35.2},{-6,-26},{18,-26}}, color={0,0,127}));
  connect(eps_nonLin_lin.u2, modelica.y_linear) annotation (Line(points={{18,
          -44},{-6,-44},{-6,-35.2},{-19.4,-35.2}}, color={0,0,127}));
  connect(modelica.y_nonLinear, eps_nonLin_lin.u1) annotation (Line(points={{
          -19.2,-45.2},{-6,-45.2},{-6,-56},{18,-56}}, color={0,0,127}));
  connect(ssm.y_ssm[1], eps_lin_rom10.u2) annotation (Line(points={{-19,14.6},{
          -1.5,14.6},{-1.5,14},{18,14}}, color={0,0,127}));
  connect(ssm.y_rom10[1], eps_lin_rom10.u1) annotation (Line(points={{-19,20},{
          0,20},{0,26},{18,26}}, color={0,0,127}));
  connect(ssm.y_rom5[1], eps_lin_rom5.u1) annotation (Line(points={{-19,26},{
          -12,26},{-12,66},{18,66}}, color={0,0,127}));
  connect(ssm.y_ssm[1], eps_lin_rom5.u2) annotation (Line(points={{-19,14.6},{
          -6,14.6},{-6,54},{18,54}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=1e+006),
    __Dymola_experimentSetupOutput,
    __Dymola_Commands(file=
          "modelica://IDEAS/Resources/Scripts/Dymola/Buildings/Linearisation/Examples/linCase900Comparison.mos"
        "Simulate and Plot"),
    Documentation(info="<html>
<p>
This model allows comparing the simulation accuracy between non-linear, linear, linearised and reduced order models for the example model IDEAS.Buildings.Linearisation.Examples.BaseClasses.LinCase900.
</p>
</html>"));
end linCase900Comparison;
