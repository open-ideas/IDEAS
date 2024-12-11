within IDEAS.Airflow.Multizone.Validation;
model LargeHorizontalOpening
  "Model to verify the flow when a cavity is horizontal and a small pressure difference exists"
  extends Modelica.Icons.Example;
  package Medium = IDEAS.Media.Specialized.Air.PerfectGas;

  Orifice Opening_Orifice(
    redeclare package Medium = Medium,
    useDefaultProperties=false,
    dp_turbulent=Opening_CrackOrOperableDoor.dp_turbulent_ope,
    A=2,
    CD=0.78) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-118,-24})));

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
    A_q50=0,
    q50=0,
    useDoor=true,
    use_y=false,
    inc=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,-20})));
  Modelica.Blocks.Math.Sum MF_Doormodel(nin=2, k={3600,3600})
    annotation (Placement(transformation(extent={{4,14},{-16,34}})));
  Modelica.Blocks.Math.Sum MF_Orifice(nin=1, k={3600})
    annotation (Placement(transformation(extent={{-180,28},{-200,48}})));
  Modelica.Units.SI.MassFlowRate OpeningflowDiff=abs(MF_Doormodel.y)-abs(MF_Orifice.y);

protected
  Fluid.Sensors.MassFlowRate MFsensor_Orifice(
    redeclare package Medium = Medium) "Mass flow rate sensor" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-118,36})));

  Fluid.Sensors.MassFlowRate Ori_Mixingvol_MF2(
    redeclare package Medium = Medium) "Mass flow rate sensor" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,24})));
  Fluid.MixingVolumes.MixingVolume vol1(
    redeclare package Medium = Medium,
    massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=293.15,
    m_flow_nominal=1e-12,
    allowFlowReversal=true,
    V=15,
    nPorts=4) "Pressure boundary" annotation (Placement(transformation(extent={{-10,10},
            {10,-10}},
        rotation=0,
        origin={-18,-102})));
  Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = Medium,
    massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=293.15,
    m_flow_nominal=1e-12,
    allowFlowReversal=true,
    V=15,
    nPorts=4) "Pressure boundary" annotation (Placement(transformation(extent={{-10,-10},
            {10,10}},
        rotation=0,
        origin={-20,68})));
  MediumColumn col2(
    redeclare package Medium = Medium,
    h=1.5,
    densitySelection=IDEAS.Airflow.Multizone.Types.densitySelection.fromTop)
    annotation (Placement(transformation(extent={{-128,-4},{-108,16}})));
  MediumColumn col3(
    redeclare package Medium = Medium,
    h=1.5,
    densitySelection=IDEAS.Airflow.Multizone.Types.densitySelection.fromBottom)
    annotation (Placement(transformation(extent={{-128,-64},{-108,-44}})));

  Orifice ori2(
    redeclare package Medium = Medium,
    useDefaultProperties=false,
    A=0.5,
    CD=0.6) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={90,-148})));
  MediumColumn col4(
    redeclare package Medium = Medium,
    h=1.5,
    densitySelection=IDEAS.Airflow.Multizone.Types.densitySelection.fromBottom)
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  MediumColumn col5(
    redeclare package Medium = Medium,
    h=1.5,
    densitySelection=IDEAS.Airflow.Multizone.Types.densitySelection.fromTop)
    annotation (Placement(transformation(extent={{-4,-142},{16,-122}})));
  Orifice ori3(
    redeclare package Medium = Medium,
    useDefaultProperties=false,
    A=0.5,
    CD=0.6) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={50,116})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=293.15)
    annotation (Placement(transformation(extent={{-172,58},{-152,78}})));
  Fluid.Sensors.MassFlowRate Ori_Mixingvol_MF1(
    redeclare package Medium = Medium) "Mass flow rate sensor" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={72,24})));
  Fluid.Sources.Boundary_pT bouA1(
    redeclare package Medium = Medium,
    X={0,1},
    p(displayUnit="Pa") = 101325,
    T=278.15,
    nPorts=2) "Pressure boundary" annotation (Placement(transformation(extent={{10,10},
            {-10,-10}},
        rotation=0,
        origin={198,172})));
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

initial equation
  for i in 1:vol.nPorts loop
    vol.ports[i].Xi_outflow = {0};
  end for;
  for i in 1:vol1.nPorts loop
    vol1.ports[i].Xi_outflow = {0};
  end for;

