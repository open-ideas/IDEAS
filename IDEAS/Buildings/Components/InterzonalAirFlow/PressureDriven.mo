within IDEAS.Buildings.Components.InterzonalAirFlow;
model PressureDriven "Pressure driven air inflitration model"
  extends BaseClasses.PartialInterzonalAirFlow(nPorts=2*nSurf,defaultBoundary=false);

  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow mFloZon(
    alpha=1, Q_flow=1) if
                sim.computeInterzonalAirFlow
    "Dummy to avoid singularity"
    annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={-87,69})));
equation
  connect(port_b_exterior, port_a_interior) annotation (Line(points={{-20,100},{
          -20,-20},{-60,-20},{-60,-100}}, color={0,127,255}));
  connect(port_b_interior, port_a_exterior) annotation (Line(points={{60,-100},{
          60,-20},{20,-20},{20,100}}, color={0,127,255}));
  connect(portsInf[1:nSurf], ports[1:nSurf]) annotation (Line(points={{-100,-1.11022e-15},
          {-78,-1.11022e-15},{-78,0},{0,0},{0,-100}},
                        color={0,127,255}));
  connect(portsItz[1:nSurf], ports[(1+nSurf):2*nSurf]) annotation (Line(points={{100,-8.88178e-16},{0,-8.88178e-16},
          {0,-100}}, color={0,127,255}));
  connect(mFloZon.port, sim.portVent) annotation (Line(points={{-87,76},{-86,76},
          {-86,80},{-86.4,80}}, color={191,0,0}));
end PressureDriven;
