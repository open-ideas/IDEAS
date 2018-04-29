within IDEAS.Buildings.Components.InterzonalAirFlow;
model PressureDrivenSimplified
  "Simplified pressure driven air inflitration model"
  extends BaseClasses.PartialInterzonalAirFlow(nPorts=2*nSurf);

  parameter Boolean setAbsolutePressure=false "=true, to set absolute pressure";
  Modelica.SIunits.Density rhoOut = sim.pAbs/287/sim.Te;
  Modelica.SIunits.Density rhoIn = sim.pAbs/287/sim.TZone;
  Modelica.SIunits.PressureDifference dpStack = (rhoOut-rhoIn)*hRel*9.81 "Pressure difference due to stack effect";

  Modelica.Blocks.Sources.RealExpression pAtmExp(y=sim.pAbs)
    "Expression for atmospheric pressure"
    annotation (Placement(transformation(extent={{-36,6},{-16,26}})));
  SolarwindBES.Fluid.Sources.Boundary_ph bouHvac(
    nPorts=2,
    use_p_in=true,
    redeclare package Medium = Medium,
    use_C_in=true,
    use_h_in=true,
    use_X_in=false)                    "Boundary pressure for HVAC equipment"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,30})));
  SolarwindBES.Fluid.Sources.PropertySource proSouHvacOut(
    redeclare package Medium = Medium,
    use_Xi_in=Medium.nXi > 0,
    use_h_in=false,
    use_C_in=false)         "Property source for setting outlet properties"
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-20,58})));
  SolarwindBES.Fluid.Sensors.MassFlowRate
                             senMasFloForOut(redeclare each package Medium =
        Medium) "Forced outlet flow rate" annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-20,86})));
  SolarwindBES.Fluid.Sensors.MassFlowRate
                             senMasFloForIn(redeclare each package Medium =
        Medium) "Forced inlet flow rate" annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=90,
        origin={20,80})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{-30,88},{-40,78}})));
  SolarwindBES.Fluid.Sources.PropertySource proSouInf[nSurf](
    redeclare each package Medium = Medium,
    each use_h_in=true,
    each use_Xi_in=Medium.nXi > 0,
    each use_C_in=Medium.nC > 0)
    "Property source for setting variables, vector to avoid mixing"
    annotation (Placement(transformation(extent={{-90,10},{-70,-10}})));
  SolarwindBES.Fluid.Sensors.MassFlowRate
                             senMasFloInf[nSurf](redeclare each package Medium =
        Medium) "Infiltration mass flow rate"
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-70,30})));
  SolarwindBES.Fluid.Sources.MassFlowSource_T mFloHvacBou(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    nPorts=1) "Boundary that injects net HVAC mass flow rate"
    annotation (Placement(transformation(extent={{-40,40},{-60,60}})));
  SolarwindBES.Fluid.Interfaces.IdealSource
                               ideSou(
    redeclare package Medium = Medium,
    control_m_flow=false,
    control_dp=true) "Ideal pressure difference source for stack effect"
                                                        annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-70,70})));
  Modelica.Blocks.Sources.RealExpression dpExpStack(y=dpStack)
    "Pressure difference expression for stack effect"
    annotation (Placement(transformation(extent={{-40,66},{-58,86}})));
  SolarwindBES.Fluid.Sources.Boundary_pT sin(
    redeclare package Medium = Medium,
    use_p_in=true,
    nPorts=1) annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=270,
        origin={-70,92})));
  Modelica.Blocks.Sources.RealExpression pBui(y=sim.portVent.T*unit)
    "Building internal pressure"
    annotation (Placement(transformation(extent={{-42,102},{-60,122}})));
  Modelica.Blocks.Sources.RealExpression mFloZonExp(y=sin.ports[1].m_flow)
    "Expression for total mass flow rate entering the zone due to HVAC and infiltration"
    annotation (Placement(transformation(
        extent={{-9,-10},{9,10}},
        rotation=90,
        origin={-87,50})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow mFloZon
    "Total mass flow rate entering the zone due to HVAC and infiltration"
    annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={-87,69})));
  SolarwindBES.Fluid.Sources.PropertySource proSouHvacIn(
    redeclare package Medium = Medium,
    use_Xi_in=Medium.nXi > 0,
    use_h_in=false,
    use_C_in=false)         "Property source for setting outlet properties"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={20,58})));
  Modelica.Blocks.Sources.RealExpression XZone[Medium.nXi](y=inStream(
        port_a_interior.Xi_outflow)) if
                                    Medium.nXi>0
    annotation (Placement(transformation(extent={{100,46},{80,66}})));
  Modelica.Blocks.Sources.RealExpression CZone[Medium.nC](y=inStream(
        port_a_interior.C_outflow)) if
                                    Medium.nC>0
    annotation (Placement(transformation(extent={{100,34},{80,54}})));
  Modelica.Blocks.Sources.RealExpression hZone(y=inStream(port_a_interior.h_outflow))
    "Specific enthalpy of zone"
    annotation (Placement(transformation(extent={{100,58},{80,78}})));
  Modelica.Blocks.Sources.RealExpression mZoneIn(y=port_a_exterior.m_flow)
    "Total incoming zone flow rates"
    annotation (Placement(transformation(extent={{30,-34},{50,-14}})));
  Modelica.Blocks.Sources.RealExpression XiZoneIn[Medium.nXi](y=inStream(
        port_a_exterior.Xi_outflow)) if
                                    Medium.nXi>0
    "Total incoming infiltration flow rate"
    annotation (Placement(transformation(extent={{30,-58},{50,-38}})));
  Modelica.Blocks.Sources.RealExpression hZoneIn(y=inStream(port_a_exterior.h_outflow))
    "Total incoming zone flow rates"
    annotation (Placement(transformation(extent={{30,-46},{50,-26}})));
  Modelica.Blocks.Sources.RealExpression CZoneIn[Medium.nC](y=inStream(
        port_a_exterior.C_outflow)) if
                                   Medium.nC>0
    "Total incoming infiltration flow rate"
    annotation (Placement(transformation(extent={{30,-70},{50,-50}})));
  Modelica.Blocks.Sources.RealExpression mZoneIn1[nSurf](y=portsInf.m_flow)
                         "Total incoming zone flow rates"
    annotation (Placement(transformation(extent={{-38,-14},{-18,6}})));
  Modelica.Blocks.Sources.RealExpression hZoneIn1[nSurf](y=inStream(portsInf.h_outflow))
    "Total incoming zone flow rates"
    annotation (Placement(transformation(extent={{-38,-26},{-18,-6}})));
  Modelica.Blocks.Sources.RealExpression XiZoneIn1[nSurf,Medium.nXi](y=inStream(
         portsInf.Xi_outflow)) if   Medium.nXi>0
    "Total incoming infiltration flow rate"
    annotation (Placement(transformation(extent={{-38,-38},{-18,-18}})));
  Modelica.Blocks.Sources.RealExpression CZoneIn1[nSurf,Medium.nC](y=inStream(
        portsInf.C_outflow)) if    Medium.nC>0
    "Total incoming infiltration flow rate"
    annotation (Placement(transformation(extent={{-38,-50},{-18,-30}})));
  Modelica.Blocks.Sources.RealExpression mZoneIn2[nSurf](y=portsItz.m_flow)
                            "Total incoming zone flow rates"
    annotation (Placement(transformation(extent={{-60,-14},{-40,6}})));
  Modelica.Blocks.Sources.RealExpression hZoneIn2[nSurf](y=inStream(portsItz.h_outflow))
    "Total incoming zone flow rates"
    annotation (Placement(transformation(extent={{-60,-26},{-40,-6}})));
  Modelica.Blocks.Sources.RealExpression XiZoneIn2[nSurf,Medium.nXi](y=inStream(
         portsItz.Xi_outflow)) if   Medium.nXi>0
    "Total incoming infiltration flow rate"
    annotation (Placement(transformation(extent={{-60,-38},{-40,-18}})));
  Modelica.Blocks.Sources.RealExpression CZoneIn2[nSurf,Medium.nC](y=inStream(
        portsItz.C_outflow)) if    Medium.nC>0
    "Total incoming infiltration flow rate"
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  SolarwindBES.Fluid.Sources.MassFlowSource_h bouSupZone(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    use_h_in=true,
    use_C_in=Medium.nC > 0,
    each use_X_in=false,
    each use_Xi_in=Medium.nX > 0,
    nPorts=1) "Boundary flow rate for zone" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,-70})));
  SolarwindBES.Fluid.Sources.MassFlowSource_h bouInfZone[nSurf](
    redeclare each package Medium = Medium,
    each use_m_flow_in=true,
    each use_h_in=true,
    each nPorts=1,
    each use_C_in=Medium.nC > 0,
    each use_X_in=false,
    each use_Xi_in=Medium.nX > 0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={10,-70})));
  SolarwindBES.Fluid.Sources.MassFlowSource_h bouItzZone[nSurf](
    redeclare each package Medium = Medium,
    each use_m_flow_in=true,
    each use_h_in=true,
    each nPorts=1,
    each use_C_in=Medium.nC > 0,
    each use_X_in=false,
    each use_Xi_in=Medium.nX > 0) "Boundary for interzonal air exchange"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,-70})));
  SolarwindBES.Fluid.Sources.Boundary_ph bouZone(
    nPorts=1,
    use_p_in=true,
    redeclare package Medium = Medium,
    use_C_in=true,
    use_h_in=true,
    use_X_in=false)
                   "Boundary pressure for zone" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-60,-70})));
  Modelica.Blocks.Sources.RealExpression mZoneIn3(y=sim.pAbs)
    "Total incoming zone flow rates"
    annotation (Placement(transformation(extent={{-110,-38},{-90,-18}})));
  Modelica.Blocks.Sources.RealExpression XiZoneIn3
                                                 [Medium.nXi](y=inStream(
        port_b_exterior.Xi_outflow)) if
                                    Medium.nXi>0
    "Total incoming infiltration flow rate"
    annotation (Placement(transformation(extent={{-110,-62},{-90,-42}})));
  Modelica.Blocks.Sources.RealExpression hZoneIn3(y=inStream(port_b_exterior.h_outflow))
    "Total incoming zone flow rates"
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
  Modelica.Blocks.Sources.RealExpression CZoneIn3
                                                [Medium.nC](y=inStream(
        port_b_exterior.C_outflow)) if
                                   Medium.nC>0
    "Total incoming infiltration flow rate"
    annotation (Placement(transformation(extent={{-110,-74},{-90,-54}})));
  Modelica.Blocks.Math.Sum sum1(nin=nSurf)
    annotation (Placement(transformation(extent={{-12,0},{0,12}})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{6,-14},{18,-2}})));
  SolarwindBES.Fluid.Sources.MassFlowSource_h
                                 boundary(
    redeclare package Medium = Medium,
    nPorts=nSurf,
    use_m_flow_in=true) if not setAbsolutePressure
    annotation (Placement(transformation(extent={{30,10},{50,-10}})));
  SolarwindBES.Fluid.Sources.PropertySource
                               proSou[nSurf](
    redeclare package Medium = Medium,
    each use_h_in=true,
    each use_C_in=Medium.nC > 0,
    each use_Xi_in=Medium.nXi > 0)
    "Property source for setting variables, vector to avoid mixing"
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Solarwind.Fluid.Sources.Boundary_pT bou4(
    nPorts=nSurf,
    redeclare package Medium = Medium) if setAbsolutePressure
                   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={52,28})));
