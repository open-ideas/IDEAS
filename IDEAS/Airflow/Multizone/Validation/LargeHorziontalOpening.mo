within IDEAS.Airflow.Multizone.Validation;
model LargeHorziontalOpening
  "Model to verify the flow when a cavity is horizontal and a small pressure difference exists"
  extends Modelica.Icons.Example;
  package Medium = IDEAS.Media.Specialized.Air.PerfectGas;

  Orifice Opening_Orifice(
    redeclare package Medium = Medium,
    useDefaultProperties=false,
    dp_turbulent=Opening_CrackOrOperableDoor.dp_turbulent_ope,
    A=2,
    CD=0.78) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-116,-18})));

   CrackOrOperableDoor Opening_CrackOrOperableDoor(
    redeclare package Medium = Medium,
    wOpe=1,
    hOpe=2,
    interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts,
    h_b1=0,
    h_b2=0,
    h_a1=0,
    h_a2=0,
    hA=-1.5,
    hB=1.5,
    A_q50=0.01,
    q50=0.01,
    useDoor=true,
    use_y=false,
    inc=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,-6})));
  Modelica.Blocks.Math.Sum MF_Doormodel(nin=2, k={3600,3600})
    annotation (Placement(transformation(extent={{14,30},{-6,50}})));
  Modelica.Blocks.Math.Sum MF_Orifice(nin=1, k={3600})
    annotation (Placement(transformation(extent={{-180,28},{-200,48}})));

protected
    Fluid.Sensors.MassFlowRate MFsensor_Orifice(redeclare package Medium =
        Medium)                                 "Mass flow rate sensor"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-116,38})));

   Fluid.Sensors.MassFlowRate Ori_Mixingvol_MF2(redeclare package Medium =
        Medium)                           "Mass flow rate sensor"
                            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,40})));
 Fluid.MixingVolumes.MixingVolume
                            vol1(
    redeclare package Medium = Medium,
    T_start=293.15,
    X_start={0,1},
    m_flow_nominal=1e-6,
    V=15,
    nPorts=2) "Pressure boundary" annotation (Placement(transformation(extent={{-10,10},
            {10,-10}},
        rotation=0,
        origin={-134,-76})));
  Fluid.MixingVolumes.MixingVolume
                            vol(
    redeclare package Medium = Medium,
    T_start=293.15,
    X_start={0,1},
    m_flow_nominal=1e-6,
    V=15,
    nPorts=2) "Pressure boundary" annotation (Placement(transformation(extent={{-10,-10},
            {10,10}},
        rotation=0,
        origin={-134,64})));
  MediumColumn col2(
    redeclare package Medium = Medium,
    h=1.5,
    densitySelection=IDEAS.Airflow.Multizone.Types.densitySelection.fromTop)
    annotation (Placement(transformation(extent={{-124,2},{-104,22}})));
  MediumColumn col3(
    redeclare package Medium = Medium,
    h=1.5,
    densitySelection=IDEAS.Airflow.Multizone.Types.densitySelection.fromBottom)
    annotation (Placement(transformation(extent={{-124,-58},{-104,-38}})));

  Orifice ori2(
    redeclare package Medium = Medium,
    useDefaultProperties=false,
    A=0.5,
    CD=0.6) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-152,-130})));
  MediumColumn col4(
    redeclare package Medium = Medium,
    h=1.5,
    densitySelection=IDEAS.Airflow.Multizone.Types.densitySelection.fromBottom)
    annotation (Placement(transformation(extent={{-124,74},{-104,94}})));
  MediumColumn col5(
    redeclare package Medium = Medium,
    h=1.5,
    densitySelection=IDEAS.Airflow.Multizone.Types.densitySelection.fromTop)
    annotation (Placement(transformation(extent={{-124,-124},{-104,-104}})));
  Orifice ori3(
    redeclare package Medium = Medium,
    useDefaultProperties=false,
    A=0.5,
    CD=0.6) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-80,100})));
  Fluid.Sources.Boundary_pT bouA4(
    redeclare package Medium = Medium,
    X={0,1},
    p(displayUnit="Pa") = 101325,
    T=278.15,
    nPorts=2) "Pressure boundary" annotation (Placement(transformation(extent={{10,10},
            {-10,-10}},
        rotation=0,
        origin={2,172})));
  Modelica.Thermal.HeatTransfer.Celsius.FixedTemperature fixedTemperature(T=20)
    annotation (Placement(transformation(extent={{-172,54},{-152,74}})));
  Modelica.Thermal.HeatTransfer.Celsius.FixedTemperature fixedTemperature1(T=20)
    annotation (Placement(transformation(extent={{-176,-86},{-156,-66}})));
  MediumColumn col6(
    redeclare package Medium = Medium,
    h=10,
    densitySelection=IDEAS.Airflow.Multizone.Types.densitySelection.fromTop)
    annotation (Placement(transformation(extent={{-40,-76},{-12,-48}})));
  MediumColumn col7(
    redeclare package Medium = Medium,
    h=4,
    densitySelection=IDEAS.Airflow.Multizone.Types.densitySelection.fromTop)
    annotation (Placement(transformation(extent={{-56,128},{-28,156}})));
  Fluid.MixingVolumes.MixingVolume
                            vol2(
    redeclare package Medium = Medium,
    T_start=293.15,
    X_start={0,1},
    m_flow_nominal=1e-6,
    V=15,
    nPorts=3) "Pressure boundary" annotation (Placement(transformation(extent={{-10,10},
            {10,-10}},
        rotation=0,
        origin={50,-66})));
  Fluid.MixingVolumes.MixingVolume
                            vol3(
    redeclare package Medium = Medium,
    T_start=293.15,
    X_start={0,1},
    m_flow_nominal=1e-6,
    V=15,
    nPorts=3) "Pressure boundary" annotation (Placement(transformation(extent={{-10,-10},
            {10,10}},
        rotation=0,
        origin={50,74})));
  Fluid.Sensors.MassFlowRate Ori_Mixingvol_MF1(redeclare package Medium =
        Medium)                           "Mass flow rate sensor"
                            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={82,40})));
  Orifice ori5(
    redeclare package Medium = Medium,
    useDefaultProperties=false,
    A=0.5,
    CD=0.6) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={32,-120})));
  MediumColumn col9(
    redeclare package Medium = Medium,
    h=1.5,
    densitySelection=IDEAS.Airflow.Multizone.Types.densitySelection.fromBottom)
    annotation (Placement(transformation(extent={{60,84},{80,104}})));
  MediumColumn col10(
    redeclare package Medium = Medium,
    h=1.5,
    densitySelection=IDEAS.Airflow.Multizone.Types.densitySelection.fromTop)
    annotation (Placement(transformation(extent={{60,-114},{80,-94}})));
  Orifice ori6(
    redeclare package Medium = Medium,
    useDefaultProperties=false,
    A=0.5,
    CD=0.6) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={104,110})));
  Fluid.Sources.Boundary_pT bouA1(
    redeclare package Medium = Medium,
    X={0,1},
    p(displayUnit="Pa") = 101325,
    T=278.15,
    nPorts=2) "Pressure boundary" annotation (Placement(transformation(extent={{10,10},
            {-10,-10}},
        rotation=0,
        origin={186,166})));
  Modelica.Thermal.HeatTransfer.Celsius.FixedTemperature fixedTemperature2(T=20)
    annotation (Placement(transformation(extent={{12,64},{32,84}})));
  Modelica.Thermal.HeatTransfer.Celsius.FixedTemperature fixedTemperature3(T=20)
    annotation (Placement(transformation(extent={{8,-76},{28,-56}})));
  MediumColumn col11(
    redeclare package Medium = Medium,
    h=10,
    densitySelection=IDEAS.Airflow.Multizone.Types.densitySelection.fromTop)
    annotation (Placement(transformation(extent={{144,-80},{172,-52}})));
  MediumColumn col12(
    redeclare package Medium = Medium,
    h=4,
    densitySelection=IDEAS.Airflow.Multizone.Types.densitySelection.fromTop)
    annotation (Placement(transformation(extent={{128,122},{156,150}})));


