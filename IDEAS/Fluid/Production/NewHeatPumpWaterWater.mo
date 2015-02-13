within IDEAS.Fluid.Production;
model NewHeatPumpWaterWater
  //Extensions
  extends Interfaces.PartialHeatPump(
    measurePower=true,
    redeclare Interfaces.HeatSources.HeatPumpWaterWater
     heatSource(
      useToutPrimary=false,
      useToutSecondary=false,
      useMassFlowSecondary=false));

  Sensors.TemperatureTwoPort senTem(redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-94,30},{-74,50}})));
  Sensors.TemperatureTwoPort senTem1(
                                    redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{40,-50},{20,-30}})));
  Interfaces.BaseClasses.QAsked qAsked(redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{74,-50},{54,-30}})));
equation
  PFuel = 0;
  PEl = 0;

  connect(port_a1, senTem.port_a) annotation (Line(
      points={{-100,40},{-94,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem1.port_b, massFlowRate.port_a) annotation (Line(
      points={{20,-40},{10,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(port_b1, evaporator.port_b) annotation (Line(
      points={{-100,-40},{-70,-40},{-70,-10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem.port_b, evaporator.port_a) annotation (Line(
      points={{-74,40},{-70,40},{-70,10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(condensor.port_b, port_b) annotation (Line(
      points={{-34,10},{-34,40},{100,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heatSource.TinPrimary, senTem1.T) annotation (Line(
      points={{8,11.8},{8,0},{30,0},{30,-29}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(senTem.T, heatSource.TinSecondary) annotation (Line(
      points={{-84,51},{-84,60},{8,60},{8,32.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qAsked.port_b, senTem1.port_a) annotation (Line(
      points={{54,-40},{40,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(qAsked.port_a, port_a) annotation (Line(
      points={{74,-40},{100,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(u, qAsked.u) annotation (Line(
      points={{20,-110},{20,-68},{84,-68},{84,-26},{66.1,-26},{66.1,-33.1}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qAsked.y, heatSource.QAsked) annotation (Line(
      points={{61.9,-33.1},{61.9,18},{10,18}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end NewHeatPumpWaterWater;
