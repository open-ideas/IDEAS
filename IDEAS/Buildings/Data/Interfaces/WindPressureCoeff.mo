within IDEAS.Buildings.Data.Interfaces;
record WindPressureCoeff
  "Record for storing tables for wind pressure coeff"
  extends Modelica.Icons.Record;

  parameter Real Cp_Wall [:,:];
  parameter Real Cp_Roof[:,:];
  parameter Real Cp_Floor[:,:];

end WindPressureCoeff;
