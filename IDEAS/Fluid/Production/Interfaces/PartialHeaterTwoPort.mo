within IDEAS.Fluid.Production.Interfaces;
partial model PartialHeaterTwoPort
  "Partial heater interface for a twoport production system"

  extends IDEAS.Fluid.Interfaces.TwoPortHeatMassExchanger(
  redeclare final IDEAS.Fluid.MixingVolumes.MixingVolume vol(
    nPorts=2, V=m2/rho_default));

  extends PartialHeater(
    final UALoss2=(cDry2 + m2*
      Medium.specificHeatCapacityCp(Medium.setState_pTX(Medium.p_default, Medium.T_default,Medium.X_default)))/tauHeatLoss2,
    hIn(y=inStream(port_a.h_outflow)),
    m_flow2(y=port_a.m_flow),
    heatSource(
      final m_flow_nominal=m_flow_nominal,
      redeclare package Medium=Medium,
      final useTout1=false,
      final useMassFlow1=false,
      final heatPumpWaterWater=false,
      useTout2=true,
      use_modulation_security=use_modulation_security),
    qAsked(redeclare package Medium = Medium),
    thermalLosses2(G=UALoss2));

equation
  connect(vol.heatPort, Tout2.port) annotation (Line(
      points={{-9,-10},{-36,-10},{-36,32}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
end PartialHeaterTwoPort;
