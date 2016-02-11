within IDEAS.Fluid.Production.Interfaces.BaseClasses;
partial record PartialNonModulatingRecord
  extends PartialRecord;

  parameter Real[:,:] heat = [[0]];
  parameter Real[:,:] power = [[0]];
  parameter Real[:,:] cop = [[0]];

end PartialNonModulatingRecord;
