within IDEAS.Interfaces.Examples;
model building
  extends IDEAS.Interfaces.Building(
    redeclare Buildings.Examples.BaseClasses.structure building,
                redeclare IDEAS.Circuits.Ventilation.None             ventilationSystem,
    redeclare IDEAS.BoundaryConditions.Occupants.Standards.None occupant,
    redeclare IDEAS.Circuits.Heating.None                                 heatingSystem,
    redeclare BaseClasses.InhomeFeeder inHomeGrid);

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end building;
