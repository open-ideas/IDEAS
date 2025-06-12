within IDEAS.Fluid.PvtCollectors;
package Data "Data for solar thermal collectors"
extends Modelica.Icons.MaterialPropertiesPackage;

  record GenericQuasiDynamic
    "Generic data record for PVT collector models following ISO 9806:2013 Quasi Dynamic approach"
    extends IDEAS.Fluid.SolarCollectors.Data.BaseClasses.Generic;

    parameter Real IAMDiff(final min=0, final max=1, final unit="1")
      "Incidence angle modifier for diffuse irradiance (incidence angle of 50°)";
    parameter Real eta0(final min=0, final max=1, final unit="1")
      "Optical efficiency (Maximum efficiency)";
    parameter Modelica.Units.SI.CoefficientOfHeatTransfer a1(final min=0)
      "First order heat loss coefficient";
    parameter Real a2(final unit="W/(m2.K2)", final min=0)
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

  package WISC "Package with SRCC rating information for WISC PVT collectors"
  extends Modelica.Icons.MaterialPropertiesPackage;

    record WISC_TRNSYSValidation =
      IDEAS.Fluid.PvtCollectors.Data.GenericQuasiDynamic (
        final A=1.66,
        final CTyp=IDEAS.Fluid.SolarCollectors.Types.HeatCapacity.TotalCapacity,
        final C=42200*1.66,
        final V=5/1000,
        final mDry=28,
        final mperA_flow_nominal=0.03,
        final dp_nominal=60000,
        final incAngDat=Modelica.Units.Conversions.from_deg({0,10,20,30,40,50,60,70,90}),
        final incAngModDat={1,1,1,0.99,0.99,0.98,0.96,0.92,0.00},
        final IAMDiff=1,
        final eta0=0.475,
        final a1=7.411,
        final a2=0.0,
        final c3=1.7,
        final c4=0.437,
        final c6=0.003)
        annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datPVT",
    Documentation(info = "<html>
    
    <h4>References</h4>
      <p>
        Ratings data taken from the <a href=\"http://www.solar-rating.org\">
        Solar Rating and Certification Corporation website</a>. 
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
  end WISC;

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
