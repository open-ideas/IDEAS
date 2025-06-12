within IDEAS.Fluid.PvtCollectors;
package BaseClasses "Package with base classes for IDEAS.Fluid.SolarCollectors"
extends Modelica.Icons.BasesPackage;










  block ASHRAEHeatLoss
    "Calculate the heat loss of a solar collector per ASHRAE standard 93"
    extends IDEAS.Fluid.SolarCollectors.BaseClasses.PartialHeatLoss(
      QLos_internal = -slope * A_c/nSeg * {dT[i] for i in 1:nSeg});

    parameter Modelica.Units.SI.CoefficientOfHeatTransfer slope(final max=0)
      "Slope from ratings data";

  annotation (
  defaultComponentName="heaLos",
  Documentation(info="<html>
<p>
This component computes the heat loss from the solar thermal collector to the
environment.
It is designed for use with ratings data collected in accordance with
ASHRAE Standard 93.
A negative heat loss indicates that heat is being lost to the environment.
</p>

<h4> Model description </h4>
<p>
This model calculates the heat loss to the ambient, for each segment
<i>i &isin; {1, ..., n<sub>seg</sub>}</i> where <i>n<sub>seg</sub></i> is
the number of segments, as
</p>
<p align=\"center\" style=\"font-style:italic;\">
Q<sub>los,i</sub> = -slope A<sub>c</sub> &frasl; n<sub>seg</sub>
  (T<sub>env</sub>-T<sub>flu,i</sub>)
</p>
<p>
where
<i>slope &lt; 0</i> is the slope for the heat loss as specified in the ratings
data, <i>A<sub>c</sub></i> is the collector area, <i>T<sub>env</sub></i> is
the environment temperature, and <i>T<sub>flu,i</sub></i> is the
fluid temperature in segment <i>i &isin; {1, ..., n<sub>seg</sub>}</i>.
</p>
<p>
This model reduces the heat loss rate to <i>0</i> when the fluid temperature
is within <i>1</i> Kelvin of the minimum temperature of the medium model.
The calculation is performed using the
<a href=\"modelica://IDEAS.Utilities.Math.Functions.smoothHeaviside\">
IDEAS.Utilities.Math.Functions.smoothHeaviside</a> function.
</p>

<h4>Implementation</h4>
<p>
ASHRAE uses the collector fluid inlet temperature to compute the heat loss
(see Duffie and Beckmann, p. 293).
However, unless the environment temperature which was present during the
collector rating is known, which is not the case, one cannot compute a
log mean temperature difference that would improve the <i>UA</i> calculation.
Hence, this model is using the fluid temperature of each segment
to compute the heat loss to the environment.
</p>

<h4>References</h4>
<p>
ASHRAE 93-2010 -- Methods of Testing to Determine the Thermal Performance of Solar
Collectors (ANSI approved).
</p>
<p>
J.A. Duffie and W.A. Beckman 2006, Solar Engineering of Thermal Processes (3rd Edition),
John Wiley &amp; Sons, Inc.
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
December 17, 2017, by Michael Wetter:<br/>
Revised computation of heat loss.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/1100\">
issue 1100</a>.
</li>
<li>
Jan 16, 2012, by Peter Grant:<br/>
First implementation
</li>
</ul>
</html>"));
  end ASHRAEHeatLoss;

  block ASHRAESolarGain
    "Calculate the solar heat gain of a solar collector per ASHRAE Standard 93"
    extends Modelica.Blocks.Icons.Block;
    extends SolarCollectors.BaseClasses.PartialParameters;

    replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
      "Medium in the system";

    parameter Real y_intercept(final unit="1") "y intercept(maximum efficiency)";
    parameter Modelica.Units.SI.Angle[:] incAngDat "Incidence angle modifier spline derivative coefficients";
    parameter Real[size(incAngDat,1)] incAngModDat(
      each final unit="1") "Incidence angle modifier spline derivative coefficients";
    parameter Boolean use_shaCoe_in = false "Enable input connector for shaCoe"
      annotation(Dialog(group="Shading"));

    parameter Real shaCoe(
      min=0.0,
      max=1.0) = 0 "Shading coefficient 0.0: no shading, 1.0: full shading"
      annotation(Dialog(enable = not use_shaCoe_in, group = "Shading"));

    parameter Modelica.Units.SI.Angle til "Surface tilt";

    Modelica.Blocks.Interfaces.RealInput shaCoe_in if use_shaCoe_in
      "Shading coefficient"
      annotation(Placement(transformation(extent={{-140,-70},{-100,-30}})));
     Modelica.Blocks.Interfaces.RealInput TFlu[nSeg](
     each unit = "K",
     each displayUnit="degC",
     each quantity="ThermodynamicTemperature")
     annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
     Modelica.Blocks.Interfaces.RealInput HSkyDifTil(
       unit="W/m2", quantity="RadiantEnergyFluenceRate")
      "Diffuse solar irradiation on a tilted surfce from the sky"
       annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
    Modelica.Blocks.Interfaces.RealInput HGroDifTil(
      unit="W/m2", quantity="RadiantEnergyFluenceRate")
      "Diffuse solar irradiation on a tilted surfce from the ground"
      annotation (Placement(transformation(extent={{-140,30},{-100,70}})));
    Modelica.Blocks.Interfaces.RealInput incAng(
      quantity="Angle",
      unit="rad",
      displayUnit="deg") "Incidence angle of the sun beam on a tilted surface"
      annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
    Modelica.Blocks.Interfaces.RealInput HDirTil(
      unit="W/m2", quantity="RadiantEnergyFluenceRate")
      "Direct solar irradiation on a tilted surfce"
      annotation (Placement(transformation(extent={{-140,0},{-100,40}})));
    Modelica.Blocks.Interfaces.RealOutput QSol_flow[nSeg](each final unit="W")
      "Solar heat gain"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  protected
    constant Modelica.Units.SI.TemperatureDifference dTMax=1
      "Safety temperature difference to prevent TFlu > Medium.T_max";
    final parameter Modelica.Units.SI.Temperature TMedMax=Medium.T_max - dTMax
      "Fluid temperature above which there will be no heat gain computed to prevent TFlu > Medium.T_max";
    final parameter Modelica.Units.SI.Temperature TMedMax2=TMedMax - dTMax
      "Fluid temperature above which there will be no heat gain computed to prevent TFlu > Medium.T_max";

    final parameter Real iamSky(fixed=false)
      "Incident angle modifier for diffuse solar radiation from the sky";
    final parameter Real iamGro(fixed=false)
      "Incident angle modifier for diffuse solar radiation from the ground";
    final parameter Modelica.Units.SI.Angle incAngSky(fixed=false)
      "Incident angle of diffuse radiation from the sky";
    final parameter Modelica.Units.SI.Angle incAngGro(fixed=false)
      "Incident angle of diffuse radiation from the ground";
    final parameter Real tilDeg(
      unit = "deg") = Modelica.Units.Conversions.to_deg(til)
      "Surface tilt angle in degrees";
    final parameter Modelica.Units.SI.HeatFlux HTotMin=1
      "Minimum HTot to avoid div/0";
    final parameter Real HMinDel = 0.001
      "Delta of the smoothing function for HTot";

    Real iamBea "Incident angle modifier for direct solar radiation";
    Real iam "Weighted incident angle modifier";

    Modelica.Blocks.Interfaces.RealInput shaCoe_internal
      "Internally used shading coefficient";

    parameter Real[size(incAngDat, 1)] dMonotone(each fixed=false) "Derivatives";

  initial algorithm
    dMonotone := IDEAS.Utilities.Math.Functions.splineDerivatives(
      x=incAngDat,
      y=incAngModDat,
      ensureMonotonicity=false);

  initial equation
    // EnergyPlus 23.2.0 Engineering Reference Eq 18.300
    incAngSky =Modelica.Units.Conversions.from_deg(59.68 - 0.1388*(tilDeg) +
      0.001497*(tilDeg)^2);
    // Diffuse radiation from the sky
    // EnergyPlus 23.2.0 Engineering Reference Eq 18.298
    iamSky = SolarCollectors.BaseClasses.IAM(incAngSky, incAngDat, incAngModDat, dMonotone);
    // EnergyPlus 23.2.0 Engineering Reference Eq 18.301
    incAngGro =Modelica.Units.Conversions.from_deg(90 - 0.5788*(tilDeg) +
      0.002693*(tilDeg)^2);
    // Diffuse radiation from the ground
    // EnergyPlus 23.2.0 Engineering Reference Eq 18.298
    iamGro = SolarCollectors.BaseClasses.IAM(incAngGro, incAngDat, incAngModDat, dMonotone);

  equation

    connect(shaCoe_internal, shaCoe_in);

    if not use_shaCoe_in then
      shaCoe_internal = shaCoe;
    end if;

    // EnergyPlus 23.2.0 Engineering Reference Eq 18.298
    iamBea = SolarCollectors.BaseClasses.IAM(incAng, incAngDat, incAngModDat, dMonotone);
    // EnergyPlus 23.2.0 Engineering Reference Eq 18.299
    iam = (HDirTil*iamBea + HSkyDifTil*iamSky + HGroDifTil*iamGro)/
        IDEAS.Utilities.Math.Functions.smoothMax((
          HDirTil + HSkyDifTil + HGroDifTil), HTotMin, HMinDel);
    // Modified from EnergyPlus 23.2.0 Engineering Reference Eq 18.302
    // by applying shade effect for direct solar radiation
    // Only solar heat gain is considered here
    for i in 1 : nSeg loop
      QSol_flow[i] = A_c/nSeg*(y_intercept*iam*
        (HDirTil*(1.0 - shaCoe_internal) + HSkyDifTil + HGroDifTil))*
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
This model uses ratings data according to ASHRAE93.
The solar heat gain is calculated using Equations 18.298-18.302 in the
referenced EnergyPlus documentation.
</p>
<p>
The solar radiation absorbed by the panel is identified using Eq 18.302 from
the EnergyPlus documentation. It is
</p>
<p align=\"center\" style=\"font-style:italic;\">
Q<sub>flow</sub>[i]=A<sub>c</sub>/nSeg (F<sub>R</sub>(&tau;&alpha;)
  K<sub>(&tau;&alpha;)<sub>net</sub></sub> (G<sub>dir</sub>
  (1-shaCoe)+G<sub>dif</sub>+G<sub>gnd</sub>))
</p>
<p>
where <i>Q<sub>flow</sub>[i]</i> is the heat gain in each segment,
<i>A<sub>c</sub></i> is the area of the collector,
<i>nSeg</i> is the user-specified number of segments in the simulation,
<i>F<sub>R</sub>(&tau;&alpha;)</i> is the maximum collector efficiency,
<i>K<sub>(&tau;&alpha;)<sub>net</sub></sub></i> is the incidence angle modifier,
<i>G<sub>dir</sub></i> is the direct solar radiation,
<i>shaCoe</i> is the user-specified shading coefficient,
<i>G<sub>sky</sub></i> is the diffuse solar radiation from the sky,
and <i>G<sub>gnd</sub></i> is the diffuse radiation from the ground.
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
The incidence angle modifier used in the solar radiation equation is found using
Eq 18.299 from the EnergyPlus documentation. It is
</p>
<p align=\"center\" style=\"font-style:italic;\">
K<sub>(&tau;&alpha;),net</sub>=(G<sub>dir</sub> K<sub>(&tau;&alpha;),dir</sub>
  +G<sub>sky</sub> K<sub>(&tau;&alpha;),sky</sub>
  +G<sub>gnd</sub> K<sub>(&tau;&alpha;),gnd</sub>)
  /(G<sub>dir</sub>+G<sub>sky</sub>+G<sub>gnd</sub>)
</p>
<p>
where <i>K<sub>(&tau;&alpha;),net</sub></i> is the net incidence angle modified,
<i>G<sub>dir</sub></i> is the (direct) beam radiation,
<i>K<sub>(&tau;&alpha;),dir</sub></i> is the incidence angle modifier
for (direct) beam radiation,
<i>G<sub>sky</sub></i> is the diffuse radiation from the sky,
<i>K<sub>(&tau;&alpha;),sky</sub></i> is the incidence angle modifier
for radiation from the sky,
<i>G<sub>gnd</sub></i> is the diffuse radiation from the ground,
and <i>K<sub>(&tau;&alpha;),gnd</sub></i> is the incidence angle modifier
for diffuse radiation from the ground.
</p>
<p>
Each incidence angle modifier is calculated using Eq 18.298 from the EnergyPlus
documentation. It is
</p>
<p align=\"center\" style=\"font-style:italic;\">
K<sub>(&tau;&alpha;),x</sub>=1+b<sub>0</sub> (1/cos(&theta;)-1)+b<sub>1</sub>
  (1/cos(&theta;)-1)<sup>2</sup>
</p>
<p>
where x can refer to beam, sky or ground.
<i>&theta;</i> is the incidence angle.
For beam radiation <i>&theta;</i> is found via standard geometry.
The incidence angle for sky and ground diffuse radiation are found using,
respectively, Eq 18.300 and 18.301 from the EnergyPlus documentation.
They are
</p>
<p align=\"center\" style=\"font-style:italic;\">
&theta;<sub>sky</sub>=59.68-0.1388 til+0.001497 til<sup>2</sup><br/>
&theta;<sub>gnd</sub>=90.0-0.5788 til+0.002693 til<sup>2</sup>
</p>
<p>
where <i>&theta;<sub>sky</sub></i> is the incidence angle
for diffuse radiation from the sky,
<i>til</i> is the tilt of the solar thermal collector,
and <i>&theta;<sub>gnd</sub></i> is the incidence angle
for diffuse radiation from the ground.
</p>
<p>
These two equations must be evaluated in degrees.
The necessary unit conversions are made internally.
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
ASHRAE 93-2010 -- Methods of Testing to Determine the Thermal Performance of Solar
Collectors (ANSI approved).
</p>
<p>
<a href=\"https://energyplus.net/assets/nrel_custom/pdfs/pdfs_v23.2.0/EngineeringReference.pdf\">
EnergyPlus 23.2.0 Engineering Reference</a>.
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
solar irradiation because temperature goes above medium
temperature bound.
</li>
<li>
November 20, 2014, by Michael Wetter:<br/>
Added missing <code>each</code> keyword.
</li>
<li>
Jan 15, 2013, by Peter Grant:<br/>
First implementation
</li>
</ul>
</html>"));
  end ASHRAESolarGain;

  block EN12975HeatLoss "Calculate the heat loss of a solar collector per EN12975"
    extends IDEAS.Fluid.SolarCollectors.BaseClasses.PartialHeatLoss(
      QLos_internal = A_c/nSeg * {dT[i] * (a1 - a2 * dT[i]) for i in 1:nSeg});

    parameter Modelica.Units.SI.CoefficientOfHeatTransfer a1(final min=0)
      "a1 from ratings data";

    parameter Real a2(final unit = "W/(m2.K2)", final min=0)
      "a2 from ratings data";

  annotation (
  defaultComponentName="heaLos",
  Documentation(info="<html>
<p>
This component computes the heat loss from the solar thermal collector
to the environment. It is designed anticipating ratings data collected in
accordance with EN12975. A negative heat loss indicates that heat
is being lost to the environment.
</p>
<p>
This model calculates the heat loss to the ambient, for each
segment <i>i &isin; {1, ..., n<sub>seg</sub>}</i>
where <i>n<sub>seg</sub></i> is the number of segments, as
</p>
<p align=\"center\" style=\"font-style:italic;\">
Q<sub>los,i</sub> = A<sub>c</sub> &frasl; n<sub>seg</sub>
(T<sub>env</sub>-T<sub>flu,i</sub>) (a<sub>1</sub> - a<sub>2</sub>
  (T<sub>env</sub>-T<sub>flu,i</sub>))
</p>
<p>
where
<i>a<sub>1</sub> &gt; 0</i> is the heat loss coefficient
from EN12975 ratings data,
<i>a<sub>2</sub> &ge; 0</i> is the temperature dependence of heat loss
from EN12975 ratings data,
<i>A<sub>c</sub></i> is the collector area,
<i>T<sub>env</sub></i> is the environment temperature and
<i>T<sub>flu,i</sub></i> is the fluid temperature in segment
<i>i &isin; {1, ..., n<sub>seg</sub>}</i>.
</p>
<p>
This model reduces the heat loss rate to <i>0</i> when the fluid temperature is within
<i>1</i> Kelvin of the minimum temperature of the medium model. The calculation is
performed using the
<a href=\"modelica://IDEAS.Utilities.Math.Functions.smoothHeaviside\">
IDEAS.Utilities.Math.Functions.smoothHeaviside</a> function.
</p>
<h4>Implementation</h4>
<p>
EN 12975 uses the arithmetic average temperature of the collector fluid inlet
and outlet temperature to compute the heat loss (see Duffie and Beckmann, p. 293).
However, unless the environment temperature that was present during the collector rating
is known, which is not the case, one cannot compute
a log mean temperature difference that would improve the <i>UA</i> calculation. Hence,
this model is using the fluid temperature of each segment
to compute the heat loss to the environment.
If the arithmetic average temperature were used, then segments at the collector
outlet could be cooled below the ambient temperature, which violates the 2nd law
of Thermodynamics.
</p>

<h4>References</h4>
<p>
CEN 2006, European Standard 12975-1:2006, European Committee for Standardization
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
December 17, 2017, by Michael Wetter:<br/>
Revised computation of heat loss.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/1100\">
issue 1100</a>.
</li>
<li>
Jan 16, 2012, by Peter Grant:<br/>
First implementation
</li>
</ul>
</html>"));
  end EN12975HeatLoss;

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

  function IAM "Function for incident angle modifier"
    extends Modelica.Icons.Function;

    input Modelica.Units.SI.Angle incAng "Incident angle";
    input Modelica.Units.SI.Angle[:] incAngDat "Incident angle data";
    input Real[size(incAngDat,1)] incAngModDat(
      each final min=0,
      each final max=1,
      each final unit="1") "Incident angle modifier data";
    input Real[size(incAngDat,1)] dMonotone "Incident angle modifier spline derivatives";
    output Real incAngMod "Incident angle modifier coefficient";
  protected
    Integer i "Counter to pick the interpolation interval";
    constant Real delta = 0.0001 "Width of the smoothing function";

  algorithm
    i := 1;
    for j in 1:size(incAngDat, 1) - 1 loop
      if incAng > incAngDat[j] then
        i := j;
      end if;
    end for;
    // Extrapolate or interpolate the data and sets its value to 0 if
    // the incident angle modifier becomes negative.
    incAngMod := IDEAS.Utilities.Math.Functions.smoothMax(
      x1 = IDEAS.Utilities.Math.Functions.cubicHermiteLinearExtrapolation(
        x=incAng,
        x1=incAngDat[i],
        x2=incAngDat[i + 1],
        y1=incAngModDat[i],
        y2=incAngModDat[i + 1],
        y1d=dMonotone[i],
        y2d=dMonotone[i + 1]),
      x2 = 0,
      deltaX = delta);

    annotation (
    smoothOrder=1,
      Documentation(info="<html>
<h4>Overview</h4>
<p>
This function computes the incidence angle modifier for solar irradiation
striking the surface of the solar thermal collector.
It is calculated using cubic spline interpolation and
measurement data for the incident angle modifier provided in data sheets.
</p>

<h4>References</h4>
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
May 31, 2017, by Michael Wetter and Filip Jorissen:<br/>
Change limits for incident angle modifier to avoid dip in temperature
at shallow incidence angles.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/785\">issue 785</a>.
</li>
<li>
November 20, 2014, by Michael Wetter:<br/>
Added missing <code>protected</code> keyword.
</li>
<li>
May 22, 2012, by Wangda Zuo:<br/>
First implementation.
</li>
</ul>
</html>"));
  end IAM;

  block PartialHeatLoss
    "Partial heat loss model on which ASHRAEHeatLoss and EN12975HeatLoss are based"
    extends Modelica.Blocks.Icons.Block;
    extends SolarCollectors.BaseClasses.PartialParameters;

    replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
      "Medium in the component";

    Modelica.Blocks.Interfaces.RealInput TEnv(
      quantity="ThermodynamicTemperature",
      unit="K",
      displayUnit="degC") "Temperature of surrounding environment"
      annotation (Placement(transformation(extent={{-140,40},{-100,80}})));

    Modelica.Blocks.Interfaces.RealInput TFlu[nSeg](
      each quantity="ThermodynamicTemperature",
      each unit = "K",
      each displayUnit="degC") "Temperature of the heat transfer fluid"
      annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
    Modelica.Blocks.Interfaces.RealOutput QLos_flow[nSeg](
      each quantity="HeatFlowRate",
      each unit="W",
      each displayUnit="W") = {QLos_internal[i]*smooth(1, if TFlu[i] > TMedMin2
       then 1 else IDEAS.Utilities.Math.Functions.smoothHeaviside(TFlu[i] -
      TMedMin, dTMin)) for i in 1:nSeg}
      "Limited heat loss rate at current conditions"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  protected
    constant Modelica.Units.SI.Temperature dTMin=1
      "Safety temperature difference to prevent TFlu < Medium.T_min";
    final parameter Modelica.Units.SI.Temperature TMedMin=Medium.T_min + dTMin
      "Fluid temperature below which there will be no heat loss computed to prevent TFlu < Medium.T_min";
    final parameter Modelica.Units.SI.Temperature TMedMin2=TMedMin + dTMin
      "Fluid temperature below which there will be no heat loss computed to prevent TFlu < Medium.T_min";

    input Modelica.Units.SI.HeatFlowRate QLos_internal[nSeg]
      "Heat loss rate at current conditions for each segment";

    Modelica.Units.SI.TemperatureDifference dT[nSeg]={TEnv - TFlu[i] for i in 1:
        nSeg} "Environment minus collector fluid temperature";

    annotation (
  defaultComponentName="heaLos",
  Documentation(info="<html>
<p>
This component is a partial model used as the base for
<a href=\"modelica://IDEAS.Fluid.SolarCollectors.BaseClasses.ASHRAEHeatLoss\">
IDEAS.Fluid.SolarCollectors.BaseClasses.ASHRAEHeatLoss</a> and
<a href=\"modelica://IDEAS.Fluid.SolarCollectors.BaseClasses.EN12975HeatLoss\">
IDEAS.Fluid.SolarCollectors.BaseClasses.EN12975HeatLoss</a>. It contains the
input, output and parameter declarations which are common to both models. More
detailed information is available in the documentation of the extending classes.
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
December 17, 2017, by Michael Wetter:<br/>
Revised computation of heat loss.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/1100\">
issue 1100</a>.
</li>
<li>
June 29, 2015, by Michael Wetter:<br/>
Revised implementation of heat loss near <code>Medium.T_min</code>
to make it more efficient.
</li>
<li>
November 20, 2014, by Michael Wetter:<br/>
Added missing <code>each</code> keyword.
</li>
<li>
Apr 17, 2013, by Peter Grant:<br/>
First implementation
</li>
</ul>
</html>"));
  end PartialHeatLoss;

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

  partial model PartialSolarCollector "Partial model for solar collectors"
   extends IDEAS.Fluid.Interfaces.LumpedVolumeDeclarations;
    extends IDEAS.Fluid.Interfaces.TwoPortFlowResistanceParameters(
      final dp_nominal = dp_nominal_final,
      final computeFlowResistance=(abs(dp_nominal) > Modelica.Constants.eps));
    extends IDEAS.Fluid.Interfaces.PartialTwoPortInterface(
      final m_flow_nominal=m_flow_nominal_final);

    constant Boolean homotopyInitialization = true "= true, use homotopy method"
      annotation(HideResult=true);

    parameter Integer nSeg = 3
      "Number of segments used to discretize the collector model";

    parameter Modelica.Units.SI.Angle azi(displayUnit="deg")
      "Surface azimuth (0 for south-facing; -90 degree for east-facing; +90 degree for west facing";
    parameter Modelica.Units.SI.Angle til(displayUnit="deg")
      "Surface tilt (0 for horizontally mounted collector)";
    parameter Real rho(
      final min=0,
      final max=1,
      final unit = "1") "Ground reflectance";

    parameter Modelica.Units.SI.HeatCapacity CTot=
      if per.CTyp==IDEAS.Fluid.SolarCollectors.Types.HeatCapacity.TotalCapacity then
        per.C
      elseif per.CTyp==IDEAS.Fluid.SolarCollectors.Types.HeatCapacity.DryCapacity then
        per.C+rho_default*per.V*cp_default
      else
        385*per.mDry+rho_default*per.V*cp_default
      "Heat capacity of solar collector with fluid";

    parameter Boolean use_shaCoe_in = false
      "Enables an input connector for shaCoe"
      annotation(Dialog(group="Shading"));
    parameter Real shaCoe(
      min=0.0,
      max=1.0) = 0 "Shading coefficient. 0.0: no shading, 1.0: full shading"
      annotation(Dialog(enable = not use_shaCoe_in, group = "Shading"));

    parameter IDEAS.Fluid.SolarCollectors.Types.NumberSelection nColType=
    IDEAS.Fluid.SolarCollectors.Types.NumberSelection.Number
      "Selection of area specification format"
      annotation(Dialog(group="Area declarations"));
    parameter Integer nPanels= 0 "Desired number of panels in the simulation"
      annotation(Dialog(group="Area declarations", enable= (nColType == IDEAS.Fluid.SolarCollectors.Types.NumberSelection.Number)));

    parameter Modelica.Units.SI.Area totalArea=0
      "Total area of panels in the simulation" annotation (Dialog(group=
            "Area declarations", enable=(nColType == IDEAS.Fluid.SolarCollectors.Types.NumberSelection.Area)));

    parameter IDEAS.Fluid.SolarCollectors.Types.SystemConfiguration sysConfig=
    IDEAS.Fluid.SolarCollectors.Types.SystemConfiguration.Series
      "Selection of system configuration"
      annotation(Dialog(group="Configuration declarations"));
    parameter Integer nPanelsSer=0 "Number of array panels in series"
      annotation(Dialog(group="Configuration declarations", enable= (sysConfig == IDEAS.Fluid.SolarCollectors.Types.SystemConfiguration.Array)));
    parameter Integer nPanelsPar=0 "Number of array panels in parallel"
      annotation(Dialog(group="Configuration declarations", enable= (sysConfig == IDEAS.Fluid.SolarCollectors.Types.SystemConfiguration.Array)));

    Modelica.Blocks.Interfaces.RealInput shaCoe_in if use_shaCoe_in
      "Shading coefficient"
      annotation(Placement(transformation(extent={{-140,60},{-100,20}})));

    IDEAS.BoundaryConditions.WeatherData.Bus weaBus "Weather data bus"
      annotation (Placement(
      transformation(extent={{-110,70},{-90,90}})));
    IDEAS.BoundaryConditions.SolarIrradiation.DiffusePerez HDifTilIso(
      final outSkyCon=true,
      final outGroCon=true,
      final til=til,
      final azi=azi,
      final rho=rho) "Diffuse solar irradiation on a tilted surface"
      annotation (Placement(transformation(extent={{-80,70},{-60,90}})));

    IDEAS.BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTil(
      final til=til,
      final azi=azi) "Direct solar irradiation on a tilted surface"
      annotation (Placement(transformation(extent={{-80,40},{-60,60}})));

    IDEAS.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
      Medium, allowFlowReversal=allowFlowReversal) "Mass flow rate sensor"
      annotation (Placement(transformation(extent={{-90,-11},{-70,11}})));
    IDEAS.Fluid.FixedResistances.PressureDrop res(
      redeclare final package Medium = Medium,
      final from_dp=from_dp,
      final show_T=show_T,
      final m_flow_nominal=m_flow_nominal,
      final allowFlowReversal=allowFlowReversal,
      final linearized=linearizeFlowResistance,
      final homotopyInitialization=homotopyInitialization,
      deltaM=deltaM,
      final dp_nominal=dp_nominal_final) "Flow resistance"
      annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));

    // The size of the liquid volume has been increased to also add
    // the heat capacity of the metal.
    IDEAS.Fluid.MixingVolumes.MixingVolume vol[nSeg](
      each nPorts=2,
      redeclare package Medium = Medium,
      each final m_flow_nominal=m_flow_nominal,
      each final energyDynamics=energyDynamics,
      each final p_start=p_start,
      each final T_start=T_start,
      each final m_flow_small=m_flow_small,
      each final V=CTot/cp_default/rho_default*nPanels_internal/nSeg,
      each final massDynamics=massDynamics,
      each final X_start=X_start,
      each final C_start=C_start,
      each final C_nominal=C_nominal,
      each final mSenFac=mSenFac,
      each final allowFlowReversal=allowFlowReversal,
      each final prescribedHeatFlowRate=false)
      "Volume of fluid in one segment of the solar collector"
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={50,-20})));

    Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temSen[nSeg]
      "Temperature sensor"
      annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={0,-20})));

    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow QGai[nSeg]
      "Rate of solar heat gain"
      annotation (Placement(transformation(extent={{50,40},{70,60}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow QLos[nSeg]
      "Rate of heat loss"
      annotation (Placement(transformation(extent={{50,10},{70,30}})));
    replaceable parameter IDEAS.Fluid.SolarCollectors.Data.GenericASHRAE93 per
      constrainedby IDEAS.Fluid.SolarCollectors.Data.BaseClasses.Generic
      "Performance data"
      annotation(Placement(transformation(extent={{60,-80},{80,-60}})),choicesAllMatching=true);

  protected
    Modelica.Blocks.Interfaces.RealInput shaCoe_internal
      "Internally used shading coefficient";

    final parameter Modelica.Units.SI.MassFlowRate m_flow_nominal_final(
        displayUnit="kg/s") = nPanelsPar_internal*per.mperA_flow_nominal*per.A
      "Nominal mass flow rate through the system of collectors";

    final parameter Modelica.Units.SI.PressureDifference dp_nominal_final(
        displayUnit="Pa") = nPanelsSer_internal*per.dp_nominal
      "Nominal pressure loss across the system of collectors";

    parameter Modelica.Units.SI.Area ATot_internal=nPanels_internal*per.A
      "Area used in the simulation";

    parameter Real nPanels_internal=
      if nColType == IDEAS.Fluid.SolarCollectors.Types.NumberSelection.Number then
        nPanels
      else
        totalArea/per.A "Number of panels used in the simulation";
    parameter Real nPanelsSer_internal=
      if sysConfig == IDEAS.Fluid.SolarCollectors.Types.SystemConfiguration.Series then
        nPanels
      else if sysConfig == IDEAS.Fluid.SolarCollectors.Types.SystemConfiguration.Parallel then
        1
      else
        nPanelsSer "Number of panels in series";
    parameter Real nPanelsPar_internal=
      if sysConfig == IDEAS.Fluid.SolarCollectors.Types.SystemConfiguration.Parallel then
        nPanels
      else if sysConfig == IDEAS.Fluid.SolarCollectors.Types.SystemConfiguration.Series then
        1
      else
        nPanelsPar "Number of panels in parallel";

    parameter Medium.ThermodynamicState sta_default = Medium.setState_pTX(
      T=Medium.T_default,
      p=Medium.p_default,
      X=Medium.X_default[1:Medium.nXi]) "Medium state at default properties";
    parameter Modelica.Units.SI.SpecificHeatCapacity cp_default=
        Medium.specificHeatCapacityCp(sta_default)
      "Specific heat capacity of the fluid";
    parameter Modelica.Units.SI.Density rho_default=Medium.density(sta_default)
      "Density, used to compute fluid mass";

  initial equation
    assert(homotopyInitialization, "In " + getInstanceName() +
      ": The constant homotopyInitialization has been modified from its default value. This constant will be removed in future releases.",
      level = AssertionLevel.warning);

    if sysConfig==IDEAS.Fluid.SolarCollectors.Types.SystemConfiguration.Array then
      assert(abs(nPanelsPar_internal*nPanelsSer_internal-nPanels_internal) < 1E-6,
        "In " + getInstanceName() +
        ": The product of the number of panels in series and parallel is not equal to the total number of panels in the array.",
        level = AssertionLevel.error);
    end if;

  equation
    connect(shaCoe_internal,shaCoe_in);

    if not use_shaCoe_in then
      shaCoe_internal=shaCoe;
    end if;

    connect(weaBus, HDifTilIso.weaBus) annotation (Line(
        points={{-100,80},{-80,80}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(weaBus, HDirTil.weaBus) annotation (Line(
        points={{-100,80},{-90,80},{-90,50},{-80,50}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(port_a, senMasFlo.port_a) annotation (Line(
        points={{-100,0},{-90,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(senMasFlo.port_b, res.port_a) annotation (Line(
        points={{-70,0},{-60,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(vol[nSeg].ports[2], port_b) annotation (Line(
        points={{51,-10},{51,0},{100,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(vol[1].ports[1], res.port_b) annotation (Line(
        points={{49,-10},{49,0},{-40,0}},
        color={0,127,255},
        smooth=Smooth.None));
        for i in 1:(nSeg - 1) loop
      connect(vol[i].ports[2], vol[i + 1].ports[1]);
    end for;
    connect(vol.heatPort, temSen.port)            annotation (Line(
        points={{40,-20},{10,-20}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(QGai.port, vol.heatPort) annotation (Line(
        points={{70,50},{90,50},{90,-40},{30,-40},{30,-20},{40,-20}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(QLos.port, vol.heatPort) annotation (Line(
        points={{70,20},{90,20},{90,-40},{30,-40},{30,-20},{40,-20}},
        color={191,0,0},
        smooth=Smooth.None));
    annotation (
      defaultComponentName="solCol",
      Documentation(info="<html>
<p>
This component is a partial model of a solar thermal collector.
It can be expanded to create solar collector models based on either ASHRAE93 or
EN12975 ratings data.
</p>

<h4>References</h4>
<p>
<a href=\"https://energyplus.net/assets/nrel_custom/pdfs/pdfs_v23.2.0/EngineeringReference.pdf\">
EnergyPlus 23.2.0 Engineering Reference</a>
</p>
</html>",   revisions="<html>
<ul>
<li>
February 27, 2024, by Jelger Jansen:<br/>
Refactor model.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/3604\">Buildings, #3604</a>.
</li>
<li>
December 11, 2023, by Michael Wetter:<br/>
Corrected implementation of pressure drop calculation for the situation where the collectors are in parallel,
e.g., if <code>sysConfig == IDEAS.Fluid.SolarCollectors.Types.SystemConfiguration.Parallel</code>.<br/>
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
April 14, 2020, by Michael Wetter:<br/>
Changed <code>homotopyInitialization</code> to a constant.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1341\">IBPSA, #1341</a>.
</li>
<li>
November 12, 2019, by Filip Jorissen:<br/>
Set <code>prescribedHeatFlowRate=false</code>
to avoid a division by zero at zero flow when using SteadyState dynamics.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/1636\">Buildings, issue 1636</a>.
</li>
<li>
April 27, 2018, by Michael Wetter:<br/>
Corrected <code>displayUnit</code>.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/912\">Buildings, issue 912</a>.
</li>
<li>
January 22, 2016, by Michael Wetter:<br/>
Corrected type declaration of pressure difference.
This is
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/404\">#404</a>.
</li>
<li>
February 8, 2015, by Filip Jorissen:<br/>
Propagated multiple parameters from <code>LumpedVolumeDeclarations</code>,
set <code>prescribedHeatFlowRate = true</code> in <code>vol</code>.
</li>
<li>
September 18, 2014, by Michael Wetter:<br/>
Removed the separate instance of
<code>Modelica.Thermal.HeatTransfer.Components.HeatCapacitor</code> and
added this capacity to the volume.
This is in response to
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/276\">
https://github.com/lbl-srg/modelica-buildings/issues/276</a>.
</li>
<li>
June 25, 2014, by Michael Wetter:<br/>
Improved comments for tilt to address
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/246\">
https://github.com/lbl-srg/modelica-buildings/issues/246</a>.
</li>
<li>
October 8, 2013, by Michael Wetter:<br/>
Removed parameter <code>show_V_flow</code> in declaration of instance <code>res</code>.
</li>
<li>
January 4, 2013, by Peter Grant:<br/>
First implementation.
</li>
</ul>
</html>"));
  end PartialSolarCollector;

  package Examples "Collection of models that illustrate model use and test models"
  extends Modelica.Icons.ExamplesPackage;


    model ASHRAEHeatLoss "Example showing the use of ASHRAEHeatLoss"
      extends Modelica.Icons.Example;
      parameter IDEAS.Fluid.SolarCollectors.Data.GenericASHRAE93 per=
        IDEAS.Fluid.SolarCollectors.Data.GlazedFlatPlate.FP_SolahartKf()
        "Performance data"
        annotation (choicesAllMatching=true);
      Modelica.Blocks.Sources.Sine TEnv(
        f=0.01,
        offset=273.15 + 10,
        amplitude=7.5) "Temperature of the surrounding environment"
        annotation (Placement(transformation(extent={{30,70},{50,90}})));
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
      IDEAS.Fluid.SolarCollectors.BaseClasses.ASHRAEHeatLoss  heaLos(
        nSeg=3,
        redeclare package Medium = IDEAS.Media.Water,
        A_c=per.A,
        slope=per.slope) "Heat loss model using EN12975 calculations"
        annotation (Placement(transformation(extent={{70,-10},{90,10}})));
    equation
      connect(TEnv.y, heaLos.TEnv) annotation (Line(
          points={{51,80},{60,80},{60,6},{68,6}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(T3.y, heaLos.TFlu[3]) annotation (Line(
          points={{-29,-40},{-20,-40},{-20,-6},{68,-6},{68,-5.33333}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(T2.y, heaLos.TFlu[2]) annotation (Line(
          points={{11,-60},{20,-60},{20,-6},{68,-6}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(T1.y, heaLos.TFlu[1]) annotation (Line(
          points={{51,-80},{60,-80},{60,-6.66667},{68,-6.66667}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (
        Documentation(info="<html>
<p>
This examples demonstrates the implementation of
<a href=\"modelica://IDEAS.Fluid.SolarCollectors.BaseClasses.ASHRAEHeatLoss\">
IDEAS.Fluid.SolarCollectors.BaseClasses.ASHRAEHeatLoss</a>.
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
</ul>
  </html>"),
        __Dymola_Commands(file=
              "modelica://IDEAS/Resources/Scripts/Dymola/Fluid/SolarCollectors/BaseClasses/Examples/ASHRAEHeatLoss.mos"
            "Simulate and plot"),
            experiment(Tolerance=1e-6, StopTime=100));
    end ASHRAEHeatLoss;

    model ASHRAESolarGain "Example showing the use of ASHRAESolarGain"
      extends Modelica.Icons.Example;
      parameter IDEAS.Fluid.SolarCollectors.Data.GenericASHRAE93 per=
        IDEAS.Fluid.SolarCollectors.Data.GlazedFlatPlate.FP_ThermaLiteHS20()
        "Performance data"
        annotation (choicesAllMatching=true);
      IDEAS.Fluid.SolarCollectors.BaseClasses.ASHRAESolarGain solGai(
        nSeg=3,
        incAngDat=per.incAngDat,
        incAngModDat=per.incAngModDat,
        shaCoe=0,
        use_shaCoe_in=true,
        A_c=per.A,
        y_intercept=per.y_intercept,
        redeclare package Medium = IDEAS.Media.Water,
        til=0.78539816339745) "Solar heat gain model using ASHRAE 93 calculations"
        annotation (Placement(transformation(extent={{70,-10},{90,10}})));
      Modelica.Blocks.Sources.Sine HGroDifTil(
        amplitude=50,
        f=4/86400,
        offset=100) "Diffuse radiation from the ground, tilted surface"
        annotation (Placement(transformation(extent={{-10,50},{10,70}})));
      Modelica.Blocks.Sources.Ramp incAng(duration=86400, height=60*(2*Modelica.Constants.pi
            /360)) "Incidence angle"
        annotation (Placement(transformation(extent={{-90,10},{-70,30}})));
      Modelica.Blocks.Sources.Sine HDirTil(
        offset=400,
        amplitude=300,
        f=2/86400) "Direct beam radiation, tilted surface"
        annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
      Modelica.Blocks.Sources.Sine HSkyDifTil(
        f=1/86400,
        amplitude=100,
        offset=100) "Diffuse radiation, tilted surface"
        annotation (Placement(transformation(extent={{30,70},{50,90}})));
      Modelica.Blocks.Sources.Ramp shaCoe(
        height=-1,
        duration=86400,
        offset=1) "Shading coefficient"
        annotation (Placement(transformation(extent={{-90,-30},{-70,-10}})));
      Modelica.Blocks.Sources.Sine T3(
        f=2/86400,
        amplitude=50,
        offset=273.15 + 110)
        annotation (Placement(transformation(extent={{-50,-50},{-30,-30}})));
      Modelica.Blocks.Sources.Sine T2(
        f=2/86400,
        amplitude=50,
        offset=273.15 + 100)
        annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
      Modelica.Blocks.Sources.Sine T1(
        f=2/86400,
        amplitude=50,
        offset=273.15 + 90)
        annotation (Placement(transformation(extent={{30,-90},{50,-70}})));
    equation
      connect(HGroDifTil.y,solGai. HGroDifTil) annotation (Line(
          points={{11,60},{20,60},{20,5},{68,5}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(shaCoe.y,solGai. shaCoe_in) annotation (Line(
          points={{-69,-20},{-60,-20},{-60,-5},{68,-5}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(incAng.y,solGai. incAng) annotation (Line(
          points={{-69,20},{-60,20},{-60,-2},{68,-2}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(HDirTil.y,solGai. HDirTil) annotation (Line(
          points={{-29,40},{-20,40},{-20,2},{68,2}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(HSkyDifTil.y,solGai. HSkyDifTil) annotation (Line(
          points={{51,80},{60,80},{60,8},{68,8}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(T3.y,solGai. TFlu[3]) annotation (Line(
          points={{-29,-40},{-20,-40},{-20,-8},{68,-8},{68,-7.33333}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(T2.y,solGai. TFlu[2]) annotation (Line(
          points={{11,-60},{20,-60},{20,-8},{68,-8}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(T1.y,solGai. TFlu[1]) annotation (Line(
          points={{51,-80},{60,-80},{60,-8.66667},{68,-8.66667}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (
        Documentation(info="<html>
<p>
This examples demonstrates the implementation of
<a href=\"modelica://IDEAS.Fluid.SolarCollectors.BaseClasses.ASHRAESolarGain\">
IDEAS.Fluid.SolarCollectors.BaseClasses.ASHRAESolarGain</a>.
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
              "modelica://IDEAS/Resources/Scripts/Dymola/Fluid/SolarCollectors/BaseClasses/Examples/ASHRAESolarGain.mos"
            "Simulate and plot"),
            experiment(Tolerance=1e-6, StopTime=86400));
    end ASHRAESolarGain;

    model EN12975HeatLoss "Example showing the use of EN12975HeatLoss"
      extends Modelica.Icons.Example;
      parameter IDEAS.Fluid.SolarCollectors.Data.GenericEN12975 per=
        IDEAS.Fluid.SolarCollectors.Data.GlazedFlatPlate.FP_VerificationModel()
        "Performance data"
        annotation (choicesAllMatching=true);
      Modelica.Blocks.Sources.Sine TEnv(
        f=0.01,
        offset=273.15 + 10,
        amplitude=15) "Temperature of the surrounding environment"
        annotation (Placement(transformation(extent={{30,70},{50,90}})));
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
      IDEAS.Fluid.SolarCollectors.BaseClasses.EN12975HeatLoss heaLos(
        nSeg=3,
        redeclare package Medium = IDEAS.Media.Water,
        a1=per.a1,
        a2=per.a2,
        A_c=per.A)       "Heat loss model using EN12975 calculations"
        annotation (Placement(transformation(extent={{70,-10},{90,10}})));
    equation
      connect(TEnv.y, heaLos.TEnv) annotation (Line(
          points={{51,80},{60,80},{60,6},{68,6}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(T3.y, heaLos.TFlu[3]) annotation (Line(
          points={{-29,-40},{-20,-40},{-20,-6},{68,-6},{68,-5.33333}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(T2.y, heaLos.TFlu[2]) annotation (Line(
          points={{11,-60},{20,-60},{20,-6},{68,-6}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(T1.y, heaLos.TFlu[1]) annotation (Line(
          points={{51,-80},{60,-80},{60,-6.66667},{68,-6.66667}},
          color={0,0,127},
          smooth=Smooth.None));
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

    model EN12975SolarGain "Example showing the use of EN12975SolarGain"
      extends Modelica.Icons.Example;
      parameter IDEAS.Fluid.SolarCollectors.Data.GenericEN12975 per=
        IDEAS.Fluid.SolarCollectors.Data.GlazedFlatPlate.FP_VerificationModel()
        "Performance data"
        annotation (choicesAllMatching=true);
      IDEAS.Fluid.SolarCollectors.BaseClasses.EN12975SolarGain solGai(
        eta0=per.eta0,
        incAngDat=per.incAngDat,
        incAngModDat=per.incAngModDat,
        nSeg=3,
        A_c=per.A,
        iamDiff=per.IAMDiff,
        shaCoe=0,
        use_shaCoe_in=true,
        redeclare package Medium = IDEAS.Media.Water)
        "Solar heat gain model using EN12975 calculations"
        annotation (Placement(transformation(extent={{70,-10},{90,10}})));
      Modelica.Blocks.Sources.Ramp incAng(duration=86400,
        height=60*(2*Modelica.Constants.pi/360)) "Incidence angle"
        annotation (Placement(transformation(extent={{-90,10},{-70,30}})));
      Modelica.Blocks.Sources.Sine HDirTil(
        offset=400,
        amplitude=300,
        f=2/86400) "Direct beam radiation, tilted surface"
        annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
      Modelica.Blocks.Sources.Sine HDifTil(
        amplitude=200,
        f=1/86400,
        offset=300) "Diffuse radiation, tilted surface"
        annotation (Placement(transformation(extent={{30,70},{50,90}})));
      Modelica.Blocks.Sources.Ramp shaCoe(
        duration=86400,
        offset=1,
        height=-1) "Shading coefficient"
        annotation (Placement(transformation(extent={{-90,-30},{-70,-10}})));
      Modelica.Blocks.Sources.Sine T3(
        f=2/86400,
        amplitude=50,
        offset=273.15 + 110)
        annotation (Placement(transformation(extent={{-50,-50},{-30,-30}})));
      Modelica.Blocks.Sources.Sine T2(
        f=2/86400,
        amplitude=50,
        offset=273.15 + 100)
        annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
      Modelica.Blocks.Sources.Sine T1(
        f=2/86400,
        amplitude=50,
        offset=273.15 + 90)
        annotation (Placement(transformation(extent={{30,-90},{50,-70}})));
    equation
      connect(incAng.y, solGai.incAng) annotation (Line(
          points={{-69,20},{-60,20},{-60,-2},{68,-2}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(shaCoe.y, solGai.shaCoe_in) annotation (Line(
          points={{-69,-20},{-60,-20},{-60,-5},{68,-5}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(HDirTil.y, solGai.HDirTil) annotation (Line(
          points={{-29,40},{-20,40},{-20,2},{68,2}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(HDifTil.y, solGai.HSkyDifTil) annotation (Line(
          points={{51,80},{60,80},{60,8},{68,8}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(T3.y, solGai.TFlu[3]) annotation (Line(
          points={{-29,-40},{-20,-40},{-20,-7.33333},{68,-7.33333}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(T2.y, solGai.TFlu[2]) annotation (Line(
          points={{11,-60},{20,-60},{20,-8},{68,-8}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(T1.y, solGai.TFlu[1]) annotation (Line(
          points={{51,-80},{60,-80},{60,-8},{68,-8},{68,-8.66667}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (
        Documentation(info="<html>
<p>
This examples demonstrates the implementation of
<a href=\"modelica://IDEAS.Fluid.SolarCollectors.BaseClasses.EN12975SolarGain\">
IDEAS.Fluid.SolarCollectors.BaseClasses.EN12975SolarGain</a>.
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
        __Dymola_Commands(file="modelica://IDEAS/Resources/Scripts/Dymola/Fluid/SolarCollectors/BaseClasses/Examples/EN12975SolarGain.mos"
            "Simulate and plot"),
            experiment(Tolerance=1e-6, StopTime=86400));
    end EN12975SolarGain;
  annotation (preferredView="info", Documentation(info="<html>
<p>
This package contains examples for the use of models that can be found in
<a href=\"modelica://IDEAS.Fluid.SolarCollectors.BaseClasses\">
IDEAS.Fluid.SolarCollectors.BaseClasses.</a>
</p>
</html>"));
  end Examples;
annotation (preferredView="info", Documentation(info="<html>
  <p>
    This package contains base classes that are used to construct the models in
    <a href=\"modelica://IDEAS.Fluid.SolarCollectors\">IDEAS.Fluid.SolarCollectors</a>.
   </p>
</html>"));
end BaseClasses;
