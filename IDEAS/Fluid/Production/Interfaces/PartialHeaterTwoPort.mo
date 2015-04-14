within IDEAS.Fluid.Production.Interfaces;
partial model PartialHeaterTwoPort
  extends IDEAS.Fluid.Interfaces.TwoPortHeatMassExchanger(
  redeclare final IDEAS.Fluid.MixingVolumes.MixingVolume vol(nPorts=2, V=mWater
        /rho_default),
  final showDesignFlowDirection=true);

  extends PartialHeater(
    h_in_val(y=inStream(port_a.h_outflow)),
    m_flow_val(y=port_a.m_flow),
    heatSource(m_flow_nominal=m_flow_nominal, final heatPumpWaterWater=false,
      redeclare package Medium = Medium),
    qAsked(redeclare package Medium = Medium));

  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor T_out
    annotation (Placement(transformation(extent={{-10,4},{-4,10}})));
equation
  connect(vol.heatPort, thermalLosses.port_a) annotation (Line(
      points={{-9,-10},{-20,-10},{-20,-74}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heatSource.heatPort, vol.heatPort) annotation (Line(
      points={{-10,24},{-20,24},{-20,-10},{-9,-10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(T_out.port, vol.heatPort) annotation (Line(
      points={{-10,7},{-20,7},{-20,-10},{-9,-10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(T_out.T, heatSource.ToutSecondary) annotation (Line(
      points={{-4,7},{4,7},{4,13.8}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end PartialHeaterTwoPort;
