within IDEAS.Buildings.Validation.BaseClasses.VentilationSystem;
model None "None"
  extends IDEAS.Circuits.VentilationSystems.Ideal(
                                         final m_flow = zeros(nZones), final nLoads=1);
end None;
