within IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Validation;
model GeoCoolValidation
  "Validation based on measurement data from GeoCool project"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable[3](
    each tableOnFile=true,
    tableName={"MassFlowRateECkgh","TinECC","ToutECC"},
    each fileName="modelica://IDEAS/Resources/Data/GeoCool.mat")
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  MultipleBoreHoles multipleBoreholes(
    redeclare package Medium = Medium,
    T_start=273.15 + 19.5,
    bfData=bfData,
    lenSim=5*365*24*3600) "borefield"
    annotation (Placement(transformation(extent={{-20,-40},{20,0}})));
  Movers.FlowMachine_m_flow pum[2](
    redeclare each package Medium = Medium,
    each m_flow_nominal=bfData.m_flow_nominal,
    each dynamicBalance=false)
    annotation (Placement(transformation(extent={{-6,10},{-26,30}})));
  Sensors.TemperatureTwoPort senTem[2](
    redeclare each package Medium = Medium,
    each m_flow_nominal=bfData.m_flow_nominal,
    each tau=0)
    annotation (Placement(transformation(extent={{40,-30},{60,-10}})));
  parameter Data.BorefieldData.BorefieldDataGeoCool
    bfData
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Fluid.Sources.Boundary_pT boundary(          redeclare package
      Medium = Medium,
    use_T_in=true,
    nPorts=3)
    annotation (Placement(transformation(extent={{92,6},{72,26}})));
  Modelica.Blocks.Math.Add add[3]
    annotation (Placement(transformation(extent={{-30,70},{-10,90}})));
  Modelica.Blocks.Sources.Constant const[3](k={0,273.15,273.15})
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Modelica.Blocks.Math.Gain gain[3](k={0.00027777,1,1})
    annotation (Placement(transformation(extent={{0,70},{20,90}})));
  replaceable package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater;
  Modelica.Blocks.Math.Min minb[3]
    annotation (Placement(transformation(extent={{30,60},{50,80}})));
  Modelica.Blocks.Math.Max maxb[3] annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={70,80})));
  Modelica.Blocks.Sources.Constant const1[3](k={0,273.15,273.15})
    annotation (Placement(transformation(extent={{30,80},{50,100}})));
  Modelica.Blocks.Sources.Constant const2[3](k={2,273.15 + 60,273.15 + 60})
    annotation (Placement(transformation(extent={{-30,50},{-10,70}})));
  Annex60.Fluid.HeatExchangers.HeaterCooler_u hea(
    redeclare package Medium = Medium,
    dp_nominal=0,
    m_flow_nominal=bfData.m_flow_nominal,
    Q_flow_nominal=0)
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
  Modelica.Blocks.Sources.RealExpression Qflow(y=min(20000, max(-20000, (maxb[2].y
         - maxb[3].y)*4180*maxb[1].y)))
              annotation (Placement(transformation(extent={{-150,-74},{-96,-54}})));
  MultipleBoreHoles multipleBoreholes1(
    redeclare package Medium = Medium,
    T_start=273.15 + 19.5,
    bfData=bfData,
    lenSim=5*365*24*3600) "borefield"
    annotation (Placement(transformation(extent={{-20,-90},{20,-50}})));
equation
  connect(add.u1, combiTimeTable.y[1]) annotation (Line(
      points={{-32,86},{-36,86},{-36,90},{-39,90}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const.y, add.u2) annotation (Line(
      points={{-39,70},{-36,70},{-36,74},{-32,74}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add.y, gain.u) annotation (Line(
      points={{-9,80},{-2,80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(minb.y, maxb.u1) annotation (Line(
      points={{51,70},{58,70},{58,74}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(minb.u1, gain.y) annotation (Line(
      points={{28,76},{28,80},{21,80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(boundary.T_in, maxb[2].y) annotation (Line(
      points={{94,20},{96,20},{96,80},{81,80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const1.y, maxb.u2) annotation (Line(
      points={{51,90},{54,90},{54,86},{58,86}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const2.y, minb.u2) annotation (Line(
      points={{-9,60},{28,60},{28,64}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pum[1].port_a, boundary.ports[1]) annotation (Line(
      points={{-6,20},{34,20},{34,18.6667},{72,18.6667}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem[1].port_b, boundary.ports[2]) annotation (Line(
      points={{60,-20},{72,-20},{72,16}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(Qflow.y, hea.u) annotation (Line(
      points={{-93.3,-64},{-62,-64}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pum[1].m_flow_in, maxb[1].y) annotation (Line(
      points={{-15.8,32},{96,32},{96,80},{81,80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pum[2].m_flow_in, maxb[1].y) annotation (Line(
      points={{-15.8,32},{96,32},{96,80},{81,80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pum[1].port_b, multipleBoreholes.port_a) annotation (Line(
      points={{-26,20},{-80,20},{-80,-20},{-20,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(multipleBoreholes1.port_b, senTem[2].port_a) annotation (Line(
      points={{20,-70},{40,-70},{40,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(multipleBoreholes.port_b, senTem[1].port_a) annotation (Line(
      points={{20,-20},{40,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(hea.port_b, multipleBoreholes1.port_a) annotation (Line(
      points={{-40,-70},{-20,-70}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(hea.port_a, pum[2].port_b) annotation (Line(
      points={{-60,-70},{-80,-70},{-80,20},{-26,20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem[2].port_b, pum[2].port_a) annotation (Line(
      points={{60,-20},{60,20},{-6,20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boundary.ports[3], multipleBoreholes1.port_b) annotation (Line(
      points={{72,13.3333},{72,-62},{20,-62},{20,-70}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (experiment(
      StartTime=1.11231e+09,
      StopTime=1.25422e+09,
      __Dymola_Algorithm="Radau"),         __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>
This model serves as a validation for the bore field model. 
Measurement data from the GeoCool [1] project is used to validate the model.
 Measured inlet temperatures are used as model inputs and the return 
temperature can be compared with the measured return temperature.
</p>
<p>
Two versions exist: 
1) the measured temperatures are used directly as model inputs and 
2) the measured temperatures are used to calculate the thermal power 
demanded from the bore field and this thermal power is used as input. 
The second option is currently disabled because it leads to an error. 
It can be enabled by setting <code>Q_nominal = 1</code> in the heater.
</p>
<p>
[1] Ruiz-Calvo, F., &#38; Montagud, C. (2014). Reference data sets for validating GSHP system models and analyzing performance parameters based on a five-year operation period. <i>Geothermics</i>, <i>51</i>, 417&#8211;428.
</p>
</html>", revisions="<html>
<ul>
<li>
March 2015, by Filip Jorissen:<br>
First implementation.
</li>
</ul>
</html>"),
    __Dymola_Commands(file="modelica://Resources/Scripts/Dymola/Fluid/HeatExchangers/GroundHeatExchangers/Borefield/Validation/TrtValidation.mos"
        "Simulate and plot"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics));
end GeoCoolValidation;
