within IDEAS.Buildings.Components.Shading;
model BuildingShade
  "Component for modeling shade cast by distant objects such as buildings and treelines"
  extends IDEAS.Buildings.Components.Interfaces.StateShading(final controlled=false);

  parameter Modelica.SIunits.Length L "Horizontal distance to object";
  parameter Modelica.SIunits.Length dh
    "Height difference between top of object and top of window";
  parameter Modelica.SIunits.Length hWin = 1 "Window height";

  Real tanZen = tan(min(angZen, Modelica.Constants.pi/2.2));

equation
  if noEvent(tanZen < L/dh) then
    iSolDir=0;
  elseif noEvent(tanZen > L/2/dh) then
    iSolDir=solDir * (L/tanZen-dh)/dh;
  else
    iSolDir=solDir;
  end if;

  iSolDif = solDif;
  angInc = iAngInc;

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-50,-100},{50,100}}),
        graphics),
    Diagram(graphics),
    Documentation(info="<html>
<p>This model assumes that the window is surrounded by an opaque object with constant height at distance L.</p>
</html>", revisions="<html>
<ul>
<li>
June 12, 2015, by Filip Jorissen:<br/>
Initial implementation.
</li>
</ul>
</html>"));
end BuildingShade;
