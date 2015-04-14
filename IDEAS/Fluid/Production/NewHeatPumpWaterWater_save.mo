within IDEAS.Fluid.Production;
model NewHeatPumpWaterWater_save
  //Extensions
  extends Interfaces.PartialHeatPump_save(
    measurePower=true,
    redeclare Interfaces.HeatSources.HeatPumpWaterWater
     heatSource(redeclare
        IDEAS.Fluid.Production.Interfaces.Data.VitoCal300GBWS301dotA08 data));

  Sensors.TemperatureTwoPort senTem(redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-90,50},{-70,70}})));
  Sensors.TemperatureTwoPort senTem1(
                                    redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{40,-50},{20,-30}})));
  Interfaces.BaseClasses.QAsked_save qAsked(redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{74,-50},{54,-30}})));
equation
  PFuel = 0;
  PEl = 0;

  connect(port_a1, senTem.port_a) annotation (Line(
      points={{-100,60},{-90,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem1.port_b, massFlowRate.port_a) annotation (Line(
      points={{20,-40},{10,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(port_b1, evaporator.port_b) annotation (Line(
      points={{-100,-60},{-70,-60},{-70,-10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem.port_b, evaporator.port_a) annotation (Line(
      points={{-70,60},{-70,10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(qAsked.port_b, senTem1.port_a) annotation (Line(
      points={{54,-40},{40,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(qAsked.port_a, port_a) annotation (Line(
      points={{74,-40},{88,-40},{88,-60},{100,-60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(u, qAsked.u) annotation (Line(
      points={{20,-110},{20,-68},{84,-68},{84,-26},{66.1,-26},{66.1,-33.1}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(senTem.T, heatSource.TinSecondary) annotation (Line(
      points={{-80,71},{-80,74},{8,74},{8,11.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(condensor.port_b, port_b) annotation (Line(
      points={{-34,10},{-34,60},{100,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem1.T, heatSource.TinPrimary) annotation (Line(
      points={{30,-29},{30,-6},{8,-6},{8,32.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qAsked.y, heatSource.QAsked) annotation (Line(
      points={{61.9,-33.1},{61.9,18},{10,18}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end NewHeatPumpWaterWater_save;
