within IDEAS.Experimental.Electric.Data.Interfaces;
record GridImp "Describe a grid by matrices of layout and impedances"
  extends Modelica.Icons.MaterialProperty;
  //extends IDEAS.Experimental.Electric.Data.Interfaces.GridLayout;
  //parameter Integer n(min=1);
  //parameter Integer T_matrix[nNodes,nNodes];

  parameter Integer nNodes( min=1);
 // parameter Integer nodeMatrix[size(nodeMatrix, 1), :];
  parameter Integer nodeMatrix[nNodes, nNodes];
  parameter Modelica.Units.SI.Resistance R[nNodes];
  parameter Modelica.Units.SI.Reactance X[nNodes];
  parameter Modelica.Units.SI.ComplexImpedance Z[nNodes](re=R, im=X);

end GridImp;