equation

  connect(col3.port_b, vol1.ports[1]) annotation (Line(points={{-114,-58},{-114,
          -66},{-135,-66}},color={0,127,255}));
  connect(Opening_Orifice.port_a, col2.port_b)
    annotation (Line(points={{-116,-8},{-116,2},{-114,2}}, color={0,127,255}));
  connect(col3.port_a, Opening_Orifice.port_b) annotation (Line(points={{-114,-38},
          {-114,-32},{-116,-32},{-116,-28}}, color={0,127,255}));
  connect(col2.port_a, MFsensor_Orifice.port_a) annotation (Line(points={{-114,22},
          {-114,26},{-116,26},{-116,28}}, color={0,127,255}));
  connect(MFsensor_Orifice.port_b, vol.ports[1]) annotation (Line(points={{-116,
          48},{-116,54},{-135,54}}, color={0,127,255}));
  connect(vol.ports[2], col4.port_b)
    annotation (Line(points={{-133,54},{-114,54},{-114,74}},
                                                          color={0,127,255}));
  connect(vol1.ports[2], col5.port_a) annotation (Line(points={{-133,-66},{-114,
          -66},{-114,-104}},
                           color={0,127,255}));
  connect(col5.port_b, ori2.port_b) annotation (Line(points={{-114,-124},{-114,-130},
          {-142,-130}},      color={0,127,255}));
  connect(col4.port_a, ori3.port_a) annotation (Line(points={{-114,94},{-114,100},
          {-90,100}}, color={0,127,255}));
  connect(fixedTemperature.port, vol.heatPort)
    annotation (Line(points={{-152,64},{-144,64}},
                                                 color={191,0,0}));
  connect(fixedTemperature1.port, vol1.heatPort)
    annotation (Line(points={{-156,-76},{-144,-76}},
                                                   color={191,0,0}));
  connect(col6.port_a, bouA4.ports[1]) annotation (Line(points={{-26,-48},{-26,122},
          {-12,122},{-12,173},{-8,173}},       color={0,127,255}));
  connect(col6.port_b, ori2.port_a) annotation (Line(points={{-26,-76},{-26,-146},
          {-168,-146},{-168,-130},{-162,-130}},    color={0,127,255}));
  connect(col7.port_a, bouA4.ports[2]) annotation (Line(points={{-42,156},{-42,171},
          {-8,171}},       color={0,127,255}));
  connect(col7.port_b, ori3.port_b) annotation (Line(points={{-42,128},{-42,100},
          {-70,100}}, color={0,127,255}));
  connect(Ori_Mixingvol_MF1.port_b, vol3.ports[1]) annotation (Line(points={{82,50},
          {82,62},{70,62},{70,64},{48.6667,64}},     color={0,127,255}));
  connect(vol3.ports[2], col9.port_b)
    annotation (Line(points={{50,64},{70,64},{70,84}}, color={0,127,255}));
  connect(vol2.ports[1], col10.port_a) annotation (Line(points={{48.6667,-56},{
          70,-56},{70,-94}},
                          color={0,127,255}));
  connect(col10.port_b, ori5.port_b) annotation (Line(points={{70,-114},{70,-120},
          {42,-120}}, color={0,127,255}));
  connect(col9.port_a,ori6. port_a) annotation (Line(points={{70,104},{70,110},{
          94,110}},   color={0,127,255}));
  connect(fixedTemperature2.port, vol3.heatPort)
    annotation (Line(points={{32,74},{40,74}}, color={191,0,0}));
  connect(fixedTemperature3.port,vol2. heatPort)
    annotation (Line(points={{28,-66},{40,-66}},   color={191,0,0}));
  connect(col11.port_a, bouA1.ports[1]) annotation (Line(points={{158,-52},{158,
          116},{166,116},{166,167},{176,167}}, color={0,127,255}));
  connect(col11.port_b, ori5.port_a) annotation (Line(points={{158,-80},{158,
          -146},{16,-146},{16,-120},{22,-120}},
                                          color={0,127,255}));
  connect(col12.port_a, bouA1.ports[2]) annotation (Line(points={{142,150},{142,
          165},{176,165}}, color={0,127,255}));
  connect(col12.port_b, ori6.port_b) annotation (Line(points={{142,122},{142,110},
          {114,110}}, color={0,127,255}));
  connect(Opening_CrackOrOperableDoor.port_a1, vol2.ports[2]) annotation (Line(
        points={{54,-16},{54,-50},{50,-50},{50,-56}}, color={0,127,255}));
  connect(Opening_CrackOrOperableDoor.port_b2, vol2.ports[3]) annotation (Line(
        points={{66,-16},{66,-50},{51.3333,-50},{51.3333,-56}}, color={0,127,255}));
  connect(Opening_CrackOrOperableDoor.port_a2, Ori_Mixingvol_MF1.port_a)
    annotation (Line(points={{66,4},{66,24},{82,24},{82,30}}, color={0,127,255}));
  connect(Opening_CrackOrOperableDoor.port_b1, Ori_Mixingvol_MF2.port_a)
    annotation (Line(points={{54,4},{54,24},{50,24},{50,30}}, color={0,127,255}));
  connect(Ori_Mixingvol_MF2.port_b, vol3.ports[3]) annotation (Line(points={{50,50},
          {51.3333,50},{51.3333,64}},     color={0,127,255}));
  connect(Ori_Mixingvol_MF2.m_flow, MF_Doormodel.u[1]) annotation (Line(points={
          {39,40},{28,40},{28,39.5},{16,39.5}}, color={0,0,127}));
  connect(Ori_Mixingvol_MF1.m_flow, MF_Doormodel.u[2]) annotation (Line(points={
          {71,40},{66,40},{66,56},{32,56},{32,40},{28,40},{28,40.5},{16,40.5}},
        color={0,0,127}));
  connect(MF_Orifice.u[1], MFsensor_Orifice.m_flow)
    annotation (Line(points={{-178,38},{-127,38}}, color={0,0,127}));
  annotation (Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-200,-160},{220,200}})),
    experiment(
      StopTime=300,
      Interval=10,
      Tolerance=1e-09,
      __Dymola_Algorithm="Cvode"),
      __Dymola_Commands(file="modelica://IDEAS/Resources/Scripts/Dymola/Airflow/Multizone/Validation/OneWayFlow.mos"
        "Simulate and plot"),
    Documentation(revisions="<html>
<ul>
<li>
October 30, 2024, by Klaas De Jonge:<br/>
First implementation.
</li>
</ul>
</html>
", info="<html>
<p>Model to test the airflow trough large non-horizontal openings.</p>
</html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end LargeHorziontalOpening;
