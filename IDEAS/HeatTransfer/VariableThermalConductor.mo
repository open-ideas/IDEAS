within IDEAS.HeatTransfer;
model VariableThermalConductor
  "Thermal conductor (lumped) with conductance (G-value) as input"
  extends Modelica.Thermal.HeatTransfer.Interfaces.Element1D;

  Modelica.Blocks.Interfaces.RealInput G
    "Variable thermal conductance of material"
    annotation (Placement(transformation(extent={{-128,40},{-88,80}})));
equation
  Q_flow = G*dT;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={Rectangle(
          extent={{-90,70},{90,-70}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward),Line(
          points={{-90,70},{-90,-70}},
          color={0,0,0},
          thickness=0.5),Line(
          points={{90,70},{90,-70}},
          color={0,0,0},
          thickness=0.5),Text(
          extent={{-150,115},{150,75}},
          textString="%name",
          lineColor={0,0,255}),Text(
          extent={{-150,-75},{150,-105}},
          lineColor={0,0,0},
          textString="G=%G")}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={Line(
          points={{-80,0},{80,0}},
          color={255,0,0},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Filled}),Text(
          extent={{-26,-10},{27,-39}},
          lineColor={255,0,0},
          textString="Q_flow"),Text(
          extent={{-80,50},{80,20}},
          lineColor={0,0,0},
          textString="dT = port_a.T - port_b.T")}),
    Documentation(info="<html>
<p><h4>Description</h4></p>
<p>This is a model for transport of heat without storing it. It may be used for complicated geometries where the thermal conductance G (= inverse of thermal resistance) is not a parameter but a variable. </p>
<p><h4>Assumptions and limitations</h4></p>
<p><ol>
<li>Lumped (no discretization inside this element)</li>
<li>Variable G as realInput</li>
</ol></p>
<p><h4>Model use</h4></p>
<p>If the component consists mainly of one type of material and a regular geometry, it may be calculated, e.g., with one of the following equations: </p>
<p><ul>
<li>Conductance for a <b>box</b> geometry under the assumption that heat flows along the box length: </li>
<pre>    G = k*A/L
    k: Thermal conductivity (material constant)
    A: Area of box
    L: Length of box

     </pre>
<li>Conductance for a <b>cylindrical</b> geometry under the assumption that heat flows from the inside to the outside radius of the cylinder: </li>
</ul></p>
<pre>    G = 2*pi*k*L/log(r_out/r_in)
    pi   : Modelica.Constants.pi
    k    : Thermal conductivity (material constant)
    L    : Length of cylinder
    log  : Modelica.Math.log;
    r_out: Outer radius of cylinder
    r_in : Inner radius of cylinder

     

    Typical values for k at 20 degC in W/(m.K):
      aluminium   220
      concrete      1
      copper      384
      iron         74
      silver      407
      steel        45 .. 15 (V2A)

      wood         0.1 ... 0.2 </pre>
<p><h4>Validation</h4></p>
<p>None </p>
</html>"));
end VariableThermalConductor;
