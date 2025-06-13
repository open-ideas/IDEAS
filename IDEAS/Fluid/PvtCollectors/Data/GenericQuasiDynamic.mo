within IDEAS.Fluid.PvtCollectors.Data;
record GenericQuasiDynamic
  "Generic data record for PVT collector models following ISO 9806:2013 Quasi Dynamic procedure"
  extends IDEAS.Fluid.SolarCollectors.Data.BaseClasses.Generic;

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
Record containing thermal performance parameters for PVT collectors tested
according to the ISO 9806:2013 quasi-dynamic procedure. These parameters can
be used for glazed and unglazed photovoltaic–thermal collectors, and represent
the thermal side of the PVT performance.
</p>
<h4>References</h4>
<ul>
<li>
IEA SHC (2018). Task 60. PVT Systems: Application of PVT Collectors and New Solutions in HVAC Systems.
<a href=\"https://www.iea-shc.org/task60\">https://www.iea-shc.org/task60</a>. International Energy Agency Solar Heating and Cooling Programme.
</li>
<li>
ISO 9806:2013. Solar thermal collectors — Test methods.
</li>
</ul>
</html>", evisions = "<html>
<ul>
<li>
June 12, 2025, by Lone Meertens:<br/>
Added performance record for PVT collectors following ISO 9806 quasi-dynamic procedure.<br/>
Based on collector classifications in IEA SHC Task 60.<br/>
<a href=\"https://github.com/open-ideas/IDEAS/issues/1436\">IDEAS, #1436</a>.
</li>
</ul>
</html>"));
end GenericQuasiDynamic;
