within IDEAS.Fluid.Production.BaseClasses;
partial record PartialModulatingRecord
  import IDEAS;
  extends IDEAS.Fluid.Production.BaseClasses.PartialRecord;

  parameter Real modulationStart=0;
  parameter Real modulationMin=-1;

  parameter Boolean efficiencyData=true;

  parameter Real[:,:,:] heat = {[[0]]};
  parameter Real[:,:,:] power = {[[0]]};
  parameter Real[:,:,:] cop = {[[0]]};

  parameter Integer n(min=2);
  parameter Real[n] modulationVector;

end PartialModulatingRecord;
