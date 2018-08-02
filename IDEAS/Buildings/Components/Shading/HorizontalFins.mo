within IDEAS.Buildings.Components.Shading;
model HorizontalFins "horizontal fins shading"
  extends IDEAS.Buildings.Components.Shading.Interfaces.PartialShading(final controlled=use_betaInput);

  parameter Modelica.SIunits.Length s(min=0)
    "Vertical spacing between fins";
  parameter Modelica.SIunits.Length w(min=0)
    "Fin width";
  parameter Modelica.SIunits.Length t(min=0)
    "Fin thickness";
  parameter Boolean use_betaInput = false
    "=true, to use input for fin inclination angle"
    annotation(Evaluate=true);
  parameter Modelica.SIunits.Angle beta(min=0)=0
    "Fin inclination angle: 0 for horizontal inclination, see documentation"
    annotation(Dialog(enable=not use_betaInput));

  Real shaFrac "Shaded fraction of the glazing";
  Real shaDifFrac "Diffuse transmittance of shadow system";

  //Dif-to-Dif view factors

  //Optical parameters
  parameter Real transmittance = 0.7 "transmittance of the material";
  parameter Real reflectance = 0.3 "reflectance of the material";

  Real Ef[3] "front surface irradiances vector";
  Real Eb[3] "back surface irradiances vector";

  //view factors for tile
  Real F_1f_0b = (w + s - diag_s)/2/w;
  Real F_1f_2f = (w + s - diag_B)/2/w;
  Real F_1f_1b = (diag_B + diag_s - 2*s)/2/w;

  Real F_1b_0b = F_1f_2f;
  Real F_1b_2f = F_1f_0b;
  Real F_1b_1f = F_1f_1b;

  //view factors for hollows
  Real F_0b_1f = (s + w - diag_s)/2/s;
  Real F_0b_1b = (s + w - diag_B)/2/s;
  Real F_0b_2f = (diag_B + diag_s - 2*w)/2/s;

  Real F_2f_1f = F_0b_1b;
  Real F_2f_1b = F_0b_1f;
  Real F_2f_0b = F_0b_2f;

protected
  Modelica.SIunits.Length dy1 = s-cos(beta_internal)*w-sin(beta_internal)*t;
  Modelica.SIunits.Length dx = cos(beta_internal)*w-sin(beta_internal)*t;
  Modelica.SIunits.Length dz = dx/cos(angInc);
  Modelica.SIunits.Length dy3 = max(0,min(dz*tan(angAlt),s));

  Modelica.SIunits.Length diag_B = sqrt(w^2 + s^2 + 2*w*s*sin(beta_internal));
  Modelica.SIunits.Length diag_s = sqrt(w^2 + s^2 - 2*w*s*sin(beta_internal));

  Modelica.Blocks.Interfaces.RealInput beta_internal "Internal variable for inclination angle";
  Modelica.SIunits.Angle angAlt = Modelica.Constants.pi/2 - angZen "Altitude angle";

initial equation
  if not use_betaInput then
    assert(beta > 0 and beta < acos(t/s), "beta between feasible values");
  end if;
  assert(s > 0 and w > 0 and t >= 0,
   "The fin spacing, width and thickness should be positive");

equation

   Ef[1] = HSkyDifTil;
   Ef[2] = Eb[3]*F_2f_1f + Ef[1]*F_0b_1f + (reflectance*Eb[2]+transmittance*Ef[2])*F_1b_1f;
   Ef[3] = (reflectance*Ef[2]+transmittance*Eb[2])*F_1f_2f+Ef[1]*F_0b_2f+(reflectance*Eb[2]+transmittance*Ef[2])*F_1b_1f;
   Eb[1] = (reflectance*Eb[2]+transmittance*Ef[2])*F_1b_0b+(reflectance*Ef[2]+transmittance*Eb[2])*F_1f_0b+Eb[3]*F_2f_0b;
   Eb[2] = Ef[1]*F_0b_1b + (reflectance*Ef[2]+transmittance*Eb[2])*F_1f_1b + Eb[3]*F_2f_1b;
   Eb[3] = 0;

  shaDifFrac = Ef[3]/Ef[1];

  connect(beta_internal,Ctrl);
  if not use_betaInput then
    beta_internal = beta;
  end if;

  if dy3 > dy1 then
    shaFrac = 1;
  else
    shaFrac = 1-(dy1-min(dy1,dy3))/s;
  end if;

  HShaDirTil = (1-shaFrac)*HDirTil;
  HShaSkyDifTil = shaDifFrac*HSkyDifTil;
  HShaGroDifTil = shaDifFrac*HGroDifTil;

  angInc = iAngInc;
  //connect(HSkyDifTil, HShaSkyDifTil);
  //connect(HGroDifTil, HShaGroDifTil);

    annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-50,-100},{50,100}})),
    Documentation(info="<html>
<p>
Shading model for exterior horizontal fins in front of a window,
in function of the fin angle.
</p>
<h4>Assumption and limitations</h4>
<p>
We assume that the fins fully cover the window at all times.
The fin angle should be positive.
The diffuse solar irradiation is not modified, i.e. only the direct
solar irradiation is influenced.
</p>
<h4>Typical use and important parameters</h4>
<p>
Parameter <code>t</code> is the fin thickness,
<code>s</code> is the vertical spacing between the fins and
<code>w</code> is the fin width.
See the figure below for an illustration.
</p>
<h4>Dynamics</h4>
<p>
This model has no dynamics.
</p>
<h4>Implementation</h4>
<p>
The implementation is illustrated using this figure: 
<br/><img alt=\"illustration\" src=\"modelica://IDEAS/Resources/Images/Buildings/Components/Shading/HorizontalFins.PNG\"/>
</p>
</html>", revisions="<html>
<ul>
<li>
April, 2017 by Iago Cupeiro:<br/>
Cleaned up implementation and documentation.
</li>
</ul>
</html>"));
end HorizontalFins;
