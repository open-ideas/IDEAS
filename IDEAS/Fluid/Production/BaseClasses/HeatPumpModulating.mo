within IDEAS.Fluid.Production.BaseClasses;
model HeatPumpModulating "Modulating heat pump"
  extends HeatPump3D;



protected
  parameter Boolean hasSpeedTable = dat.inputType1 == IDEAS.Fluid.Production.BaseClasses.InputType.Speed or dat.inputType2 == IDEAS.Fluid.Production.BaseClasses.InputType.Speed or dat.inputType3 == IDEAS.Fluid.Production.BaseClasses.InputType.Speed "True, if the performance data is a function of the compressor normalized speed";
  Real modInt "Modulation factor";
public
  Modelica.Blocks.Sources.RealExpression modExp(y=modInt) if hasSpeedTable
    "Table input for modulation rate"
    annotation (Placement(transformation(extent={{-122,-18},{-102,2}})));
equation

  if hasSpeedTable then
    P=PInt;
    QEva=QEvaInt;
    QCon=QConInt;
    cop=copInt;
    connect(modExp.y, inputs[7].u) annotation (Line(points={{-101,-8},{-101,-8},{-66,
          -8},{-66,0},{-62,0}}, color={0,0,127}));
  else
    P=PInt*modInt;
    QEva=QEvaInt*modInt;
    QCon=QConInt*modInt;
    cop=copInt;
  end if;

end HeatPumpModulating;
