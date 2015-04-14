within IDEAS.Fluid.Production.Interfaces.BaseClasses;
partial record PartialModulatingRecord
  extends PartialRecord;

  parameter Real modulationStart=30;
  parameter Real modulationMin=20;

  parameter Real[:,:,:] heat = {[[0]]};
  parameter Real[:,:,:] power = {[[0]]};

  parameter Integer n(min=2);
  parameter Real[n] modulationVector;

end PartialModulatingRecord;
