within IDEAS.Fluid.PVTCollectors.Data;
package Uncovered
  "Performance data for uncovered (WISC) PVT collectors"
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
This package contains thermal and electrical performance data for uncovered (WISC) photovoltaic–thermal collectors. 
All records conform to ISO 9806:2013 quasi-dynamic thermal testing, with parameters sourced from 
Solar Keymark Certificates. The thermal parameters apply to the PV module operating in maximum power point (MPP) mode, 
and the electrical performance parameters can be retrieved from manufacturer datasheets.
</p>

</html>"));

end Uncovered;
