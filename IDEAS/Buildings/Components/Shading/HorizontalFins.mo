within IDEAS.Buildings.Components.Shading;
model HorizontalFins "Horizontal fin shading with 2 control input options"
  extends IDEAS.Buildings.Components.Shading.Interfaces.PartialShading(final controlled=use_betaInput or use_displacementInput);

  parameter Modelica.SIunits.Length s(min=0)
    "Vertical spacing between fins";
  parameter Modelica.SIunits.Length w(min=0)
    "Fin width";
  parameter Modelica.SIunits.Length t(min=0)
    "Fin thickness";
  parameter Boolean use_displacementInput = false
    "=true, to use input for controlling the horizontal fin displacement"
    annotation(Evaluate=true);
  parameter Boolean use_betaInput = false
    "=true, to use input for fin inclination angle"
    annotation(Evaluate=true);
  parameter Modelica.SIunits.Angle beta(min=0)=0
    "Fin inclination angle: 0 for horizontal inclination, see documentation"
    annotation(Dialog(enable=not use_betaInput));

  Real shaFrac "Shaded fraction of the glazing";


protected
  Modelica.SIunits.Length dy1 = s-sin(beta_internal)*w-cos(beta_internal)*t;
  Modelica.SIunits.Length dx = cos(beta_internal)*w-sin(beta_internal)*t;
  Modelica.SIunits.Length dz = dx/cos(angInc) "Horizontal ray displacement along the ray direction";
  Modelica.SIunits.Length dy3 = max(0,min(dz*tan(angAlt),s));

  Real dispLim=min(1,max(0,disp_internal));

  Modelica.Blocks.Interfaces.RealInput beta_internal
    "Internal variable for inclination angle";
  Modelica.Blocks.Interfaces.RealInput disp_internal
    "Internal variable for displacement fraction";
  Modelica.SIunits.Angle angAlt = Modelica.Constants.pi/2 - angZen
    "Altitude angle";

initial equation
  if not use_betaInput then
    assert(beta >= 0 and beta < acos(t/s), "In " + getInstanceName() + ": Beta must be within the feasible range.");
  end if;
  assert(s > 0 and w > 0 and t >= 0,
   "The fin spacing, width and thickness should be positive");
  assert(not use_betaInput or not use_displacementInput,
    "In " + getInstanceName() + ": Either use_betaInput or use_displacementInput should be false.");

equation

  if not use_betaInput then
    beta_internal = beta;
  else
    connect(beta_internal,Ctrl);
  end if;
  if not use_displacementInput then
    disp_internal=1;
  else
    connect(disp_internal,Ctrl);
  end if;

  if dy3 > dy1 then
    shaFrac = dispLim;
  else
    // The shaded part equals 100% minus the unshaded part due to displacement (1-dispLim),
    // minus the shaded fraction (disp) that is unshaded by the fins (dy1-min(dy1,dy3))/s.
    // i.e. 1 - (1-dispLim) - dispLim*(dy1-min(dy1,dy3))/s
    // after collecting terms this results in:
    shaFrac = dispLim*(1 - (dy1-min(dy1,dy3))/s);
  end if;

  HShaDirTil = (1-shaFrac)*HDirTil;
  angInc = iAngInc;
  connect(HSkyDifTil, HShaSkyDifTil);
  connect(HGroDifTil, HShaGroDifTil);

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
If <code>use_betaInput=true</code>, 
the input <code>Ctrl</code> is used to control the angle beta,
such that <code>beta</code> in the figure equals <code>Ctrl</code>.
Note that <code>beta</code> must have radians as a unit.
If <code>use_displacementInput=true</code>,
the input <code>0 &lt; Ctrl &lt; 1</code> is used to control the horizontal
displacement of the fins.
For <code>Ctrl=0</code>, the fins are moved away from the window, 
into the plane of the figure below,
such that no sun light is blocked.
Either <code>use_displacementInput</code> or <code>use_betaInput</code>
should be false.
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
March 18, 2019 by Filip Jorissen:<br/>
Added control option for horizontal displacement.
Fixed bug in the implementation.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/992\">#992</a>.
</li>
<li>
April, 2017 by Iago Cupeiro:<br/>
Cleaned up implementation and documentation.
</li>
</ul>
</html>"));
end HorizontalFins;
