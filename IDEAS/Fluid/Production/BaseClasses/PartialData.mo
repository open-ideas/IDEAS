within IDEAS.Fluid.Production.BaseClasses;
partial record PartialData "Partial for every production data file"
  extends Modelica.Icons.Record;

   parameter Modelica.SIunits.Power QNomRef(min=0)=1000
    "Nominal power from which the power data are used in this model";
   parameter Real etaRef(min=0, max=1)=1
    "Nominal efficiency (higher heating value)of the xxx boiler at 50/30degC.  See datafile";
   parameter Real modulationMin(min=0, max=100)=20
    "Minimal modulation percentage";
   parameter Real modulationStart(min=0, max=100)=30
    "Min estimated modulation level required for start of the heat source";
   parameter Modelica.SIunits.Temperature TMax "Maximum set point temperature";
   parameter Modelica.SIunits.Temperature TMin "Minimum set point temperature";

   parameter Boolean use_polynomial=false;
   parameter Boolean use_3DHeatSource=false;
   parameter Boolean use_2DHeatSource=false;
   parameter Boolean use_1DHeatSource=false;

   parameter Real beta[:] if use_polynomial
    "Coefficient for polynominal, if polynominal heat source is used";
   parameter Integer powers[:,:] if  use_polynomial
    "Exponents for polynominal, if polynominal heat source is used";

   parameter Real[:,:] table if use_2DHeatSource or use_1DHeatSource
    "Table of efficient of heatSource in function of THxIn (if 1DHeatSource is used) and in function of THxIn and mFlowHx (if 2DHeatSource is used)";

    parameter IDEAS.Utilities.Tables.Space space(
     planes=performanceMap,
     n=numberOfModulations) if  use_3DHeatSource
    "Efficiency space in case if 3DHeatSource is used";

    parameter Integer numberOfModulations(min=2) = 2 if use_3DHeatSource
    "The number of modulation degrees in case of 3DHeatSource is used";
    parameter IDEAS.Utilities.Tables.Plane[numberOfModulations] performanceMap if   use_3DHeatSource
    "The performance map in the form of a space in case of 3DHeatSource is used";

end PartialData;
