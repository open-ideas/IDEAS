within IDEAS.Buildings.Components.BaseClasses.ConvectiveHeatTransfer;
model InteriorConvection "interior surface convection"

  parameter Modelica.Units.SI.Area A "surface area";
  parameter Modelica.Units.SI.Angle inc "inclination";

  parameter Boolean linearise = false
    "= true, if convective heat transfer should be linearised"
    annotation(Evaluate=true);
  parameter Modelica.Units.SI.TemperatureDifference dT_nominal=-2
    "Nominal temperature difference used for linearisation, negative temperatures indicate the solid is colder"
    annotation (Evaluate=true, enable=linearise);
  parameter Modelica.Units.SI.Length hZone=2.7
    "Zone height, for calculation of hydraulic diameter"
    annotation (Dialog(tab="Advanced"));
  parameter Modelica.Units.SI.Length DhWall=4*A/(2*A/hZone + 2*hZone)
    "Hydraulic diameter for walls" annotation (Dialog(tab="Advanced"));
  parameter Modelica.Units.SI.Length DhFloor=sqrt(A)
    "Hydraulic diameter for ceiling/floor" annotation (Dialog(tab="Advanced"));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

protected
  Modelica.Units.SI.TemperatureDifference dT(start=0);
  final parameter Real coeffWall = A*1.823/DhWall^0.121
    "For avoiding calculation of power at every time step";
  final parameter Real coeffFloor = A*2.175/DhFloor^0.076
    "For avoiding calculations at every time step";
  final parameter Real coeffCeiling = A*0.704/DhFloor^0.601
    "For avoiding calculations at every time step";
  final parameter Boolean isCeiling=abs(sin(inc)) < 10E-5 and cos(inc) > 0
    "true if ceiling"
    annotation(Evaluate=true);
  final parameter Boolean isFloor=abs(sin(inc)) < 10E-5 and cos(inc) < 0
    "true if floor"
    annotation(Evaluate=true);
  final parameter Real ceilingSign = if isCeiling then 1 else -1
    "Coefficient for buoyancy direction"
    annotation(Evaluate=true);
equation
    if isCeiling or isFloor then
      if linearise then
        port_a.Q_flow = if ceilingSign*dT_nominal > 0 then
              dT*coeffCeiling*abs(dT_nominal)^0.133
              else
              dT*coeffFloor*abs(dT_nominal)^0.308;
      else
        port_a.Q_flow = IDEAS.Utilities.Math.Functions.spliceFunction(
              x=ceilingSign*dT,
              pos=sign(dT)*coeffCeiling*abs(dT)^1.133,
              neg=sign(dT)*coeffFloor*abs(dT)^1.308,
              deltax = 0.1);
      end if;
    else
      if linearise then
        port_a.Q_flow = dT*coeffWall*abs(dT_nominal)^0.293;
      else
        port_a.Q_flow = sign(dT)*coeffWall*abs(dT)^1.293;
      end if;
    end if;

  port_a.Q_flow + port_b.Q_flow = 0;
  dT = port_a.T - port_b.T;

  annotation (Icon(graphics={
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
          thickness=0.5)}), Documentation(info="<html>
<p>The interior natural convective heat transfer coefficient <i>h<sub>c,i</sub></i> is computed for each interior surface as</p>
<p><i>h<sub>c,i</sub> = n<sub>1</sub> &#183; D<sup>n2</sup> &#183; (T<sub>a</sub> - T<sub>s</sub>)<sup>n3</sub></i></p>
<p>where</p>
<ul>
<li><i>D</i> is the characteristic length of the surface,</li>
<li><i>T<sub>a</sub></i> is the indoor air temperature, and</li> 
<li><i>n<sub>i</sub></i> are correlation coefficients.</li>
</ul>
<p>The parameters {<i>n<sub>1</sub>, n<sub>2</sub>, n<sub>3</sub></i>} are equal to</p>
<ul>
<li>{1.823, -0.121, 0.293} for vertical surfaces [Awbi 1999],</li>
<li>{2.175, -0.076, 0.308} for horizontal surfaces, wherefore the heat flux is in the same direction as the buoyancy force [Khalifa 2001], and</li>
<li>{0.704, -0.601, 0.133} for horizontal surfaces, wherefore the heat flux is in the opposite direction as the buoyancy force [Awbi 1999].</li>
</ul>
<p>The interior natural convective heat transfer coefficient is only described as a function 
of the temperature difference. Similar to the thermal model for heat transfer through a wall, 
a thermal circuit formulation for the direct radiant exchange between surfaces can be derived 
[Buchberg 1955, Oppenheim 1956].</p>
<h4>References</h4>
<p>
[Awbi 1999]: H.B. Awbi, and A. Hatton, 
\"<a href=\"https://doi.org/10.1016/S0378-7788(99)00004-3\">Natural convection from heated room surfaces</a>\", 
<i>Energy and Buildings</i>, vol. 30, no. 3, pp. 233&ndash;244, 1999.<br>
[Buchberg 1955]: H. Buchberg, \"Electric analogue prediction of thermal behavior of an inhabitable enclosure\", <i>ASHRAE Transactions</i>, vol. 61, pp. 339&ndash;386, 1955.<br>
[Khalifa 2001]: A.J.N. Khalifa, 
\"<a href=\"https://doi.org/10.1016/S0196-8904(00)00043-1\">Natural convective heat transfer coefficient &ndash; a review: II. Surfaces in two- and three-dimensional enclosures</a>\", 
<i>Energy Conversion and Management</i>, vol. 42, no. 4, pp. 505&ndash;517, 2001.<br>
[Oppenheim 1956]: A.K. Oppenheim, 
\"<a href=\"https://asmedigitalcollection.asme.org/fluidsengineering/article/78/4/735/1137224/Discussion-Radiation-Analysis-by-the-Network\">Radiation analysis by the network method</a>\", 
<i>Transaction of American Society of Mechanical Engineers</i>, vol. 78, pp. 725&ndash;735, 1956.
</p>
</html>", revisions="<html>
<ul>
<li>
June 17, 2025, by Lucas Verleyen:<br/>
Replaced images with inline equations.
See <a href=https://github.com/open-ideas/IDEAS/issues/1440>#1440</a>.
</li>
<li>
July 11, 2016 by Filip Jorissen:<br/>
Adjusted formulation of correlation such that the Jacobian computation of 
non-linear algebraic loops do not lead to negative exponents.
</li>
</ul>
</html>"));
end InteriorConvection;
