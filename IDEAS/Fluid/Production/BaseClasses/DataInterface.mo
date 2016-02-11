within IDEAS.Fluid.Production.BaseClasses;
record DataInterface "Interface for every production data file"

  //Extensions
  extends Modelica.Icons.Record;

  //General settings of the heater data
  //****************************************************************************
  parameter Modelica.SIunits.Power QNomRef(min=0)
    "Nominal power from which the power data are used in this model";
  parameter Real etaRef(min=0, max=1)=1
    "Nominal efficiency (higher heating value)of the boiler during experiments.  See datafile";
  parameter Modelica.SIunits.Temperature TMax "Maximum set point temperature";
  parameter Modelica.SIunits.Temperature TMin "Minimum set point temperature";

  parameter Boolean isModulating=true
    "Set to true if the boiler is able to modulate";
  parameter Boolean usePolynomial=false
    "Set to true to use a polynomial to calcuate the required heat";

  parameter Types.Inputs typeU1=Types.Inputs.TPrimary
    "The first input variable";
  parameter Types.Inputs typeU2=Types.Inputs.MassFlow
    "The second input variable";
  parameter Types.Inputs typeU3=Types.Inputs.Modulation
    "The third input variable";

  parameter Types.Temperature TUnit=Types.Temperature.C;
  parameter Types.MassFlow mUnit=Types.MassFlow.lph;

  //Table for non-modulating heaters
  //****************************************************************************
  parameter Real[:,:] table = [0,0]
    "Table of efficient of heatSource in function of THxIn (if 1DHeatSource is used) and in function of THxIn and mFlowHx (if 2DHeatSource is used)";

  //Modulation settings of the heater
  //****************************************************************************
  parameter Real modulationMin(min=0, max=100)=20
    "Minimal modulation percentage";
  parameter Real modulationStart(min=0, max=100)=30
    "Min estimated modulation level required for start of the heat source";

  //Polynomial settings
  //****************************************************************************
  parameter Real beta[:] = {0}
    "Coefficient for polynominal, if polynominal heat source is used";
  parameter Integer powers[:,:] = [0,0]
    "Exponents for polynominal, if polynominal heat source is used";
  parameter Integer n;
  parameter Integer k;

  //3D interpolation table settings
  //****************************************************************************
  parameter IDEAS.Utilities.Tables.Space space(
    planes=performanceMap,
    n=numberOfModulations)
    "Efficiency space in for the calcuation of the modulation";
  parameter Integer numberOfModulations(min=2) = 2
    "The number of modulation degrees in case of 3DHeatSource is used";
  parameter IDEAS.Utilities.Tables.Plane[numberOfModulations] performanceMap
    "The performance map in the form of a space in case of 3DHeatSource is used";

end DataInterface;
