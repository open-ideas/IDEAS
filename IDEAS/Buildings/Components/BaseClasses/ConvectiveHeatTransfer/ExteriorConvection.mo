within IDEAS.Buildings.Components.BaseClasses.ConvectiveHeatTransfer;
model ExteriorConvection "exterior surface convection"

  parameter Modelica.SIunits.Area A "surface area";
  parameter Boolean linearise = false "Use constant convection coefficient"
    annotation(Evaluate=true);
  parameter Modelica.SIunits.CoefficientOfHeatTransfer hConExtLin = 18.3
    "Fixed exterior convection coefficient used when linearising equations"
     annotation(Dialog(enable=linearize));
  parameter Modelica.SIunits.Angle inc "Surface inclination";
  parameter Modelica.SIunits.Angle azi "Surface azimith";



  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));

  Modelica.Blocks.Interfaces.RealInput Te(unit="K",displayUnit="degC")
    annotation (Placement(transformation(extent={{-120,-68},{-80,-28}})));
  Modelica.Blocks.Interfaces.RealInput hForcedConExt(unit="W/(m2.K)")
    "Exterior convective heat transfer coefficient"
    annotation (Placement(transformation(extent={{-120,-110},{-80,-70}})));

protected
  Modelica.SIunits.CoefficientOfHeatTransfer hNatConvExt
    "Heat transfer coefficient for natural convection" annotation ();
  Modelica.SIunits.CoefficientOfHeatTransfer hSmooth
    "Heat transfer coefficient for a smooth (glass) surface" annotation ();
  Modelica.SIunits.CoefficientOfHeatTransfer hConExt
    "Heat transfer coefficient for combined forced and natural convection"
    annotation ();

  // Only used to simulate with fixed conv coeffs: applies to all surfaces.
  parameter Boolean UseFixedHTC=false "Set to true to use fixed conv coeffs";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer fixedHTC=10 "Only used if UseFixedHTC=true";

  final parameter Boolean isCeiling=abs(sin(inc)) < 10E-5 and cos(inc) > 0
    "true if ceiling" annotation (Evaluate=true);
  final parameter Boolean isFloor=abs(sin(inc)) < 10E-5 and cos(inc) < 0
    "true if floor" annotation (Evaluate=true);

  // Natural convection correlation coefficients based on TARP algorithm.
  // Taken from Equations 3.75 to 3.77 of EnergyPlus Engineering Reference (p94).
  Real C;
  constant Real C_vertical=1.31 "TARP coeff";
  constant Real C_horz_buoyant=1.509 "TARP coeff";
  constant Real C_horz_stable=0.76 "TARP coeff";
  constant Real n=1/3 "TARP coeff";

  Modelica.SIunits.TemperatureDifference dT "Surface temperature minus outdoor air temperature" annotation ();

  constant Real R=1 "Roughness factor (for testing)";

equation

  // Assign empirical coefficient according to flow regime.
  if isCeiling then
    if dT > 0 then
      C = C_horz_buoyant;
    else
      C = C_horz_stable;
    end if;
  elseif isFloor then
    if dT < 0 then
      C = C_horz_buoyant;
    else
      C = C_horz_stable;
    end if;
  else
    C = C_vertical;
  end if;

  // Calculate coefficient for natural convection.
  hNatConvExt = C * abs(dT)^n;

  // Evaluate combined coefficient for natural and forced convection, or use fixed values.
  if UseFixedHTC then
    hSmooth = 0;
    hConExt = fixedHTC;
  elseif linearise then
    hSmooth = 0;
    hConExt = hConExtLin;
  else
    hSmooth = (hNatConvExt^2 + hForcedConExt^2)^0.5;
    hConExt = (1-R)*hNatConvExt + R*hSmooth;
  end if;

  // Apply Newton's law at exterior surface.
  dT = port_a.T - Te;
  port_a.Q_flow = A * hConExt * dT;

  annotation (
    Icon(graphics={
        Rectangle(
          extent={{-90,80},{-60,-80}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward,
          pattern=LinePattern.None),
        Line(points={{-60,20},{76,20}}, color={191,0,0}),
        Line(points={{-34,80},{-34,-80}}, color={0,127,255}),
        Line(points={{-60,-20},{76,-20}}, color={191,0,0}),
        Line(points={{56,30},{76,20}}, color={191,0,0}),
        Line(points={{56,10},{76,20}}, color={191,0,0}),
        Line(points={{56,-10},{76,-20}}, color={191,0,0}),
        Line(points={{56,-30},{76,-20}}, color={191,0,0}),
        Line(points={{6,80},{6,-80}}, color={0,127,255}),
        Line(points={{40,80},{40,-80}}, color={0,127,255}),
        Line(points={{76,80},{76,-80}}, color={0,127,255}),
        Line(points={{-34,-80},{-44,-60}}, color={0,127,255}),
        Line(points={{-34,-80},{-24,-60}}, color={0,127,255}),
        Line(points={{6,-80},{-4,-60}}, color={0,127,255}),
        Line(points={{6,-80},{16,-60}}, color={0,127,255}),
        Line(points={{40,-80},{30,-60}}, color={0,127,255}),
        Line(points={{40,-80},{50,-60}}, color={0,127,255}),
        Line(points={{76,-80},{66,-60}}, color={0,127,255}),
        Line(points={{76,-80},{86,-60}}, color={0,127,255}),
        Text(
          extent={{-150,-90},{150,-130}},
          textString="%name",
          lineColor={0,0,255}),
        Line(
          points={{-60,80},{-60,-80}},
          color={0,0,0},
          thickness=0.5)}),
    Documentation(info="<html>
<p>
The exterior convective heat flow is computed as 
<img alt=\"equation\" src=\"modelica://IDEAS/Images/equations/equation-dlroqBUD.png\"/>where 
<img alt=\"equation\" src=\"modelica://IDEAS/Images/equations/equation-pvb42RGk.png\"/> is the surface area, 
<img alt=\"equation\" src=\"modelica://IDEAS/Images/equations/equation-EFr6uClx.png\"/> is the dry-bulb exterior air temperature, 
<img alt=\"equation\" src=\"modelica://IDEAS/Images/equations/equation-9BU57cj4.png\"/> is the surface temperature and 
<img alt=\"equation\" src=\"modelica://IDEAS/Images/equations/equation-HvwkeunV.png\"/> is the wind speed in the undisturbed flow at 
10 meter above the ground and where the stated correlation is valid for a 
<img alt=\"equation\" src=\"modelica://IDEAS/Images/equations/equation-HvwkeunV.png\"/> range of [0.15,7.5] meter per second 
<a href=\"IDEAS.Buildings.UsersGuide.References\">[Defraeye 2011]</a>.
 The <img alt=\"equation\" src=\"modelica://IDEAS/Images/equations/equation-HvwkeunV.png\"/>-dependent term denoting the exterior 
convective heat transfer coefficient <img alt=\"equation\" src=\"modelica://IDEAS/Images/equations/equation-W7Ft8vaa.png\"/> is 
determined as <img alt=\"equation\" src=\"modelica://IDEAS/Images/equations/equation-aZcbMNkz.png\"/> in order to take into 
account buoyancy effects at low wind speeds <a href=\"IDEAS.Buildings.UsersGuide.References\">[Jurges 1924]</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
November 15, 2016, by Filip Jorissen:<br/>
Revised documentation for IDEAS 1.0.
</li>
</ul>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    experiment(
      StartTime=2678400,
      StopTime=3283200,
      Interval=299.99988,
      Tolerance=1e-06,
      __Dymola_Algorithm="Lsodar"));
end ExteriorConvection;
