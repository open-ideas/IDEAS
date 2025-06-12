within IDEAS.Fluid.PvtCollectors;
package Validation "Collection of validation models"
  extends Modelica.Icons.ExamplesPackage;

  model EN12975NPanels
    "Validation model for collector according to EN12975 with different settings for nPanel"
    extends Modelica.Icons.Example;
    replaceable package Medium = IDEAS.Media.Water "Medium in the system";

    parameter Integer nPanels=10 "Number of panels";

    IDEAS.Fluid.SolarCollectors.EN12975 solCol(
      redeclare package Medium = Medium,
      per=datSolCol,
      shaCoe=0,
      azi=0,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      rho=0.2,
      nColType=IDEAS.Fluid.SolarCollectors.Types.NumberSelection.Number,
      nPanels=1,
      nSeg=30,
      til=0.78539816339745)
      "Flat plate solar collector model, has been modified for validation purposes"
      annotation (Placement(transformation(extent={{30,20},{50,40}})));

    IDEAS.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
          Modelica.Utilities.Files.loadResource("modelica://IDEAS/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"),
        computeWetBulbTemperature=false)
      "Weather data file reader"
      annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
    IDEAS.Fluid.Sources.Boundary_pT sou(
      redeclare package Medium = Medium,
      use_p_in=false,
      p(displayUnit="Pa") = 101325,
      nPorts=1) "Outlet for water flow"
      annotation (Placement(transformation(extent={{90,20},{70,40}})));
    IDEAS.Fluid.Sources.MassFlowSource_T bou(
      nPorts=1,
      redeclare package Medium = Medium,
      use_m_flow_in=true,
      use_T_in=false,
      T=303.15) "Inlet for water flow, at a prescribed flow rate and temperature"
      annotation (Placement(transformation(extent={{-10,20},{10,40}})));

    IDEAS.Fluid.SolarCollectors.EN12975 solCol1(
      redeclare package Medium = Medium,
      per=datSolCol,
      shaCoe=0,
      azi=0,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      rho=0.2,
      nColType=IDEAS.Fluid.SolarCollectors.Types.NumberSelection.Number,
      nSeg=30,
      til=0.78539816339745,
      nPanels=nPanels)
      "Flat plate solar collector model, has been modified for validation purposes"
      annotation (Placement(transformation(extent={{30,-40},{50,-20}})));
    IDEAS.Fluid.Sources.Boundary_pT sou1(
      redeclare package Medium = Medium,
      use_p_in=false,
      p(displayUnit="Pa") = 101325,
      nPorts=1) "Outlet for water flow"
      annotation (Placement(transformation(extent={{90,-40},{70,-20}})));
    IDEAS.Fluid.Sources.MassFlowSource_T bou1(
      nPorts=1,
      redeclare package Medium = Medium,
      use_m_flow_in=true,
      use_T_in=false,
      T=303.15) "Inlet for water flow, at a prescribed flow rate and temperature"
      annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
    Modelica.Blocks.Math.Gain gaiNPan(k=nPanels) "Gain for number of panels"
      annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
    Modelica.Blocks.Sources.RealExpression difHeaGai(y=solCol.QGai[30].Q_flow -
          solCol1.QGai[30].Q_flow/nPanels)
      "Difference in heat gain at last panel between model with 1 and with 30 panels"
      annotation (Placement(transformation(extent={{-70,-70},{-50,-50}})));
    Modelica.Blocks.Sources.RealExpression difHeaLos(y=solCol.QLos[30].Q_flow -
          solCol1.QLos[30].Q_flow/nPanels)
      "Difference in heat loss at last panel between model with 1 and with 30 panels"
      annotation (Placement(transformation(extent={{-70,-90},{-50,-70}})));
    Modelica.Blocks.Sources.Constant m_flow_nominal(k=datSolCol.A*datSolCol.mperA_flow_nominal)
      "Nominal flow rate for one panel"
      annotation (Placement(transformation(extent={{-90,30},{-70,50}})));
    parameter Data.GlazedFlatPlate.FP_VerificationModel datSolCol
      annotation (Placement(transformation(extent={{60,60},{80,80}})));
  equation
    connect(weaDat.weaBus, solCol1.weaBus) annotation (Line(
        points={{-20,70},{20,70},{20,-22},{30,-22}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(bou1.ports[1], solCol1.port_a) annotation (Line(
        points={{10,-30},{30,-30}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(sou1.ports[1], solCol1.port_b) annotation (Line(
        points={{70,-30},{50,-30}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(gaiNPan.y, bou1.m_flow_in)
      annotation (Line(points={{-29,-20},{-20,-20},{-20,-22},{-12,-22}},
                                                     color={0,0,127}));
    connect(solCol.port_a, bou.ports[1])
      annotation (Line(points={{30,30},{10,30}},color={0,127,255}));
    connect(solCol.port_b, sou.ports[1])
      annotation (Line(points={{50,30},{70,30}}, color={0,127,255}));
    connect(solCol.weaBus, weaDat.weaBus) annotation (Line(
        points={{30,38},{20,38},{20,70},{-20,70}},
        color={255,204,51},
        thickness=0.5));
    connect(m_flow_nominal.y, bou.m_flow_in) annotation (Line(points={{-69,40},{
            -20,40},{-20,38},{-12,38}},
                                    color={0,0,127}));
    connect(gaiNPan.u, m_flow_nominal.y) annotation (Line(points={{-52,-20},{-60,
            -20},{-60,40},{-69,40}}, color={0,0,127}));
    annotation (
      Documentation(info="<html>
<p>
This model validates the solar collector model
<a href=\"modelica://IDEAS.Fluid.SolarCollectors.EN12975\">
IDEAS.Fluid.SolarCollectors.EN12975</a>
for the case
where the number of panels is <i>1</i> for the instance <code>solCol</code>
and <i>10</i> for the instance <code>solCol1</code>.
The instances <code>difHeaGai</code> and <code>difHeaLos</code>
compare the heat gain and heat loss between the two models.
The output of these blocks should be zero, except for rounding errors.
</p>
</html>",   revisions="<html>
<ul>
<li>
September 16, 2021, by Michael Wetter:<br/>
Removed parameter assignment for <code>lat</code>.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1477\">IBPSA, #1477</a>.
</li>
<li>
November 21, 2017, by Michael Wetter:<br/>
First implementation to validate
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/1073\">#1073</a>.
</li>
</ul>
</html>"),
      __Dymola_Commands(file=
            "modelica://IDEAS/Resources/Scripts/Dymola/Fluid/SolarCollectors/Validation/EN12975NPanels.mos"
          "Simulate and plot"),
      experiment(Tolerance=1e-6, StopTime=86400));
  end EN12975NPanels;

  model EN12975_Array
    "Validation model for collector according to EN12975 in array configuration"
    extends Modelica.Icons.Example;
    replaceable package Medium = IDEAS.Media.Water "Medium in the system";

    parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=solCol.per.A*
        solCol.per.mperA_flow_nominal "Nominal mass flow rate";

    model Collector
      extends IDEAS.Fluid.SolarCollectors.EN12975(
      redeclare final package Medium = IDEAS.Media.Water,
      final show_T = true,
      final per=IDEAS.Fluid.SolarCollectors.Data.GlazedFlatPlate.FP_VerificationModel(),
      final shaCoe=0,
      final azi=0,
      final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      final rho=0.2,
      final nColType=IDEAS.Fluid.SolarCollectors.Types.NumberSelection.Number,
      nPanels=1,
      final til=0.78539816339745,
      final use_shaCoe_in=false,
      sysConfig=IDEAS.Fluid.SolarCollectors.Types.SystemConfiguration.Series);

    end Collector;

    Collector solCol(
      nPanels=4,
      nSeg=3,
      sysConfig=IDEAS.Fluid.SolarCollectors.Types.SystemConfiguration.Array,
      nPanelsSer=2,
      nPanelsPar=2)
      "Flat plate solar collector model, has been modified for validation purposes"
      annotation (Placement(transformation(extent={{-20,20},{0,40}})));

    Collector solCol1(nSeg=3, nPanels=2)
      "Flat plate solar collector model, has been modified for validation purposes"
      annotation (Placement(transformation(extent={{-50,-40},{-30,-20}})));

    Collector solCol2(nSeg=3, nPanels=2)
      "Flat plate solar collector model, has been modified for validation purposes"
      annotation (Placement(transformation(extent={{-50,-80},{-30,-60}})));

    IDEAS.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
          Modelica.Utilities.Files.loadResource("modelica://IDEAS/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"),
        computeWetBulbTemperature=false)
      "Weather data file reader"
      annotation (Placement(transformation(extent={{-88,60},{-68,80}})));
    IDEAS.Fluid.Sources.Boundary_pT sou(
      redeclare package Medium = Medium,
      use_p_in=false,
      p(displayUnit="Pa") = 101325,
      nPorts=1) "Outlet for water flow"
      annotation (Placement(transformation(extent={{80,20},{60,40}})));
    IDEAS.Fluid.Sources.MassFlowSource_T bou(
      nPorts=1,
      redeclare package Medium = Medium,
      use_T_in=false,
      m_flow=m_flow_nominal,
      T=303.15) "Inlet for water flow, at a prescribed flow rate and temperature"
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));

    IDEAS.Fluid.Sources.Boundary_pT sou1(
      redeclare package Medium = Medium,
      use_p_in=false,
      p(displayUnit="Pa") = 101325,
      nPorts=1) "Outlet for water flow"
      annotation (Placement(transformation(extent={{80,-40},{60,-20}})));
    IDEAS.Fluid.Sources.MassFlowSource_T bou1(
      nPorts=1,
      redeclare package Medium = Medium,
      use_T_in=false,
      m_flow=m_flow_nominal/2,
      T=303.15) "Inlet for water flow, at a prescribed flow rate and temperature"
      annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));

    Sensors.TemperatureTwoPort senTem(
       redeclare package Medium = Medium,
       tau=0,
       m_flow_nominal=m_flow_nominal)
      "Temperature sensor"
      annotation (Placement(transformation(extent={{20,40},{40,20}})));
    Sensors.TemperatureTwoPort senTem1(
      redeclare package Medium = Medium,
      tau=0,
      m_flow_nominal=m_flow_nominal)
      "Temperature sensor"
      annotation (Placement(transformation(extent={{20,-20},{40,-40}})));
    Modelica.Blocks.Math.Add dT(final k2=-1) "Temperature difference (must be zero)"
      annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
    Sources.MassFlowSource_T                 bou2(
      nPorts=1,
      redeclare package Medium = Medium,
      use_T_in=false,
      m_flow=m_flow_nominal/2,
      T=303.15) "Inlet for water flow, at a prescribed flow rate and temperature"
      annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  equation
    connect(weaDat.weaBus, solCol1.weaBus) annotation (Line(
        points={{-68,70},{-50,70},{-50,-22}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(bou1.ports[1], solCol1.port_a) annotation (Line(
        points={{-60,-30},{-50,-30}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(solCol.port_a, bou.ports[1]) annotation (Line(points={{-20,30},{-60,30}},
                             color={0,127,255}));
    connect(solCol.weaBus, weaDat.weaBus) annotation (Line(
        points={{-20,38},{-24,38},{-24,70},{-68,70}},
        color={255,204,51},
        thickness=0.5));
    connect(weaDat.weaBus, solCol2.weaBus) annotation (Line(
        points={{-68,70},{-50,70},{-50,-62}},
        color={255,204,51},
        thickness=0.5));
    connect(solCol.port_b, senTem.port_a)
      annotation (Line(points={{0,30},{20,30}}, color={0,127,255}));
    connect(senTem.port_b, sou.ports[1])
      annotation (Line(points={{40,30},{60,30}}, color={0,127,255}));
    connect(sou1.ports[1], senTem1.port_b)
      annotation (Line(points={{60,-30},{40,-30}}, color={0,127,255}));
    connect(dT.u1, senTem.T) annotation (Line(points={{58,-64},{50,-64},{50,0},{30,
            0},{30,19}},  color={0,0,127}));
    connect(senTem1.T, dT.u2) annotation (Line(points={{30,-41},{30,-76},{58,-76}},
                                         color={0,0,127}));
    connect(bou2.ports[1], solCol2.port_a)
      annotation (Line(points={{-60,-70},{-50,-70}}, color={0,127,255}));
    connect(solCol1.port_b, senTem1.port_a)
      annotation (Line(points={{-30,-30},{20,-30}}, color={0,127,255}));
    connect(solCol2.port_b, senTem1.port_a) annotation (Line(points={{-30,-70},{-20,
            -70},{-20,-30},{20,-30}}, color={0,127,255}));
    annotation (
      Documentation(info="<html>
<p>
This model validates the solar collector model
<a href=\"modelica://IDEAS.Fluid.SolarCollectors.EN12975\">
IDEAS.Fluid.SolarCollectors.EN12975</a>
for the case where one model has multiple panels in a 2x2 array,
versus the case where two models are in parallel,
each having two panels in series.
The output of the block <code>dT</code> must be zero,
as both cases must have the same outlet temperatures.
Furthermore, the pressure drops over all models should be the same.
</p>
</html>",   revisions="<html>
<ul>
<li>
February 27, 2024, by Jelger Jansen:<br/>
First implementation.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/3604\">Buildings, #3604</a>.
</li>
</ul>
</html>"),
      __Dymola_Commands(file=
            "modelica://IDEAS/Resources/Scripts/Dymola/Fluid/SolarCollectors/Validation/EN12975_Array.mos"
          "Simulate and plot"),
      experiment(Tolerance=1e-6, StopTime=86400));
  end EN12975_Array;

  model EN12975_Series
    "Validation model for collector according to EN12975 with different panels in series"
    extends Modelica.Icons.Example;
    replaceable package Medium = IDEAS.Media.Water "Medium in the system";

    parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=solCol.per.A*
        solCol.per.mperA_flow_nominal "Nominal mass flow rate";

    model Collector
      extends IDEAS.Fluid.SolarCollectors.EN12975(
      redeclare final package Medium = IDEAS.Media.Water,
      final show_T = true,
      final per=IDEAS.Fluid.SolarCollectors.Data.GlazedFlatPlate.FP_VerificationModel(),
      final shaCoe=0,
      final azi=0,
      final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      final rho=0.2,
      final nColType=IDEAS.Fluid.SolarCollectors.Types.NumberSelection.Number,
      nPanels=1,
      final til=0.78539816339745,
      final use_shaCoe_in=false,
      final sysConfig=IDEAS.Fluid.SolarCollectors.Types.SystemConfiguration.Series);

    end Collector;

    Collector solCol(nPanels=2, nSeg=6)
      "Flat plate solar collector model, has been modified for validation purposes"
      annotation (Placement(transformation(extent={{-20,20},{0,40}})));

    Collector solCol1(nSeg=3, nPanels=1)
      "Flat plate solar collector model, has been modified for validation purposes"
      annotation (Placement(transformation(extent={{-50,-40},{-30,-20}})));

    Collector solCol2(nSeg=3, nPanels=1)
      "Flat plate solar collector model, has been modified for validation purposes"
      annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));

    IDEAS.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
          Modelica.Utilities.Files.loadResource("modelica://IDEAS/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"),
        computeWetBulbTemperature=false)
      "Weather data file reader"
      annotation (Placement(transformation(extent={{-88,60},{-68,80}})));
    IDEAS.Fluid.Sources.Boundary_pT sou(
      redeclare package Medium = Medium,
      use_p_in=false,
      p(displayUnit="Pa") = 101325,
      nPorts=1) "Outlet for water flow"
      annotation (Placement(transformation(extent={{80,20},{60,40}})));
    IDEAS.Fluid.Sources.MassFlowSource_T bou(
      nPorts=1,
      redeclare package Medium = Medium,
      use_T_in=false,
      m_flow=m_flow_nominal,
      T=303.15) "Inlet for water flow, at a prescribed flow rate and temperature"
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));

    IDEAS.Fluid.Sources.Boundary_pT sou1(
      redeclare package Medium = Medium,
      use_p_in=false,
      p(displayUnit="Pa") = 101325,
      nPorts=1) "Outlet for water flow"
      annotation (Placement(transformation(extent={{80,-40},{60,-20}})));
    IDEAS.Fluid.Sources.MassFlowSource_T bou1(
      nPorts=1,
      redeclare package Medium = Medium,
      use_T_in=false,
      m_flow=m_flow_nominal,
      T=303.15) "Inlet for water flow, at a prescribed flow rate and temperature"
      annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));

    Sensors.TemperatureTwoPort senTem(
       redeclare package Medium = Medium,
       tau=0,
       m_flow_nominal=m_flow_nominal)
      "Temperature sensor"
      annotation (Placement(transformation(extent={{20,40},{40,20}})));
    Sensors.TemperatureTwoPort senTem1(
      redeclare package Medium = Medium,
      tau=0,
      m_flow_nominal=m_flow_nominal)
      "Temperature sensor"
      annotation (Placement(transformation(extent={{20,-20},{40,-40}})));
    Modelica.Blocks.Math.Add dT(final k2=-1) "Temperature difference (must be zero)"
      annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
  equation
    connect(weaDat.weaBus, solCol1.weaBus) annotation (Line(
        points={{-68,70},{-50,70},{-50,-22}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(bou1.ports[1], solCol1.port_a) annotation (Line(
        points={{-60,-30},{-50,-30}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(solCol.port_a, bou.ports[1]) annotation (Line(points={{-20,30},{-60,30}},
                             color={0,127,255}));
    connect(solCol.weaBus, weaDat.weaBus) annotation (Line(
        points={{-20,38},{-24,38},{-24,70},{-68,70}},
        color={255,204,51},
        thickness=0.5));
    connect(solCol2.port_a, solCol1.port_b)
      annotation (Line(points={{-20,-30},{-30,-30}},
                                                  color={0,127,255}));
    connect(weaDat.weaBus, solCol2.weaBus) annotation (Line(
        points={{-68,70},{-24,70},{-24,-22},{-20,-22}},
        color={255,204,51},
        thickness=0.5));
    connect(solCol.port_b, senTem.port_a)
      annotation (Line(points={{0,30},{20,30}}, color={0,127,255}));
    connect(senTem.port_b, sou.ports[1])
      annotation (Line(points={{40,30},{60,30}}, color={0,127,255}));
    connect(sou1.ports[1], senTem1.port_b)
      annotation (Line(points={{60,-30},{40,-30}}, color={0,127,255}));
    connect(senTem1.port_a, solCol2.port_b)
      annotation (Line(points={{20,-30},{0,-30}}, color={0,127,255}));
    connect(dT.u1, senTem.T) annotation (Line(points={{58,-64},{50,-64},{50,0},{30,
            0},{30,19}},  color={0,0,127}));
    connect(senTem1.T, dT.u2) annotation (Line(points={{30,-41},{30,-76},{58,-76}},
                                         color={0,0,127}));
    annotation (
      Documentation(info="<html>
<p>
This model validates the solar collector model
<a href=\"modelica://IDEAS.Fluid.SolarCollectors.EN12975\">
IDEAS.Fluid.SolarCollectors.EN12975</a>
for the case where one model has multiple panels in series,
versus the case where two models are in series, each having one panel.
The output of the block <code>dT</code> must be zero, as both
cases must have the same outlet temperatures.
</p>
</html>",   revisions="<html>
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
December 12, 2017, by Michael Wetter:<br/>
First implementation to validate
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/1100\">#1100</a>.
</li>
</ul>
</html>"),
      __Dymola_Commands(file=
            "modelica://IDEAS/Resources/Scripts/Dymola/Fluid/SolarCollectors/Validation/EN12975_Series.mos"
          "Simulate and plot"),
      experiment(Tolerance=1e-6, StopTime=86400));
  end EN12975_Series;

  model ExtremeAmbientConditions
    "Validation model for to ensure that collectors do not freeze or boil"
    extends Modelica.Icons.Example;

    replaceable package Medium = IDEAS.Media.Water(T_min=273.15, T_max=273.15+100)
      "Medium in the system";

    EN12975 solEn(
      redeclare package Medium = Medium,
      shaCoe=0,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      rho=0.2,
      nColType=IDEAS.Fluid.SolarCollectors.Types.NumberSelection.Number,
      sysConfig=IDEAS.Fluid.SolarCollectors.Types.SystemConfiguration.Series,
      nPanels=1,
      azi=0.3,
      til=0.5,
      per=IDEAS.Fluid.SolarCollectors.Data.GlazedFlatPlate.FP_VerificationModel(),
      T_start=313.15) "Flat plate solar collector model using the EN 12975 model"
      annotation (Placement(transformation(extent={{20,-90},{40,-70}})));

    Sources.MassFlowSource_T sou(
      redeclare package Medium = Medium,
      nPorts=1,
      m_flow=0) "Inlet boundary conditions"
      annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-10,-40})));
    Sources.Boundary_pT sou1(
      redeclare package Medium = Medium,
      p(displayUnit="Pa"),
      use_p_in=false,
      nPorts=2) "Inlet boundary conditions"
      annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={80,-60})));
    Modelica.Blocks.Sources.Ramp TAmb(
      offset=273.15 + 40,
      height=-100,
      duration=10*3600) "Ambient temperature"
      annotation (Placement(transformation(extent={{-80,90},{-60,110}})));
    Modelica.Blocks.Sources.Ramp HSol(
      duration=12*3600,
      height=1000,
      startTime=10*3600) "Solar irradiation"
      annotation (Placement(transformation(extent={{-80,60},{-60,80}})));

    Sources.MassFlowSource_T sou2(
      redeclare package Medium = Medium,
      nPorts=1,
      m_flow=0) "Inlet boundary conditions"
      annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-10,-80})));
    BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
          transformation(extent={{-10,-10},{10,10}}),iconTransformation(extent={{-154,
              16},{-134,36}})));
    Modelica.Blocks.Sources.Constant const(k=0) "Constant that outputs zero"
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Modelica.Blocks.Sources.Constant solTim(k=12*3600) "Solar time"
      annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
    Modelica.Blocks.Sources.Constant lat(k=0.656593) "Location latitude"
      annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
    Modelica.Blocks.Sources.Constant alt(k=2) "Location altitude"
      annotation (Placement(transformation(extent={{-80,-110},{-60,-90}})));
    Modelica.Blocks.Sources.Constant const1(k=0)
                                                "Constant that outputs zero"
      annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  equation
    connect(sou.ports[1], solAsh.port_a)
      annotation (Line(points={{1.77636e-15,-40},{20,-40}}, color={0,127,255}));
    connect(sou2.ports[1], solEn.port_a)
      annotation (Line(points={{1.77636e-15,-80},{20,-80}}, color={0,127,255}));
    connect(solAsh.port_b, sou1.ports[1])
      annotation (Line(points={{40,-40},{70,-40},{70,-61}},
                                                         color={0,127,255}));
    connect(solEn.port_b, sou1.ports[2]) annotation (Line(points={{40,-80},{70,
            -80},{70,-59}},     color={0,127,255}));
    connect(weaBus, solAsh.weaBus) annotation (Line(
        points={{0,0},{16,0},{16,-32},{20,-32}},
        color={255,204,51},
        thickness=0.5), Text(
        textString="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(TAmb.y, weaBus.TDryBul) annotation (Line(points={{-59,100},{0,100},{0,
            50},{0.05,50},{0.05,0.05}},
                        color={0,0,127}), Text(
        textString="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(HSol.y, weaBus.HDifHor) annotation (Line(points={{-59,70},{-28,70},{-28,
            0.05},{0.05,0.05}},
                       color={0,0,127}), Text(
        textString="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(HSol.y, weaBus.HGloHor) annotation (Line(points={{-59,70},{-28,70},{-28,
            0.05},{0.05,0.05}},
                       color={0,0,127}), Text(
        textString="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(const.y, weaBus.solZen) annotation (Line(points={{-59,30},{-28,30},{-28,
            0.05},{0.05,0.05}},
                       color={0,0,127}), Text(
        textString="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(solTim.y, weaBus.solTim) annotation (Line(points={{-59,-40},{-28,-40},
            {-28,0.05},{0.05,0.05}},
                            color={0,0,127}), Text(
        textString="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(HSol.y, weaBus.HDirNor) annotation (Line(points={{-59,70},{-28,70},{-28,
            0.05},{0.05,0.05}},
                       color={0,0,127}), Text(
        textString="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(solEn.weaBus, weaBus) annotation (Line(
        points={{20,-72},{16,-72},{16,0},{0,0}},
        color={255,204,51},
        thickness=0.5), Text(
        textString="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(lat.y, weaBus.lat) annotation (Line(points={{-59,-70},{-28,-70},{-28,0.05},
            {0.05,0.05}},
                       color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(alt.y, weaBus.alt) annotation (Line(points={{-59,-100},{-28,-100},{-28,
            0.05},{0.05,0.05}},
                       color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const1.y, weaBus.cloTim) annotation (Line(points={{-59,-10},{-28,-10},
            {-28,0.05},{0.05,0.05}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    annotation (
      Documentation(info="<html>
<p>
This model validates the correct implementation of the heat transfer
to the collector when ambient temperatures are very low or irradiation is very
large.
It applies a ramp boundary condition that reduces the ambient temperature
to <i>-60</i>&deg;C to verify that the collector fluid temperature does not
drop below <code>Medium.T_min</code>.
Afterwards, the solar irradiation is increased to overheat the collector.
If the fluid temperature approaches <code>Medium.T_max</code>,
then the solar heat gain is reduced to zero.
Ensuring these bounds is important as otherwise, the collector model
would trigger an assertion and the simulation would stop.
The tested collector models are
<a href=\"modelica://IDEAS.Fluid.SolarCollectors.ASHRAE93\">
IDEAS.Fluid.SolarCollectors.ASHRAE93</a>
and
<a href=\"modelica://IDEAS.Fluid.SolarCollectors.EN12975\">
IDEAS.Fluid.SolarCollectors.EN12975</a>.
</p>
<p>
Note that the medium has been declared
as <code>IDEAS.Media.Water(T_min=273.15, T_max=273.15+100)</code>
to set the two bounds for the water temperature.
</p>
</html>",
  revisions="<html>
<ul>
<li>
September 25, 2023, by Michael Wetter:<br/>
Corrected <code>connect</code> statement with wrong quantity.
</li>
<li>
September 16, 2021, by Michael Wetter:<br/>
Removed parameter assignment for <code>lat</code>.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1477\">IBPSA, #1477</a>.
</li>
<li>
June 30, 2015, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
      __Dymola_Commands(file="modelica://IDEAS/Resources/Scripts/Dymola/Fluid/SolarCollectors/Validation/ExtremeAmbientConditions.mos"
          "Simulate and plot"),
      experiment(Tolerance=1e-06, StopTime=86400),
      Diagram(coordinateSystem(extent={{-100,-120},{100,120}})),
      Icon(coordinateSystem(extent={{-100,-120},{100,120}})));
  end ExtremeAmbientConditions;

  model FlatPlate "Validation model for FlatPlate"
    extends Modelica.Icons.Example;
    replaceable package Medium = IDEAS.Media.Water "Medium in the system";
    IDEAS.Fluid.SolarCollectors.ASHRAE93
     solCol(
      redeclare package Medium = Medium,
      shaCoe=0,
      azi=0,
      per=IDEAS.Fluid.SolarCollectors.Data.GlazedFlatPlate.FP_TRNSYSValidation(),
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      rho=0.2,
      nColType=IDEAS.Fluid.SolarCollectors.Types.NumberSelection.Number,
      nPanels=1,
      nSeg=30,
      til=0.78539816339745)
      "Flat plate solar collector model, has been modified for validation purposes"
      annotation (Placement(transformation(extent={{30,-10},{50,10}})));

    IDEAS.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
      Modelica.Utilities.Files.loadResource("modelica://IDEAS/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"),
        computeWetBulbTemperature=false)
      "Weather data file reader"
      annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
    IDEAS.Fluid.Sources.Boundary_pT sou(
      redeclare package Medium = Medium,
      use_p_in=false,
      p(displayUnit="Pa") = 101325,
      nPorts=1) "Outlet for water flow"
      annotation (Placement(transformation(extent={{90,-10},{70,10}})));
    IDEAS.Fluid.Sources.MassFlowSource_T bou(
      nPorts=1,
      redeclare package Medium = Medium,
      use_m_flow_in=true,
      use_T_in=true)
      "Inlet for water flow, at a prescribed flow rate and temperature"
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Math.Add add
      "Converts TRNSYS data from degree Celsius to Kelving"
      annotation (Placement(transformation(extent={{-50,0},{-30,20}})));
    Modelica.Blocks.Sources.CombiTimeTable datRea(
      tableOnFile=true,
      tableName="TRNSYS",
      columns=2:5,
      fileName=Modelica.Utilities.Files.loadResource(
         "modelica://IDEAS/Resources/Data/Fluid/SolarCollectors/Validation/FlatPlate/TRNSYSAnnualData.txt"),
      smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments)
      "Data reader with inlet conditions from TRNSYS"
      annotation (Placement(transformation(extent={{-90,20},{-70,40}})));

    Modelica.Blocks.Sources.Constant const(k=273.15)
      "Used to convert TRNSYS data from degree Celsius to Kelving"
      annotation (Placement(transformation(extent={{-90,-40},{-70,-20}})));

  equation
    connect(weaDat.weaBus, solCol.weaBus) annotation (Line(
        points={{-20,70},{20,70},{20,8},{30,8}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(bou.ports[1], solCol.port_a)      annotation (Line(
        points={{10,0},{30,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(const.y, add.u2) annotation (Line(
        points={{-69,-30},{-60,-30},{-60,4},{-52,4}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(add.y, bou.T_in)      annotation (Line(
        points={{-29,10},{-24,10},{-24,4},{-12,4}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(datRea.y[1], add.u1)        annotation (Line(
        points={{-69,30},{-60,30},{-60,16},{-52,16}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(datRea.y[4], bou.m_flow_in)             annotation (Line(
        points={{-69,30},{-20,30},{-20,8},{-12,8}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(sou.ports[1], solCol.port_b) annotation (Line(
        points={{70,0},{50,0}},
        color={0,127,255},
        smooth=Smooth.None));
    annotation (
      Documentation(info="<html>
<p>
This model was used to validate the
<a href=\"modelica://IDEAS.Fluid.SolarCollectors.ASHRAE93\">
IDEAS.Fluid.SolarCollectors.ASHRAE93</a> solar collector model
against TRNSYS data. Data files are used to ensure that the
<a href=\"modelica://IDEAS.Fluid.SolarCollectors.ASHRAE93\">
IDEAS.Fluid.SolarCollectors.ASHRAE93</a> solar collector model and
the TRNSYS model use the same inlet and weather conditions. The
solar collector model must reference the
<a href=\"modelica://IDEAS.Fluid.SolarCollectors.Data.GlazedFlatPlate.FP_TRNSYSValidation\">
IDEAS.Fluid.SolarCollectors.Data.GlazedFlatPlate.FP_TRNSYSValidation</a>
data record when comparing model results to the stored TRNSYS results.
</p>
<p>
The solar collector temperature of the Modelica model has a spike
in the morning. At this time, there is solar irradiation on the collector
but no mass flow rate, which leads to an increase in temperature.
</p>
</html>",
  revisions="<html>
<ul>
<li>
September 16, 2021, by Michael Wetter:<br/>
Removed parameter assignment for <code>lat</code>.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1477\">IBPSA, #1477</a>.
</li>
<li>
April 21, 2016, by Michael Wetter:<br/>
Replaced <code>ModelicaServices.ExternalReferences.loadResource</code> with
<code>Modelica.Utilities.Files.loadResource</code>.
</li>
<li>
December 22, 2014 by Michael Wetter:<br/>
Removed <code>Modelica.Fluid.System</code>
to address issue
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/311\">#311</a>.
</li>
<li>
March 27, 2013, by Peter Grant:<br/>
First implementation.
</li>
</ul>
</html>"),
    __Dymola_Commands(file="modelica://IDEAS/Resources/Scripts/Dymola/Fluid/SolarCollectors/Validation/FlatPlate.mos"
      "Simulate and plot"),
    experiment(Tolerance=1e-6, StopTime=86400));
  end FlatPlate;

  model FlatPlateNPanels
    "Validation model for flat plate collector with different settings for nPanel"
    extends IDEAS.Fluid.SolarCollectors.Validation.FlatPlate;
    parameter Integer nPanels = 10 "Number of panels";
    IDEAS.Fluid.SolarCollectors.ASHRAE93
     solCol1(
      redeclare package Medium = Medium,
      shaCoe=0,
      azi=0,
      per=IDEAS.Fluid.SolarCollectors.Data.GlazedFlatPlate.FP_TRNSYSValidation(),
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      rho=0.2,
      nColType=IDEAS.Fluid.SolarCollectors.Types.NumberSelection.Number,
      nSeg=30,
      til=0.78539816339745,
      nPanels=nPanels)
      "Flat plate solar collector model, has been modified for validation purposes"
      annotation (Placement(transformation(extent={{30,-50},{50,-30}})));
    IDEAS.Fluid.Sources.Boundary_pT sou1(
      redeclare package Medium = Medium,
      use_p_in=false,
      p(displayUnit="Pa") = 101325,
      nPorts=1) "Outlet for water flow"
      annotation (Placement(transformation(extent={{90,-50},{70,-30}})));
    IDEAS.Fluid.Sources.MassFlowSource_T bou1(
      nPorts=1,
      redeclare package Medium = Medium,
      use_m_flow_in=true,
      use_T_in=true)
      "Inlet for water flow, at a prescribed flow rate and temperature"
      annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
    Modelica.Blocks.Math.Gain gaiNPan(k=nPanels) "Gain for number of panels"
      annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
    Modelica.Blocks.Sources.RealExpression difHeaGai(y=solCol.QGai[30].Q_flow -
          solCol1.QGai[30].Q_flow/nPanels)
      "Difference in heat gain at last panel between model with 1 and with 30 panels"
      annotation (Placement(transformation(extent={{-70,-70},{-50,-50}})));
    Modelica.Blocks.Sources.RealExpression difHeaLos(y=solCol.QLos[30].Q_flow -
          solCol1.QLos[30].Q_flow/nPanels)
      "Difference in heat loss at last panel between model with 1 and with 30 panels"
      annotation (Placement(transformation(extent={{-70,-90},{-50,-70}})));
  equation
    connect(weaDat.weaBus, solCol1.weaBus) annotation (Line(
        points={{-20,70},{20,70},{20,-32},{30,-32}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(bou1.ports[1], solCol1.port_a) annotation (Line(
        points={{10,-40},{30,-40}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(add.y, bou1.T_in) annotation (Line(
        points={{-29,10},{-24,10},{-24,-36},{-12,-36}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(sou1.ports[1], solCol1.port_b) annotation (Line(
        points={{70,-40},{50,-40}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(gaiNPan.y, bou1.m_flow_in)
      annotation (Line(points={{-29,-20},{-20,-20},{-20,-32},{-12,-32}},
                                                     color={0,0,127}));
    connect(gaiNPan.u, datRea.y[4]) annotation (Line(points={{-52,-20},{-64,-20},
            {-64,30},{-69,30}},color={0,0,127}));
    annotation (
      Documentation(info="<html>
<p>
This model validates the solar collector model
<a href=\"modelica://IDEAS.Fluid.SolarCollectors.ASHRAE93\">
IDEAS.Fluid.SolarCollectors.ASHRAE93</a>
for the case
where the number of panels is <i>1</i> for the instance <code>solCol</code>
and <i>10</i> for the instance <code>solCol1</code>.
The instances <code>difHeaGai</code> and <code>difHeaLos</code>
compare the heat gain and heat loss between the two models.
The output of these blocks should be zero, except for rounding errors.
</p>
</html>",
  revisions="<html>
<ul>
<li>
September 16, 2021, by Michael Wetter:<br/>
Removed parameter assignment for <code>lat</code>.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1477\">IBPSA, #1477</a>.
</li>
<li>
November 21, 2017, by Michael Wetter:<br/>
First implementation to validate
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/1073\">#1073</a>.
</li>
</ul>
</html>"),
    __Dymola_Commands(file="modelica://IDEAS/Resources/Scripts/Dymola/Fluid/SolarCollectors/Validation/FlatPlateNPanels.mos"
      "Simulate and plot"),
    experiment(Tolerance=1e-6, StopTime=86400));
  end FlatPlateNPanels;
annotation (preferredView="info", Documentation(info="<html>
<p>
This package contains validation models for the classes in
<a href=\"modelica://IDEAS.Fluid.SolarCollectors\">
IDEAS.Fluid.SolarCollectors</a>.
</p>
<p>
Note that most validation models contain simple input data
which may not be realistic, but for which the correct
output can be obtained through an analytic solution.
The examples plot various outputs, which have been verified against these
solutions. These model outputs are stored as reference data and
used for continuous validation whenever models in the library change.
</p>
</html>"));
end Validation;
