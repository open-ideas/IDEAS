within IDEAS.Fluid.Production.Interfaces;
partial model PartialHeaterFourPort
  "Partial interface for a fourport production system"

  //Extensions
  extends IDEAS.Fluid.Interfaces.FourPortHeatMassExchanger(vol2(nPorts=2,
      V=m2/rho2_nominal), vol1(V=m1/rho1_nominal));
  extends IDEAS.Fluid.Production.Interfaces.PartialHeater(
    m_flow2(y=port_a2.m_flow),
    hIn(y=inStream(port_a2.h_outflow)),
    qAsked(redeclare package Medium = Medium2, useQSet=false),
    heatSource(
      UALoss2=UALoss1,
      heatPumpWaterWater=true,
      useTin1=true,
      useTout1=true,
      use_modulation_security=use_modulation_security,
      useTout2=true));

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
      Medium.specificHeatCapacityCp(Medium.setState_pTX(Medium.p_default, Medium.T_default,Medium.X_default)))/tauHeatLoss1;
  Modelica.Blocks.Sources.RealExpression Tin1(y=Medium1.temperature_phX(
        Medium1.p_default,
        inStream(port_a1.h_outflow),
        Medium1.X_default))
    annotation (Placement(transformation(extent={{-94,38},{-74,58}})));
equation
  connect(heatPort, heatPort) annotation (Line(
      points={{0,-100},{0,-96},{0,-96},{0,-100}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(thermalLosses2.port_a, vol1.heatPort) annotation (Line(
      points={{-36,-24},{-36,60},{-10,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Tin1.y, heatSource.Tin1) annotation (Line(
      points={{-73,48},{-6,48},{-6,42.2}},
      color={0,0,127},
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
