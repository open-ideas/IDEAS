within IDEAS.Fluid.Production.BaseClasses.HeatSources;
model PolynomialHeatSource "Heat source based on a polynomial function"
  //Extensions
  extends IDEAS.Fluid.Production.BaseClasses.PartialHeatSource(redeclare replaceable
      Data.Polynomials.Boiler2ndDegree data);

  //Parameters en Constants
  constant Real kgps2lph=3600/Medium.density(Medium.setState_pTX(Medium.p_default, Medium.T_default, Medium.X_default))*1000
    "Conversion from kg/s to l/h";
  parameter Real beta[:] = data.beta
    "Constant parameters of the polynomial function";
  parameter Integer powers[:,k] = data.powers
    "Constant powers of the polynomial function";

  final parameter Integer n = size(powers, 1);
  final parameter Integer k = 4 "Number of inputs + 1";

  //Components

equation
  //Calcualation of the heat powers
  QMax = PolynomialDimensions(beta=beta, powers=powers, X={100, m_flowHx_scaled*kgps2lph, THxIn-273.15}, n=n, k=k)/etaRef*QNom;

  //Polynomial
  eta = if on_internal then PolynomialDimensions(beta=beta, powers=powers, X={modulation, m_flowHx_scaled*kgps2lph, THxIn-273.15}, n=n, k=k) else 0;

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics));
end PolynomialHeatSource;
