within IDEAS.Interfaces.BaseClasses;
model InhomeFeeder
  "Causal inhome feeder model for a single phase grid connection"

  // Building characteristics  //////////////////////////////////////////////////////////////////////////

  parameter Modelica.SIunits.Length len=10 "Cable length to district feeder";

  // Interfaces  ///////////////////////////////////////////////////////////////////////////////////////

  Modelica.Blocks.Interfaces.RealOutput VGrid
    annotation (Placement(transformation(extent={{96,30},{116,50}})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug
    nodeSingle(m=1)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin
    pinSingle annotation (Placement(transformation(extent={{90,-10},{110,10}}),
        iconTransformation(extent={{90,-10},{110,10}})));

  // Components  ///////////////////////////////////////////////////////////////////////////////////////

  Electrical.BaseClasses.AC.WattsLaw wattsLaw(numPha=1)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));

  Electrical.Distribution.AC.BaseClasses.BranchLenTyp branch(len=len)
    "Cable to district feeder"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  IDEAS.Electrical.BaseClasses.AC.PotentialSensor voltageSensor
    "District feeder voltagesensor" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,20})));

protected
  Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource
    voltageSource(
    f=50,
    V=230,
    phi=0) "Steady building-side 230 V voltage source" annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=270,
        origin={-80,-42})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground(pin(
        final reference)) "Grounding for the building-side voltage source"
    annotation (Placement(transformation(extent={{-90,-80},{-70,-60}})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPin_p plugToPin_p(
      m=1) "Plug-to-pin conversion" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-80,-22})));

algorithm
  wattsLaw.P := -Modelica.ComplexMath.real(plugToPin_p.plug_p.pin[1].v*
    Modelica.ComplexMath.conj(plugToPin_p.plug_p.pin[1].i));
  wattsLaw.Q := -Modelica.ComplexMath.imag(plugToPin_p.plug_p.pin[1].v*
    Modelica.ComplexMath.conj(plugToPin_p.plug_p.pin[1].i));

equation
  connect(nodeSingle, plugToPin_p.plug_p) annotation (Line(
      points={{-100,0},{-80,0},{-80,-20},{-80,-20}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(voltageSource.pin_p, plugToPin_p.pin_p) annotation (Line(
      points={{-80,-34},{-80,-24}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(ground.pin, voltageSource.pin_n) annotation (Line(
      points={{-80,-60},{-80,-50}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(wattsLaw.vi[1], voltageSensor.vi) annotation (Line(
      points={{40,0},{50,0},{50,10}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(voltageSensor.VGrid, VGrid) annotation (Line(
      points={{50,30.4},{50,40},{106,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(wattsLaw.vi[1], branch.pin_p) annotation (Line(
      points={{40,0},{60,0}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(branch.pin_n, pinSingle) annotation (Line(
      points={{80,0},{100,0}},
      color={85,170,255},
      smooth=Smooth.None));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={
        Ellipse(
          extent={{-100,100},{-60,60}},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={255,212,170}),
        Ellipse(
          extent={{-100,-60},{-60,-100}},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={255,212,170}),
        Ellipse(
          extent={{60,100},{100,60}},
          fillColor={145,200,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={255,212,170}),
        Ellipse(
          extent={{60,-60},{100,-100}},
          fillColor={145,200,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={255,212,170}),
        Polygon(
          points={{80,100},{60,100},{20,-100},{80,-100},{80,-80},{100,-80},{100,
              80},{80,80},{80,100}},
          fillColor={145,200,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={175,175,175}),
        Polygon(
          points={{-100,80},{-80,80},{-80,100},{60,100},{20,-100},{-80,-100},{
              -80,-80},{-100,-80},{-100,80}},
          pattern=LinePattern.None,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Ellipse(extent={{-50,-40},{-30,-60}}, lineColor={255,255,255}),
        Ellipse(extent={{30,-40},{50,-60}}, lineColor={255,255,255}),
        Ellipse(extent={{-20,10},{20,-30}}, lineColor={255,255,255}),
        Line(points={{-14,4},{14,-24}}, color={255,255,255}),
        Line(points={{14,4},{-14,-24}}, color={255,255,255}),
        Rectangle(extent={{-30,60},{30,40}}, lineColor={255,255,255}),
        Line(points={{30,50},{60,50},{60,-20},{40,-20},{40,-40}}, color={255,
              255,255}),
        Line(points={{20,-10},{60,-10}}, color={255,255,255}),
        Line(points={{-60,-10},{-20,-10}}, color={255,255,255}),
        Line(points={{-40,-40},{-40,-20},{-60,-20},{-60,0}}, color={255,255,255}),
        Line(points={{-60,32},{-60,50},{-30,50}}, color={255,255,255}),
        Line(points={{-60,0},{-48,28}}, color={255,255,255})}),
    Diagram(graphics),
    Documentation(info="<html>
<p>This gives an in home grid with single phase plugs and single phase grid connection</p>
</html>"));
end InhomeFeeder;
