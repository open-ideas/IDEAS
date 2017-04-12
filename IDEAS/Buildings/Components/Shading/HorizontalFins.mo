within IDEAS.Buildings.Components.Shading;
model HorizontalFins "Horizontal fin shading model"
  extends IDEAS.Buildings.Components.Shading.Interfaces.PartialShading(
                                                             final controlled=false);

  parameter Modelica.SIunits.Angle beta(min=0) = 0 "Rotation angle of shading fins with respect to horizontal.";
  parameter Modelica.SIunits.Length l(min=0) = 0.170 "Vertical distance between fins";
  parameter Modelica.SIunits.Length D(min=0) = 0.175 "Fin width";
  parameter Modelica.SIunits.Length w(min=0) = 0.032 "Fin thickness";

initial equation
  assert(beta > 0 and beta < 5*Modelica.Constants.pi/12, "beta between feasible values");
  assert(l > 0 and D > 0 and w > 0, "Fin parameters must be positive");
  assert(w < l, "Fin thickness must me smaller than distance between fins");

equation
  if noEvent(D*cos(beta)>(l-D*sin(beta))*tan(iAngInc)) then
    iSolDir = 0;
  else
    iSolDir = solDir*(l*sin(iAngInc)-(D+w*tan(iAngInc-beta))*cos(iAngInc-beta))/l*sin(iAngInc);
  end if;

  connect(solDif, iSolDif)
    annotation (Line(points={{-60,10},{40,10},{40,10}}, color={0,0,127}));
  connect(angInc, iAngInc) annotation (Line(points={{-60,-50},{-15,-50},{-15,-50},
          {40,-50}}, color={0,0,127}));
    annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-50,-100},{50,100}})),
    Documentation(info="<html>
<p>
Shading model of multiple, fixed horizontal fins in front of the window.
</p>
<p>
<img src=\"modelica://IDEAS/Resources/Images/Buildings/Components/Shading/HorizontalFins.png\"/>
</p>
</html>", revisions="<html>
<ul>
<li>
April 12, 2017 by Filip Jorissen:<br/>
Cleaned up implementation and documentation.
</li>
<li>
April, 2017 by Iago Cupeiro:<br/>
First implementation.
</li>
</ul>
</html>"));
end HorizontalFins;
