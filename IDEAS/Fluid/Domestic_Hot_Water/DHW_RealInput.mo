within IDEAS.Fluid.Domestic_Hot_Water;
model DHW_RealInput "DHW consumption with input for flowrate at 60 degC"

  extends IDEAS.Fluid.Domestic_Hot_Water.partial_DHW;

  annotation (Diagram(graphics), Documentation(info="<html>
<p><b>Description</b> </p>
<p>Model of a domestic hot water (DHW) system composed mainly of a thermostatic mixing valve. The DHW flow rate is passed as a realInput.</p>
<p>This model is an extension of the <a href=\"modelica://IDEAS.Thermal.Components.Domestic_Hot_Water.partial_DHW\">Partial_DHW</a> model, see there for the documentation.</p>
<p><h4>Examples</h4></p>
<p>An example of this model is given in <a href=\"modelica://IDEAS.Thermal.Components.Examples.StorageTank_DHW_HP\">IDEAS.Thermal.Components.Examples.StorageTank_DHW_HP</a>.</p>
</html>"));
end DHW_RealInput;
