within IDEAS.Circuits.BaseCircuits;
model MixingCircuit_Linear "Mixing circuit with linear three way valve"
  extends Interfaces.PartialMixingCircuit(redeclare
      Fluid.Actuators.Valves.ThreeWayLinear partialThreeWayValve);

end MixingCircuit_Linear;
