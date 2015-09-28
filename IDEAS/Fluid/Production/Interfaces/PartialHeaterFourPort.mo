within IDEAS.Fluid.Production.Interfaces;
partial model PartialHeaterFourPort
  "Partial interface for a fourport production system"

  //Extensions
  extends IDEAS.Fluid.Interfaces.FourPortHeatMassExchanger(redeclare final
      IDEAS.Fluid.MixingVolumes.MixingVolume
                                           vol2(
      nPorts=2, V=m2/rho2_nominal),
    vol1(V=m1/rho1_nominal));
  extends IDEAS.Fluid.Production.Interfaces.PartialHeater(
    final UALoss2=(cDry2 + m2*
      Medium2.specificHeatCapacityCp(Medium2.setState_pTX(Medium2.p_default, Medium2.T_default,Medium2.X_default)))/tauHeatLoss2,
    m_flow2(y=port_a1.m_flow),
    hIn(y=inStream(port_a2.h_outflow)),
    qAsked(redeclare package Medium = Medium2, reversible=reversible),
    heatSource(
      UALoss2=UALoss1,
      heatPumpWaterWater=true,
      useTin1=true,
      useTout1=true,
      use_modulation_security=use_modulation_security,
      useTout2=true,
      m_flow_nominal=m2_flow_nominal),
    thermalLosses2(G=UALoss2));
  parameter Boolean reversible = false;
  parameter Modelica.SIunits.Time tauHeatLoss1=7200
    "Time constant of environmental heat losses";
  parameter Modelica.SIunits.Mass m1=5 "Mass of water in the secondary circuit";
  parameter Modelica.SIunits.HeatCapacity cDry1=4800
    "Capacity of dry material lumped to the secondary circuit";

  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalLosses1(G=UALoss1)
                annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
       origin={-66,-30})));
  final parameter Modelica.SIunits.ThermalConductance UALoss1=(cDry1 + m1*
      Medium1.specificHeatCapacityCp(Medium1.setState_pTX(Medium1.p_default, Medium1.T_default,Medium1.X_default)))/tauHeatLoss1;

  Modelica.SIunits.Temperature T1in;
  Modelica.Blocks.Sources.RealExpression T1inExpr(y=T1in)
    annotation (Placement(transformation(extent={{-32,40},{-12,60}})));
      Modelica.Blocks.Interfaces.BooleanInput rev if reversible
    "Reverse the heat pump"                                                         annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={60,108})));

equation
  T1in = IDEAS.Utilities.Math.Functions.spliceFunction(
              x=port_a1.m_flow,
              pos=Medium1.temperature(Medium1.setState_phX(port_a1.p, inStream(port_a1.h_outflow), inStream(port_a1.Xi_outflow))),
              neg=  Medium1.temperature(Medium1.setState_phX(port_b1.p, inStream(port_b1.h_outflow), inStream(port_b1.Xi_outflow))),
              deltax=  m1_flow_nominal/10);

  connect(heatPort, heatPort) annotation (Line(
      points={{0,-100},{0,-96},{0,-96},{0,-100}},
      color={191,0,0},
      smooth=Smooth.None));

  connect(thermalLosses2.port_b, heatPort) annotation (Line(
      points={{-36,-36},{-36,-76},{-36,-76},{-36,-100},{0,-100}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heatSource.heatPort1, vol1.heatPort) annotation (Line(
      points={{-24,28},{-66,28},{-66,60},{-10,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(vol2.heatPort, Tout2.port) annotation (Line(
      points={{12,-60},{16,-60},{16,-16},{-36,-16},{-36,32}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(thermalLosses1.port_a, vol1.heatPort) annotation (Line(
      points={{-66,-24},{-66,60},{-10,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(thermalLosses1.port_b, heatPort) annotation (Line(
      points={{-66,-36},{-66,-80},{-36,-80},{-36,-100},{0,-100}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(T1inExpr.y, heatSource.Tin1)
    annotation (Line(points={{-11,50},{-6,50},{-6,42.2}}, color={0,0,127}));
  connect(rev, qAsked.rev) annotation (Line(points={{60,108},{60,64},{25.8,64},{
          25.8,51.2}}, color={255,0,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={Text(
          extent={{-32,72},{-12,66}},
          lineColor={0,0,0},
          textString="Primary"),    Text(
          extent={{-8,-40},{12,-46}},
          lineColor={0,0,0},
          textString="Secondary")}),      Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Line(
          points={{0,38},{0,-34}},
          color={191,0,0},
          thickness=0.5),
        Polygon(
          points={{-10,-10},{-10,10},{10,0},{-10,-10}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid,
          origin={0,-36},
          rotation=270)}));
end PartialHeaterFourPort;
