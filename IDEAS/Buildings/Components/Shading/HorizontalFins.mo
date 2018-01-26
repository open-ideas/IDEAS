within IDEAS.Buildings.Components.Shading;
model HorizontalFins "horizontal fins shading"
  extends IDEAS.Buildings.Components.Shading.Interfaces.PartialShading(final controlled=use_betaInput);

  parameter Boolean use_betaInput = false
    "=true, to use input for fin inclination angle"
    annotation(Evaluate=true);
  parameter Modelica.SIunits.Angle beta
    "Fin inclination angle: 0 for horizontal inclination, -Pi/2 for downward 
    inclination of 45 degrees, Pi/2 for upward inclination of 45 degrees"
    annotation(Dialog(enable=not use_betaInput));
  parameter Modelica.SIunits.Length spacing(min=0)
    "Vertical spacing between fins";
  parameter Modelica.SIunits.Length w(min=0)
    "Fin width";
  parameter Modelica.SIunits.Length t(min=0)
    "Fin thickness";

  Real shaFrac "Shaded fraction of the glazing.";


protected
  Modelica.SIunits.Angle beta_internal "Internal variable for inclination angle";
  Modelica.SIunits.Angle angAlt = Modelica.Constants.pi/2 - angZen "Altitude angle";
  Modelica.SIunits.Angle projectedAltitudeAngle = -atan(tan(angAlt)/cos(angAzi+azi));

  Real tipShadow;
  Real headShadow;
  Real footShadow;
  Real totalShadow;

initial equation
  if not use_betaInput then
    assert(beta > 0 and beta < acos(t/spacing), "beta between feasible values");
  end if;
  assert(spacing > 0 and w > 0 and t > 0,
   "The fin spacing, width and thickness should be positive");

equation
  connect(beta_internal,Ctrl);
  if not use_betaInput then
    beta_internal = beta;
  end if;

  if angAlt > beta_internal then
    tipShadow = sqrt(w*w+t*t)*(cos(beta_internal-atan(t/w))*tan(projectedAltitudeAngle)-sin(beta_internal-atan(t/w)));
    headShadow = 0;
    footShadow = 0;
    totalShadow = 0;
    if tipShadow > spacing then
      shaFrac = 1;
    else
      shaFrac = min(1, tipShadow/spacing);
    end if;
  else
    headShadow = max(0, -1 * ((w*sin(Modelica.Constants.pi/2 - beta_internal)/tan(Modelica.Constants.pi/2 - projectedAltitudeAngle))-w*cos(Modelica.Constants.pi/2-beta_internal)));
    footShadow = max(0, t * (cos(beta_internal)+ sin(beta_internal)*tan(projectedAltitudeAngle)));
    tipShadow = 0;
    totalShadow = headShadow + footShadow;
    shaFrac = min(1, totalShadow/spacing);
  end if;

  HShaDirTil = (1-shaFrac)*HDirTil;
  angInc = iAngInc;
  connect(HSkyDifTil, HShaSkyDifTil);
  connect(HGroDifTil, HShaGroDifTil);

    annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-50,-100},{50,100}})),
    Documentation(info="<html>
<p>Shading model of horizontal fins in function of the inclination angle of the fins.</p>
<p><br><img src=\"modelica://IDEAS/Resources/Images/Buildings/Components/Shading/HorizontalFins.png\"/></p>
</html>", revisions="<html>
<ul>
<li>
April, 2017 by Iago Cupeiro:<br/>
Cleaned up implementation and documentation.
</li>
</ul>
</html>"));
end HorizontalFins;
