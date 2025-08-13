within IDEAS.Fluid.PVTCollectors.Data;
package Covered "Performance data for covered PVT collectors"
extends Modelica.Icons.MaterialPropertiesPackage;

/**  
    Record of SRCC-validated parameters for uncovered (WISC) PVT collectors  
    tested according to ISO 9806:2013 quasi-dynamic procedure, retrieved  
    from Solar Keymark Certificate No. 011-7S2782P. Thermal performance  
    parameters are given for the PV module operating at maximum power  
    point (MPP mode).  
  */
  annotation (
Documentation(info = "<html>
<p>
This package contains performance data for uncovered (WISC)
flat-plate photovoltaic-thermal collectors. All records conform to
ISO 9806:2013 quasi-dynamic testing, with parameters sourced from
Solar Keymark Certificate. Thermal performance parameters
apply to the PV module in maximum power point (MPP) operation mode.
</p>
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

end Covered;
