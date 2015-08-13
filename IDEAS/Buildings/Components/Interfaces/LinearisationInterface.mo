within IDEAS.Buildings.Components.Interfaces;
model LinearisationInterface
  "Extend this interface if you want to linearise a model"

protected
  inner input WindowBus[sim.nWindow] winBusIn if    sim.linearise and not sim.createOutputs;
  inner output WindowBus[sim.nWindow] winBusOut if  sim.linearise and sim.createOutputs;
  inner input IDEAS.Buildings.Components.Interfaces.WeaBus weaBus(
    final numSolBus=sim.numAzi + 1) if sim.linearise and not sim.createOutputs;
public
  inner SimInfoManager sim(linearise=true, createOutputs=false)
    annotation (Placement(transformation(extent={{-100,78},{-80,98}})));
end LinearisationInterface;
