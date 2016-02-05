within IDEAS.Electrical.Batteries.AC;
model BatterySystemGeneral
  extends Partials.BatterySystem;

  // Variables
  Modelica.SIunits.Power Pnet "Power available to charge/discharge battery";

  // Models
  Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin pin[
    numPha] annotation (Placement(transformation(extent={{-106,-10},{-86,10}},
          rotation=0)));

  IDEAS.Electrical.Batteries.Control.BatteryCtrlGeneral batteryCtrlGeneral(
    numPha=numPha,
    DOD_max=DOD_max,
    EBat=3600000*EBat,
    eta_out=technology.eta_out,
    eta_in=technology.eta_in,
    eta_c=technology.eta_c,
    eta_d=technology.eta_d,
    e_c=technology.e_c,
    e_d=technology.e_d,
    P=Pnet) annotation (Placement(transformation(extent={{20,0},{40,20}})));

equation
  connect(wattsLaw.vi, pin) annotation (Line(
      points={{-20,30},{-14,30},{-14,0},{-96,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(batteryCtrlGeneral.PFinal, wattsLaw.P) annotation (Line(
      points={{20,13},{10,13},{0,13},{0,46},{-48,46},{-48,35},{-36,35}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(batteryCtrlGeneral.QFinal, wattsLaw.Q) annotation (Line(
      points={{20,7},{10,7},{0,7},{0,10},{-48,10},{-48,31},{-37,31}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(batteryCtrlGeneral.PInit, battery.PFlow) annotation (Line(
      points={{40,13},{60,13}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(battery.SoC_out, batteryCtrlGeneral.SoC) annotation (Line(
      points={{60,7},{40,7}},
      color={0,0,127},
      smooth=Smooth.None));
annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Polygon(
          points={{-62,40},{-62,-40},{72,-40},{72,40},{-62,40}},
          smooth=Smooth.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{58,32},{58,-30},{32,-30},{10,32},{58,32}},
          smooth=Smooth.None,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-2,32},{20,-30},{0,-30},{-22,32},{-2,32}},
          smooth=Smooth.None,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-74,12},{-74,-12},{-62,-12},{-62,12},{-74,12}},
          smooth=Smooth.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0})},
          defaultComponentName="battery",
          defaultComponentPrefixes="inner"));
end BatterySystemGeneral;
