within IDEAS.Buildings.Components.Shading;
model HorizontalFins "horizontal fins shading"
  extends IDEAS.Buildings.Components.Shading.Interfaces.PartialShading(
                                                             final controlled=false);

  parameter Modelica.SIunits.Angle beta= Modelica.Constants.pi/6 "inclination angle of shading fins";
  parameter Modelica.SIunits.Length l=0.170 "distance between shading fins, in meters";
  parameter Modelica.SIunits.Length D=0.175 "size of the fins, in meters";
  parameter Modelica.SIunits.Length w=0.032 "width of the fins, in meters";

initial equation
  assert(beta > 0 and beta < 5*Modelica.Constants.pi/12, "beta between feasible values");
  assert(l > 0 and D > 0 and w > 0, "positive parameters for fins description");

equation
  if noEvent(D*cos(beta)>(l-D*sin(beta))*tan(iAngInc)) then
    iSolDir = 0;
  else
    iSolDir = solDir*(l*sin(iAngInc)-(D+w*tan(iAngInc-beta))*cos(iAngInc-beta))/l*sin(iAngInc);
  end if;

  angInc = iAngInc;

  connect(solDif, iSolDif);

    annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-50,-100},{50,100}})),
    Documentation(info="<html>
<p>Shading model of horizontal fins in function of the inclination angle of the fins.</p>
<p><br><img src=\"modelica://Shading/../Pictures/figure_fins.PNG\"/></p>
</html>", revisions="<html>
<ul>
<li>
April, 2017 by Iago Cupeiro:<br/>
Cleaned up implementation and documentation.
</li>
</ul>
</html>"));
end HorizontalFins;
