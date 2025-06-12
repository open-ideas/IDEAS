within IDEAS.Fluid.PvtCollectors;
package Data "Data for solar thermal collectors"
extends Modelica.Icons.MaterialPropertiesPackage;

  record GenericQuasiDynamic
    "Generic data record for PVT collector models following ISO 9806:2013 Quasi Dynamic approach"
    extends IDEAS.Fluid.PvtCollectors.Data.BaseClasses.Generic;

    parameter Real IAMDiff(final min=0, final max=1, final unit="1")
      "Incidence angle modifier for diffuse irradiance (incidence angle of 50°)";
    parameter Real eta0(final min=0, final max=1, final unit="1")
      "Optical efficiency (Maximum efficiency)";
    parameter Modelica.Units.SI.CoefficientOfHeatTransfer c1(final min=0)
      "First order heat loss coefficient";
    parameter Real c2(final unit="W/(m2.K2)", final min=0)
      "Second order heat loss coefficient";
    parameter Real c3(final unit="J/(m3.K)", final min=0)
      "Windspeed dependence of heat losses";
    parameter Real c4(final unit="", final min=0)
      "Sky temperature dependence of the heat-loss coefficient";
    parameter Real c6(final unit="s/m", final min=0)
      "Windspeed dependence of zero-loss efficiency";


  annotation (
  defaultComponentPrefixes="parameter",
  defaultComponentName="datPvtCol",
  Documentation(info="<html>
<p>
Record containing performance parameters for ISO 9806:2013 Quasi Dynamic tested PVT collector models.
</p>
</html>",   revisions="<html>
<ul>
<li>
June 12, 2025, by Lone Meertens:<br/>
Refactor model.<br/>
This is for
<a href=\"https://github.com/open-ideas/IDEAS/issues/1436\">IDEAS, #1436</a>.

</li>
</ul>
</html>"));
  end GenericQuasiDynamic;

  package GlazedFlatPlate "Package with SRCC rating information for glazed flat-plate solar thermal collectors"
  extends Modelica.Icons.MaterialPropertiesPackage;


    record FP_GuangdongFSPTY95 =
        IDEAS.Fluid.SolarCollectors.Data.GenericASHRAE93 (
        final A=2,
        final mDry=35,
        final CTyp=IDEAS.Fluid.SolarCollectors.Types.HeatCapacity.DryMass,
        final C=0,
        final V=1.7/1000,
        final dp_nominal=235,
        final mperA_flow_nominal=0.02,
        final incAngDat=Modelica.Units.Conversions.from_deg({0,10,20,30,40,50,60,70,80,90}),
        final incAngModDat={1.0,0.9967,0.9862,0.9671,0.9360,0.8868,0.8065,0.6686,0.4906,0.0},
        final y_intercept=0.678,
        final slope=-4.426)
      "FP - Guandong Fivestar Solar Energy Co, FS-PTY95-2.0"
        annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datSolCol",
    Documentation(info = "<html>
<h4>References</h4>
<p>
Ratings data taken from the <a href=\"http://www.solar-rating.org\">
Solar Rating and Certification Corporation website</a>. SRCC# = 2012043A.<br/>
</p>
</html>"));
    record FP_SolahartKf =
        IDEAS.Fluid.SolarCollectors.Data.GenericASHRAE93 (
        final A=2.003,
        final CTyp=IDEAS.Fluid.SolarCollectors.Types.HeatCapacity.DryMass,
        final C=0,
        final mDry=42,
        final V=3.8/1000,
        final dp_nominal=93.89,
        final mperA_flow_nominal=0.0194,
        final incAngDat=Modelica.Units.Conversions.from_deg({0,10,20,30,40,50,60,70,80,90}),
        final incAngModDat={1.0,0.9979,0.9913,0.9792,0.9597,0.929,0.8796,0.7979,0.724,0.0},
        final y_intercept=0.775,
        final slope=-5.103) "FP - Solahart Kf"
        annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datSolCol",
    Documentation(info = "<html>
<h4>References</h4>
<p>
Ratings data taken from the <a href=\"http://www.solar-rating.org\">
Solar Rating and Certification Corporation website</a>. SRCC# = 2012021A.<br/>
</p>
</html>"));
    record FP_TRNSYSValidation =
        IDEAS.Fluid.SolarCollectors.Data.GenericASHRAE93 (
        A=5,
        CTyp=IDEAS.Fluid.SolarCollectors.Types.HeatCapacity.DryMass,
        C=0,
        mDry=8.6,
        V=0.6/1000,
        dp_nominal=100,
        mperA_flow_nominal=0.0111,
        incAngDat=Modelica.Units.Conversions.from_deg({0,10,20,30,40,50,60,70,80,90}),
        incAngModDat={1.0,0.9969,0.9872,0.9691,0.9389,0.8889,0.8,0.6152,0.0482,0.0},
        y_intercept=0.8,
        slope=-3.6111)
      "Default values in the TRNSYS Simulation Studio SDHW example"
        annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datSolCol",
    Documentation(info="<html>
<p>
Default values in the TRNSYS Simualtion Studio SDHW example.
No value for <code>dp_nominal</code> was provided in TRNSYS, so 100
Pascal was used as a placeholder.<br/>
</p>
</html>"));
    record FP_ThermaLiteHS20 =
        IDEAS.Fluid.SolarCollectors.Data.GenericASHRAE93 (
        final A=1.97,
        final CTyp=IDEAS.Fluid.SolarCollectors.Types.HeatCapacity.DryMass,
        final C=0,
        final mDry=26,
        final V=2.8/1000,
        final dp_nominal=242.65,
        final mperA_flow_nominal=0.1777,
        final incAngDat=Modelica.Units.Conversions.from_deg({0,10,20,30,40,50,60,70,80,90}),
        final incAngModDat={1.0,0.9989,0.9946,0.9836,0.9567,0.8882,0.6935,0.0,0.0,0.0},
        final y_intercept=0.762,
        final slope=-3.710) "FP - Therma-Lite, HS-20"
        annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datSolCol",
    Documentation(info = "<html>
<h4>References</h4>
<p>
Ratings data taken from the <a href=\"http://www.solar-rating.org\">
Solar Rating and Certification Corporation website</a>. SRCC# = 2012047A.
</p>
</html>"));
    record FP_VerificationModel =
      IDEAS.Fluid.SolarCollectors.Data.GenericEN12975 (
        final A=4.302,
        final CTyp=IDEAS.Fluid.SolarCollectors.Types.HeatCapacity.DryMass,
        final C=0,
        final V=4.4/1000,
        final dp_nominal = 100,
        final mperA_flow_nominal=0.0241,
        final eta0=0.720,
        final IAMDiff=0.133,
        final a1=2.8312,
        final a2=0.00119,
        final incAngDat=Modelica.Units.Conversions.from_deg({0,10,20,30,40,50,60,70,80,90}),
        final incAngModDat={1.0,0.9967,0.9862,0.9671,0.9360,0.8868,0.8065,0.6686,0.4906,0.0},
        final mDry=484)
      "FP - All inputs necessary for verification of EN12975 models"
        annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datSolCol",
    Documentation(info = "<html>
<p>
No model on the <a href=\"http://www.solar-rating.org\"> Solar Rating and
Certification Corporation </a> website tested to EN12975 standards provides all
of the necessary information for modeling.
This data record was created to allow verification of EN12975 base classes
despite the limitations in available data.
</p>
</html>"));
  annotation (Documentation(info="<html>
  <p>
    Package with records for SRCC rating information for glazed flat-plate solar thermal collector.
    All models in the GlazedFlatPlate package are tested according to the ASHRAE Standard 93.
  </p>
  </html>",
    revisions="<html>
    <ul>
      <li>
        June 8, 2012, by Wangda Zuo:<br/>
        First implementation.
      </li>
    </ul>
  </html>"));
  end GlazedFlatPlate;

  package Tubular "Package with SRCC rating information for tubular solar thermal collectors"
  extends Modelica.Icons.MaterialPropertiesPackage;

    record T_AMKCollectraAGOWR20 =
        IDEAS.Fluid.SolarCollectors.Data.GenericASHRAE93 (
        final A=3.457,
        final CTyp=IDEAS.Fluid.SolarCollectors.Types.HeatCapacity.DryMass,
        final C=0,
        final mDry=73,
        final V=3.5/1000,
        final dp_nominal=100,
        final mperA_flow_nominal=0.0201,
        final incAngDat=Modelica.Units.Conversions.from_deg({0,10,20,30,40,50,60,70,80,90}),
        final incAngModDat={1.0,1.0088,1.0367,1.0884,1.1743,1.3164,1.567,2.0816,3.6052,0.0},
        final y_intercept=0.446,
        final slope=-1.432) "T - AMG Collectra AG, OWR 20"
        annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datSolCol",
    Documentation(info = "<html>
<h4>References</h4>
<p>
Ratings data taken from the <a href=\"http://www.solar-rating.org\">
Solar Rating and Certification Corporation website</a>.
SRCC# = 2012018A.
</p>
<p>
The ratings provided for <code>dp_nominal</code> were suspicious
so 100 Pa is used instead.<br/>
</p>
</html>"));
    record T_JiaxingDiyiC0130 =
        IDEAS.Fluid.SolarCollectors.Data.GenericASHRAE93 (
        final A=4.650,
        final CTyp=IDEAS.Fluid.SolarCollectors.Types.HeatCapacity.DryMass,
        final C=0,
        final mDry=95,
        final V=1.7/1000,
        final dp_nominal=100,
        final mperA_flow_nominal=0.0142,
        final incAngDat=Modelica.Units.Conversions.from_deg({0,10,20,30,40,50,60,70,80,90}),
        final incAngModDat={1.0,1.0222,1.0897,1.2034,1.3596,1.5272,1.5428,0.4206,0.0,0.0},
        final y_intercept=0.388,
        final slope=-1.453) "T - Jiaxing Diyi New Energy Co., Ltd., DIYI-C01-30"
        annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datSolCol",
    Documentation(info = "<html>
<h4>References</h4>
<p>
Ratings data taken from the <a href=\"http://www.solar-rating.org\">
Solar Rating and Certification Corporation website</a>.
SRCC# = 2012036A.
</p>
<p>
The ratings provided for <code>dp_nominal</code> were suspicious
so 100 Pa is used instead.<br/>
</p>
</html>"));
      annotation(Documentation(info="<html>
      <p>
        Package with data describing tubular solar collectors. All models in the Tubular
        pacakage use ASHRAE93 test data.
      </p>
    </html>"));
  end Tubular;

  package BaseClasses "Package with base classes for data records of solar thermal collectors"
    extends Modelica.Icons.BasesPackage;

    function validateAngles "Function to validate the provided angles"
      extends Modelica.Icons.Function;
      input Modelica.Units.SI.Angle[:] incAngDat(
        each final min=0,
        each final max=Modelica.Constants.pi/2)
        "Incident angle data in degrees";
      input Real[:] incAngModDat(
        each final min=0,
        each final unit="1")
        "Incident angle modifier data";
      output Boolean valid;
    protected
      Integer n = size(incAngDat,1) "Number of elements";
    algorithm
      assert(size(incAngModDat, 1) == n, "Both arguments incAngDat and incAngModDat must have the same size.");
      assert(abs(incAngDat[1]) < 1E-4, "First element of incAngDat must be zero.");
      assert(abs(Modelica.Constants.pi/2-incAngDat[n]) < 1E-4, "Last element of incAngDat must be pi/2.");
      assert(abs(1-incAngModDat[1]) < 1E-4, "First element of incAngModDat must be 1.");
      assert(abs(incAngModDat[n]) < 1E-4, "Last element of incAngModDat must be 0.");
      valid := true;

      annotation (Documentation(info="<html>
<p>
Function that validates the incidence angle modifiers.
If the data are invalid, the function issues an assertion and stops the simulation.
Otherwise it returns <code>true</code>.
</p>
</html>",     revisions="<html>
<ul>
<li>
March 14, 2023, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
    end validateAngles;

    record Generic
      "Generic data record providing common inputs for ASHRAE93 and EN12975 solar collector models"
      extends Modelica.Icons.Record;

      parameter Modelica.Units.SI.Area A "Area";
      parameter IDEAS.Fluid.SolarCollectors.Types.HeatCapacity CTyp
        "Total thermal capacity or fluid volume and 'dry' thermal capacity or mass";
      parameter Modelica.Units.SI.HeatCapacity C
        "Dry or total thermal capacity of the solar thermal collector";
      parameter Modelica.Units.SI.Volume V "Fluid volume ";
      parameter Modelica.Units.SI.Mass mDry "Dry mass";
      parameter Real mperA_flow_nominal(final unit="kg/(s.m2)")
        "Nominal mass flow rate per unit area of collector";
      parameter Modelica.Units.SI.PressureDifference dp_nominal(displayUnit="Pa")
        "Nominal pressure drop";
      parameter Modelica.Units.SI.Angle[:] incAngDat=Modelica.Units.Conversions.from_deg({0,10,20,30,40,50,60,70,80,90})
        "Incident angle data";
      parameter Real[size(incAngDat,1)] incAngModDat(
        each final min=0,
        each final unit="1")
        "Incident angle modifier data";

      final parameter Boolean validated = validateAngles(
        incAngDat=incAngDat,
        incAngModDat=incAngModDat)
        "True if data are valid, otherwise an assertion is issued";

    annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datSolCol",
    Documentation(info="<html>
<p>
Partial record containing common performance parameters for ASHRAE93 and EN12975
solar collector models.
</p>
<p>
Depending on the data source that is used, different parameters are available to
model the thermal capacity of the solar collector.
The choice of CTyp determines which parameters are used to calculate the
representative heat capacity of the entire solar collector (including fluid).
When the dry mass of the solar collector is used to calculate the heat capacity,
the collector is assumed to be made fully out of copper
(specific heat capacity of <i>385 J/kg/K</i>).
<table summary=\"summary\" border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr>
<th>CTyp</th>
<th> C </th>
<th> V </th>
<th> mDry </th>
</tr>
<tr>
<td> TotalCapacity </td>
<td> CTot </td>
<td> / </td>
<td> / </td>
</tr>
<tr>
<td> DryCapacity </td>
<td> CDry </td>
<td> V </td>
<td> / </td>
</tr>
<tr>
<td> DryMass </td>
<td> / </td>
<td> V </td>
<td> mDry </td>
</tr>
</table>
</html>",     revisions="<html>
<ul>
<li>
February 28, 2024, by Jelger Jansen:<br/>
Refactor model.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/3604\">Buildings, #3604</a>.
</li>
<li>
January 4, 2013, by Peter Grant:<br/>
First implementation.
</li>
</ul>
</html>"));
    end Generic;
  annotation (Documentation(info="<html>
<p>
Package with base classes for performance data for solar thermal collectors.
</p>
</html>"));
  end BaseClasses;
annotation (Documentation(info="<html>
  <p>
    Package with performance data for solar thermal collectors. All solar collector data package
    names begin with an abbreviation of the type of collector it is.  The abbreviations are as
    follows:
  </p>
  <ul>
    <li>C: Concentrating</li>
    <li>FP: Flat Plate</li>
    <li>T: Tubular</li>
  </ul>
</html>"));
end Data;
