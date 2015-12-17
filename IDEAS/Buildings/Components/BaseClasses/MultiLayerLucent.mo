within IDEAS.Buildings.Components.BaseClasses;
model MultiLayerLucent "multiple non-opaque layers"

  parameter Modelica.SIunits.Area A "surface area";
  parameter Modelica.SIunits.Angle inc "inclination";
  parameter Integer nLay(min=1) "input: number of layers";
  parameter Real mSenFac = 1 "Correction factor for window thermal mass"
    annotation(Evaluate=true);
  parameter Modelica.SIunits.HeatCapacity C = sum(mats.d*mats.rho*mats.c*A)
    "Total heat capacity of the glazing sheets"
    annotation(Evaluate=true);
  parameter IDEAS.Buildings.Data.Interfaces.Material mats[nLay] "input";

  final parameter Modelica.SIunits.ThermalInsulance R=sum(nMat.R)
    "total specific thermal resistance";

  IDEAS.Buildings.Components.BaseClasses.MonoLayerLucent[nLay] nMat(
    each final A=A,
    each final inc=inc,
    final mat=mats,
    epsLw_a=cat(1, {0.85}, mats[1:nLay-1].epsLw_b),
    epsLw_b=cat(1, mats[2:nLay].epsLw_a, {0.85}));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nLay] port_gain
    "port for gains by embedded active layers"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealOutput iEpsLw_b
    "output of the interior emissivity for radiative heat losses"
    annotation (Placement(transformation(extent={{90,70},{110,90}})));
  Modelica.Blocks.Interfaces.RealOutput iEpsSw_b
    "output of the interior emissivity for radiative heat losses"
    annotation (Placement(transformation(extent={{90,30},{110,50}})));
  Modelica.Blocks.Interfaces.RealOutput iEpsLw_a
    "output of the interior emissivity for radiative heat losses"
    annotation (Placement(transformation(extent={{-90,70},{-110,90}})));
  Modelica.Blocks.Interfaces.RealOutput iEpsSw_a
    "output of the interior emissivity for radiative heat losses"
    annotation (Placement(transformation(extent={{-90,30},{-110,50}})));
  Modelica.Blocks.Interfaces.RealOutput area=A
    "output of the interior emissivity for radiative heat losses" annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={0,100})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=mSenFac
        *C) "A single lumped state for all sheets of glass"
    annotation (Placement(transformation(extent={{70,0},{90,-20}})));
equation
  connect(port_a, nMat[1].port_a);

  for j in 1:nLay - 1 loop
    connect(nMat[j].port_b, nMat[j + 1].port_a);
  end for;

  connect(nMat.port_gain, port_gain);
  connect(port_b, nMat[nLay].port_b);

  iEpsLw_a = mats[1].epsLw_a;
  iEpsSw_a = mats[1].epsSw_a;
  iEpsLw_b = mats[nLay].epsLw_b;
  iEpsSw_b = mats[nLay].epsSw_b;
  connect(port_b, heatCapacitor.port)
    annotation (Line(points={{100,0},{80,0}}, color={191,0,0}));
  annotation (
    Icon(graphics={
        Rectangle(
          extent={{-90,80},{20,-80}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward,
          pattern=LinePattern.None),
        Text(
          extent={{-150,113},{150,73}},
          textString="%name",
          lineColor={0,0,255}),
        Rectangle(
          extent={{20,80},{40,-80}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Forward,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{40,80},{80,-80}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward,
          pattern=LinePattern.None),
        Line(
          points={{20,80},{20,-80}},
          pattern=LinePattern.None,
          smooth=Smooth.None),
        Line(
          points={{40,80},{40,-80}},
          pattern=LinePattern.None,
          smooth=Smooth.None),
        Ellipse(
          extent={{-40,-42},{40,38}},
          lineColor={127,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-39,40},{39,-40}},
          lineColor={127,0,0},
          fontName="Calibri",
          origin={0,-1},
          rotation=90,
          textString="S")}),
    Documentation(info="<html>
<p>For the purpose of dynamic building simulation, the partial differential equation of the continuous time and space model of heat transport through a solid is most often simplified into ordinary differential equations with a finite number of parameters representing only one-dimensional heat transport through a construction layer. Within this context, the wall is modeled with lumped elements, i.e. a model where temperatures and heat fluxes are determined from a system composed of a sequence of discrete resistances and capacitances R_{n+1}, C_{n}. The number of capacitive elements $n$ used in modeling the transient thermal response of the wall denotes the order of the lumped capacitance model.</p>
<p align=\"center\"><img src=\"modelica://IDEAS/Images/equations/equation-pqp0E04K.png\"/></p>
<p>where <img src=\"modelica://IDEAS/Images/equations/equation-I7KXJhSH.png\"/> is the added energy to the lumped capacity, <img src=\"modelica://IDEAS/Images/equations/equation-B0HPmGTu.png\"/> is the temperature of the lumped capacity, <img src=\"modelica://IDEAS/Images/equations/equation-t7aqbnLB.png\"/> is the thermal capacity of the lumped capacity equal to<img src=\"modelica://IDEAS/Images/equations/equation-JieDs0oi.png\"/> for which rho denotes the density and <img src=\"modelica://IDEAS/Images/equations/equation-ml5CM4zK.png\"/> is the specific heat capacity of the material and <img src=\"modelica://IDEAS/Images/equations/equation-hOGNA6h5.png\"/> the equivalent thickness of the lumped element, where <img src=\"modelica://IDEAS/Images/equations/equation-1pDREAb7.png\"/> the heat flux through the lumped resistance and <img src=\"modelica://IDEAS/Images/equations/equation-XYf3O3hw.png\"/> is the total thermal resistance of the lumped resistance and where <img src=\"modelica://IDEAS/Images/equations/equation-dgS5sGAN.png\"/> are internal thermal source.</p>
</html>", revisions="<html>
<ul>
<li>
December 17, 2015, by Filip Jorissen:<br/>
Added a temperature state for decoupling non-linear systems of equations.
This is for issue <a href=https://github.com/open-ideas/IDEAS/issues/412>412</a>.
</li>
<li>
September 2, 2015, by Filip Jorissen:<br/>
epsLw is now defined as part of the material property of the solid layer, 
instead of the gas layer.
</li>
</ul>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})));
end MultiLayerLucent;
