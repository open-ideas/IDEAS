within IDEAS.Fluid.Production;
package HeatSources
  model PerformanceMap3D "Heat source based on data from a 3D performance map"
    //Extensions
    extends IDEAS.Fluid.Production.BaseClasses.PartialHeatSource(
      modulating=true);

    //Parameters en Constants
    constant Real kgps2lph=3600/Medium.density(Medium.setState_pTX(Medium.p_default, Medium.T_default, Medium.X_default))*1000
      "Conversion from kg/s to l/h";
    parameter IDEAS.Utilities.Tables.Space space
      "The 3D space containing the performance data";

    //Components
    Modelica.Blocks.Logical.Hysteresis hysteresis(
      uLow=modulationMin,
      uHigh=modulationStart)
      annotation (Placement(transformation(extent={{-42,40},{-22,60}})));
    Utilities.Tables.InterpolationTable3D interpolationTable(space=space)
      "Interpolation table to determine the efficiency at a modulation grade"
      annotation (Placement(transformation(extent={{-10,12},{10,32}})));
    Utilities.Tables.InterpolationTable3D interpolationTableQMax(space=space)
      "Interpolation table to determine the maximum possible power output at 100% modulation"
      annotation (Placement(transformation(extent={{-10,-24},{10,-4}})));

  equation
    //Calculation of the efficiency at 100% modulation
    interpolationTableQMax.u1 = THxIn-273.15;
    interpolationTableQMax.u2 = m_flowHx_scaled*kgps2lph;
    interpolationTableQMax.u3 = 100;

    //Calculation of the efficiency at the required modulation grade
    interpolationTable.u1 = THxIn-273.15;
    interpolationTable.u2 = m_flowHx_scaled*kgps2lph;
    interpolationTable.u3 = modulation;

    //Calculation of the modulation
    release = if noEvent(m_flow > Modelica.Constants.eps) then 0.0 else 1.0;
    modulationInit = QAsked/QMax*100;
      hysteresis.u = modulationInit;
    modulation = if hysteresis.y then min(modulationInit, 100) else 0;

    //Calcualation of the heat powers
    QMax = interpolationTableQMax.y/etaRef*QNom;
    QAsked = IDEAS.Utilities.Math.Functions.smoothMax(0, m_flow*(Medium.specificEnthalpy(Medium.setState_pTX(Medium.p_default, TSet, Medium.X_default)) -hIn), 10);
    QLossesToCompensate = if noEvent(modulation) > 0 then UALoss*(heatPort.T - sim.Te) else 0;

    //Final heat power of the heat source
    eta = interpolationTable.y;
    heatPort.Q_flow = -eta/etaRef*modulation/100*QNom - QLossesToCompensate;
    PFuel = if noEvent(release < 0.5) and noEvent(eta>Modelica.Constants.eps) then -heatPort.Q_flow/eta else 0;

    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics));
  end PerformanceMap3D;

  model Polynomial "Heat source based on a polynomial function"
    //Extensions
    extends IDEAS.Fluid.Production.BaseClasses.PartialHeatSource;

    //Parameters en Constants
    constant Real kgps2lph=3600/Medium.density(Medium.setState_pTX(Medium.p_default, Medium.T_default, Medium.X_default))*1000
      "Conversion from kg/s to l/h";
    parameter Real beta[:] "Constant parameters of the polynomial function";
    parameter Integer powers[:,k] "Constant powers of the polynomial function";

    final parameter Integer n = size(powers, 1);
    final parameter Integer k = 4 "Number of inputs + 1";

    //Components
     Modelica.Blocks.Logical.Hysteresis hysteresis(
      uLow=modulationMin,
      uHigh=modulationStart)
      annotation (Placement(transformation(extent={{-40,40},{-20,60}})));

  equation
    //Calculation of the modulation
    release = if noEvent(m_flow > Modelica.Constants.eps) then 0.0 else 1.0;
    hysteresis.u = modulationInit;
    modulationInit = QAsked/QMax*100;
    modulation = if hysteresis.y then IDEAS.Utilities.Math.Functions.smoothMin(modulationInit, 100, deltaX=0.1) else 0;

    //Calcualation of the heat powers
    QMax = PolynomialDimensions(beta=beta, powers=powers, X={100, m_flowHx_scaled*kgps2lph, THxIn-273.15}, n=n, k=k)/etaRef*QNom;
    QAsked = IDEAS.Utilities.Math.Functions.smoothMax(0, m_flow*(Medium.specificEnthalpy(Medium.setState_pTX(Medium.p_default, TSet, Medium.X_default)) -hIn), QNom/10000);
    QLossesToCompensate = if noEvent(modulation > 0) then UALoss*(heatPort.T - sim.Te) else 0;

    //Polynomial
    eta = PolynomialDimensions(beta=beta, powers=powers, X={modulation, m_flowHx_scaled*kgps2lph, THxIn-273.15}, n=n, k=k);
    heatPort.Q_flow = -eta/etaRef*modulation/100*QNom - QLossesToCompensate;
    PFuel = if noEvent(release < 0.5) and noEvent(eta>Modelica.Constants.eps) then -heatPort.Q_flow/eta else 0;

    annotation (Diagram(graphics));
  end Polynomial;

  function PolynomialDimensions "Function to calculate the output of a polynomial based on the number of
  inputs and the degree"

    //Dimensions of the power matrix nxk
    input Integer n;
    input Integer k;

    //Constants
    input Real beta[n];

    //Powers
    input Integer powers[n,k];

    //Inputs
    input Real[k-1] X;

    //Output
    output Real result;

    //Variables
  protected
    Real variables[k];
    Real term;

  algorithm
     variables[1] :=1;
     for i in 2:k loop
       variables[i] := X[i-1];
     end for;

    result := 0;

    for i in 1:n loop
      term := beta[i];
      for j in 1:k loop
        if variables[j]<=0 and powers[i,j] <=0 then
          term := term;
        else
          term := term * variables[j]^powers[i,j];
        end if;
      end for;
      result := result + term;
    end for;

  end PolynomialDimensions;
end HeatSources;
