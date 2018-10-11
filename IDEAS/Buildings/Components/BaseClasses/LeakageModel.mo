within IDEAS.Buildings.Components.BaseClasses;
model LeakageModel "Model for zone air leakage"
  replaceable package Medium = SolarwindBES.Media.Air constrainedby
    Modelica.Media.Interfaces.PartialMedium;

  parameter Modelica.SIunits.Area AFac(min=1) "Facade surface area for air leakage";

  IDEAS.Fluid.FixedResistances.PressureDrop res(
    redeclare package Medium = Medium,
    final from_dp=true,
    dp_nominal=1,
    deltaM=0.01,
    m_flow_nominal=AFac*sim.k_facade) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={30,0})));
  outer IDEAS.BoundaryConditions.SimInfoManager sim
    "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Fluid.Sources.Outside_CpLowRise out(
    redeclare package Medium = Medium,
    nPorts=1,
    use_C_in=Medium.nC == 1,
    azi=azi,
    s=1) "Boundary model"
                annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={10,30})));
  Modelica.Fluid.Interfaces.FluidPort_a port_lea(redeclare package Medium =
        Medium) "Port for air leakage towards surroundings"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  parameter SI.Angle azi "Surface azimuth (South:0, West:pi/2)";
protected
  IDEAS.Buildings.Components.Interfaces.WeaBus weaBus(numSolBus=sim.numIncAndAziInBus,
      outputAngles=sim.outputAngles)
    annotation (Placement(transformation(extent={{-50,82},{-30,102}})));

equation
  connect(out.C_in[1],weaBus. CEnv)
    annotation (Line(points={{18,42},{18,46},{62,46},{62,92},{10,92},{10,92.05},
          {-39.95,92.05}},                              color={0,0,127}));
  connect(sim.weaBus,weaBus)  annotation (Line(
      points={{-81,93},{-40,93},{-40,92}},
      color={255,204,51},
      thickness=0.5));
  connect(res.port_a,out. ports[1])
    annotation (Line(points={{20,0},{10,0},{10,20}}, color={0,127,255}));
  connect(res.port_b, port_lea)
    annotation (Line(points={{40,0},{100,0}}, color={0,127,255}));
  connect(out.weaBus, sim.weaDatBus) annotation (Line(
      points={{9.8,40},{10,40},{10,60},{-80.1,60},{-80.1,90}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end LeakageModel;
