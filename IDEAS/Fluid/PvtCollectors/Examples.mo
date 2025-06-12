within IDEAS.Fluid.PvtCollectors;
package Examples "Examples demonstrating the use of models in the SolarCollectors package"
  extends Modelica.Icons.ExamplesPackage;










  model FlatPlate "Test model for FlatPlate"
    extends Modelica.Icons.Example;
    replaceable package Medium = Modelica.Media.Incompressible.Examples.Glycol47
      "Medium in the system";

    IDEAS.Fluid.SolarCollectors.ASHRAE93 solCol(
      redeclare package Medium = Medium,
      shaCoe=0,
      rho=0.2,
      nColType=IDEAS.Fluid.SolarCollectors.Types.NumberSelection.Number,
      sysConfig=IDEAS.Fluid.SolarCollectors.Types.SystemConfiguration.Array,
      nPanelsSer=5,
      nPanelsPar=5,
      per=IDEAS.Fluid.SolarCollectors.Data.GlazedFlatPlate.FP_GuangdongFSPTY95(),
      nPanels=25,
      nSeg=9,
      azi=0.3,
      til=0.5,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
      "Flat plate solar collector model"
      annotation (Placement(transformation(extent={{2,-10},{22,10}})));

    IDEAS.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
      Modelica.Utilities.Files.loadResource("modelica://IDEAS/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
      "Weather data input file"
      annotation (Placement(transformation(extent={{-28,60},{-8,80}})));
    IDEAS.Fluid.Sources.Boundary_pT sin(
      redeclare package Medium = Medium,
      p(displayUnit="bar") = 100000,
      nPorts=1) "Outlet for water flow"
      annotation (Placement(transformation(extent={{82,-10},{62,10}})));
    IDEAS.Fluid.Sensors.TemperatureTwoPort TOut(
      redeclare package Medium = Medium,
      T_start(displayUnit="K"),
      m_flow_nominal=solCol.m_flow_nominal) "Temperature sensor"
      annotation (Placement(transformation(extent={{32,-10},{52,10}})));
    IDEAS.Fluid.Sensors.TemperatureTwoPort TIn(redeclare package Medium =
      Medium, m_flow_nominal=solCol.m_flow_nominal) "Temperature sensor"
      annotation (Placement(transformation(extent={{-28,-10},{-8,10}})));
    Sources.Boundary_pT sou(
      redeclare package Medium = Medium,
      T=273.15 + 10,
      nPorts=1,
      use_p_in=true) "Inlet for water flow"
      annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-48,0})));
    Modelica.Blocks.Sources.Sine sine(
      f=3/86400,
      amplitude=-solCol.dp_nominal,
      offset=1E5) "Pressure source"
      annotation (Placement(transformation(extent={{-88,-18},{-68,2}})));
  equation
    connect(solCol.port_b, TOut.port_a) annotation (Line(
        points={{22,0},{32,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(sou.ports[1], TIn.port_a) annotation (Line(
        points={{-38,0},{-28,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(weaDat.weaBus, solCol.weaBus) annotation (Line(
        points={{-8,70},{2,70},{2,8}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(TIn.port_b, solCol.port_a)
      annotation (Line(points={{-8,0},{2,0}},               color={0,127,255}));
    connect(TOut.port_b, sin.ports[1])
      annotation (Line(points={{52,0},{62,0}},              color={0,127,255}));
    connect(sine.y, sou.p_in) annotation (Line(points={{-67,-8},{-60,-8}},
                             color={0,0,127}));
    annotation (
      Documentation(info="<html>
<p>
This example demonstrates the implementation of
<a href=\"modelica://IDEAS.Fluid.SolarCollectors.ASHRAE93\">
IDEAS.Fluid.SolarCollectors.ASHRAE93</a>
for a variable fluid flow rate and weather data from San Francisco, CA, USA.
</p>
</html>",
  revisions="<html>
<ul>
<li>
February 15, 2024, by Jelger Jansen:<br/>
Refactor model.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/3604\">Buildings, #3604</a>.
</li>
<li>
September 16, 2021, by Michael Wetter:<br/>
Removed parameter assignment for <code>lat</code>.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1477\">IBPSA, #1477</a>.
</li>
<li>
December 22, 2014 by Michael Wetter:<br/>
Removed <code>Modelica.Fluid.System</code>
to address issue
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/311\">#311</a>.
</li>
<li>
September 18, 2014, by Michael Wetter:<br/>
Changed medium from water to glycol.
</li>
<li>
Mar 27, 2013, by Peter Grant:<br/>
First implementation.
</li>
</ul>
</html>"),
  __Dymola_Commands(file="modelica://IDEAS/Resources/Scripts/Dymola/Fluid/SolarCollectors/Examples/FlatPlate.mos"
          "Simulate and plot"),
   experiment(Tolerance=1e-6, StopTime=86400.0));
  end FlatPlate;

  model FlatPlateShaCoeTrue "Test model for FlatPlate with use_shaCoe_in = true"
    extends Modelica.Icons.Example;
    replaceable package Medium = IDEAS.Media.Water "Medium in the system";
    IDEAS.Fluid.SolarCollectors.ASHRAE93          solCol(
      redeclare package Medium = Medium,
      shaCoe=0,
      from_dp=true,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      use_shaCoe_in=true,
      per=IDEAS.Fluid.SolarCollectors.Data.GlazedFlatPlate.FP_GuangdongFSPTY95(),
      rho=0.2,
      azi=0,
      nColType=IDEAS.Fluid.SolarCollectors.Types.NumberSelection.Number,
      nPanels=5,
      sysConfig=IDEAS.Fluid.SolarCollectors.Types.SystemConfiguration.Series,
      nSeg=9,
      til=0.5235987755983) "Flat plate solar collector with 3 segments"
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

    IDEAS.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
      Modelica.Utilities.Files.loadResource("modelica://IDEAS/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
      "Weather data input file"
      annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
    IDEAS.Fluid.Sources.Boundary_pT sin(
      redeclare package Medium = Medium,
      use_p_in=false,
      p(displayUnit="Pa") = 101325,
      nPorts=1) "Outlet for water flow"
      annotation (Placement(transformation(extent={{70,-10},{50,10}})));
    IDEAS.Fluid.Sensors.TemperatureTwoPort TOut(
      redeclare package Medium = Medium,
      T_start(displayUnit="K"),
      m_flow_nominal=solCol.m_flow_nominal) "Temperature sensor"
      annotation (Placement(transformation(extent={{20,-10},{40,10}})));
    IDEAS.Fluid.Sensors.TemperatureTwoPort TIn(redeclare package Medium =
      Medium, m_flow_nominal=solCol.m_flow_nominal) "Temperature sensor"
      annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
    IDEAS.Fluid.Sources.Boundary_pT sou(
      redeclare package Medium = Medium,
      use_p_in=false,
      nPorts=1,
      T=273.15 + 10,
      p(displayUnit="Pa") = 101325 + 5*solCol.per.dp_nominal)
      "Inlet for water flow"
      annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-60,0})));
    Modelica.Blocks.Sources.Ramp shaCoe(
      startTime=34040,
      height=1,
      duration=24193) "Varying shading coefficient"
      annotation (Placement(transformation(extent={{-58,30},{-38,50}})));
  equation
    connect(solCol.port_b, TOut.port_a) annotation (Line(
        points={{10,0},{20,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(TOut.port_b, sin.ports[1]) annotation (Line(
        points={{40,0},{50,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(TIn.port_b, solCol.port_a) annotation (Line(
        points={{-20,0},{-10,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(sou.ports[1], TIn.port_a) annotation (Line(
        points={{-50,0},{-50,0},{-40,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(shaCoe.y, solCol.shaCoe_in) annotation (Line(
        points={{-37,40},{-16,40},{-16,4},{-12,4},{-12,4}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(weaDat.weaBus, solCol.weaBus) annotation (Line(
        points={{-20,70},{-10,70},{-10,8}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    annotation (
      Documentation(info="<html>
<p>
This example demonstrates the use of <code>use_shaCoe_in</code>.
Aside from changed use of <code>use_shaCoe_in</code> it is identical to
<a href=\"modelica://IDEAS.Fluid.SolarCollectors.Examples.FlatPlate\">
IDEAS.Fluid.SolarCollectors.Examples.FlatPlate</a>.
</p>
</html>",
  revisions="<html>
<ul>
<li>
February 15, 2024, by Jelger Jansen:<br/>
Refactor model.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/3604\">Buildings, #3604</a>.
</li>
<li>
September 16, 2021, by Michael Wetter:<br/>
Removed parameter assignment for <code>lat</code>.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1477\">IBPSA, #1477</a>.
</li>
<li>
December 22, 2014 by Michael Wetter:<br/>
Removed <code>Modelica.Fluid.System</code>
to address issue
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/311\">#311</a>.
</li>
<li>
May 13, 2013, by Peter Grant:<br/>
First implementation.
</li>
</ul>
</html>"),
      __Dymola_Commands(file=
            "modelica://IDEAS/Resources/Scripts/Dymola/Fluid/SolarCollectors/Examples/FlatPlateShaCoeTrue.mos"
          "Simulate and plot"),
      experiment(Tolerance=1e-6, StopTime=86400.0));
  end FlatPlateShaCoeTrue;

  model FlatPlateTotalArea "Example showing the use of TotalArea and nSeg"
    extends Modelica.Icons.Example;
    replaceable package Medium = IDEAS.Media.Water "Medium in the system";

    IDEAS.Fluid.SolarCollectors.ASHRAE93          solCol(
      redeclare package Medium = Medium,
      shaCoe=0,
      from_dp=true,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      rho=0.2,
      sysConfig=IDEAS.Fluid.SolarCollectors.Types.SystemConfiguration.Series,
      per=IDEAS.Fluid.SolarCollectors.Data.GlazedFlatPlate.FP_SolahartKf(),
      nColType=IDEAS.Fluid.SolarCollectors.Types.NumberSelection.Number,
      nPanels=10,
      nSeg=9,
      azi=0.3,
      til=0.5) "Flat plate solar collector model"
      annotation (Placement(transformation(extent={{-10,20},{10,40}})));

    IDEAS.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
      Modelica.Utilities.Files.loadResource("modelica://IDEAS/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
      "Weather data input file"
      annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
    IDEAS.Fluid.Sources.Boundary_pT sin(
      redeclare package Medium = Medium,
      use_p_in=false,
      p(displayUnit="Pa") = 101325,
      nPorts=2) "Outlet for water flow"
      annotation (Placement(transformation(extent={{70,-10},{50,10}})));
    IDEAS.Fluid.Sensors.TemperatureTwoPort TOut(
      redeclare package Medium = Medium,
      T_start(displayUnit="K"),
      m_flow_nominal=solCol.m_flow_nominal) "Temperature sensor"
      annotation (Placement(transformation(extent={{20,20},{40,40}})));
    IDEAS.Fluid.Sensors.TemperatureTwoPort TIn(redeclare package Medium =
      Medium, m_flow_nominal=solCol.m_flow_nominal) "Temperature sensor"
      annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
    IDEAS.Fluid.Sources.Boundary_pT sou(
      redeclare package Medium = Medium,
      T=273.15 + 10,
      use_p_in=false,
      nPorts=2,
      p(displayUnit="Pa") = 101325 + solCol.dp_nominal) "Inlet for water flow"
      annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-60,0})));

    IDEAS.Fluid.SolarCollectors.ASHRAE93 solCol1(
      redeclare package Medium = Medium,
      shaCoe=0,
      from_dp=true,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      rho=0.2,
      sysConfig=IDEAS.Fluid.SolarCollectors.Types.SystemConfiguration.Series,
      per=IDEAS.Fluid.SolarCollectors.Data.GlazedFlatPlate.FP_SolahartKf(),
      nColType=IDEAS.Fluid.SolarCollectors.Types.NumberSelection.Number,
      nPanels=10,
      nSeg=27,
      azi=0.3,
      til=0.5) "Flat plate solar collector model"
      annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
    IDEAS.Fluid.Sensors.TemperatureTwoPort TOut1(
      redeclare package Medium = Medium,
      T_start(displayUnit="K"),
      m_flow_nominal=solCol.m_flow_nominal) "Temperature sensor"
      annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
    IDEAS.Fluid.Sensors.TemperatureTwoPort TIn1(
      redeclare package Medium =
      Medium, m_flow_nominal=solCol.m_flow_nominal) "Temperature sensor"
      annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  equation
    connect(solCol.port_b, TOut.port_a) annotation (Line(
        points={{10,30},{20,30}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(TOut.port_b, sin.ports[1]) annotation (Line(
        points={{40,30},{50,30},{50,-1}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(TIn.port_b, solCol.port_a) annotation (Line(
        points={{-20,30},{-10,30}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(sou.ports[1], TIn.port_a) annotation (Line(
        points={{-50,-1},{-50,30},{-40,30}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(weaDat.weaBus, solCol.weaBus) annotation (Line(
        points={{-40,70},{-14,70},{-14,38},{-10,38},{-10,38}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(solCol1.port_b, TOut1.port_a)
                                        annotation (Line(
        points={{10,-30},{20,-30}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(TIn1.port_b, solCol1.port_a)
                                       annotation (Line(
        points={{-20,-30},{-10,-30}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(weaDat.weaBus, solCol1.weaBus)
                                          annotation (Line(
        points={{-40,70},{-14,70},{-14,-22},{-10,-22}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(sou.ports[2], TIn1.port_a) annotation (Line(
        points={{-50,1},{-50,-30},{-40,-30}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(TOut1.port_b, sin.ports[2]) annotation (Line(
        points={{40,-30},{50,-30},{50,1}},
        color={0,127,255},
        smooth=Smooth.None));
    annotation (
      Documentation(info="<html>
<p>
This model uses <code>TotalArea</code> instead of <code>nPanels</code> to
define the system size.
Aside from that change, this model is identical to
<a href=\"modelica://IDEAS.Fluid.SolarCollectors.Examples.FlatPlate\">
IDEAS.Fluid.SolarCollectors.Examples.FlatPlate</a>.
</p>
</html>",
  revisions="<html>
<ul>
<li>
February 15, 2024, by Jelger Jansen:<br/>
Refactor model.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/3604\">Buildings, #3604</a>.
</li>
<li>
September 16, 2021, by Michael Wetter:<br/>
Removed parameter assignment for <code>lat</code>.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1477\">IBPSA, #1477</a>.
</li>
<li>
December 22, 2014 by Michael Wetter:<br/>
Removed <code>Modelica.Fluid.System</code>
to address issue
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/311\">#311</a>.
</li>
<li>
Mar 27, 2013, by Peter Grant:<br/>
First implementation.
</li>
</ul>
</html>"),
      __Dymola_Commands(file=
            "modelica://IDEAS/Resources/Scripts/Dymola/Fluid/SolarCollectors/Examples/FlatPlateTotalArea.mos"
          "Simulate and plot"),
      experiment(Tolerance=1e-6, StopTime=86400.0));
  end FlatPlateTotalArea;

  model FlatPlateWithTank
    "Example showing use of the flat plate solar collector in a complete solar thermal system"
    extends Modelica.Icons.Example;
    replaceable package Medium = IDEAS.Media.Water
      "Fluid in the storage tank";
    replaceable package Medium_2 = IDEAS.Media.Water "Fluid flowing through the collector";

    parameter Modelica.Units.SI.Angle azi=0.3
      "Surface azimuth (0 for south-facing; -90 degree for east-facing; +90 degree for west facing";
    parameter Modelica.Units.SI.Angle til=0.78539816339745
      "Surface tilt (0 for horizontally mounted collector)";
    parameter Real rho=0.2 "Ground reflectance";

    parameter Modelica.Units.SI.MassFlowRate m_flow_nominal = solCol.m_flow_nominal
      "Nominal mass flow rate";

    IDEAS.Fluid.SolarCollectors.ASHRAE93 solCol(
      redeclare package Medium = Medium_2,
      shaCoe=0,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      nColType=IDEAS.Fluid.SolarCollectors.Types.NumberSelection.Number,
      nPanels=5,
      sysConfig=IDEAS.Fluid.SolarCollectors.Types.SystemConfiguration.Series,
      per=IDEAS.Fluid.SolarCollectors.Data.GlazedFlatPlate.FP_SolahartKf(),
      nSeg=9,
      final azi=azi,
      final til=til,
      final rho=rho) "Flat plate solar collector model"
      annotation (Placement(transformation(extent={{-2,46},{18,66}})));

    IDEAS.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
      Modelica.Utilities.Files.loadResource("modelica://IDEAS/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"),
      computeWetBulbTemperature=false) "Weather data file reader"
      annotation (Placement(transformation(extent={{-180,60},{-160,80}})));
    IDEAS.Fluid.Sensors.TemperatureTwoPort TOut(
      T_start(displayUnit="K"),
      m_flow_nominal=m_flow_nominal,
      redeclare package Medium = Medium_2) "Temperature sensor"
      annotation (Placement(transformation(extent={{30,46},{50,66}})));
    IDEAS.Fluid.Sensors.TemperatureTwoPort TIn(m_flow_nominal=m_flow_nominal,
      redeclare package Medium = Medium_2) "Temperature sensor"
      annotation (Placement(transformation(extent={{-34,46},{-14,66}})));
    IDEAS.Fluid.Storage.StratifiedEnhancedInternalHex
     tan(
      nSeg=4,
      redeclare package Medium = Medium,
      hTan=1.8,
      m_flow_nominal=m_flow_nominal,
      VTan=1.5,
      dIns=0.07,
      redeclare package MediumHex = Medium_2,
      CHex=200,
      dExtHex=0.01905,
      hHex_a=0.9,
      hHex_b=0.65,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      Q_flow_nominal=3000,
      mHex_flow_nominal=3000/20/4200,
      T_start=293.15,
      TTan_nominal=293.15,
      THex_nominal=323.15,
      energyDynamicsHex=Modelica.Fluid.Types.Dynamics.FixedInitial)
      "Storage tank model"
      annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        origin={100,-20})));
    IDEAS.Fluid.SolarCollectors.Controls.CollectorPump pumCon(
      per=IDEAS.Fluid.SolarCollectors.Data.GlazedFlatPlate.FP_ThermaLiteHS20(),
      final azi=azi,
      final til=til,
      final rho=rho)
      "Pump controller"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-130,0})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature rooT(T=293.15)
      "Room temperature"
      annotation (Placement(transformation(extent={{20,-90},{40,-70}})));
    IDEAS.Fluid.Sources.Boundary_pT bou(redeclare package Medium =
      Medium, nPorts=1) "Outlet for hot water draw"
      annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={150,20})));
    IDEAS.Fluid.Sources.MassFlowSource_T bou1(
      redeclare package Medium = Medium,
      use_m_flow_in=false,
      nPorts=1,
      m_flow=0.001,
      T=288.15) "Inlet and flow rate for hot water draw"
      annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        origin={150,-20})));
    IDEAS.Fluid.Movers.FlowControlled_m_flow pum(
      redeclare package Medium = Medium_2,
      m_flow_nominal=m_flow_nominal,
      energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      nominalValuesDefineDefaultPressureCurve=true)
      "Pump forcing circulation through the system" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-50,0})));
    IDEAS.Fluid.Storage.ExpansionVessel exp(
      redeclare package Medium = Medium_2,
      V_start=0.1) "Expansion tank"
      annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={0,-20})));
    Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TTan
      "Temperature in the tank water that surrounds the heat exchanger"
      annotation (Placement(transformation(extent={{-80,20},{-100,40}})));

    Modelica.Blocks.Math.BooleanToReal booToRea(
      realTrue=m_flow_nominal)
      "Conversion of control signal to real-valued signal"
   annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  equation
    connect(solCol.port_b,TOut. port_a) annotation (Line(
        points={{18,56},{30,56}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(TIn.port_b,solCol. port_a) annotation (Line(
        points={{-14,56},{-2,56}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(weaDat.weaBus,solCol. weaBus) annotation (Line(
        points={{-160,70},{-2,70},{-2,64}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(weaDat.weaBus, pumCon.weaBus) annotation (Line(
        points={{-160,70},{-152,70},{-152,5},{-140,5}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(rooT.port, tan.heaPorTop)                  annotation (Line(
        points={{40,-80},{48,-80},{48,0},{104,0},{104,-5.2}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(rooT.port, tan.heaPorSid)                  annotation (Line(
        points={{40,-80},{111.2,-80},{111.2,-20}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(pum.port_b, TIn.port_a) annotation (Line(
        points={{-50,10},{-50,56},{-34,56}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(pum.port_a, exp.port_a) annotation (Line(
        points={{-50,-10},{-50,-36},{0,-36},{0,-30}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(exp.port_a, tan.portHex_b) annotation (Line(
        points={{0,-30},{0,-36},{80,-36}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(TOut.port_b, tan.portHex_a) annotation (Line(
        points={{50,56},{68,56},{68,-27.6},{80,-27.6}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(bou.ports[1], tan.port_a) annotation (Line(
        points={{140,20},{100,20},{100,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(bou1.ports[1], tan.port_b) annotation (Line(
        points={{140,-20},{120,-20},{120,-40},{100,-40}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(tan.heaPorVol[3], TTan.port) annotation (Line(
        points={{100,-19.85},{98,-19.85},{98,-20},{96,-20},{96,30},{-80,30}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(TTan.T, pumCon.TIn) annotation (Line(
        points={{-101,30},{-160,30},{-160,-4},{-142,-4}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(pumCon.on, booToRea.u)
      annotation (Line(points={{-118,0},{-102,0}}, color={255,0,255}));
    connect(pum.m_flow_in, booToRea.y) annotation (Line(points={{-62,7.77156e-16},
            {-70,7.77156e-16},{-70,0},{-78,0}}, color={0,0,127}));
      annotation(
     __Dymola_Commands(file="modelica://IDEAS/Resources/Scripts/Dymola/Fluid/SolarCollectors/Examples/FlatPlateWithTank.mos"
          "Simulate and plot"),
     experiment(Tolerance=1e-6, StopTime=86400.0),
          Documentation(info="<html>
<p>
This example shows how several different models can be combined to create
an entire solar water heating system.
The
<a href=\"modelica://IDEAS.Fluid.Storage.StratifiedEnhancedInternalHex\">
IDEAS.Fluid.Storage.StratifiedEnhancedInternalHex</a> (tan) model is
used to represent the tank filled with hot water.
A loop, powered by a pump
(<a href=\"modelica://IDEAS.Fluid.Movers.FlowControlled_m_flow\">
IDEAS.Fluid.Movers.FlowControlled_m_flow</a>, pum), 
passes the water through an expansion tank
(<a href=\"modelica://IDEAS.Fluid.Storage.ExpansionVessel\">
IDEAS.Fluid.Storage.ExpansionVessel</a>, exp),
a temperature sensor
(<a href=\"modelica://IDEAS.Fluid.Sensors.TemperatureTwoPort\">
IDEAS.Fluid.Sensors.TemperatureTwoPort</a>, TIn),
the solar collector
(<a href=\"modelica://IDEAS.Fluid.SolarCollectors.ASHRAE93\">
IDEAS.Fluid.SolarCollectors.ASHRAE93,</a> solCol),
and a second temperature sensor
(<a href=\"modelica://IDEAS.Fluid.Sensors.TemperatureTwoPort\">
IDEAS.Fluid.Sensors.TemperatureTwoPort</a>, TOut)
before re-entering the tank.
</p>
<p>
The solar collector is connected to the weather model
(<a href=\"modelica://IDEAS.BoundaryConditions.WeatherData.ReaderTMY3\">
IDEAS.BoundaryConditions.WeatherData.ReaderTMY3</a>, weaDat) which passes
information for the San Francisco, CA, USA climate.
This information is used to identify both the heat gain in the water 
from the sun and the heat loss to the ambient conditions.
</p>
<p>
The flow rate through the pump is controlled by a solar pump controller model
(<a href=\"modelica://IDEAS.Fluid.SolarCollectors.Controls.CollectorPump\">
IDEAS.Fluid.SolarCollectors.Controls.CollectorPump</a>, pumCon)
and a gain model.
The controller outputs a binary on (1) / off (0) signal.
The on/off signal is passed through a boolean to real signal converter 
to set the pump mass flow rate.
</p>
<p>
The heat ports for the tank are connected to an ambient temperature of 
20 degrees C representing the temperature of the room the tank is stored in.
</p>
<p>
bou1 (<a href=\"modelica://IDEAS.Fluid.Sources.MassFlowSource_T\">
IDEAS.Fluid.Sources.MassFlowSource_T)</a> provides a constant mass flow
rate for a hot water draw while bou
(<a href=\"modelica://IDEAS.Fluid.Sources.Boundary_pT\">
IDEAS.Fluid.Sources.Boundary_pT)</a> 
provides a boundary condition for the outlet of the draw.
</p>
</html>",
  revisions="<html>
<ul>
<li>
February 15, 2024, by Jelger Jansen:<br/>
Refactor model.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/3604\">Buildings, #3604</a>.
</li>
<li>
November 7, 2022, by Michael Wetter:<br/>
Revised example to provide values for new parameters and to integrate the revised solar pump controller.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/3074\">issue 3074</a>.
</li>
<li>
September 16, 2021, by Michael Wetter:<br/>
Removed parameter assignment for <code>lat</code>.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1477\">IBPSA, #1477</a>.
</li>
<li>
December 22, 2014 by Michael Wetter:<br/>
Removed <code>Modelica.Fluid.System</code>
to address issue
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/311\">#311</a>.
</li>
<li>
April 18, 2014, by Michael Wetter:<br/>
Updated model to use the revised tank and increased the tank height.
</li>
<li>
March 25, 2014, by Michael Wetter:<br/>
Updated model with new expansion vessel.
</li>
<li>
March 27, 2013 by Peter Grant:<br/>
First implementation
</li>
</ul>
</html>"),
      Diagram(coordinateSystem(extent={{-200,-100},{180,100}})),
      Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
  end FlatPlateWithTank;

  model Tubular "Example showing the use of Tubular"
    extends Modelica.Icons.Example;
    replaceable package Medium = IDEAS.Media.Water "Medium in the system";
    IDEAS.Fluid.SolarCollectors.ASHRAE93 solCol(
      redeclare package Medium = Medium,
      shaCoe=0,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      use_shaCoe_in=false,
      per=IDEAS.Fluid.SolarCollectors.Data.Tubular.T_AMKCollectraAGOWR20(),
      nPanels=10,
      sysConfig=IDEAS.Fluid.SolarCollectors.Types.SystemConfiguration.Parallel,
      nColType=IDEAS.Fluid.SolarCollectors.Types.NumberSelection.Number,
      rho=0.2,
      nSeg=9,
      azi=0.3,
      til=0.5) "Tubular solar collector model"
               annotation (Placement(transformation(extent={{10,-10},{30,10}})));

    IDEAS.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
      Modelica.Utilities.Files.loadResource("modelica://IDEAS/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
      "Weather data input file"
      annotation (Placement(transformation(extent={{-20,60},{0,80}})));
    IDEAS.Fluid.Sources.Boundary_pT sin(
      redeclare package Medium = Medium,
      use_p_in=false,
      p(displayUnit="Pa") = 101325,
      nPorts=1) "Inlet for fluid flow" annotation (Placement(transformation(extent={{90,-10},
              {70,10}})));
    IDEAS.Fluid.Sensors.TemperatureTwoPort TOut(
      redeclare package Medium = Medium,
      T_start(displayUnit="K"),
      m_flow_nominal=solCol.m_flow_nominal) "Temperature sensor"
      annotation (Placement(transformation(extent={{40,-10},{60,10}})));
    IDEAS.Fluid.Sensors.TemperatureTwoPort TIn(redeclare package Medium =
      Medium, m_flow_nominal=solCol.m_flow_nominal) "Temperature sensor"
      annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
    Modelica.Blocks.Sources.Sine sine(
      f=3/86400,
      offset=101325,
      amplitude=-0.1*solCol.dp_nominal)
      annotation (Placement(transformation(extent={{-80,-18},{-60,2}})));
    IDEAS.Fluid.Sources.Boundary_pT sou(
      redeclare package Medium = Medium,
      T=273.15 + 10,
      nPorts=1,
      use_p_in=true,
      p(displayUnit="Pa")) "Inlet for water flow"
      annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={-40,0})));
  equation
    connect(solCol.port_b,TOut. port_a) annotation (Line(
        points={{30,0},{40,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(TOut.port_b,sin. ports[1]) annotation (Line(
        points={{60,0},{70,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(TIn.port_b,solCol. port_a) annotation (Line(
        points={{0,0},{10,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(weaDat.weaBus, solCol.weaBus) annotation (Line(
        points={{0,70},{10,70},{10,8}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(sine.y, sou.p_in) annotation (Line(
        points={{-59,-8},{-52,-8}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(sou.ports[1], TIn.port_a) annotation (Line(
        points={{-30,0},{-20,0}},
        color={0,127,255},
        smooth=Smooth.None));
    annotation (__Dymola_Commands(file=
      "modelica://IDEAS/Resources/Scripts/Dymola/Fluid/SolarCollectors/Examples/Tubular.mos"
          "Simulate and plot"),
      experiment(Tolerance=1e-6, StopTime=86400.0),
      Documentation(info="<html>
<p>
  This example models a tubular solar thermal collector. It uses the
  <a href=\"modelica://IDEAS.Fluid.SolarCollectors.ASHRAE93\">
  IDEAS.Fluid.SolarCollectors.ASHRAE93</a> model and references
  data in the <a href=\"modelica://IDEAS.Fluid.SolarCollectors.Data.Tubular\">
  IDEAS.Fluid.SolarCollectors.Data.Tubular</a> package.
</p>
</html>",
  revisions="<html>
<ul>
<li>
February 15, 2024, by Jelger Jansen:<br/>
Refactor model.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/3604\">Buildings, #3604</a>.
</li>
<li>
December 11, 2023, by Michael Wetter:<br/>
Changed design flow rate. This is due to correction for the
implementation of the pressure drop calculation for the situation where collectors are in parallel,
e.g., if <code>sysConfig == IDEAS.Fluid.SolarCollectors.Types.SystemConfiguration.Parallel</code>.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/3597\">Buildings, #3597</a>.
</li>
<li>
September 16, 2021, by Michael Wetter:<br/>
Removed parameter assignment for <code>lat</code>.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1477\">IBPSA, #1477</a>.
</li>
<li>
December 22, 2014 by Michael Wetter:<br/>
Removed <code>Modelica.Fluid.System</code>
to address issue
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/311\">#311</a>.
</li>
<li>
March 27, 2013 by Peter Grant:<br/>
First implementation
</li>
</ul>
</html>"));
  end Tubular;
  annotation(Documentation(info="<html>
    <p>
      This package contains example model demonstrating the use of models in
      the SolarCollectors package.
    </p>
  </html>"));
end Examples;
