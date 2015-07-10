within IDEAS.Fluid.Production.Interfaces;
partial model PartialHeaterTwoPort
  "Partial heater interface for a twoport production system"
  extends IDEAS.Fluid.Interfaces.TwoPortHeatMassExchanger(
  redeclare final IDEAS.Fluid.MixingVolumes.MixingVolume vol(
    nPorts=3,
    V=mWater/rho_default),
  final showDesignFlowDirection=true);

  extends PartialHeater(
    hIn(y=inStream(port_a.h_outflow)),
    mFlowSecondary(y=port_a.m_flow),
    heatSource(
      final m_flow_nominal=m_flow_nominal,
      redeclare package Medium=Medium,
      final useTinPrimary=false,
      final useToutPrimary=false,
      final useMassFlowPrimary=false,
      final heatPumpWaterWater=false,
      useToutSecondary=true,
      use_modulation_security=use_modulation_security),
    qAsked(redeclare package Medium = Medium));

equation
  connect(vol.heatPort, thermalLosses.port_a) annotation (Line(
      points={{-9,-10},{-36,-10},{-36,-32}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
end PartialHeaterTwoPort;
