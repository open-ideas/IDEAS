within IDEAS.Examples.PPD12;
model VentilationInterzonal "Ppd 12 example model"
  extends IDEAS.Examples.PPD12.PartialVentilation(
    living(
      redeclare Buildings.Components.InterzonalAirFlow.PressureDriven
        interzonalAirFlow),
    Diner(
      redeclare Buildings.Components.InterzonalAirFlow.PressureDriven
        interzonalAirFlow),
    stairWay(
      redeclare Buildings.Components.InterzonalAirFlow.PressureDriven
        interzonalAirFlow),
    bathRoom(
      redeclare Buildings.Components.InterzonalAirFlow.PressureDriven
        interzonalAirFlow),
    bedRoom1(
      redeclare Buildings.Components.InterzonalAirFlow.PressureDriven
        interzonalAirFlow),
    bedRoom2(
      redeclare Buildings.Components.InterzonalAirFlow.PressureDriven
        interzonalAirFlow),
    bedRoom3(
      redeclare Buildings.Components.InterzonalAirFlow.PressureDriven
        interzonalAirFlow),
    hallway(redeclare
        Buildings.Components.InterzonalAirFlow.PressureDriven
        interzonalAirFlow),
    Porch(redeclare
        Buildings.Components.InterzonalAirFlow.PressureDriven
        interzonalAirFlow),
    sim(computeInterzonalAirFlow=true),
    pump(allowFlowReversal=true),
    hea(allowFlowReversal=true));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature hack(T=274.15)
    "to aovid singularity"
    annotation (Placement(transformation(extent={{364,2},{384,22}})));
equation
  connect(hack.port, sim.portVent) annotation (Line(points={{384,12},{394,12},{
          394,14},{386.4,14},{386.4,38}}, color={191,0,0}));
   annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -200},{400,240}},
        initialScale=0.1), graphics={
        Line(points={{-72,-100},{-100,-100},{-100,100},{-68,100},{-68,-10},{0,-10},
              {0,100},{-68,100}}, color={28,108,200}),
        Line(points={{-72,-98}}, color={28,108,200}),
        Line(points={{-72,-100},{-72,-50},{0,-50},{0,-8}}, color={28,108,200}),
        Line(points={{-60,-10},{-100,-10}}, color={28,108,200}),
        Line(points={{-72,-100},{0,-100},{0,-50}}, color={28,108,200}),
        Line(points={{60,100},{160,100},{160,46},{60,46},{60,100}}, color={28,108,
              200}),
        Line(
          points={{92,100},{92,46}},
          color={28,108,200},
          pattern=LinePattern.Dash),
        Line(points={{60,46},{160,46},{160,-8},{60,-8},{60,46}}, color={28,108,200}),
        Line(points={{92,46},{92,-8}}, color={28,108,200}),
        Line(points={{220,100},{320,100},{320,46},{220,46},{220,100}},
                                                                    color={28,108,
              200}),
        Line(points={{220,46},{320,46},{320,-8},{220,-8},{220,46}}, color={28,108,
              200}),
        Line(
          points={{-68,46},{0,46}},
          color={28,108,200},
          pattern=LinePattern.Dash)}),
                                Icon(coordinateSystem(
        preserveAspectRatio=false,
        initialScale=0.1)),
    experiment(
      StopTime=500000,
      __Dymola_NumberOfIntervals=5000,
      __Dymola_fixedstepsize=15,
      __Dymola_Algorithm="Euler"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Examples/PPD12/Ventilation.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
Example model of a partially renovated terraced house in Belgium.
This model adds the building ventilation system.
</p>
</html>", revisions="<html>
<ul>
<li>
January 9, 2017 by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
end VentilationInterzonal;
