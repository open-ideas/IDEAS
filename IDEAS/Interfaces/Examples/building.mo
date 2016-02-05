within IDEAS.Interfaces.Examples;
model building
  extends IDEAS.Interfaces.Building(
    redeclare Buildings.Examples.BaseClasses.structure building,
                redeclare Circuits.Ventilation.None             ventilationSystem,
    redeclare Occupants.Standards.None occupant,
    redeclare Circuits.Heating.None                                 heatingSystem,
    redeclare BaseClasses.CausalInhomeFeeder inHomeGrid);

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end building;