equation

  connect(col3.port_b, vol1.ports[1]) annotation (Line(points={{-118,-64},{-118,
          -82},{-19.5,-82},{-19.5,-92}},
                           color={0,127,255}));
  connect(col2.port_a, MFsensor_Orifice.port_a) annotation (Line(points={{-118,16},
          {-118,26}},                     color={0,127,255}));
  connect(MFsensor_Orifice.port_b, vol.ports[1]) annotation (Line(points={{-118,46},
          {-118,50},{-21.5,50},{-21.5,58}},
                                    color={0,127,255}));
  connect(vol.ports[2], col4.port_b)
    annotation (Line(points={{-20.5,58},{-20.5,56},{-22,56},{-22,52},{-50,52},{-50,
          80}},                                           color={0,127,255}));
  connect(vol1.ports[2], col5.port_a) annotation (Line(points={{-18.5,-92},{-18.5,
          -90},{-16,-90},{-16,-82},{6,-82},{6,-122}},
                           color={0,127,255}));
  connect(col5.port_b, ori2.port_b) annotation (Line(points={{6,-142},{6,-148},{
          80,-148}},         color={0,127,255}));
  connect(col4.port_a, ori3.port_a) annotation (Line(points={{-50,100},{-50,116},
          {40,116}},  color={0,127,255}));
  connect(fixedTemperature.port, vol.heatPort)
    annotation (Line(points={{-152,68},{-30,68}},color={191,0,0}));
  connect(col11.port_a, bouA1.ports[1]) annotation (Line(points={{158,-52},{158,
          173},{188,173}},                     color={0,127,255}));
  connect(col12.port_a, bouA1.ports[2]) annotation (Line(points={{142,150},{142,
          171},{188,171}}, color={0,127,255}));
  connect(Opening_CrackOrOperableDoor.port_a2, Ori_Mixingvol_MF1.port_a)
    annotation (Line(points={{66,-10},{66,8},{72,8},{72,14}}, color={0,127,255}));
  connect(Opening_CrackOrOperableDoor.port_b1, Ori_Mixingvol_MF2.port_a)
    annotation (Line(points={{54,-10},{54,8},{40,8},{40,14}}, color={0,127,255}));
  connect(Ori_Mixingvol_MF2.m_flow, MF_Doormodel.u[1]) annotation (Line(points={{29,24},
          {18,24},{18,23.5},{6,23.5}},          color={0,0,127}));
  connect(Ori_Mixingvol_MF1.m_flow, MF_Doormodel.u[2]) annotation (Line(points={{61,24},
          {56,24},{56,40},{22,40},{22,24},{18,24},{18,24.5},{6,24.5}},
        color={0,0,127}));
  connect(MF_Orifice.u[1], MFsensor_Orifice.m_flow)
    annotation (Line(points={{-178,38},{-154,38},{-154,36},{-129,36}},
                                                   color={0,0,127}));
  connect(col3.port_a, Opening_Orifice.port_a) annotation (Line(points={{-118,-44},
          {-118,-34}},                       color={0,127,255}));
  connect(Opening_Orifice.port_b, col2.port_b) annotation (Line(points={{-118,-14},
          {-118,-4}},                    color={0,127,255}));
  connect(col12.port_b, ori3.port_b) annotation (Line(points={{142,122},{142,116},
          {60,116}},                                          color={0,127,255}));
  connect(col11.port_b, ori2.port_a) annotation (Line(points={{158,-80},{158,-148},
          {100,-148}},                          color={0,127,255}));
  connect(fixedTemperature.port, vol1.heatPort) annotation (Line(points={{-152,68},
          {-76,68},{-76,-102},{-28,-102}}, color={191,0,0}));
  connect(Opening_CrackOrOperableDoor.port_a1, vol1.ports[3]) annotation (Line(
        points={{54,-30},{54,-82},{-17.5,-82},{-17.5,-92}}, color={0,127,255}));
  connect(Opening_CrackOrOperableDoor.port_b2, vol1.ports[4]) annotation (Line(
        points={{66,-30},{66,-82},{-16.5,-82},{-16.5,-92}}, color={0,127,255}));
  connect(Ori_Mixingvol_MF2.port_b, vol.ports[3]) annotation (Line(points={{40,34},
          {40,52},{-19.5,52},{-19.5,58}}, color={0,127,255}));
  connect(Ori_Mixingvol_MF1.port_b, vol.ports[4]) annotation (Line(points={{72,34},
          {72,52},{-22,52},{-22,58},{-18.5,58}}, color={0,127,255}));
  annotation (Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-200,-160},{220,200}})),
    experiment(
      StopTime=300,
      Interval=10,
      Tolerance=1e-09,
      __Dymola_Algorithm="Cvode"),
      __Dymola_Commands(file="modelica://IDEAS/Resources/Scripts/Dymola/Airflow/Multizone/Validation/LargeHorizontalOpening.mos"
        "Simulate and Plot"),
    Documentation(revisions="<html>
<ul>
<li>
October 30, 2024, by Klaas De Jonge:<br/>
First implementation.
</li>
</ul>
</html>
", info="<html>
<p>Differences in assumptions for density calculations linked to stack-effect airflow (internally for door component, external via density columns for orifice) can result in different pressure differences over the opening (10e-3). However, for large horizontal openings this can result in important differences in volume flow results. This example shows how two similar openings with other underlying modelling assumptions lead to noticeable differences in massflowrate.</p>
</html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end LargeHorizontalOpening;
