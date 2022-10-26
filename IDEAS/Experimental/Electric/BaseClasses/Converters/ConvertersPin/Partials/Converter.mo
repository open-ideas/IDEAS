within IDEAS.Experimental.Electric.BaseClasses.Converters.ConvertersPin.Partials;
partial model Converter "Converter"
 extends Modelica.Blocks.Icons.Block;

 parameter Integer numPha(min=1,max=3) = 1 "Number of phases";

  parameter Modelica.Units.SI.Efficiency eff
    "Converter efficiency as a function of the input power [%/100]";

 parameter Real pf(min=0,max=1) = 1 "Converter power factor (output) [%/100]";
 parameter Boolean lagging = true "Lagging pf or not"; // At converter: lagging = Q-consumption by inverter and vice versa.
 parameter Real Qsign = if lagging then 1 else -1 "Sign of reactive power";

  Modelica.Units.SI.ComplexPower sAC "AC apparent power";
  Modelica.Units.SI.ActivePower pAC "AC active power";
  Modelica.Units.SI.ReactivePower qAC "AC reactive power";

  Modelica.Units.SI.Power pDC=(pin_pDC.v - pin_nDC.v)*pin_pDC.i "DC power";
  parameter Modelica.Units.SI.Voltage vDC=380 "Fixed DC voltage";
  Modelica.Units.SI.Current iDC=pin_pDC.i "DC current";

 Modelica.Electrical.Analog.Interfaces.PositivePin pin_pDC
   annotation (Placement(transformation(extent={{90,110},{110,90}}),
       iconTransformation(extent={{90,110},{110,90}})));
 Modelica.Electrical.Analog.Interfaces.NegativePin pin_nDC
   annotation (Placement(transformation(extent={{90,-110},{110,-90}}),
       iconTransformation(extent={{90,-110},{110,-90}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.PositivePin pin_pAC[
    numPha] annotation (Placement(transformation(extent={{-110,10},{-90,-10}}),
        iconTransformation(extent={{-118,10},{-98,-10}})));

equation
 vDC = pin_pDC.v - pin_nDC.v;
 pin_pDC.i + pin_nDC.i = 0;

 sAC = if numPha == 1 then pin_pAC[1].v * Modelica.ComplexMath.conj(pin_pAC[1].i) else pin_pAC[1].v * Modelica.ComplexMath.conj(pin_pAC[1].i) +  pin_pAC[2].v * Modelica.ComplexMath.conj(pin_pAC[2].i) + pin_pAC[3].v * Modelica.ComplexMath.conj(pin_pAC[3].i);
 pAC =Modelica.ComplexMath.abs(sAC)*pf;
 pAC = Modelica.ComplexMath.real(sAC);
 qAC = Qsign*Modelica.ComplexMath.imag(sAC);

 if numPha == 3 then
   pAC/3 = Modelica.ComplexMath.real(pin_pAC[1].v*Modelica.ComplexMath.conj(pin_pAC[1].i));
   qAC/3 = Modelica.ComplexMath.imag(pin_pAC[1].v*Modelica.ComplexMath.conj(pin_pAC[1].i));
   pAC/3 = Modelica.ComplexMath.real(pin_pAC[2].v*Modelica.ComplexMath.conj(pin_pAC[2].i));
   qAC/3 = Modelica.ComplexMath.imag(pin_pAC[2].v*Modelica.ComplexMath.conj(pin_pAC[2].i));
   // Third phase is defined by sAC calculation in variable list
 end if;

 annotation (Diagram(graphics),Documentation(info="<html>
<p>
This is a pin-based converter model to convert power with a certain efficiency. The output can be AC or DC, wit a possibility included to deliver reactive power support. It is assumed that the DC voltage is fixed
</p>
</html>", revisions="<html>
<ul>
<li>
April 8, 2015 by Juan Van Roy:<br/>
First implementation.
</li>
</ul>
</html>"));
end Converter;
