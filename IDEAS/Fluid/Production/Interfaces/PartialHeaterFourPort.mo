within IDEAS.Fluid.Production.Interfaces;
partial model PartialHeaterFourPort

  //Extensions
  extends IDEAS.Fluid.Interfaces.FourPortHeatMassExchanger(vol2(nPorts=2));
  extends IDEAS.Fluid.Production.Interfaces.PartialHeater(
    m_flow_val(y=port_a2.m_flow),
    h_in_val(y=inStream(port_a2.h_outflow)),
    qAsked(redeclare package Medium = Medium2, useQSet=false),
    heatSource(
      m_flow_nominal=m2_flow_nominal,
      UALossE=UALossE,
      heatPumpWaterWater=true));

  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalLossesE(G=UALossE)
                annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
       origin={-40,-80})));

  parameter Modelica.SIunits.Mass mBrine=5 "Mass of water in the Evaporator";
  final parameter Modelica.SIunits.ThermalConductance UALossE=(cDry + mBrine*
      Medium.specificHeatCapacityCp(Medium.setState_pTX(Medium.p_default, Medium.T_default,Medium.X_default)))/tauHeatLoss;
  Modelica.Blocks.Sources.RealExpression h_in_val1(y=Medium1.temperature_phX(
        Medium1.p_default,
        inStream(port_a1.h_outflow),
        Medium1.X_default))
          annotation (Placement(transformation(extent={{50,36},{20,52}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor T_out
    annotation (Placement(transformation(extent={{-10,4},{-4,10}})));
equation
  connect(heatPort, heatPort) annotation (Line(
      points={{-30,-100},{-30,-96},{-30,-96},{-30,-100}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(thermalLossesE.port_b, heatPort) annotation (Line(
      points={{-40,-86},{-40,-86},{-40,-100},{-30,-100}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heatSource.heatPortE, vol1.heatPort) annotation (Line(
      points={{-10,28},{-20,28},{-20,60},{-10,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heatSource.heatPort, vol2.heatPort) annotation (Line(
      points={{-10,24},{-20,24},{-20,-40},{20,-40},{20,-60},{12,-60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(thermalLosses.port_a, vol2.heatPort) annotation (Line(
      points={{-20,-74},{20,-74},{20,-60},{12,-60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(thermalLossesE.port_a, vol1.heatPort) annotation (Line(
      points={{-40,-74},{-40,60},{-10,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(h_in_val1.y, heatSource.TinPrimary) annotation (Line(
      points={{18.5,44},{8,44},{8,34.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(T_out.port, vol2.heatPort) annotation (Line(
      points={{-10,7},{-16,7},{-16,6},{-20,6},{-20,-40},{20,-40},{20,-60},{12,-60}},
      color={191,0,0},
      smooth=Smooth.None));

  connect(T_out.T, heatSource.ToutSecondary) annotation (Line(
      points={{-4,7},{4,7},{4,8},{4,8},{4,13.8}},
      color={0,0,127},
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
          points={{-100,60},{-20,60},{-40,40},{-20,20},{-40,0},{-20,-20},{-40,
              -40}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{100,60},{20,60},{40,40},{20,20},{40,0},{20,-20},{40,-40}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-20,0},{0,0}},
          color={191,0,0},
          thickness=0.5),
        Polygon(
          points={{0,-10},{0,10},{20,0},{0,-10}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-40,-40},{-20,-60},{-92,-60}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{40,-40},{20,-60},{90,-60}},
          color={0,0,255},
          smooth=Smooth.None)}));
end PartialHeaterFourPort;
