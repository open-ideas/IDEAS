within IDEAS.Electrical.AC.ThreePhasesUnbalanced.Sources.BaseClasses;
model UnbalancedWindTurbine_N
  "Base model for an unbalanced wind power source with neutral cable"
  extends
    IDEAS.Electrical.AC.ThreePhasesUnbalanced.Sources.BaseClasses.BaseUnbalancedWindTurbine;
  Interfaces.Terminal4_p terminal
    "Connector for three-phase unbalanced systems with neutral cable"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Interfaces.Connection3to4_p conn3to4 "Connection between 3 to 4 wire"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        origin={40,0})));
protected
  Interfaces.Adapter3to3 ada "Adapter"
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
equation

  if plugPhase1 then
    connect(wt_phase1.terminal, ada.terminals[1]) annotation (Line(points={{-18,50},
            {-10,50},{-10,-0.533333},{0,-0.533333}},
                                                   color={0,120,120}));
  end if;

  if plugPhase2 then
    connect(wt_phase2.terminal, ada.terminals[2])
    annotation (Line(points={{-20,0},{-10,0},{0,0}}, color={0,120,120}));
  end if;

  if plugPhase3 then
    connect(wt_phase3.terminal, ada.terminals[3]) annotation (Line(points={{-20,-50},
            {-10,-50},{-10,0.533333},{0,0.533333}},
                                                  color={0,120,120}));
  end if;

  connect(conn3to4.terminal4, terminal) annotation (Line(
      points={{50,0},{100,0}},
      color={127,0,127},
      smooth=Smooth.None));
  connect(ada.terminal, conn3to4.terminal3)
    annotation (Line(points={{20,0},{25,0},{30,0}}, color={0,120,120}));
  annotation ( Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          pattern=LinePattern.None,
          fillColor={202,230,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{42,44},{46,-54}},
          fillColor={233,233,233},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-42,12},{-38,-86}},
          fillColor={233,233,233},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Polygon(
          points={{-44,10},{-26,-42},{-38,14},{-44,10}},
          smooth=Smooth.None,
          fillColor={222,222,222},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Polygon(
          points={{-38,10},{8,44},{-42,16},{-38,10}},
          smooth=Smooth.None,
          fillColor={222,222,222},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Polygon(
          points={{-42,10},{-90,38},{-38,16},{-42,10}},
          smooth=Smooth.None,
          fillColor={222,222,222},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Polygon(
          points={{40,42},{100,38},{42,48},{40,42}},
          smooth=Smooth.None,
          fillColor={222,222,222},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Polygon(
          points={{-21,-17},{27,17},{-25,-11},{-21,-17}},
          smooth=Smooth.None,
          fillColor={222,222,222},
          fillPattern=FillPattern.Solid,
          origin={29,67},
          rotation=90,
          lineColor={0,0,0}),
        Polygon(
          points={{24,-14},{-20,22},{26,-8},{24,-14}},
          smooth=Smooth.None,
          fillColor={222,222,222},
          fillPattern=FillPattern.Solid,
          origin={32,18},
          rotation=90,
          lineColor={0,0,0}),
        Ellipse(
          extent={{-46,18},{-34,6}},
          lineColor={0,0,0},
          fillColor={222,222,222},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{38,50},{50,38}},
          lineColor={0,0,0},
          fillColor={222,222,222},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
This model is a class extended by three-phase unbalanced
wind turbine power sources with neutral cable connection.
</p>
<p>
The neutral cable is connected to the ground reference.
</p>
</html>",
        revisions="<html>
<ul>
<li>
February 26, 2016, by Michael Wetter:<br/>
Added adapter for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/426\">issue 426</a>.
</li>
<li>
September 25, 2014, by Marco Bonvini:<br/>
Revised model and documentation.
</li>
<li>
August 27, 2014, by Marco Bonvini:<br/>
Revised documentation.
</li>
</ul>
</html>"));
end UnbalancedWindTurbine_N;
