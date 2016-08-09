within IDEAS.Fluid.Production.BaseClasses;
partial record HeatPumpData3D "Data record for storing data for a heat pump"
  extends Modelica.Icons.Record;

  parameter Integer nDim1(min=1) = size(indicesDim1,1) "Number of elements in dimension 1";
  parameter Integer nDim2(min=1) = size(indicesDim2,1) "Number of elements in dimension 2";
  parameter Integer nDim3(min=1, max=7) = size(indicesDim3,1) "Number of elements in dimension 3";

  parameter IDEAS.Fluid.Production.BaseClasses.InputType inputType1
    "Table input type corresponding to first dimension"
    annotation(Evaluate=true);
  parameter IDEAS.Fluid.Production.BaseClasses.InputType inputType2
    "Table input type corresponding to second dimension"
    annotation(Evaluate=true);
  parameter IDEAS.Fluid.Production.BaseClasses.InputType inputType3
    "Table input type corresponding to third dimension"
    annotation(Evaluate=true);

  parameter IDEAS.Fluid.Production.BaseClasses.OutputType outputType1
    "Output of table a"
    annotation(Evaluate=true);
  parameter IDEAS.Fluid.Production.BaseClasses.OutputType outputType2
    "Output of table b"
    annotation(Evaluate=true);

  parameter Real indicesDim1[:];
  parameter Real indicesDim2[:];
  parameter Real indicesDim3[:];

  parameter Real table1_a[nDim1, nDim2] = zeros(nDim1,nDim2)
    "Table matrix containing dimensions 1 and 2 for first entry of dimension 3"
    annotation (Dialog(group="Table data definition"));
  parameter Real table2_a[nDim1, nDim2] = zeros(nDim1,nDim2)
    "Table matrix containing dimensions 1 and 2 for second entry of dimension 3"
    annotation (Dialog(group="Table data definition"));
  parameter Real table3_a[nDim1, nDim2] = zeros(nDim1,nDim2)
    "Table matrix containing dimensions 1 and 2 for third entry of dimension 3"
    annotation (Dialog(group="Table data definition"));
  parameter Real table4_a[nDim1, nDim2] = zeros(nDim1,nDim2)
    "Table matrix containing dimensions 1 and 2 for fourth entry of dimension 3"
    annotation (Dialog(group="Table data definition"));
  parameter Real table5_a[nDim1, nDim2] = zeros(nDim1,nDim2)
    "Table matrix containing dimensions 1 and 2 for fifth entry of dimension 3"
    annotation (Dialog(group="Table data definition"));
  parameter Real table6_a[nDim1, nDim2] = zeros(nDim1,nDim2)
    "Table matrix containing dimensions 1 and 2 for sixth entry of dimension 3"
    annotation (Dialog(group="Table data definition"));
  parameter Real table7_a[nDim1, nDim2] = zeros(nDim1,nDim2)
    "Table matrix containing dimensions 1 and 2 for seventh entry of dimension 3"
    annotation (Dialog(group="Table data definition"));
  parameter Real table1_b[nDim1, nDim2] = zeros(nDim1,nDim2)
    "Table matrix containing dimensions 1 and 2 for first entry of dimension 3"
    annotation (Dialog(group="Table data definition"));
  parameter Real table2_b[nDim1, nDim2] = zeros(nDim1,nDim2)
    "Table matrix containing dimensions 1 and 2 for second entry of dimension 3"
    annotation (Dialog(group="Table data definition"));
  parameter Real table3_b[nDim1, nDim2] = zeros(nDim1,nDim2)
    "Table matrix containing dimensions 1 and 2 for third entry of dimension 3"
    annotation (Dialog(group="Table data definition"));
  parameter Real table4_b[nDim1, nDim2] = zeros(nDim1,nDim2)
    "Table matrix containing dimensions 1 and 2 for fourth entry of dimension 3"
    annotation (Dialog(group="Table data definition"));
  parameter Real table5_b[nDim1, nDim2] = zeros(nDim1,nDim2)
    "Table matrix containing dimensions 1 and 2 for fifth entry of dimension 3"
    annotation (Dialog(group="Table data definition"));
  parameter Real table6_b[nDim1, nDim2] = zeros(nDim1,nDim2)
    "Table matrix containing dimensions 1 and 2 for sixth entry of dimension 3"
    annotation (Dialog(group="Table data definition"));
  parameter Real table7_b[nDim1, nDim2] = zeros(nDim1,nDim2)
    "Table matrix containing dimensions 1 and 2 for seventh entry of dimension 3"
    annotation (Dialog(group="Table data definition"));

  parameter Modelica.SIunits.MassFlowRate m1_flow_nominal
    "Mass flow rate of the evaporator for calculation of the pressure drop";
  parameter Modelica.SIunits.MassFlowRate m2_flow_nominal
    "Mass flow rate of the condensor for calculation of the pressure drop";

  parameter Modelica.SIunits.Pressure dp1_nominal
    "Pressure drop of the evaporator at nominal mass flow rate";
  parameter Modelica.SIunits.Pressure dp2_nominal
    "Pressure drop of the condensor at nominal mass flow rate";

  parameter Modelica.SIunits.Temperature TEvaMin = 0
    "Lower bound for evaporator temperature";
  parameter Modelica.SIunits.Temperature TEvaMax = 500
    "Upper bound for evaporator temperature";
  parameter Modelica.SIunits.Temperature TConMin = 0
    "Lower bound for condensor temperature";
  parameter Modelica.SIunits.Temperature TConMax = 500
    "Upper bound for condensor temperature";

  annotation (Documentation(revisions="<html>
<ul>
<li>March 2014 by Filip Jorissen:<br/> 
Initial version
</li>
</ul>
</html>"));
end HeatPumpData3D;
