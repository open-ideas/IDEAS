within IDEAS.Fluid.PvtCollectors.Data;
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
</html>", revisions="<html>
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
