within IDEAS.Fluid.Production.Interfaces;
partial model PartialHeaterFourPort

  //Extensions
  extends IDEAS.Fluid.Interfaces.FourPortHeatMassExchanger(vol2(nPorts=2));
  extends IDEAS.Fluid.Production.Interfaces.PartialHeater(
    mFlowSecondary(y=port_a2.m_flow),
    hIn(y=inStream(port_a2.h_outflow)),
    qAsked(redeclare package Medium = Medium2, useQSet=false),
    heatSource(
      m_flow_nominal=m2_flow_nominal,
      UALossE=UALossE,
      heatPumpWaterWater=true,
      useTinPrimary=true,
      useToutSecondary=true));

  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalLossesE(G=UALossE)
                annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
       origin={-66,-42})));

  parameter Modelica.SIunits.Mass mBrine=5 "Mass of water in the Evaporator";
  final parameter Modelica.SIunits.ThermalConductance UALossE=(cDry + mBrine*
      Medium.specificHeatCapacityCp(Medium.setState_pTX(Medium.p_default, Medium.T_default,Medium.X_default)))/tauHeatLoss;
  Modelica.Blocks.Sources.RealExpression TinPrimary(y=Medium1.temperature_phX(
        Medium1.p_default,
        inStream(port_a1.h_outflow),
        Medium1.X_default))
    annotation (Placement(transformation(extent={{-94,38},{-74,58}})));
equation
  connect(heatPort, heatPort) annotation (Line(
      points={{0,-100},{0,-96},{0,-96},{0,-100}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heatSource.heatPortE, vol1.heatPort) annotation (Line(
      points={{-24,36},{-36,36},{-36,60},{-10,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(thermalLossesE.port_a, vol1.heatPort) annotation (Line(
      points={{-66,-32},{-66,60},{-10,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(TinPrimary.y, heatSource.TinPrimary) annotation (Line(
      points={{-73,48},{-6,48},{-6,42.2}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(thermalLosses.port_a, vol2.heatPort) annotation (Line(
      points={{-36,-32},{-36,-20},{16,-20},{16,-60},{12,-60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(thermalLossesE.port_b, heatPort) annotation (Line(
      points={{-66,-52},{-66,-76},{-36,-76},{-36,-100},{0,-100}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={Text(
          extent={{-32,72},{-12,66}},
          lineColor={0,0,0},
          textString="Evaporator"), Text(
          extent={{-8,-40},{12,-46}},
          lineColor={0,0,0},
          textString="Condensor")}),      Icon(coordinateSystem(
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
