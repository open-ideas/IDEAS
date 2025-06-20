within IDEAS.Buildings.Components.BaseClasses.ConductiveHeatTransfer;
model MonoLayerDynamic "Dynamic layer for uniform solid."

  parameter Modelica.Units.SI.Area A "Layer area";
  parameter IDEAS.Buildings.Data.Interfaces.Material mat "Layer material";
  parameter Modelica.Units.SI.Temperature T_start=293.15
    "Start temperature for each of the states";
  parameter Integer nStaMin(min=1) = 2 "Minimum number of states";

  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial
    "Static (steady state) or transient (dynamic) thermal conduction model"
    annotation (Evaluate=true, Dialog(tab="Dynamics", group="Equations"));
  final parameter Boolean present=mat.d > Modelica.Constants.small;
  final parameter Integer nSta=max(nStaMin, mat.nSta) "Number of states";
  final parameter Real R=mat.R "Total specific thermal resistance";
  final parameter Modelica.Units.SI.HeatCapacity Ctot=A*mat.rho*mat.c*mat.d
    "Total heat capacity";
  // This option is for solving problems when connecting a
  // fixed temperature boundary to a state when linearising a model.
  parameter Boolean addRes_b=false
    "Set to true to add a resistor at port b.";
  Modelica.Blocks.Interfaces.RealOutput E(unit="J") = sum(T .* C);

protected
  final parameter Integer nRes=
    if addRes_b
    then nSta
    else max(nSta - 1, 1)
    "Number of thermal resistances";
  final parameter Modelica.Units.SI.ThermalConductance[nRes] G=fill(nRes*A/R,
      nRes);
  final parameter Modelica.Units.SI.HeatCapacity[nSta] C=Ctot*(if nSta <= 2 or
      addRes_b then ones(nSta)/nSta else cat(
      1,
      {0.5},
      ones(nSta - 2),
      {0.5})/(nSta - 1));
  final parameter Real[nSta] Cinv(each unit="K/J") = ones(nSta) ./ C
    "Dummy parameter for efficiently handling check for division by zero";
  Modelica.Units.SI.Temperature[nSta] T(each start=T_start)
    "Temperature at the states";
  Modelica.Units.SI.HeatFlowRate[nRes] Q_flow
    "Heat flow rate from state i to i-1";

public
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

initial equation
  // We define initial conditions only for the inner states to avoid
  // redundant initial equations.
  // Initial equations for the outer states are defined at the MultiLayer level.
  if energyDynamics == Modelica.Fluid.Types.Dynamics.FixedInitial then
    if addRes_b then
      T[nSta]=T_start;
    end if;
    for i in 2:nSta-1 loop
      T[i] = T_start;
    end for;
  elseif energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyStateInitial then
    if addRes_b then
      der(T[nSta])=0;
    end if;
    for i in 2:nSta-1 loop
      der(T[i]) = 0;
    end for;
  end if;
  assert(nSta >= 1, "Number of states needs to be higher than zero.");
  assert(abs(sum(C) - A*mat.rho*mat.c*mat.d) < 1e-6, "Verification error in MonLayerDynamic");
  assert(abs(sum(ones(size(G, 1)) ./ G) - R/A) < 1e-6, "Verification error in MonLayerDynamic");
  assert(not energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState, "MonoLayerDynamic is configured to steady state, which is not the scope of this model!");
equation
  port_a.T = T[1];

  if nSta > 1 then
    der(T[1]) = (port_a.Q_flow - Q_flow[1])*Cinv[1];
    // Q_flow[i] is heat flowing from (i-1) to (i)
    for i in 1:nSta - 1 loop
      (T[i] - T[i + 1])*G[i] = Q_flow[i];
    end for;
    for i in 2:nRes loop
      der(T[i]) = (Q_flow[i - 1] - Q_flow[i])*Cinv[i];
    end for;

    if not addRes_b then
      der(T[nSta]) = (Q_flow[nSta - 1] + port_b.Q_flow)*Cinv[nSta];
      port_b.T = T[nSta];
    else
      (T[end] - port_b.T)*G[end] = Q_flow[end];
      port_b.Q_flow = -Q_flow[end];
    end if;
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
<p>For the purpose of dynamic building simulation, the partial differential equation of the continuous 
time and space model of heat transport through a solid is most often simplified into ordinary differential 
equations with a finite number of parameters representing only one-dimensional heat transport through a construction layer. 
Within this context, the wall is modelled with lumped elements, i.e. a model where temperatures and heat 
fluxes are determined from a system composed of a sequence of discrete resistances <i>R<sub>n+1</sub></i> and capacitances <i>C<sub>n</sub></i>. 
The number of capacitive elements <i>n</i> used in modelling the transient thermal response of the wall denotes the order of the lumped capacitance model.</p>
<p><i>C<sub>c</sub> &#183; dT<sub>c</sub> / dt = &Sigma;<sub>i=1</sub><sup>n</sup> Q&#775;<sub>res,i</sub> + Q&#775;<sub>source</sub></i></p>
<p>where</p>
<ul>
<li><i>T<sub>c</sub></i> is the temperature of the lumped capacity,</li>
<li><i>Q&#775;<sub>res</sub></i> is the heat flux through the lumped resistance,</li>
<li><i>R<sub>res</sub></i> is the total thermal resistance of the lumped resistance,</li>
<li><i>Q&#775;<sub>source</sub></i> are internal thermal sources that represent the added energy to the lumped capacity, and</li>
<li><i>C<sub>c</sub></i> is the thermal capacity of the lumped capacity, equal to
<i>(&rho; &#183; c<sub>p</sub> &#183; d<sub>c</sub> &#183; A)</i>, where</li>
<ul><li><i>&rho;</i> denotes the density,</li> 
<li><i>c<sub>p</sub></i> is the specific heat capacity of the material,</li>
<li><i>d<sub>c</sub></i> is the equivalent thickness of the lumped capacity, and
<li><i>A</i> is the surface area of the wall.</li></ul>
</ul>
</html>", revisions="<html>
<ul>
<li>
June 17, 2025, by Lucas Verleyen:<br/>
Replaced images with inline equations.
See <a href=https://github.com/open-ideas/IDEAS/issues/1440>#1440</a>.
</li>
<li>
January 25, 2019, by Filip Jorissen:<br/>
Revised initial equation implementation.
See issue <a href=https://github.com/open-ideas/IDEAS/issues/971>#971</a>.
</li>
<li>
January 25, 2018, by Filip Jorissen:<br/>
Propagated <code>T_start</code> in the declaration of <code>T</code>.
See issue <a href=https://github.com/open-ideas/IDEAS/issues/692>#692</a>.
</li>
<li>
December 8, 2016, by Filip Jorissen and Damien Picard:<br/>
Revised implementation of placeCapacityAtSurf_b, which has been renamed to addRes_b.
This is for solving problems when linearising a model.
See issue 591.
</li>
<li>
February 10, 2016, by Filip Jorissen and Damien Picard:<br/>
Revised implementation.
</li>
</ul>
</html>"));
end MonoLayerDynamic;
