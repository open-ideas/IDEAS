within IDEAS.Fluid.PvtCollectors;
package BaseClasses "Package with base classes for IDEAS.Fluid.SolarCollectors"
extends Modelica.Icons.BasesPackage;










  block PartialEN12975HeatLoss_QuasiDynamic
    "Calculate the heat loss of a solar collector per EN12975"
    extends IDEAS.Fluid.SolarCollectors.BaseClasses.EN12975HeatLoss(
      QLos_internal=A_c/nSeg*{dT[i] * (a1 - a2 * dT[i] + c3*u) + c4*(E_L - sigma*TEnv^4) -
          c6*u*G for i in 1:nSeg});

  // Constants
    parameter Real c3(final unit = "J/(m3.K)", final min=0) "a3 from ratings data";
    parameter Real c4(final unit = "", final min=0) "c4 from ratings data";
    parameter Real c6(final unit = "J/(m3.K)", final min=0) "c6 from ratings data";
    parameter Real sigma = 5.67e-8 "Stefan-Boltzmann constant [W/m²K^4]";

    // Inputs
     Modelica.Blocks.Interfaces.RealInput u(
      quantity="Windspeed",
      unit="m/s",
      displayUnit="m/s") "windspeed of surrounding air"
      annotation (Placement(transformation(extent={{-142,0},{-100,42}}),
          iconTransformation(extent={{-142,0},{-100,42}})));
    Modelica.Blocks.Interfaces.RealInput E_L(
      quantity="long-wave solar irradiance",
      unit="W/m2",
      displayUnit="W/m2") "Long-wave solar irradiance [W/m2]" annotation (Placement(
          transformation(extent={{-21,-21},{21,21}},
          rotation=0,
          origin={-121,-99}),  iconTransformation(
            extent={{-142,-120},{-100,-78}})));

     Modelica.Blocks.Interfaces.RealInput G(
      quantity="Global solar irradiance",
      unit="W/m2",
      displayUnit="W/m2") "global solar irradiance [W/m2]" annotation (Placement(
          transformation(extent={{-21,-21},{21,21}},
          rotation=0,
          origin={-121,-21}),                               iconTransformation(
            extent={{-140,-42},{-98,0}})));

    // Internal variables to be visible in simulation results
    Real c1_c2_term(unit="W");
    Real c3_term(unit="W");
    Real c4_term(unit="W");
    Real c6_term(unit="W");

    // Equations for terms
  equation
      c1_c2_term = sum(A_c/nSeg*{dT[i]*(a1 - a2*dT[i]) for i in 1:nSeg});
      c3_term = sum(A_c/nSeg*{dT[i]*(c3*u) for i in 1:nSeg});
      c4_term = sum(A_c/nSeg*{c4*(E_L - sigma*TEnv^4) for i in 1:nSeg});
      c6_term = sum(A_c/nSeg*{(-1)* c6*u*G  for i in 1:nSeg});


  end PartialEN12975HeatLoss_QuasiDynamic;

  model EN12975SolarGain "Model calculating solar gains per the EN12975 standard"
    extends Modelica.Blocks.Icons.Block;
    extends SolarCollectors.BaseClasses.PartialParameters;

    replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
      "Medium in the system";

    parameter Real eta0(final unit="1") "Optical efficiency (maximum efficiency)";
    parameter Modelica.Units.SI.Angle[:] incAngDat "Incidence angle modifier spline derivative coefficients";
    parameter Real[size(incAngDat,1)] incAngModDat(each final unit="1") "Incidence angle modifier spline derivative coefficients";
    parameter Boolean use_shaCoe_in = false
      "Enables an input connector for shaCoe"
      annotation(Dialog(group="Shading"));
    parameter Real shaCoe(
      min=0.0,
      max=1.0) = 0 "Shading coefficient 0.0: no shading, 1.0: full shading"
      annotation(Dialog(enable = not use_shaCoe_in,group="Shading"));

    parameter Real iamDiff "Incidence angle modifier for diffuse radiation";

    Modelica.Blocks.Interfaces.RealInput shaCoe_in if use_shaCoe_in
      "Time varying input for the shading coefficient"
      annotation(Placement(transformation(extent={{-140,-70},{-100,-30}})));

    Modelica.Blocks.Interfaces.RealInput HSkyDifTil(
      unit="W/m2",
      quantity="RadiantEnergyFluenceRate")
      "Diffuse solar irradiation on a tilted surfce from the sky"
      annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
    Modelica.Blocks.Interfaces.RealInput incAng(
      quantity="Angle",
      unit="rad",
      displayUnit="deg") "Incidence angle of the sun beam on a tilted surface"
      annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
    Modelica.Blocks.Interfaces.RealInput HDirTil(
      unit="W/m2",
      quantity="RadiantEnergyFluenceRate")
      "Direct solar irradiation on a tilted surfce"
      annotation (Placement(transformation(extent={{-140,0},{-100,40}})));
    Modelica.Blocks.Interfaces.RealOutput QSol_flow[nSeg](each final unit="W")
      "Solar heat gain"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.RealInput TFlu[nSeg](
       each final unit="K",
       each displayUnit="degC",
       each final quantity="ThermodynamicTemperature")
      annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));

  protected
    constant Modelica.Units.SI.TemperatureDifference dTMax=1
      "Safety temperature difference to prevent TFlu > Medium.T_max";
    final parameter Modelica.Units.SI.Temperature TMedMax=Medium.T_max - dTMax
      "Fluid temperature above which there will be no heat gain computed to prevent TFlu > Medium.T_max";
    final parameter Modelica.Units.SI.Temperature TMedMax2=TMedMax - dTMax
      "Fluid temperature above which there will be no heat gain computed to prevent TFlu > Medium.T_max";
    Real iamBea "Incidence angle modifier for director solar radiation";
    Modelica.Blocks.Interfaces.RealInput shaCoe_internal "Internally used shaCoe";

    parameter Real[size(incAngDat, 1)] dMonotone(each fixed=false) "Derivatives";

  initial algorithm
    dMonotone := IDEAS.Utilities.Math.Functions.splineDerivatives(
      x=incAngDat,
      y=incAngModDat,
      ensureMonotonicity=false);

  equation
    connect(shaCoe_internal, shaCoe_in);

    if not use_shaCoe_in then
      shaCoe_internal = shaCoe;
    end if;

    // EnergyPlus 23.2.0 Engineering Reference Eq 18.298
    iamBea = SolarCollectors.BaseClasses.IAM(incAng, incAngDat, incAngModDat, dMonotone);
    // Modified from EnergyPlus 23.2.0 Engineering Reference Eq 18.302
    // by applying shade effect for direct solar radiation
    // Only solar heat gain is considered here
    for i in 1 : nSeg loop
    QSol_flow[i] = A_c/nSeg*(eta0*(iamBea*HDirTil*(1.0 - shaCoe_internal) + iamDiff *
    HSkyDifTil))*
        smooth(1, if TFlu[i] < TMedMax2
          then 1
          else IDEAS.Utilities.Math.Functions.smoothHeaviside(TMedMax-TFlu[i], dTMax));
    end for;
    annotation (
      defaultComponentName="solGai",
      Documentation(info="<html>
<p>
This component computes the solar heat gain of the solar thermal collector.
It only calculates the solar heat gain without considering the heat loss
to the environment.
This model uses ratings data according to EN12975.
The solar heat gain is calculated using Equations 18.298 and 18.302 in the
referenced EnergyPlus documentation.
The calculation is modified to use coefficients from EN12975.
</p>
<p>
The equation used to calculate solar gain is a modified version of Eq 18.302
from the EnergyPlus documentation.
It is
</p>
<p align=\"center\" style=\"font-style:italic;\">
Q<sub>flow</sub>[i] = A<sub>c</sub>/nSeg &eta;<sub>0</sub> (K<sub>
(&tau;&alpha;),dir</sub> G<sub>dir</sub> (1-shaCoe)+K<sub>dif</sub> G<sub>
dif</sub>),
</p>
<p>
where <i>Q<sub>flow</sub>[i]</i> is the heat gained in each segment,
<i>A<sub>c</sub></i> is the area of the collector,
<code>nSeg</code> is the number of segments in the collector,
<i>&eta;<sub>0</sub></i> is the maximum efficiency of the collector,
<i>K<sub>(&tau;&alpha;),dir</sub> </i>is the incidence angle modifier
for (direct) beam radiation,
<i>G<sub>dir</sub></i> is the current beam radiation on the collector,
<code>shaCoe</code> is the shading coefficient,
<i>K<sub>dif</sub></i> is the incidence angle modifier
for diffuse radiation,
and <i>G<sub>dif</sub></i> is the diffuse radiation striking the surface.
</p>
<p>
The solar radiation equation indicates that the collector is divided into
multiple segments.
The number of segments used in the simulation is specified by the user via <code>nSeg</code>.
The area of an individual segment is identified by dividing the collector area
by the total number of segments.
The term <code>shaCoe</code> is used to define the percentage of the collector
that is shaded.
</p>
<p>
The main difference between this model and the ASHRAE model is the handling of
diffuse radiation.
The ASHRAE model contains calculated incidence angle modifiers for
both sky and ground diffuse radiation,
while this model uses a coefficient from test data for diffuse radiation.
</p>
<p>
The incidence angle modifier is calculated using Eq 18.298 from the EnergyPlus
documentation. It is
</p>
<p align=\"center\" style=\"font-style:italic;\">
K<sub>(&tau;&alpha;),x</sub>=1+b<sub>0</sub> (1/cos(&theta;)-1)+b<sub>1</sub>
  (1/cos(&theta;)-1)<sup>2</sup>
</p>
<p>
where <i>K<sub>(&tau;&alpha;),dir</sub></i> is the incidence angle modifier
for beam radiation,
<i>b<sub>0</sub></i> is the first incidence angle modifier coefficient,
<i>b<sub>1</sub></i> is the second incidence angle modifier coefficient,
and <i>&theta;</i> is the incidence angle.
</p>
<p>
This model reduces the heat gain rate to 0 W when the fluid temperature is
within 1 degree C of the maximum temperature of the medium model.
The calculation is performed using the
<a href=\"modelica://IDEAS.Utilities.Math.Functions.smoothHeaviside\">
IDEAS.Utilities.Math.Functions.smoothHeaviside</a> function.
</p>

<h4>References</h4>
<p>
CEN 2022, European Standard 12975:2022, European Committee for Standardization
</p>
<p>
<a href=\"https://energyplus.net/assets/nrel_custom/pdfs/pdfs_v23.2.0/EngineeringReference.pdf\">
EnergyPlus 23.2.0 Engineering Reference</a>
</p>
</html>",   revisions="<html>
<ul>
<li>
February 28, 2024, by Jelger Jansen:<br/>
Refactor model.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/3604\">Buildings, #3604</a>.
</li>
<li>
January 12, 2019, by Michael Wetter:<br/>
Added missing <code>each</code>.
</li>
<li>
April 27, 2018, by Michael Wetter:<br/>
Corrected <code>displayUnit</code>.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/912\">Buildings, issue 912</a>.
</li>
<li>
May 31, 2017, by Michael Wetter and Filip Jorissen:<br/>
Change limits for incident angle modifier to avoid dip in temperature
at shallow incidence angles.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/785\">issue 785</a>.
</li>
<li>
September 17, 2016, by Michael Wetter:<br/>
Corrected quantity from <code>Temperature</code> to <code>ThermodynamicTemperature</code>
to avoid an error in the pedantic model check in Dymola 2017 FD01 beta2.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/557\">issue 557</a>.
</li>
<li>
June 29, 2015, by Michael Wetter:<br/>
Revised implementation of heat loss near <code>Medium.T_max</code>
to make it more efficient.
</li>
<li>
June 29, 2015, by Filip Jorissen:<br/>
Fixed sign mistake causing model to fail under high
solar irradiation because temperature goes above
medium temperature bound.
</li>
<li>
Jan 15, 2013, by Peter Grant:<br/>
First implementation
</li>
</ul>
</html>"));
  end EN12975SolarGain;

  block PartialParameters "Partial model for parameters"

    parameter Modelica.Units.SI.Area A_c "Area of the collector";
    parameter Integer nSeg=3 "Number of segments";

    annotation(Documentation(info="<html>
<p>
Partial parameters used in all solar collector models
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
Apr 17, 2013, by Peter Grant:<br/>
First implementation
</li>
</ul>
</html>"));
  end PartialParameters;

  package Examples "Collection of models that illustrate model use and test models"
  extends Modelica.Icons.ExamplesPackage;


    model EN12975HeatLoss "Example showing the use of EN12975HeatLoss"
      extends Modelica.Icons.Example;
      parameter IDEAS.Fluid.PvtCollectors.Data.GenericQuasiDynamic per=
        IDEAS.Fluid.PvtCollectors.Data.WISC.WISC_TRNSYSValidation()
        "Performance data"
        annotation (choicesAllMatching=true);
      Modelica.Blocks.Sources.Sine T1(
        amplitude=15,
        f=0.1,
        offset=273.15 + 10) "Temperature of the first segment"
        annotation (Placement(transformation(extent={{30,-90},{50,-70}})));
      Modelica.Blocks.Sources.Sine T2(
        f=0.1,
        amplitude=15,
        offset=273.15 + 15) "Temperature of the second segment"
        annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
      Modelica.Blocks.Sources.Sine T3(
        f=0.1,
        amplitude=15,
        offset=273.15 + 20) "Temperature of the third segment"
        annotation (Placement(transformation(extent={{-50,-50},{-30,-30}})));
      EN12975HeatLoss_QuasiDynamic eN12975HeatLoss_QuasiDynamic(
      nSeg=3,
        redeclare package Medium = IDEAS.Media.Water,
        a1=per.a1,
        a2=per.a2,
        c3=per.c3,
        c4=per.c4,
        c6=per.c6,
        A_c=per.A)
        annotation (Placement(transformation(extent={{74,12},{94,32}})));
      BoundaryConditions.WeatherData.ReaderTMY3       weaDat(filNam=
            Modelica.Utilities.Files.loadResource("modelica://IDEAS/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
        "Weather data input file"
        annotation (Placement(transformation(extent={{-84,70},{-64,90}})));
      Modelica.Blocks.Sources.RealExpression globIrrTil(y=600)           "[W/m2]"
        annotation (Placement(transformation(extent={{-47.5,26},{-28.5,42}})));
    equation
      connect(weaDat.weaBus, eN12975HeatLoss_QuasiDynamic.WeaBus) annotation (Line(
          points={{-64,80},{68,80},{68,29.2},{73.6,29.2}},
          color={255,204,51},
          thickness=0.5));
      connect(eN12975HeatLoss_QuasiDynamic.G, globIrrTil.y) annotation (Line(points={{72,20.6},
              {-24,20.6},{-24,34},{-27.55,34}},            color={0,0,127}));
      connect(T3.y, eN12975HeatLoss_QuasiDynamic.TFlu[1]) annotation (Line(points={{-29,-40},
              {62,-40},{62,16.9333},{72,16.9333}},                         color={0,
              0,127}));
      connect(T2.y, eN12975HeatLoss_QuasiDynamic.TFlu[2]) annotation (Line(points={{11,-60},
              {62,-60},{62,17.6},{72,17.6}},
            color={0,0,127}));
      connect(T1.y, eN12975HeatLoss_QuasiDynamic.TFlu[3]) annotation (Line(points={{51,-80},
              {62,-80},{62,18.2667},{72,18.2667}},
                           color={0,0,127}));
      annotation (
        Documentation(info="<html>
<p>
This examples demonstrates the implementation of
<a href=\"modelica://IDEAS.Fluid.SolarCollectors.BaseClasses.EN12975HeatLoss\">
IDEAS.Fluid.SolarCollectors.BaseClasses.EN12975HeatLoss</a>.
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
Mar 27, 2013 by Peter Grant:<br/>
First implementation.
</li>
</ul>
  </html>"),
        __Dymola_Commands(file=
              "modelica://IDEAS/Resources/Scripts/Dymola/Fluid/SolarCollectors/BaseClasses/Examples/EN12975HeatLoss.mos"
            "Simulate and plot"),
            experiment(Tolerance=1e-6, StopTime=100));
    end EN12975HeatLoss;

  annotation (preferredView="info", Documentation(info="<html>
<p>
This package contains examples for the use of models that can be found in
<a href=\"modelica://IDEAS.Fluid.SolarCollectors.BaseClasses\">
IDEAS.Fluid.SolarCollectors.BaseClasses.</a>
</p>
</html>"));
  end Examples;

  model PartialQuasiDynamicPvtCollector
    "Extended solar thermal collector with discretized PV electrical calculations"
    extends IDEAS.Fluid.SolarCollectors.BaseClasses.PartialSolarCollector(redeclare IDEAS.Fluid.PvtCollectors.Data.GenericQuasiDynamic per);

    // ===== Photovoltaic Parameters =====
    parameter Modelica.Units.SI.Irradiance G_STC = 1000
      "Irradiance at Standard Conditions (W/m2)";
    parameter Modelica.Units.SI.Power      P_STC = 500
      "PV panel power at STC (W)";
    parameter Modelica.Units.SI.LinearTemperatureCoefficient gamma = -0.0037
      "Temperature coefficient of the PV panel(s)";
    parameter Modelica.Units.SI.Efficiency   P_loss_factor = 0.10
      "Loss factor of the PV panel(s)";
    parameter Modelica.Units.SI.CoefficientOfHeatTransfer U_pvt = 35
      "Heat transfer coefficient used in cell temperature calculation";
    constant Modelica.Units.SI.Temperature _T_ref = 25 + 273
      "Reference cell temperature (K)";

    // ===== Measurement Data =====
    // (Assumes that an outer meaDat is available providing measurement data)

    // ===== Variables for PV Electrical Calculations per Segment =====
    // (Assuming that the base model provides arrays: temSen, QGai, QLos, and the scalar ATot_internal)
    Real Tm[nSeg]         "Mean fluid temperature for each segment";
    Real qth[nSeg]        "Thermal power density per segment [W/m2]";
    Real T_cell[nSeg]     "Cell temperature for each segment (K)";
    Real T_diff[nSeg]     "Temperature difference of the cell relative to reference (K)";
    Real G                "Global irradiance on the panel (W/m2)";

    // ===== Real Output Connectors =====
    Modelica.Blocks.Interfaces.RealOutput Pel
      "Electrical power generated by the photovoltaic installation"
      annotation(Placement(transformation(extent={{100,-70},{120,-50}})));
    Modelica.Blocks.Interfaces.RealOutput Qth
      "Total thermal power generated by the PVT installation"
      annotation(Placement(transformation(extent={{100,-90},{120,-70}})));
    Modelica.Blocks.Interfaces.RealOutput T_module(
    quantity="Temperature",
      unit="K",
      displayUnit="degC")
      "Average cell temperature"
      annotation(Placement(transformation(extent={{100,58},{120,78}})));
    Modelica.Blocks.Interfaces.RealOutput T_mean(
    quantity="Temperature",
      unit="K",
      displayUnit="degC")
      "Average fluid temperature"
      annotation(Placement(transformation(extent={{100,78},{120,98}})));
     Modelica.Blocks.Interfaces.RealOutput solarPower_internal[nSeg]
    "Electrical power produced by each discretized PV segment (W)";
    Modelica.Blocks.Math.Add G_glob "Total irradiation on tilted surface"
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=90,
          origin={24,78})));
  equation
    // Directly calculate global irradiance from measurement data
    G = G_glob.y;

    // Calculate PV electrical performance for each segment
    for i in 1:nSeg loop
      // Retrieve the mean fluid temperature from the sensor array (provided by the base model)
      Tm[i] = temSen[i].T;
      // Compute the local thermal power density (W/m2)
      qth[i] = (QGai[i].Q_flow + QLos[i].Q_flow) / (ATot_internal/nSeg);
      // Estimate the cell temperature using fluid temperature and thermal flux
      T_cell[i] = Tm[i] + qth[i] / U_pvt;
      // Determine the temperature difference relative to the reference temperature
      T_diff[i] = T_cell[i] - _T_ref;
      // Calculate electrical power output per segment using the PV performance equation
      solarPower_internal[i] = (ATot_internal/nSeg) * (P_STC/per.A) * (G / G_STC) *
                               (1 + gamma * T_diff[i]) * (1 - P_loss_factor);
    end for;

    // Assign the sum of the segment electrical outputs to the output connector Pel
    Pel = sum(solarPower_internal);

    // Calculate the total thermal power by multiplying the thermal density with the segment area and summing up
    Qth = (ATot_internal/nSeg) * sum(qth);

    // Calculate the average cell temperature, defined as module temperature
    T_module = sum(T_cell)/nSeg;

    // Calculate the average fluid temperature, defined as module temperature
    T_mean = sum(Tm)/nSeg;

    connect(G_glob.u1, HDirTil.H) annotation (Line(points={{18,90},{-54,90},{-54,50},
            {-59,50}}, color={0,0,127}));
    connect(G_glob.u2, HDifTilIso.H) annotation (Line(points={{30,90},{30,98},{-54,
            98},{-54,92},{-56,92},{-56,80},{-59,80}},
                                    color={0,0,127}));
  end PartialQuasiDynamicPvtCollector;

  model EN12975_QuasiDynamic
    "Model of a solar thermal collector according to the EN12975 standard"
    extends IDEAS.Fluid.SolarCollectors.BaseClasses.PartialSolarCollector(
      redeclare replaceable IDEAS.Fluid.SolarCollectors.Data.GenericEN12975 per constrainedby IDEAS.Fluid.SolarCollectors.Data.GenericEN12975);

    outer Modelica.Blocks.Sources.CombiTimeTable meaDat(
      tableOnFile=true,
      tableName="data",
      fileName=Modelica.Utilities.Files.loadResource("modelica://PvtMod/Resources/Validation/MeasurementData/PVT_Austria_modelica.txt"),
      columns=1:25)                                     annotation (Placement(transformation(extent={{30,70},{10,90}})));

    IDEAS.Fluid.SolarCollectors.BaseClasses.EN12975SolarGain
      solGai(
      redeclare package Medium = Medium,
      final nSeg=nSeg,
      final incAngDat=per.incAngDat,
      final incAngModDat=per.incAngModDat,
      final iamDiff=per.IAMDiff,
      final eta0=per.eta0,
      final use_shaCoe_in=use_shaCoe_in,
      final shaCoe=shaCoe,
      final A_c=ATot_internal)
      "Identifies heat gained from the sun using the EN12975 standard calculations"
      annotation (Placement(transformation(extent={{-20,40},{0,60}})));
    IDEAS.Fluid.PvtCollectors.BaseClasses.PartialEN12975HeatLoss_QuasiDynamic
      heaLos(
      redeclare package Medium = Medium,
      final nSeg=nSeg,
      final a1=per.a1,
      final a2=per.a2,
      final A_c=ATot_internal,
      final dT_nominal=per.dT_nominal)
      "Calculates the heat lost to the surroundings using the EN12975 standard calculations"
      annotation (Placement(transformation(extent={{-20,10},{0,30}})));

  equation
    // Make sure the model is only used with the EN ratings data, and hence a1 > 0
    assert(per.a1 > 0,
      "In " + getInstanceName() + ": The heat loss coefficient from the EN 12975 ratings data must be strictly positive. Obtained a1 = " + String(per.a1));
    connect(shaCoe_internal, solGai.shaCoe_in);

    connect(weaBus.TDryBul, heaLos.TEnv) annotation (Line(
        points={{-99.95,80.05},{-90,80.05},{-90,26},{-22,26}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None), Text(
        textString="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(HDirTil.inc, solGai.incAng)    annotation (Line(
        points={{-59,46},{-50,46},{-50,48},{-22,48}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(HDirTil.H, solGai.HDirTil) annotation (Line(
        points={{-59,50},{-50,50},{-50,52},{-22,52}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(shaCoe_in, solGai.shaCoe_in) annotation (Line(
        points={{-120,40},{-40,40},{-40,45},{-22,45}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(heaLos.QLos_flow, QLos.Q_flow) annotation (Line(
        points={{1,20},{50,20}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(solGai.QSol_flow, QGai.Q_flow) annotation (Line(
        points={{1,50},{50,50}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(heaLos.TFlu, solGai.TFlu) annotation (Line(points={{-22,14},{-30,14},{
            -30,42},{-22,42}}, color={0,0,127}));
    connect(temSen.T, heaLos.TFlu) annotation (Line(points={{-11,-20},{-28,-20},{-28,
            14},{-22,14}}, color={0,0,127}));
    connect(HDifTilIso.H, solGai.HSkyDifTil) annotation (Line(points={{-59,80},{
            -40,80},{-40,58},{-22,58}}, color={0,0,127}));
    annotation (
    defaultComponentName="solCol",
    Documentation(info="<html>
<p>
This component models a solar thermal collector according to the EN12975
test standard.
</p>

<h4>References</h4>
<p>
CEN 2022, European Standard 12975:2022, European Committee for Standardization
</p>
<p>
<a href=\"https://energyplus.net/assets/nrel_custom/pdfs/pdfs_v23.2.0/EngineeringReference.pdf\">
EnergyPlus 23.2.0 Engineering Reference</a>
</p>
</html>",
        revisions="<html>
<ul>
<li>
February 28, 2024, by Jelger Jansen:<br/>
Refactor model.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/3604\">Buildings, #3604</a>.
</li>
<li>
December 11, 2023, by Michael Wetter:<br/>
Corrected implementation of pressure drop calculation for the situation where the collectors are in parallel,
e.g., if <code>sysConfig == Buildings.Fluid.SolarCollectors.Types.SystemConfiguration.Parallel</code>.<br/>
Changed assignment of <code>computeFlowResistance</code> to <code>final</code> based on
<code>dp_nominal</code>.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/3597\">Buildings, #3597</a>.
</li>
<li>
September 16, 2021, by Michael Wetter:<br/>
Changed <code>lat</code> from being a parameter to an input from weather bus.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1477\">IBPSA, #1477</a>.
</li>
<li>
December 17, 2017, by Michael Wetter:<br/>
Revised computation of heat loss.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/1100\">
issue 1100</a>.
</li>
<li>
November 21, 2017, by Michael Wetter:<br/>
Corrected error in heat loss calculations that did not scale correctly with <code>nPanels</code>.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/1073\">issue 1073</a>.
</li>
<li>
January 4, 2013, by Peter Grant:<br/>
First implementation.
</li>
</ul>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}),
        graphics={
          Rectangle(
            extent={{-84,100},{84,-100}},
            lineColor={27,0,55},
            fillColor={26,0,55},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-100,0},{-76,0},{-76,-90},{66,-90},{66,-60},{-64,-60},{-64,
                -30},{66,-30},{66,0},{-64,0},{-64,28},{66,28},{66,60},{-64,60},{
                -64,86},{78,86},{78,0},{98,0},{100,0}},
            color={0,128,255},
            thickness=1,
            smooth=Smooth.None),
          Ellipse(
            extent={{-24,26},{28,-26}},
            lineColor={255,255,0},
            fillColor={255,255,0},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-6,-6},{8,8}},
            color={255,255,0},
            smooth=Smooth.None,
            thickness=1,
            origin={-24,30},
            rotation=90),
          Line(
            points={{-50,0},{-30,0}},
            color={255,255,0},
            smooth=Smooth.None,
            thickness=1),
          Line(
            points={{-36,-40},{-20,-24}},
            color={255,255,0},
            smooth=Smooth.None,
            thickness=1),
          Line(
            points={{-10,0},{10,0}},
            color={255,255,0},
            smooth=Smooth.None,
            thickness=1,
            origin={2,-40},
            rotation=90),
          Line(
            points={{-8,-8},{6,6}},
            color={255,255,0},
            smooth=Smooth.None,
            thickness=1,
            origin={30,-30},
            rotation=90),
          Line(
            points={{32,0},{52,0}},
            color={255,255,0},
            smooth=Smooth.None,
            thickness=1),
          Line(
            points={{-8,-8},{6,6}},
            color={255,255,0},
            smooth=Smooth.None,
            thickness=1,
            origin={28,32},
            rotation=180),
          Line(
            points={{-10,0},{10,0}},
            color={255,255,0},
            smooth=Smooth.None,
            thickness=1,
            origin={0,40},
            rotation=90)}));
  end EN12975_QuasiDynamic;

  model EN12975HeatLoss_QuasiDynamic
    extends Modelica.Blocks.Icons.Block;

    replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
      "Medium in the system";
    parameter Integer nSeg = 3 "Number of segments";

    parameter Real a1(final unit="W/(m2.K)", final min=0)
      "Linear heat loss coefficient";
    parameter Real a2(final unit="W/(m2.K2)", final min=0)
      "Quadratic heat loss coefficient";
    parameter Real c3(final unit="J/(m3.K)", final min=0)
      "Windspeed dependence of heat losses";
    parameter Real c4(final unit="", final min=0)
      "Sky temperature dependence of the heat-loss coefficient";
    parameter Real c6(final unit="s/m", final min=0)
      "Windspeed dependence of zero-loss efficiency";
    parameter Real A_c(final unit="m2", final min=0)
      "Collector gross area";

    Modelica.Blocks.Interfaces.RealOutput QLos_flow[nSeg]
      "Limited heat loss rate at current conditions"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));

    Modelica.Blocks.Interfaces.RealInput G
      "Global solar irradiance [W/m2]"
      annotation (Placement(transformation(extent={{-140,-34},{-100,6}})));

    Modelica.Blocks.Interfaces.RealInput TFlu[nSeg]
      "Temperature of the heat transfer fluid [K]"
      annotation (Placement(transformation(extent={{-140,-64},{-100,-24}})));

    IDEAS.BoundaryConditions.WeatherData.Bus WeaBus
      "Bus with weather data"
      annotation (Placement(transformation(extent={{-114,62},{-94,82}})));

    IDEAS.Fluid.PvtCollectors.BaseClasses.PartialEN12975HeatLoss_QuasiDynamic partialLoss(
      redeclare package Medium = IDEAS.Media.Water,
      nSeg = nSeg,
      a1 = a1,
      a2 = a2,
      c3 = c3,
      c4 = c4,
      c6 = c6,
      A_c = A_c)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  equation
    connect(TFlu, partialLoss.TFlu);
    connect(G, partialLoss.G);
    connect(partialLoss.TEnv, WeaBus.TDryBul);
    connect(partialLoss.E_L, WeaBus.HHorIR);
    connect(partialLoss.u, WeaBus.winSpe);
    connect(partialLoss.QLos_flow, QLos_flow);

    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
  end EN12975HeatLoss_QuasiDynamic;
annotation (preferredView="info", Documentation(info="<html>
  <p>
    This package contains base classes that are used to construct the models in
    <a href=\"modelica://IDEAS.Fluid.SolarCollectors\">IDEAS.Fluid.SolarCollectors</a>.
   </p>
</html>"));
end BaseClasses;
