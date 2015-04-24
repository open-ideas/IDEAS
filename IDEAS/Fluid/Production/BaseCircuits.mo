within IDEAS.Fluid.Production;
package BaseCircuits "Production models wrapped in basecircuits"
  model HPWW
    extends BaseClasses.FourPortHeaterInterface;
  equation

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={
          Line(
            points={{-60,60},{-20,60},{-40,40},{-20,20},{-40,0},{-20,-20},{-40,
                -40},{-20,-60},{-60,-60}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{-20,60},{20,60},{0,40},{20,20},{0,0},{20,-20},{0,-40},{20,
                -60},{-20,-60}},
            color={0,0,255},
            smooth=Smooth.None,
            origin={40,0},
            rotation=180),
          Rectangle(
            extent={{-16,2},{4,-2}},
            lineColor={255,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{4,8},{4,-8},{12,0},{4,8}},
            lineColor={255,0,0},
            smooth=Smooth.None,
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid)}));
  end HPWW;

  package BaseClasses
    model HeaterInterface
      extends Fluid.BaseCircuits.Interfaces.PartialBaseCircuit;

      Modelica.Blocks.Interfaces.RealInput u annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={40,108})));
      Modelica.Blocks.Interfaces.RealInput u1 annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={-40,108})));
      Modelica.Blocks.Interfaces.BooleanInput u2 annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={0,108})));
      replaceable Interfaces.PartialHeater partialHeater(
        modulating=false,
        modulationInput=false,
        redeclare package Medium = Medium)
        annotation (Placement(transformation(extent={{-8,20},{12,40}})));
      Modelica.Blocks.Interfaces.RealOutput power if
                                                    measureSupplyT
        "Power measurement"  annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-80,106}),iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-80,106})));
    equation
      connect(u2, partialHeater.on) annotation (Line(
          points={{0,108},{0,40.8}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(u1, partialHeater.uModulation) annotation (Line(
          points={{-40,108},{-40,60},{-4,60},{-4,40.8}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(u, partialHeater.u) annotation (Line(
          points={{40,108},{40,60},{4,60},{4,40.8}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(partialHeater.PFuelOrEl, power) annotation (Line(
          points={{-6,27},{-52,27},{-52,82},{-80,82},{-80,106}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(partialHeater.heatPort, heatPort) annotation (Line(
          points={{2,20},{2,-100},{0,-100}},
          color={191,0,0},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics), Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics));
    end HeaterInterface;

    model TwoPortHeaterInterface
      extends HeaterInterface(
        redeclare replaceable
          IDEAS.Fluid.Production.Interfaces.PartialHeaterTwoPort partialHeater);

    equation
      connect(pipeSupply.port_b, partialHeater.port_a) annotation (Line(
          points={{-70,60},{-44,60},{-44,30},{-8,30}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(partialHeater.port_b, senTemSup.port_a) annotation (Line(
          points={{12,30},{48,30},{48,60},{60,60}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(pipeReturn.port_a, port_a2) annotation (Line(
          points={{-30,-60},{100,-60}},
          color={0,127,255},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics), Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={Rectangle(
              extent={{-20,80},{20,0}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}));
    end TwoPortHeaterInterface;

    model FourPortHeaterInterface
      extends HeaterInterface(
        redeclare replaceable
          IDEAS.Fluid.Production.Interfaces.PartialHeaterFourPort partialHeater(
            redeclare package Medium1 = Medium1, redeclare package Medium2 =
              Medium2));

    equation
      connect(pipeSupply.port_b, partialHeater.port_a1) annotation (Line(
          points={{-70,60},{-44,60},{-44,36},{-8,36}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(partialHeater.port_b1, pipeReturn.port_a) annotation (Line(
          points={{12,36},{22,36},{22,-60},{-30,-60}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(partialHeater.port_b2, senTemSup.port_a) annotation (Line(
          points={{-8,24},{-20,24},{-20,6},{46,6},{46,60},{60,60}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(partialHeater.port_a2, port_a2) annotation (Line(
          points={{12,24},{60,24},{60,-60},{100,-60}},
          color={0,127,255},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics), Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={Rectangle(
              extent={{-60,80},{60,-80}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}));
    end FourPortHeaterInterface;
  end BaseClasses;
end BaseCircuits;
