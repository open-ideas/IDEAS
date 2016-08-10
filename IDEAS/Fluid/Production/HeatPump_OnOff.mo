within IDEAS.Fluid.Production;
model HeatPump_OnOff
  extends BaseClasses.HeatPump3D;
equation
      P=PInt;
      QEva=QEvaInt;
      QCon=QConInt;
      cop=copInt;

end HeatPump_OnOff;
