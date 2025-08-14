within IDEAS.Fluid.PVTCollectors.Data;
record GenericQuasiDynamic
  "Generic data record for PVT collector models"
  extends IDEAS.Fluid.SolarCollectors.Data.BaseClasses.Generic;

  parameter Real IAMDiff(final min=0, final max=1, final unit="1")
  "Incidence angle modifier for diffuse irradiance (incidence angle of 50°)";
  parameter Real eta0(final min=0, final max=1, final unit="1")
    "Optical thermal efficiency (Maximum efficiency)";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer c1(final min=0)
    "First order thermal heat loss coefficient";
  parameter Real c2(final min=0, final unit="W/(m2.K2)")
    "Second order thermal heat loss coefficient";
  parameter Modelica.Units.SI.SpecificHeatCapacity c3(final min=0)
    "Wind speed dependence of thermal heat loss";
  parameter Modelica.Units.SI.DimensionlessRatio c4(final min=0)
    "Sky temperature dependence of the thermal heat loss coefficient";
  parameter Real c6(final min=0, final unit="s/m")
    "Wind speed dependence of thermal zero-loss efficiency";
  parameter Real P_nominal(final min=0, final unit="W")
    "PV panel power at nominal conditions (W)";
  parameter Modelica.Units.SI.LinearTemperatureCoefficient gamma
    "Temperature coefficient of the PV panel(s)";
  parameter Modelica.Units.SI.Efficiency etaEl(final min=0, final max=1)
    "Module efficiency of the photovoltaic installation";

annotation (
defaultComponentPrefixes="parameter",
defaultComponentName="datPVTCol",
Documentation(info="<html>
<p>
Record containing both thermal and electrical performance parameters for PVT
collectors. Thermal parameters,tested according to the ISO 9806:2013
quasi-dynamic procedure, apply to covered and uncovered designs, while
electrical parameters and system loss factors follow from the manufacturer datasheets.
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
</html>",
revisions="<html>
  <ul>
   <li>
      July 7, 2025, by Lone Meertens:<br/>
      First implementation PVT model; tracked in 
      <a href=\"https://github.com/open-ideas/IDEAS/issues/1436\">
        IDEAS #1436
      </a>.
    </li>
  </ul>
</html>"));
end GenericQuasiDynamic;
