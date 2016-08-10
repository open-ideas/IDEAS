within IDEAS.Fluid.Production;
model HeatPump_Nrpm "Heat pump with speed as an input"
  extends IDEAS.Fluid.Production.BaseClasses.HeatPumpModulating;
  parameter Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm speed_rpm_nominal  "Nominal compressor speed";

  Modelica.Blocks.Interfaces.RealInput Nrpm "Compressor speed" annotation (
     Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,108})));


initial equation
  assert(hasSpeedTable, "You should not use normalized speed as an input if the model record does not have Speed as one of the input types!", AssertionLevel.warning);

equation
  modInt=Nrpm/speed_rpm_nominal;
end HeatPump_Nrpm;
