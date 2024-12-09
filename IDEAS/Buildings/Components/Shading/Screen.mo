within IDEAS.Buildings.Components.Shading;
model Screen "Controllable exterior screen"
  extends IDEAS.Buildings.Components.Shading.Interfaces.PartialShadingDevice(
    TSha = TShaScreen,
    TDryBul_internal = Ctrl_internal*TSha + (1-Ctrl_internal)*Te_internal,
    epsSw_shading = 1 - shaCorr - refSw_shading,
    final controlled = true,
    TEnvExpr(y = TEnv_screen),
    TeExpr(y = TDryBul_internal));

  parameter Real shaCorr(min=0, max=1) = 0.24
    "Shortwave transmittance of the screen";
  parameter Real refSw_shading(min=0, max=1) = 0
    "Shortwave reflectance of the screen";
    
protected
  constant Modelica.Units.SI.SpecificHeatCapacity cp_air = 1004 "Specific heat capacity";
  Modelica.Units.SI.Temperature TEnv_screen = Ctrl_internal*TSha + (1-Ctrl_internal)*TEnv_internal
    "Assuming the environment temperature is a weighted average of the shading device temperature and the ambient temperature";
  // This assumes that the window rejects 1-g_glazing of the incoming solar irradation is entirely converted into sensible heat
  Modelica.Units.SI.Temperature TShaScreen = Te_internal + (HSha*(1-g_glazing) + (H - HSha) * epsSw_shading) /(hSha + abs(m_flow)*cp_air)
    "Modified shading device heat balance";
initial equation
  assert( abs(shaCorr + refSw_shading + epsSw_shading - 1) < 1e-3, "In " + getInstanceName() +
    ": The sum of the screen transmittance 'shaCorr', reflectance 'refSw_shading' and absorptance 'epsSw_shading' does not equal one. This is non-physical.");
equation
  HShaDirTil = HDirTil*((1 - Ctrl_internal) + Ctrl_internal*shaCorr);
  HShaSkyDifTil = HSkyDifTil*((1 - Ctrl_internal) + Ctrl_internal*shaCorr);
  HShaGroDifTil = HGroDifTil*((1 - Ctrl_internal) + Ctrl_internal*shaCorr);

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
July 26, 2024 by Jelger Jansen:<br/>
Replace <code>Ctrl</code> by <code>Ctrl_internal</code> to avoid using a conditional component in a connect statement.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1367\">#1367</a>.
</li>
<li>
June 12, 2024 by Lucas Verleyen:<br/>
Remove limiter block. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1290\">#1290</a>.
</li>
<li>
September 7, 2023 by Filip Jorissen:<br/>
Created flow rate dependency for screen surface temperature.
</li>
<li>
July 9, 2023 by Filip Jorissen:<br/>
Added reflectance coefficient parameter. 
No longer converting transmitted direct solar irradiation into diffuse solar irradiation.
</li>
<li>
July 18, 2022 by Filip Jorissen:<br/>
Refactored for <a href=\"https://github.com/open-ideas/IDEAS/issues/1270\">#1270</a> for including thermal effect of screens.
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
