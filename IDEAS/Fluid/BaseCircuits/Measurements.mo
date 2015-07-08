within IDEAS.Fluid.BaseCircuits;
model Measurements
  extends Interfaces.PartialBaseCircuit(
    final measureReturnT=true,
    final measureSupplyT=true,
    final includePipes=false);

equation
  connect(port_a1, senTemSup.port_a) annotation (Line(
      points={{-100,60},{-100,48},{-60,48},{-60,60},{60,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTemRet.port_a, port_a2) annotation (Line(
      points={{-60,-60},{-60,-80},{0,-80},{0,-60},{100,-60}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end Measurements;
