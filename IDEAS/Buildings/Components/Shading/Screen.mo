within IDEAS.Buildings.Components.Shading;
model Screen "Controllable exterior screen"
  extends IDEAS.Buildings.Components.Shading.Interfaces.PartialShadingDevice(
    TSha = TShaScreen,
    TDryBul_internal = limiter.y*TSha + (1-limiter.y)*Te_internal,
    epsSw_shading = 1 - shaCorr,
    final controlled = true,
    TEnvExpr(y = TEnv_screen),
    TeExpr(y = TDryBul_internal));

  parameter Real shaCorr(min=0, max=1) = 0.24
    "Shortwave transmittance of the screen";

protected
  Modelica.Units.SI.Temperature TEnv_screen = limiter.y*TSha + (1-limiter.y)*TEnv_internal
    "Assuming the environment temperature is a weighted average of the shading device temperature and the ambient temperature";
  Modelica.Blocks.Nonlinear.Limiter limiter(uMin=0, uMax=1)
    "Limits the control signal to avoid incorrect use by the user";
  // This assumes that the window rejects 1-g_glazing of the incoming solar irradation is entirely converted into sensible heat
  Modelica.Units.SI.Temperature TShaScreen = Te_internal + (HSha*(1-g_glazing) + (H - HSha) * epsSw_shading) /hSha
    "Modified shading device heat balance";
initial equation
  assert(shaCorr + epsSw_shading <= 1, "In " + getInstanceName() +
    ": The sum of the screen transmittance 'shaCorr' and absorptance 'epsSw_shading' is larger than one. This is non-physical.");
equation
  HShaDirTil = HDirTil*(1 - limiter.y);
  HShaSkyDifTil = HSkyDifTil*(1 - limiter.y) + HSkyDifTil*limiter.y*shaCorr + HDirTil*limiter.y*shaCorr;
  HShaGroDifTil = HGroDifTil*(1 - limiter.y) + HGroDifTil*limiter.y*shaCorr;

  connect(limiter.u, Ctrl);
  connect(angInc, iAngInc) annotation (Line(points={{-60,-50},{-14,-50},{-14,
          -50},{40,-50}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 200}})),
    Documentation(info="<html>
<p>
Shading model of a controllable screen. 
The transmitted direct solar irradiance varies linearly between [0, 1] with the control input. 
A fraction <code>shaCorr</code> is converted into diffuse light that enters the building.
</p>
</html>", revisions="<html>
<ul>
<li>
July 18, 2022 by Filip Jorissen:<br/>
Refactored for #1270 for including thermal effect of screens.
</li>
<li>
May 26, 2017 by Filip Jorissen:<br/>
Revised implementation for renamed
ports <code>HDirTil</code> etc.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/735\">
#735</a>.
</li>
<li>
July 18, 2016 by Filip Jorissen:<br/>
Cleaned up implementation and documentation.
</li>
</ul>
</html>"),
  Diagram(coordinateSystem(extent = {{-100, -100}, {100, 200}})));
end Screen;
