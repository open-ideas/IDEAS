within IDEAS.Buildings.Components.Shading.Interfaces;
partial model PartialShading "Window shading partial"
  parameter Boolean controlled=true
    "if true, shading has a control input"
    annotation(Evaluate=true);
  parameter Modelica.Units.SI.Area A_glazing "Surface area of the glazing";
  parameter Modelica.Units.SI.Area A_frame "Surface area of the frame";
  parameter Modelica.Units.SI.Angle inc "Surface inclination";
  parameter Modelica.Units.SI.Temperature Tenv_nom=280
    "Nominal temperature of environment";
  parameter Modelica.Units.SI.Emissivity epsSw_frame
    "Short wave solar absorption coefficient of the frame";
  parameter Modelica.Units.SI.Emissivity epsLw_frame
    "Long wave solar absorption coefficient of the frame";
  parameter Modelica.Units.SI.Emissivity epsLw_glazing
    "Long wave solar absorption coefficient of the glazing";
  parameter Modelica.Units.SI.Emissivity epsSw_shading = 0.8
    "Short wave emissivity of the shading object";
  parameter Real g_glazing(min=0,max=1)
    "Nominal shading coefficient of the glazing";
  parameter Boolean linCon = false "Linearise convective heat transfer"
    annotation(Evaluate=true);
  parameter Boolean linRad = false "Linearise radiative heat transfer"
    annotation(Evaluate=true);
  parameter Modelica.Units.SI.Angle azi "Window azimuth angle"
    annotation (Dialog(group="Window properties"));

  parameter Boolean haveBoundaryPorts = true "Include ports for setting boundary conditions";
  parameter Boolean haveFrame = A_frame*epsLw_frame > 0 "Frame enabled";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hSha = 12
    "Equivalent thermal conductance of the shading device";

  Modelica.Units.SI.Irradiance HSha = HShaDirTil + HShaSkyDifTil + HShaGroDifTil
    "Total shaded solar irradiance";
  Modelica.Units.SI.Irradiance H = HDirTil + HSkyDifTil + HGroDifTil
    "Total unshaded solar irradiance";
  // This assumes a heat balance between the outdoor air and the shading device only.
  Modelica.Blocks.Interfaces.RealInput HDirTil
    "Direct solar illuminance on surface" annotation (Placement(
        transformation(extent={{-80,30},{-40,70}}), iconTransformation(extent={
            {-60,50},{-40,70}})));
  Modelica.Blocks.Interfaces.RealInput HSkyDifTil
    "Diffuse sky solar illuminance on tilted surface" annotation (Placement(
        transformation(extent={{-80,10},{-40,50}}),  iconTransformation(extent={{-60,30},
            {-40,50}})));
  Modelica.Blocks.Interfaces.RealInput HGroDifTil
    "Diffuse ground solar illuminance on tilted surface" annotation (Placement(
        transformation(extent={{-80,-10},{-40,30}}), iconTransformation(extent={{-60,10},
            {-40,30}})));
  Modelica.Blocks.Interfaces.RealInput angZen
    "Angle of incidence" annotation (
      Placement(transformation(extent={{-80,-90},{-40,-50}}),
        iconTransformation(extent={{-60,-70},{-40,-50}})));
  Modelica.Blocks.Interfaces.RealOutput HShaDirTil
    "Shaded direct solar illuminance on surface" annotation (Placement(
        transformation(extent={{20,30},{60,70}}), iconTransformation(extent={{
            40,50},{60,70}})));
  Modelica.Blocks.Interfaces.RealOutput HShaSkyDifTil
    "Shaded diffuse sky solar illuminance on tilted surface" annotation (Placement(
        transformation(extent={{20,10},{60,50}}),  iconTransformation(extent={{40,30},
            {60,50}})));
  Modelica.Blocks.Interfaces.RealOutput HShaGroDifTil
    "Shaded diffuse ground solar illuminance on tilted surface" annotation (Placement(
        visible = true,transformation(extent = {{20, -10}, {60, 30}}, rotation = 0), iconTransformation(extent = {{40, 10}, {60, 30}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput iAngInc
    "Angle of incidence after transmittance through (possible) shading"
    annotation (Placement(transformation(extent={{20,-70},{60,-30}}),
        iconTransformation(extent={{40,-50},{60,-30}})));

  Modelica.Blocks.Interfaces.RealInput angInc "Inclination angle" annotation (
      Placement(transformation(extent={{-80,-70},{-40,-30}}),
        iconTransformation(extent={{-60,-50},{-40,-30}})));
  Modelica.Blocks.Interfaces.RealInput angAzi "Azimuth angle" annotation (
      Placement(transformation(extent={{-80,-110},{-40,-70}}),
        iconTransformation(extent={{-60,-90},{-40,-70}})));
  Modelica.Blocks.Interfaces.RealInput Ctrl(min=0, max=1) if controlled
    "Control signal between 0 and 1, i.e. 1 is fully closed" annotation (
      Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=-90,
        origin={-10,-110}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={0,-100})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_frame if haveBoundaryPorts and haveFrame annotation (
    Placement(visible = true, transformation(origin = {100, 160}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(extent = {{40, 170}, {60, 190}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_glazing if haveBoundaryPorts annotation (
    Placement(visible = true, transformation(origin = {100, 120}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(extent = {{40, 130}, {60, 150}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput TEnv(displayUnit = "degC", unit = "K") if haveBoundaryPorts
  "Environment temperature" annotation (
    Placement(visible = true, transformation(origin = {-60, 90}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-50, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Te(displayUnit = "degC", unit = "K") if haveBoundaryPorts
   annotation (
    Placement(visible = true, transformation(extent = {{-80, 110}, {-40, 150}}, rotation = 0), iconTransformation(origin = {-50, 140}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput hForcedConExt(unit = "W/(m2.K)") if haveBoundaryPorts
   annotation (
    Placement(visible = true, transformation(extent = {{-80, 90}, {-40, 130}}, rotation = 0), iconTransformation(origin = {-50, 120}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput TDryBul if haveBoundaryPorts "Exterior surface air temperature" annotation (
    Placement(visible = true, transformation(extent = {{20, -30}, {60, 10}}, rotation = 0), iconTransformation(extent = {{40, -10}, {60, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput m_flow annotation(
    Placement(visible = true, transformation(origin = {-20, 0}, extent = {{80, -110}, {40, -70}}, rotation = 0), iconTransformation(origin = {30, -100}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
protected
  Modelica.Blocks.Interfaces.RealInput Te_internal(unit="K");
  Modelica.Blocks.Interfaces.RealInput Ctrl_internal
    "Internal variable for the conditional control input";
  Modelica.Units.SI.Temperature TSha = Te_internal + (H - HSha) * epsSw_shading /hSha
    "Simplified static heat balance to compute the shading object temperature";
equation
  connect(Te,Te_internal);
  connect(Ctrl,Ctrl_internal);
  if not haveBoundaryPorts then
    Te_internal = 273.15;
  end if;
  if not controlled then
    Ctrl_internal=0;
  end if;
  assert(0 <= Ctrl_internal and Ctrl_internal <= 1,
         "The control input to the screen is not in range [0,1], which is non-physical 
         and leads to unrealistic results. Please check the screen input.");
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 200}})),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 200}}), graphics={  Polygon(fillColor = {255, 255, 170}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-50, 80}, {0, 60}, {4, 60}, {4, -20}, {-50, 0}, {-50, 80}}), Polygon(fillColor = {179, 179, 179}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{4, 40}, {50, 20}, {50, -32}, {20, -20}, {4, -20}, {4, 40}}), Line(points = {{0, 60}, {20, 60}, {20, 80}, {50, 80}}, color = {95, 95, 95}), Line(points = {{0, -20}, {20, -20}, {20, -70}, {20, -70}, {50, -70}}, color = {95, 95, 95}), Line(points = {{0, 60}, {0, 66}, {0, 100}, {50, 100}}, color = {95, 95, 95}), Line(points = {{0, -20}, {0, -90}, {50, -90}}, color = {95, 95, 95}), Line(points = {{4, 60}, {4, -20}}, thickness = 0.5)}),
    Documentation(revisions="<html>
<ul>
<li>
July 1, 2024 by Lucas Verleyen:<br/>
Add assert for control input. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1290\">#1290</a>.
</li>
<li>
July 18, 2022 by Filip Jorissen:<br/>
Refactored for #1270 for including thermal effect of screens.
</li>
<li>
March 2, 2022 by Filip Jorissen:<br/>
Added HSha output for the total solar irradiance.
</li>
<li>
July 18, 2016 by Filip Jorissen:<br/>
Cleaned up implementation and documentation.
</li>
</ul>
</html>", info = "<html>
<p>Partial model for shading computations.</p>
</html>"));
end PartialShading;
