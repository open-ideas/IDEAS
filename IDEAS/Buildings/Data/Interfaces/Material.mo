within IDEAS.Buildings.Data.Interfaces;
record Material "Template record for properties of building materials"

  extends IDEAS.Buildings.Data.Interfaces.BasicMaterial;

  parameter Modelica.Units.SI.Length d=0 "Layer thickness";
  parameter Modelica.Units.SI.Emissivity epsLw=0.85 "Longwave emissivity";
  parameter Modelica.Units.SI.Emissivity epsSw=0.85 "Shortwave emissivity";
  parameter Boolean gas=false "Boolean whether the material is a gas"
    annotation(Evaluate=true);
  parameter Boolean glass=false "Boolean whether the material is made of glass"
    annotation(Evaluate=true);
  parameter Modelica.Units.SI.KinematicViscosity nu=0
    "Viscosity, i.e. if the material is a fluid";

  parameter Modelica.Units.SI.Emissivity epsLw_a=epsLw
    "Longwave emissivity for surface a if different";
  parameter Modelica.Units.SI.Emissivity epsLw_b=epsLw
    "Longwave emissivity for surface b if different";

  parameter Modelica.Units.SI.Emissivity epsSw_a=epsSw
    "Shortwave emissivity for surface a if different";
  parameter Modelica.Units.SI.Emissivity epsSw_b=epsSw
    "Shortwave emissivity for surface b if different";

  final parameter Modelica.Units.SI.ThermalInsulance R=d/k;

  final parameter Modelica.Units.SI.ThermalDiffusivity alpha=k/(c*rho)
    "Thermal diffusivity";
  final parameter Integer nStaRef=3
    "Number of states of a reference case, i.e. 20 cm dense concrete";
  final parameter Real piRef=224
    "d/sqrt(mat.alpha) of a reference case, i.e. 20 cm dense concrete";
  final parameter Real piLay=d/sqrt(alpha)
    "d/sqrt(mat.alpha) of the depicted layer";
  final parameter Integer nSta(min=2) = max(2, integer(ceil(nStaRef*piLay/piRef)))
    "Actual number of state variables in material";

  annotation (Documentation(info="<html>
<p>
This record may be used to define material properties.
</p>
</html>", revisions="<html>
<ul>
<li>
May 3, 2022, by Jelger Jansen:<br/>
Changed symbol for kinematic viscosity to &apos;nu&apos; and corrected some typos.
</li>
<li>
November 15, 2016, by Filip Jorissen:<br/>
Revised documentation for IDEAS 1.0.
</li>
</ul>
</html>"));
end Material;
