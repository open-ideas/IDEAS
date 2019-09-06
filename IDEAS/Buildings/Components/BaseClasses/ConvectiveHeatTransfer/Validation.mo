within IDEAS.Buildings.Components.BaseClasses.ConvectiveHeatTransfer;
package Validation
  model MonoLayerAirDefaultEmmisivityWarning
    MonoLayerAir mLA_defaultEmmisivity(
      A=A,
      inc=inc,
      d=d,
      epsLw_a=epsLw_Default,
      epsLw_b=epsLw_Default)
           annotation (Placement(transformation(extent={{-10,38},{10,58}})));
    MonoLayerAir mLA_acustomEmmisivity(
      A=A,
      inc=inc,
      d=d,
      epsLw_a=epsLw_Custom,
      epsLw_b=epsLw_Default)
      annotation (Placement(transformation(extent={{-10,6},{10,26}})));
    MonoLayerAir mLA_bcustomEmmisivity(
      A=A,
      inc=inc,
      d=d,
      epsLw_a=epsLw_Default,
      epsLw_b=epsLw_Custom)
      annotation (Placement(transformation(extent={{-10,-26},{10,-6}})));
    MonoLayerAir mLA_abcustomEmmisivity(
      A=A,
      inc=inc,
      d=d,
      epsLw_a=epsLw_Custom,
      epsLw_b=epsLw_Custom)
      annotation (Placement(transformation(extent={{-10,-56},{10,-36}})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=273.15)
      annotation (Placement(transformation(extent={{-60,-8},{-40,12}})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature1(T=293.15)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={50,0})));

    parameter Real A = 1;
    parameter Real inc = 90;
    parameter Real d = 1;
    parameter Real epsLw_Default = 0.85;
    parameter Real epsLw_Custom = 0.2;

  equation
    connect(fixedTemperature.port, mLA_defaultEmmisivity.port_a) annotation (Line(
          points={{-40,2},{-24,2},{-24,48},{-10,48}}, color={191,0,0}));
    connect(mLA_acustomEmmisivity.port_a, mLA_defaultEmmisivity.port_a)
      annotation (Line(points={{-10,16},{-24,16},{-24,48},{-10,48}}, color={191,0,
            0}));
    connect(mLA_abcustomEmmisivity.port_a, fixedTemperature.port) annotation (
        Line(points={{-10,-46},{-24,-46},{-24,2},{-40,2}}, color={191,0,0}));
    connect(mLA_bcustomEmmisivity.port_a, fixedTemperature.port) annotation (Line(
          points={{-10,-16},{-24,-16},{-24,2},{-40,2}}, color={191,0,0}));
    connect(fixedTemperature1.port, mLA_defaultEmmisivity.port_b)
      annotation (Line(points={{40,0},{26,0},{26,48},{10,48}}, color={191,0,0}));
    connect(fixedTemperature1.port, mLA_abcustomEmmisivity.port_b) annotation (
        Line(points={{40,0},{26,0},{26,-46},{10,-46}}, color={191,0,0}));
    connect(mLA_bcustomEmmisivity.port_b, mLA_abcustomEmmisivity.port_b)
      annotation (Line(points={{10,-16},{26,-16},{26,-46},{10,-46}}, color={191,0,
            0}));
    connect(mLA_acustomEmmisivity.port_b, mLA_defaultEmmisivity.port_b)
      annotation (Line(points={{10,16},{26,16},{26,48},{10,48}}, color={191,0,0}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end MonoLayerAirDefaultEmmisivityWarning;
end Validation;
