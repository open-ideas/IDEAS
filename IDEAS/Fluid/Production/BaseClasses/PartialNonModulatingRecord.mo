within IDEAS.Fluid.Production.BaseClasses;
partial record PartialNonModulatingRecord
  import IDEAS;
  extends IDEAS.Fluid.Production.BaseClasses.PartialRecord;

  parameter Real[:,:] heat = [[0]];
  parameter Real[:,:] power = [[0]];
  parameter Real[:,:] cop = [[0]];

end PartialNonModulatingRecord;