protected
  parameter Real unit(unit="Pa/K")=1;
equation
  connect(bouHvac.ports[1], proSouHvacOut.port_a)
    annotation (Line(points={{-2,40},{-20,40},{-20,48}}, color={0,127,255}));
  connect(proSouHvacOut.port_b, senMasFloForOut.port_a)
    annotation (Line(points={{-20,68},{-20,80}}, color={0,127,255}));
  connect(add.u1,senMasFloForIn. m_flow) annotation (Line(points={{-29,80},{13.4,
          80}},            color={0,0,127}));
  connect(add.u2,senMasFloForOut. m_flow) annotation (Line(points={{-29,86},{-26.6,
          86}},                     color={0,0,127}));
  connect(senMasFloForOut.port_b, port_b_exterior)
    annotation (Line(points={{-20,92},{-20,100}}, color={0,127,255}));
  connect(senMasFloForIn.port_a, port_a_exterior)
    annotation (Line(points={{20,86},{20,100}}, color={0,127,255}));
  connect(pAtmExp.y, bouHvac.p_in)
    annotation (Line(points={{-15,16},{-8,16},{-8,18}},
                                                      color={0,0,127}));
  connect(proSouInf.port_b, senMasFloInf.port_a)
    annotation (Line(points={{-70,0},{-70,20}}, color={0,127,255}));
  for i in 1:nSurf loop
    if Medium.nC>0 then
      connect(proSouInf[i].C_in[1:Medium.nC], CZone.y[1:Medium.nC]) annotation (Line(points={{-76,-12},{-76,
            -14},{79,-14},{79,44}},
                             color={0,0,127},
        visible=false));
      connect(proSou[i].C_in, CZone.y)
    annotation (Line(points={{66,12},{66,44},{79,44}}, color={0,0,127}));
    end if;
    if Medium.nXi>0 then
      connect(proSou[i].Xi, XZone.y)
        annotation (Line(points={{70,12},{70,56},{79,56}}, color={0,0,127}));
      connect(proSouInf[i].Xi, XZone.y) annotation (Line(points={{-80,-12},{-58,-12},
            {-58,-16},{79,-16},{79,56}},
                                       color={0,0,127},
        visible=false));
    end if;
    connect(proSouInf[i].h, hZone.y) annotation (Line(points={{-84,-12},{-44,-12},
            {-44,-14},{79,-14},{79,68}},
                                       color={0,0,127},
        visible=false));

    connect(proSou[i].h, hZone.y)
    annotation (Line(points={{74,12},{74,68},{79,68}}, color={0,0,127}));

    connect(proSou[i].port_b,boundary. ports[i])
      annotation (Line(points={{60,0},{50,0}},     color={0,127,255}));
    connect(proSou[i].port_b,bou4. ports[i])
      annotation (Line(points={{60,0},{56,0},{56,18},{52,18}},
                                                   color={0,127,255}));
    connect(senMasFloInf[i].port_b,ideSou. port_a)
      annotation (Line(points={{-70,40},{-70,60}}, color={0,127,255}));
  end for;
  connect(mFloHvacBou.ports[1], ideSou.port_a)
    annotation (Line(points={{-60,50},{-70,50},{-70,60}}, color={0,127,255}));
  connect(add.y, mFloHvacBou.m_flow_in) annotation (Line(points={{-40.5,83},{-40,
          83},{-40,58},{-40,58}}, color={0,0,127}));
  connect(ideSou.port_b, sin.ports[1]) annotation (Line(points={{-70,80},{-68,80},
          {-68,84},{-70,84}}, color={0,127,255}));
  connect(proSouInf.port_a, portsInf)
    annotation (Line(points={{-90,0},{-100,0}}, color={0,127,255}));
  connect(dpExpStack.y, ideSou.dp_in)
    annotation (Line(points={{-58.9,76},{-62,76}}, color={0,0,127}));
  connect(pBui.y, sin.p_in) annotation (Line(points={{-60.9,112},{-63.6,112},{-63.6,
          101.6}}, color={0,0,127}));
  connect(mFloZonExp.y, mFloZon.Q_flow)
    annotation (Line(points={{-87,59.9},{-87,62}}, color={0,0,127}));
  connect(mFloZon.port, sim.portVent) annotation (Line(points={{-87,76},{-86,76},
          {-86,80},{-86.4,80}}, color={191,0,0}));
  connect(proSouHvacIn.port_a, senMasFloForIn.port_b)
    annotation (Line(points={{20,68},{20,74}}, color={0,127,255}));
  connect(proSouHvacIn.port_b, bouHvac.ports[2])
    annotation (Line(points={{20,48},{20,40},{2,40}}, color={0,127,255}));
  connect(XZone.y, proSouHvacIn.Xi) annotation (Line(points={{79,56},{34,56},{34,
          58},{8,58}}, color={0,0,127}));
  connect(XZone.y, proSouHvacOut.Xi) annotation (Line(points={{79,56},{26,56},{26,
          58},{-8,58}}, color={0,0,127}));

  connect(mZoneIn1.y, bouInfZone.m_flow_in)
    annotation (Line(points={{-17,-4},{18,-4},{18,-60}}, color={0,0,127}));
  connect(hZoneIn1.y, bouInfZone.h_in)
    annotation (Line(points={{-17,-16},{14,-16},{14,-58}}, color={0,0,127}));
  connect(XiZoneIn1.y, bouInfZone.Xi_in)
    annotation (Line(points={{-17,-28},{6,-28},{6,-58}}, color={0,0,127}));
  connect(CZoneIn1[:].y, bouInfZone.C_in[:]) annotation (Line(points={{-17,-40},
          {2,-40},{2,-60}},             color={0,0,127}));
  connect(mZoneIn2.y, bouItzZone.m_flow_in)
    annotation (Line(points={{-39,-4},{-2,-4},{-2,-60}}, color={0,0,127}));
  connect(hZoneIn2.y, bouItzZone.h_in)
    annotation (Line(points={{-39,-16},{-6,-16},{-6,-58}}, color={0,0,127}));
  connect(XiZoneIn2.y, bouItzZone.Xi_in)
    annotation (Line(points={{-39,-28},{-14,-28},{-14,-58}}, color={0,0,127}));
  connect(CZoneIn2[:].y, bouItzZone.C_in[:])
    annotation (Line(points={{-39,-40},{-18,-40},{-18,-60}}, color={0,0,127}));
  connect(XiZoneIn.y, bouSupZone.Xi_in)
    annotation (Line(points={{51,-48},{56,-48},{56,-58}}, color={0,0,127}));
  connect(hZoneIn.y, bouSupZone.h_in)
    annotation (Line(points={{51,-36},{64,-36},{64,-58}}, color={0,0,127}));
  connect(mZoneIn.y, bouSupZone.m_flow_in)
    annotation (Line(points={{51,-24},{68,-24},{68,-60}}, color={0,0,127}));
  connect(CZone.y, bouHvac.C_in) annotation (Line(points={{79,44},{40,44},{40,18},
          {8,18}}, color={0,0,127}));
  connect(bouHvac.h_in, hZone.y) annotation (Line(points={{-4,18},{-4,16},{40,16},
          {40,68},{79,68}}, color={0,0,127}));
  connect(port_b_interior, bouSupZone.ports[1])
    annotation (Line(points={{60,-100},{60,-80}}, color={0,127,255}));
  connect(port_a_interior, bouZone.ports[1])
    annotation (Line(points={{-60,-100},{-60,-80}}, color={0,127,255}));
  connect(CZoneIn3.y, bouZone.C_in) annotation (Line(points={{-89,-64},{-78,-64},
          {-78,-58},{-68,-58}}, color={0,0,127}));
  connect(XiZoneIn3.y, bouZone.X_in)
    annotation (Line(points={{-89,-52},{-64,-52},{-64,-58}}, color={0,0,127}));
  connect(hZoneIn3.y, bouZone.h_in)
    annotation (Line(points={{-89,-40},{-56,-40},{-56,-58}}, color={0,0,127}));
  connect(mZoneIn3.y, bouZone.p_in)
    annotation (Line(points={{-89,-28},{-52,-28},{-52,-58}}, color={0,0,127}));
  connect(bouInfZone[1:nSurf].ports[1],ports[1:nSurf])
    annotation (Line(points={{10,-80},{2,-80},{2,-100}},     color={0,0,127}));
  connect(bouItzZone[1:nSurf].ports[1],ports[(1+nSurf):(2*nSurf)])
    annotation (Line(points={{-10,-80},{2,-80},{2,-100}},    color={0,0,127}));
  connect(sum1.y,add1. u2) annotation (Line(points={{0.6,6},{2,6},{2,-11.6},{4.8,
          -11.6}},        color={0,0,127}));
  connect(add1.u1, add.y) annotation (Line(points={{4.8,-4.4},{4,-4.4},{4,83},{-40.5,
          83}},            color={0,0,127}));
  connect(add1.y,boundary. m_flow_in) annotation (Line(points={{18.6,-8},{30,-8}},
                          color={0,0,127}));
  connect(sum1.u, senMasFloInf.m_flow) annotation (Line(points={{-13.2,6},{-48,6},
          {-48,30},{-59,30}}, color={0,0,127}));

  connect(proSou.port_a, portsItz)
    annotation (Line(points={{80,0},{100,0}}, color={0,127,255}));
end PressureDrivenSimplified;
