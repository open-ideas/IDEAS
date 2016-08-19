within IDEAS.Buildings.Components.BaseClasses.ConductiveHeatTransfer;
model MonoLayerDynamic "Dynamic layer for uniform solid."

  parameter Modelica.SIunits.Area A "Layer area";
  parameter IDEAS.Buildings.Data.Interfaces.Material mat "Layer material";
  parameter Modelica.SIunits.Temperature T_start=293.15
    "Start temperature for each of the states";
  parameter Integer nStaMin(min=1) = 2 "Minimum number of states";
  parameter Boolean placeCapacityAtSurf_b = true
    "Set to true to place last capacity at the surface b of the layer.";
  parameter Modelica.Fluid.Types.Dynamics energyDynamics= Modelica.Fluid.Types.Dynamics.FixedInitial
    "Static (steady state) or transient (dynamic) thermal conduction model"
    annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));
  final parameter Boolean present=mat.d > Modelica.Constants.small;
  final parameter Integer nSta=max(nStaMin, mat.nSta) "Number of states";
  final parameter Real R=mat.R "Total specific thermal resistance";
  final parameter Modelica.SIunits.HeatCapacity Ctot=A*mat.rho*mat.c*mat.d
    "Total heat capacity";

  Modelica.Blocks.Interfaces.RealOutput E(unit="J") = sum(T .* C);

protected
  final parameter Integer nRes = if placeCapacityAtSurf_b then max(nSta - 1, 1) else nSta
    "Number of thermal resistances";
  final parameter Modelica.SIunits.ThermalConductance[nRes] G=fill(
     nRes*A/R, nRes);
  final parameter Modelica.SIunits.HeatCapacity[nSta] C=Ctot*(if nSta <= 2 or not placeCapacityAtSurf_b
       then ones(nSta)/nSta else cat(
      1,
      {0.5},
      ones(nSta - 2),
      {0.5})/(nSta - 1));
  final parameter Real[nSta] Cinv(unit="K/J") = ones(nSta) ./ C
    "Dummy parameter for efficiently handling check for division by zero";
  Modelica.SIunits.Temperature[nSta] T "Temperature at the states";
  Modelica.SIunits.HeatFlowRate[nRes] Q_flow
    "Heat flow rate from state i to i-1";

public
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

initial equation
  if energyDynamics== Modelica.Fluid.Types.Dynamics.FixedInitial then
    T = ones(nSta)*T_start;
  elseif energyDynamics== Modelica.Fluid.Types.Dynamics.SteadyStateInitial then
    der(T)=zeros(nSta);
  end if;
  assert(nSta >= 1, "Number of states needs to be higher than zero.");
  assert(abs(sum(C) - A*mat.rho*mat.c*mat.d) < 1e-6, "Verification error in MonLayerDynamic");
  assert(abs(sum(ones(size(G, 1)) ./ G) - R/A) < 1e-6, "Verification error in MonLayerDynamic");
  assert(not energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState, "MonoLayerDynamic is configured to steady state, which is not the scope of this model!");
equation
  port_a.T = T[1];

  if nSta > 1 and placeCapacityAtSurf_b then
    der(T[1]) = (port_a.Q_flow - Q_flow[1])*Cinv[1];
    der(T[nSta]) = (Q_flow[nSta - 1] + port_b.Q_flow)*Cinv[nSta];
    port_b.T = T[nSta];

    // Q_flow[i] is heat flowing from (i-1) to (i)
    for i in 1:nSta - 1 loop
      (T[i] - T[i + 1])*G[i] = Q_flow[i];
    end for;
    for i in 2:nSta - 1 loop
      der(T[i]) = (Q_flow[i - 1] - Q_flow[i])*Cinv[i];
    end for;
  elseif nSta > 1 and not placeCapacityAtSurf_b then
    der(T[1]) = (port_a.Q_flow - Q_flow[1])*Cinv[1];
    // Q_flow[i] is heat flowing from (i-1) to (i)
    for i in 1:nSta - 1 loop
      (T[i] - T[i + 1])*G[i] = Q_flow[i];
    end for;
    (T[end] - port_b.T)*G[end] = Q_flow[end];
    port_b.Q_flow = - Q_flow[end];
    for i in 2:nSta loop
      der(T[i]) = (Q_flow[i - 1] - Q_flow[i])*Cinv[i];
    end for;
  else
    der(port_a.T) = (port_a.Q_flow + port_b.Q_flow)*Cinv[1];
    Q_flow[1] = -port_b.Q_flow;
    Q_flow[1] = (port_a.T - port_b.T)*G[1];
  end if;

  annotation (
    Diagram(graphics),
    Icon(graphics={
        Rectangle(
          extent={{-90,80},{90,-80}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward,
          pattern=LinePattern.None),
        Text(
          extent={{-150,113},{150,73}},
          textString="%name",
          lineColor={0,0,255}),
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
February 10, 2016, by Filip Jorissen and Damien Picard:<br/>
Revised implementation.
</li>
</ul>
</html>"));
end MonoLayerDynamic;
