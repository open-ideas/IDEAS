within IDEAS.Buildings.Data.Interfaces;
record BasicMaterial
  "Template record for properties of building materials"
  extends Modelica.Icons.MaterialProperty;
  parameter Modelica.Units.SI.ThermalConductivity k "Thermal conductivity";
  parameter Modelica.Units.SI.SpecificHeatCapacity c
    "Specific thermal capacity";
  parameter Modelica.Units.SI.Density rho "Density";


  annotation (Documentation(info="<html>
<p>
This record may be used to define material properties.
</p>
</html>", revisions="<html>
<ul>
<li>
November 15, 2016, by Filip Jorissen:<br/>
Revised documentation for IDEAS 1.0.
</li>
</ul>
</html>"));
end BasicMaterial;
