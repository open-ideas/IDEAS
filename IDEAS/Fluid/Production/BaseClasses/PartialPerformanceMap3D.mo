within IDEAS.Fluid.Production.BaseClasses;
partial record PartialPerformanceMap3D
  extends Modelica.Icons.Record;
  extends PartialData;

  parameter IDEAS.Utilities.Tables.Space space(
    planes=performanceMap,
    n=numberOfModulations);

  parameter Integer numberOfModulations(min=2)
    "The number of modulation degrees";
  parameter IDEAS.Utilities.Tables.Plane[numberOfModulations] performanceMap
    "The performance map in the form of a space";

end PartialPerformanceMap3D;
