within IDEAS.Examples.TwinHouses;
model BuildingO5_Exp1_1Port
  "Model for simulation of experiment 1 for the O5 building"
 extends BuildingN2_Exp1(
   bui=2,
   exp=1,
   redeclare BaseClasses.Structures.TwinhouseO5 struct,
   redeclare BaseClasses.Ventilation.Vent_TTH_pressureNetwork vent,
    sim(interZonalAirFlowType=IDEAS.BoundaryConditions.Types.InterZonalAirFlow.OnePort, n50=1.64));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StartTime=1.5e+007,
      StopTime=2.35872e+007,
      Interval=900,
      Tolerance=1e-006),
    __Dymola_experimentSetupOutput,
    __Dymola_experimentFlags(
      Advanced(GenerateVariableDependencies=false, OutputModelicaCode=false),
      Evaluate=true,
      OutputCPUtime=true,
      OutputFlatModelica=false),
    __Dymola_Commands(file=
          "modelica://IDEAS/Resources/Scripts/Dymola/Examples/TwinHouses/BuildingO5_Exp1.mos"
        "Simulate and plot"));
end BuildingO5_Exp1_1Port;
