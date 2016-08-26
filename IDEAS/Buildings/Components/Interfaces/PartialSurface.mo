within IDEAS.Buildings.Components.Interfaces;
partial model PartialSurface "Partial model for building envelope component"

  outer IDEAS.BoundaryConditions.SimInfoManager sim
    "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{30,-100},{50,-80}})));

  parameter Modelica.SIunits.Angle inc
    "Inclination (tilt) angle of the wall, see IDEAS.Types.Tilt";
  parameter Modelica.SIunits.Angle azi
    "Azimuth angle of the wall, i.e. see IDEAS.Types.Azimuth";
  parameter Modelica.SIunits.Power QTra_design
    "Design heat losses at reference temperature of the boundary space"
    annotation (Dialog(group="Design power",tab="Advanced"));
  parameter Modelica.SIunits.Temperature T_start=293.15
    "Start temperature for each of the layers"
    annotation(Dialog(tab="Dynamics", group="Initial condition"));

  parameter Modelica.SIunits.Temperature TRef_a=291.15
    "Reference temperature of zone on side of propsBus_a, for calculation of design heat loss"
    annotation (Dialog(group="Design power",tab="Advanced"));
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial
    "Static (steady state) or transient (dynamic) thermal conduction model"
    annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));

  IDEAS.Buildings.Components.Interfaces.ZoneBus propsBus_a(
    numIncAndAziInBus=sim.numIncAndAziInBus,
    computeConservationOfEnergy=sim.computeConservationOfEnergy,
    weaBus(final outputAngles=sim.outputAngles))
    "If inc = Floor, then propsbus_a should be connected to the zone above this floor.
    If inc = ceiling, then propsbus_a should be connected to the zone below this ceiling.
    If component is an outerWall, porpsBus_a should be connect to the zone."
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={100,20}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={50,20})));

protected
  Modelica.Blocks.Sources.RealExpression QDesign(y=QTra_design);

  Modelica.Blocks.Sources.RealExpression aziExp(y=azi)
    "Azimuth angle expression";
  Modelica.Blocks.Sources.RealExpression incExp(y=inc)
    "Inclination angle expression";
  Modelica.Blocks.Sources.RealExpression E if
       sim.computeConservationOfEnergy
    "Model internal energy";
  IDEAS.Buildings.Components.BaseClasses.ConservationOfEnergy.PrescribedEnergy prescribedHeatFlowE if
       sim.computeConservationOfEnergy
    "Component for computing conservation of energy";
  Modelica.Blocks.Sources.RealExpression Qgai if sim.computeConservationOfEnergy
    "Heat gains across model boundary";
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlowQgai if
     sim.computeConservationOfEnergy
    "Component for computing conservation of energy";

  IDEAS.Buildings.Components.BaseClasses.ConductiveHeatTransfer.MultiLayer
    layMul(final inc=inc, energyDynamics=energyDynamics,
    linIntCon=sim.linearise)
    "Multilayer component that allows simulating walls, windows and other surfaces"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}})));

equation
  connect(prescribedHeatFlowE.port, propsBus_a.E);
  connect(Qgai.y,prescribedHeatFlowQgai. Q_flow);
  connect(prescribedHeatFlowQgai.port, propsBus_a.Qgai);
  connect(E.y,prescribedHeatFlowE. E);
  connect(QDesign.y, propsBus_a.QTra_design);

  connect(layMul.port_a, propsBus_a.surfRad) annotation (Line(
      points={{10,0},{22,0},{22,19.9},{100.1,19.9}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(layMul.iEpsSw_a, propsBus_a.epsSw) annotation (Line(
      points={{10,4},{20,4},{20,19.9},{100.1,19.9}},
      color={0,0,127},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(layMul.iEpsLw_a, propsBus_a.epsLw) annotation (Line(
      points={{10,8},{18,8},{18,19.9},{100.1,19.9}},
      color={0,0,127},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(layMul.area, propsBus_a.area) annotation (Line(
      points={{0,10},{0,19.9},{100.1,19.9}},
      color={0,0,127},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(incExp.y, propsBus_a.inc);
  connect(aziExp.y, propsBus_a.azi);
  connect(layMul.port_a, propsBus_a.surfCon) annotation (Line(points={{10,0},{24,
          0},{24,19.9},{100.1,19.9}}, color={191,0,0}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-50,-100},{50,100}})),
    Documentation(revisions="<html>
<ul>
<li>
March 8, 2016, by Filip Jorissen:<br/>
Added energyDynamics parameter.
</li>
<li>
February 10, 2016, by Filip Jorissen and Damien Picard:<br/>
Revised implementation: cleaned up connections and partials.
</li>
<li>
February 6, 2016 by Damien Picard:<br/>
First implementation.
</li>
</ul>
</html>"));
end PartialSurface;
