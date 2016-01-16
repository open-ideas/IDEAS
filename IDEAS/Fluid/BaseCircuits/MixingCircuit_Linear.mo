within IDEAS.Fluid.BaseCircuits;
model MixingCircuit_Linear "Mixing circuit with linear three way valve"
  extends Interfaces.PartialMixingCircuit(redeclare
      Actuators.Valves.ThreeWayLinear partialThreeWayValve);

equation
  connect(u, partialThreeWayValve.y)
    annotation (Line(points={{0,110},{0,72},{0,72}}, color={0,0,127}));
end MixingCircuit_Linear;
