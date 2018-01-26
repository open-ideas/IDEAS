within IDEAS.Buildings.Components.Shading;
model HorizontalFins "horizontal fins shading"
  extends IDEAS.Buildings.Components.Shading.Interfaces.PartialShading(
                                                             final controlled=false);

  parameter Modelica.SIunits.Angle beta= Modelica.Constants.pi/6 "inclination angle of shading fins";
  parameter Modelica.SIunits.Length l=0.170 "distance between shading fins, in meters";
  parameter Modelica.SIunits.Length D=0.175 "size of the fins, in meters";
  parameter Modelica.SIunits.Length w=0.032 "width of the fins, in meters";

  Real shaFrac "shadowing fraction over the window";
  Real tipShadow;
  Real headShadow;
  Real footShadow;
  Real totalShadow;

protected
  final Modelica.SIunits.Angle angAlt = Modelica.Constants.pi/2 - angZen "altitude angle";
  final Modelica.SIunits.Angle projectedAltitudeAngle = -atan(tan(angAlt)/cos(angAzi+azi));

initial equation
  assert(beta > 0 and beta < acos(w/l), "beta between feasible values");
  assert(l > 0 and D > 0 and w > 0, "positive parameters for fins description");

equation
  if angAlt > beta then
    tipShadow = sqrt(D*D+w*w)*(cos(beta-atan(w/D))*tan(projectedAltitudeAngle)-sin(beta-atan(w/D)));
    headShadow = 0;
    footShadow = 0;
    totalShadow = 0;
    if tipShadow > l then
      shaFrac = 1;
    else
      shaFrac = min(1, tipShadow/l);
    end if;
  else
    headShadow = max(0, -1 * ((D*sin(Modelica.Constants.pi/2 - beta)/tan(Modelica.Constants.pi/2 - projectedAltitudeAngle))-D*cos(Modelica.Constants.pi/2-beta)));
    footShadow = max(0, w * (cos(beta)+ sin(beta)*tan(projectedAltitudeAngle)));
    tipShadow = 0;
    totalShadow = headShadow + footShadow;
    shaFrac = min(1, totalShadow/l);
  end if;

  iSolDir = (1-shaFrac)*solDir;
  angInc = iAngInc;
  connect(solDif, iSolDif);

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
