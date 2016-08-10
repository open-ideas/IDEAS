within IDEAS.Fluid.Production;
model HeatPump_y "Heat pump with normalized speed as an input"
  extends IDEAS.Fluid.Production.BaseClasses.HeatPumpModulating;


  Modelica.Blocks.Interfaces.RealInput y "Normalized speed" annotation (
     Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,108})));

initial equation
  assert(hasSpeedTable, "You should not use normalized speed as an input if the model record does not have Speed as one of the input types!", AssertionLevel.warning);

equation
  modInt=y;
end HeatPump_y;
