within IDEAS.Fluid.Production.BaseClasses.HeatSources;
model PolynomialHeatSource "Heat source based on a polynomial function"
  //Extensions
  extends IDEAS.Fluid.Production.BaseClasses.PartialModulatingHeatSource;

  //Parameters en Constants
  constant Real kgps2lph=3600/Medium.density(Medium.setState_pTX(Medium.p_default, Medium.T_default, Medium.X_default))*1000
    "Conversion from kg/s to l/h";
  parameter Real beta[:] "Constant parameters of the polynomial function";
  parameter Integer powers[:,k] "Constant powers of the polynomial function";

  final parameter Integer n = size(powers, 1);
  final parameter Integer k = 4 "Number of inputs + 1";

  //Components

equation
  //Calculation of the modulation
  release = if noEvent(m_flow > Modelica.Constants.eps) then 0.0 else 1.0;
  hysteresis.u = modulationInit;
  modulationInit = QAsked/QMax*100;
  modulation = if avoidEvents then onOff_internal_filtered * IDEAS.Utilities.Math.Functions.smoothMin(modulationInit, 100, deltaX=0.1) elseif hysteresis.y and noEvent(release<0.5) then IDEAS.Utilities.Math.Functions.smoothMin(modulationInit, 100, deltaX=0.1) else 0;

  //Calcualation of the heat powers
  QMax = PolynomialDimensions(beta=beta, powers=powers, X={100, m_flowHx_scaled*kgps2lph, THxIn-273.15}, n=n, k=k)/etaRef*QNom;
  QAsked = IDEAS.Utilities.Math.Functions.smoothMax(0, m_flow*(Medium.specificEnthalpy(Medium.setState_pTX(Medium.p_default, TSet, Medium.X_default)) -hIn), QNom/10000);
  QLossesToCompensate = if noEvent(modulation > Modelica.Constants.eps) then UALoss*(heatPort.T - sim.Te) else 0;

  //Polynomial
  eta = PolynomialDimensions(beta=beta, powers=powers, X={modulation, m_flowHx_scaled*kgps2lph, THxIn-273.15}, n=n, k=k);
  heatPort.Q_flow = -eta/etaRef*modulation/100*QNom - QLossesToCompensate;
  PFuel = if noEvent(release < 0.5) and noEvent(eta>Modelica.Constants.eps) then -heatPort.Q_flow/eta else 0;

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics));
end PolynomialHeatSource;
