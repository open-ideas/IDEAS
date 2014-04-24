within IDEAS.Media;
package Water "Package with model for liquid water with constant properties"
   extends Modelica.Media.Interfaces.PartialPureSubstance(
     mediumName="Water",
     p_default=300000,
     reference_p=300000,
     reference_T=273.15,
     reference_X={1},
     final singleState=true,
     ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.T);


  redeclare record FluidConstants =
    Modelica.Media.Interfaces.Types.Basic.FluidConstants (
    each chemicalFormula="H2O",
    each structureFormula="H2O",
    each casRegistryNumber="7732-18-5",
    each iupacName="oxidane",
    each molarMass=MM_const);


  redeclare record extends ThermodynamicState "Thermodynamic state variables"
    Modelica.SIunits.Temperature T "Temperature of medium";
    Modelica.SIunits.AbsolutePressure p "Pressure of medium";
  end ThermodynamicState;

  constant Modelica.SIunits.SpecificHeatCapacity cp_const = 4148
  "Specific heat capacity at constant pressure";


  redeclare model extends BaseProperties(
     T(stateSelect=if
          preferredMediumStates then StateSelect.prefer else StateSelect.default),
     p(stateSelect=if
          preferredMediumStates then StateSelect.prefer else StateSelect.default),
     preferredMediumStates=true) "Base properties"
  equation
    h = (T - reference_T)*cp_const;
    u = h-reference_p/d;
    d = density(state);
    state.T = T;
    state.p = p;
    R=Modelica.Constants.R;
    MM=MM_const;
    annotation (Documentation(info="<html>
    <p>
    Base properties of the medium.
    </p>
</html>"));
  end BaseProperties;


redeclare function extends density "Return the density"
algorithm
  d := smooth(1,
    if state.T < 278.15 then
      -0.042860825*state.T + 1011.9695761
    elseif state.T < 373.15 then
      0.000015009*state.T^3 - 0.01813488505*state.T^2 + 6.5619527954075*state.T
      + 254.900074971947
    else
     -0.7025109*state.T + 1220.35045233);
  annotation (smoothOrder=1,
Documentation(info="<html>
<p>
This function computes the density as a function of temperature.
</p>
<h4>Implementation</h4>
<p>
The function is based on the IDA implementation in <code>therpro.nmf</code>, which
implements
</p>
<pre>
d := 1000.12 + 1.43711e-2*T_degC -
 5.83576e-3*T_degC^2 + 1.5009e-5*T_degC^3;
 </pre>
<p>
This has been converted to Kelvin, which resulted in the above expression.
In addition, below 5 &deg;C and above 100 &deg;C, the density is replaced
by a linear function to avoid inflection points.
This linear extension is such that the density is once continuously differentiable.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 18, 2013, by Michael Wetter:<br/>
First implementation, based on the IDA implementation in <code>therpro.nmf</code>, 
but converted from Celsius to Kelvin and linearly extended.
</li>
</ul>
</html>"));
end density;


redeclare function extends dynamicViscosity "Return the dynamic viscosity"
algorithm
  eta := density(state)*kinematicViscosity(state.T);
annotation (
Documentation(info="<html>
<p>
This function computes the dynamic viscosity.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 2, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end dynamicViscosity;


redeclare function extends specificEnthalpy "Return the specific enthalpy"
algorithm
  h := (state.T - reference_T)*cp_const;
annotation(smoothOrder=5,
Documentation(info="<html>
<p>
This function computes the specific enthalpy.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 11, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end specificEnthalpy;



redeclare function extends specificInternalEnergy
  "Return the specific enthalpy"
algorithm
  u := specificEnthalpy(state) - reference_p/density(state);
annotation(smoothOrder=5,
Documentation(info="<html>
<p>
This function computes the specific internal energy.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 11, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end specificInternalEnergy;


redeclare function extends specificEntropy "Return the specific entropy"
  extends Modelica.Icons.Function;
algorithm
  s := cv_const*Modelica.Math.log(state.T/reference_T);
  annotation (
    Documentation(info="<html>
<p>
This function computes the specific entropy.
</p>
<p>
To obtain the state for a given pressure, entropy and mass fraction, use
<a href=\"modelica://IDEAS.Media.Air.setState_psX\">
IDEAS.Media.Air.setState_psX</a>.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 18, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end specificEntropy;


redeclare function extends specificGibbsEnergy
  "Return the specific Gibbs energy"
  extends Modelica.Icons.Function;
algorithm
  g := specificEnthalpy(state) - state.T*specificEntropy(state);
annotation (
Documentation(info="<html>
<p>
This function computes the specific Gibbs energy.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 2, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end specificGibbsEnergy;


redeclare function extends specificHelmholtzEnergy
  "Return the specific Helmholtz energy"
  extends Modelica.Icons.Function;
algorithm
  f := specificInternalEnergy(state) - state.T*specificEntropy(state);
annotation (
Documentation(info="<html>
<p>
This function computes the specific Helmholtz energy.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 2, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end specificHelmholtzEnergy;


redeclare function extends isentropicEnthalpy "Return the isentropic enthalpy"
algorithm
  h_is := specificEnthalpy(setState_psX(
            p=p_downstream,
            s=specificEntropy(refState),
            X={1}));
annotation (
Documentation(info="<html>
<p>
This function computes the specific enthalpy for
an isentropic state change from the temperature
that corresponds to the state <code>refState</code>
to <code>reference_T</code>.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 18, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end isentropicEnthalpy;


redeclare function extends isobaricExpansionCoefficient
  "Return the isobaric expansion coefficient"
algorithm
    beta := -smooth(0,
    if state.T < 278.15 then
      0.042860825*(0.042860825*state.T - 1011.9695761)/(-0.042860825*state.T +
      1011.9695761)^2
    elseif state.T < 373.15 then
      (4.5027e-5*state.T^2 - 0.0362697701*state.T + 6.5619527954075)/
        (1.5009e-5*state.T^3 - 0.01813488505*state.T^2 + 6.5619527954075*state.T + 254.900074971947)
    else
       0.7025109*(0.7025109*state.T - 1220.35045233)/(-0.7025109*state.T +
       1220.35045233)^2);
        // Symbolic conversion of degC to Kelvin
//        ((4.5027e-05)*T_degC^2 - 0.01167152*state.T +
//               3.202446788)/((1.5009e-05)*T_degC^3 - 0.00583576*T_degC^2 +
//               0.0143711*state.T + 996.194534035)
annotation (
Documentation(info="<html>
<p>
This function returns the isobaric expansion coefficient,
</p>
<p align=\"center\" style=\"font-style:italic;\">
&beta;<sub>p</sub> = - 1 &frasl; v &nbsp; (&part; v &frasl; &part; T)<sub>p</sub>,
</p>
<p>
where
<i>v</i> is the specific volume,
<i>T</i> is the temperature and
<i>p</i> is the pressure.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 18, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end isobaricExpansionCoefficient;


redeclare function extends isothermalCompressibility
  "Return the isothermal compressibility factor"
algorithm
  kappa := 0;
annotation (
Documentation(info="<html>
<p>
This function returns the isothermal compressibility coefficient,
which is zero as this medium is incompressible.
The isothermal compressibility is defined as
</p>
<p align=\"center\" style=\"font-style:italic;\">
&kappa;<sub>T</sub> = - 1 &frasl; v &nbsp; (&part; v &frasl; &part; p)<sub>T</sub>,
</p>
<p>
where
<i>v</i> is the specific volume,
<i>T</i> is the temperature and
<i>p</i> is the pressure.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 18, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end isothermalCompressibility;


redeclare function extends density_derp_T
  "Return the partial derivative of density with respect to pressure at constant temperature"
algorithm
  ddpT := 0;
annotation (
Documentation(info="<html>
<p>
This function returns the partial derivative of density
with respect to pressure at constant temperature, 
which is zero as the medium is incompressible.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 18, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end density_derp_T;


redeclare function extends density_derT_p
  "Return the partial derivative of density with respect to temperature at constant pressure"
algorithm
  ddTp := smooth(1, if state.T < 278.15 then
            -0.042860825
          elseif state.T < 373.15 then
            (0.0000450270000000000*state.T^2 - 0.0362697701000000*state.T +
            6.56195279540750)
          else
           -0.7025109);
  annotation (smoothOrder=1, Documentation(info=
                   "<html>
<p>
This function computes the derivative of density with respect to temperature 
at constant pressure.
</p>
</html>", revisions=
"<html>
<ul>
<li>
December 18, 2013, by Michael Wetter:<br/>
First implementation, based on the IDA implementation in <code>therpro.nmf</code>, 
but converted from Celsius to Kelvin.
</li>
</ul>
</html>"));
end density_derT_p;


redeclare function extends density_derX
  "Return the partial derivative of density with respect to mass fractions at constant pressure and temperature"
algorithm
  dddX := fill(0, nX);
annotation (
Documentation(info="<html>
<p>
This function returns the partial derivative of density
with respect to mass fraction,
which is zero as the medium is a single substance.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 18, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end density_derX;


redeclare replaceable function extends specificHeatCapacityCp
  "Return the specific heat capacity at constant pressure"
algorithm
  cp := cp_const;
    annotation(derivative=der_specificHeatCapacityCp,
Documentation(info="<html>
<p>
This function returns the specific heat capacity at constant pressure.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 11, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end specificHeatCapacityCp;


redeclare replaceable function extends specificHeatCapacityCv
  "Return the specific heat capacity at constant volume"
algorithm
  cv := cv_const;
    annotation(derivative=der_specificHeatCapacityCp,
Documentation(info="<html>
<p>
This function computes the specific heat capacity at constant volume.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 11, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end specificHeatCapacityCv;


redeclare function extends thermalConductivity
  "Return the thermal conductivity"
algorithm
  lambda :=0.6065*(-1.48445 + 4.12292*(state.T/298.15) - 1.63866*(state.T/298.15)^2);
  annotation (
Documentation(info="<html>
<p>
This function returns the thermal conductivity.
The expression is obtained from Ramires et al. (1995).
</p>
<h4>References</h4>
<p>
Ramires, Maria L. V. and Nieto de Castro, Carlos A. and Nagasaka, Yuchi 
and Nagashima, Akira and Assael, Marc J. and Wakeham, William A.
Standard Reference Data for the Thermal Conductivity of Water.
<i>Journal of Physical and Chemical Reference Data</i>, 24, p. 1377-1381, 1995.
<a href=\"http://dx.doi.org/10.1063/1.555963\">DOI:10.1063/1.555963</a>.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 18, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end thermalConductivity;


redeclare function extends pressure "Return the pressure"
algorithm
    p := state.p;
annotation (
smoothOrder=99,
Documentation(info="<html>
<p>
This function returns the pressure.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 18, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end pressure;


redeclare function extends temperature "Return the temperature"
algorithm
    T := state.T;
annotation (
smoothOrder=99,
Documentation(info="<html>
<p>
This function returns the temperature.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 18, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end temperature;


redeclare function extends molarMass "Return the molar mass"
algorithm
    MM := MM_const;
    annotation (
smoothOrder=99,
Documentation(info="<html>
<p>
This function returns the molar mass,
which is assumed to be constant.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 18, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end molarMass;


redeclare function setState_dTX
  "Return the thermodynamic state as function of density d, temperature T and composition X or Xi"
  extends Modelica.Icons.Function;
  input Density d "Density";
  input Temperature T "Temperature";
  input MassFraction X[:]=reference_X "Mass fractions";
  output ThermodynamicState state "Thermodynamic state";

algorithm
    state := ThermodynamicState(p=reference_p, T=T);
    annotation (
smoothOrder=99,
Documentation(info="<html>
<p>
This function returns the thermodynamic state for a given density, temperature and composition.
Because this medium assumes density to be a function of temperature only,
this function ignores the argument <code>d</code>.
The pressure that is used to set the state is equal to the constant
<code>reference_p</code>.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 11, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end setState_dTX;


redeclare function extends setState_phX
  "Return the thermodynamic state as function of pressure p, specific enthalpy h and composition X or Xi"
algorithm
  state := ThermodynamicState(p=p, T=reference_T + h/cp_const);
  annotation (
smoothOrder=99,
Documentation(info="<html>
<p>
This function returns the thermodynamic state for a given pressure, 
specific enthalpy and composition.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 11, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end setState_phX;


redeclare function extends setState_pTX
  "Return the thermodynamic state as function of p, T and composition X or Xi"
algorithm
    state := ThermodynamicState(p=p, T=T);
annotation (smoothOrder=99,
Documentation(info="<html>
<p>
This function returns the thermodynamic state for a given pressure, 
temperature and composition.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 11, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end setState_pTX;


redeclare function extends setState_psX
  "Return the thermodynamic state as function of p, s and composition X or Xi"
algorithm
  // The temperature is obtained from symbolic solving the
  // specificEntropy function for T, i.e.,
  // s := cv_const*Modelica.Math.log(state.T/reference_T)
  state := ThermodynamicState(p=p, T=reference_T * Modelica.Math.exp(s/cv_const));
  annotation (
Inline=false,
Documentation(info="<html>
<p>
This function returns the thermodynamic state based on pressure, 
specific entropy and mass fraction.
</p>
<p>
The state is computed by symbolically solving
<a href=\"modelica://IDEAS.Media.Water.specificEntropy\">
IDEAS.Media.Water.specificEntropy</a>
for temperature.
  </p>
</html>", revisions="<html>
<ul>
<li>
December 11, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end setState_psX;

//////////////////////////////////////////////////////////////////////
// Protected classes.
// These classes are only of use within this medium model.
// Equipment models generally have no need to access them.
// Therefore, they are made protected. This also allows to redeclare the
// medium model with another medium model that does not provide an
// implementation of these classes.
protected 
  final constant Modelica.SIunits.SpecificHeatCapacity cv_const = cp_const
  "Specific heat capacity at constant volume";

  constant Modelica.SIunits.VelocityOfSound a_const=1484
  "Constant velocity of sound";
  constant Modelica.SIunits.MolarMass MM_const=0.018015268 "Molar mass";


replaceable function der_specificHeatCapacityCp
  "Return the derivative of the specific heat capacity at constant pressure"
  extends Modelica.Icons.Function;
  input ThermodynamicState state "Thermodynamic state";
  input ThermodynamicState der_state "Derivative of thermodynamic state";
  output Real der_cp(unit="J/(kg.K.s)") "Derivative of specific heat capacity";
algorithm
  der_cp := 0;
annotation (
Documentation(info="<html>
<p>
This function computes the derivative of the specific heat capacity 
at constant pressure with respect to the state.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 11, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end der_specificHeatCapacityCp;


replaceable function der_enthalpyOfLiquid
  "Temperature derivative of enthalpy of liquid per unit mass of liquid"
  extends Modelica.Icons.Function;
  input Temperature T "Temperature";
  input Real der_T "Temperature derivative";
  output Real der_h "Derivative of liquid enthalpy";
algorithm
  der_h := cp_const*der_T;
 annotation (Documentation(info=
"<html>
<p>
This function computes the temperature derivative of the enthalpy of liquid water
per unit mass.
</p>
</html>", revisions=
"<html>
<ul>
<li>
December 11, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end der_enthalpyOfLiquid;


function kinematicViscosity "Return the kinematic viscosity"
  extends Modelica.Icons.Function;

  input Modelica.SIunits.Temperature T "Temperature";
  output Modelica.SIunits.KinematicViscosity kinVis "Kinematic viscosity";
algorithm
  kinVis := smooth(1,
  if T < 278.15 then
    -(4.63023776563e-08)*T + 1.44011135763e-05
  else
    1.0e-6*Modelica.Math.exp(
      -(7.22111000000000e-7)*T^3 + 0.000809102858950000*T^2
      - 0.312920238272193*T + 40.4003044106506));

annotation (smoothOrder=1,
Documentation(info="<html>
<p>
This function computes the kinematic viscosity as a function of temperature.
</p>
<h4>Implementation</h4>
<p>
The function is based on the IDA implementation in <code>therpro.nmf</code>.
The original equation is
</p>
<pre>
kinVis :=1E-6*Modelica.Math.exp(0.577449 - 3.253945e-2*T_degC + 2.17369e-4*
      T_degC^2 - 7.22111e-7*T_degC^3);
      </pre>
<p>
This has been converted to Kelvin, which resulted in the above expression.
In addition, at 5 &deg;C the kinematic viscosity is linearly extrapolated
to avoid a large gradient at very low temperatures.
We selected the same point for the linearization as we used for the density,
as the density and the kinematic viscosity are combined in 
<a href=\"modelica://IDEAS.Media.Water.dynamicViscosity\">
IDEAS.Media.Water.dynamicViscosity</a>.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 18, 2013, by Michael Wetter:<br/>
First implementation, based on the IDA implementation in <code>therpro.nmf</code>, 
but converted from Celsius to Kelvin.
</li>
</ul>
</html>"));
end kinematicViscosity;


annotation (preferredView="info", Documentation(info="<html>
<p>
This medium package models liquid water.
For the specific heat capacities at constant pressure and at constant volume,
a constant value of <i>4184</i> J/(kg K), which corresponds to <i>20</i>&deg;C
is used.
The figure below shows the relative error of the specific heat capacity that
is introduced by this simplification.
</p>
<p align=\"center\">
<img src=\"modelica://IDEAS/Resources/Images/Media/Water/plotCp.png\" border=\"1\" 
alt=\"Relative variation of specific heat capacity with temperature\"/>
</p>
<p>
The mass density is computed using a 3rd order polynomial, which yields the following
density as a function of temperature.
</p>
<p align=\"center\">
<img src=\"modelica://IDEAS/Resources/Images/Media/Water/plotRho.png\" border=\"1\" 
alt=\"Mass density as a function of temperature\"/>
</p>
<p>
The enthalpy is computed using the convention that <i>h=0</i>
if <i>T=0</i> &deg;C.
</p>
<h4>Limitations</h4>
<p>
Water is modeled as an incompressible liquid, and there are no phase changes.
</p>
</html>", revisions="<html>
<ul>
<li>
December 18, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end Water;
