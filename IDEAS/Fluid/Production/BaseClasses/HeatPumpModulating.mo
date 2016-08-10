within IDEAS.Fluid.Production.BaseClasses;
model HeatPumpModulating "Modulating heat pump"
  extends HeatPump3D(modExp(y=modInt));

protected
  Real modInt "Modulation factor";
  parameter Boolean hasSpeedTable = dat.inputType1 == IDEAS.Fluid.Production.BaseClasses.InputType.Speed or dat.inputType2 == IDEAS.Fluid.Production.BaseClasses.InputType.Speed or dat.inputType3 == IDEAS.Fluid.Production.BaseClasses.InputType.Speed "True, if the performance data is a function of the compressor normalized speed";
equation

  // mod will be used as an input to the performance tables
  // and therefore the performance tables will determine the impact of the modulation rate
  if hasSpeedTable then
    P=PInt;
    QEva=QEvaInt;
    QCon=QConInt;
    cop=copInt;
  // mod will NOT be used as an input to the performance tables
  // therefore use default rescaling: resale thermal powers linearly and assume that COP remains the same
  else
    P=PInt*modInt;
    QEva=QEvaInt*modInt;
    QCon=QConInt*modInt;
    cop=copInt;
  end if;

end HeatPumpModulating;
