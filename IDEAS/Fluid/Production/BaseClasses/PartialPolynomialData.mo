within IDEAS.Fluid.Production.BaseClasses;
partial record PartialPolynomialData
  extends Modelica.Icons.Record;
  extends PartialData;

  parameter Real beta[:];
  parameter Integer powers[:,:];

end PartialPolynomialData;
