within IDEAS;
package Experimental "Package with experimental models"
  extends Modelica.Icons.Package;

  package Media "Package with experimental models"
    extends Modelica.Icons.Package;

    package AirPTDecoupled
      "Package with moist air model that decouples pressure and temperature"
      extends Modelica.Media.Interfaces.PartialCondensingGases(
         mediumName="AirPTDecoupled",
         final substanceNames={"water", "air"},
         final reducedX=true,
         final singleState = false,
         reference_X={0.01,0.99},
         final fluidConstants = {Modelica.Media.IdealGases.Common.FluidData.H2O,
                                 Modelica.Media.IdealGases.Common.FluidData.N2},
         reference_T=273.15,
         reference_p=101325);

      constant Integer Water=1
        "Index of water (in substanceNames, massFractions X, etc.)";
      constant Integer Air=2
        "Index of air (in substanceNames, massFractions X, etc.)";

      constant AbsolutePressure pStp = reference_p
        "Pressure for which fluid density is defined";
      constant Density dStp = 1.2 "Fluid density at pressure pStp";

      // Redeclare ThermodynamicState to avoid the warning
      // "Base class ThermodynamicState is replaceable"
      // during model check
      redeclare record extends ThermodynamicState
        "ThermodynamicState record for moist air"
      end ThermodynamicState;

      redeclare replaceable model extends BaseProperties(
        T(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
        p(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
        Xi(each stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
        final standardOrderComponents=true) "Base properties"

        Real phi(min=0, start=0.5) "Relative humidity";

      protected
        constant Modelica.SIunits.MolarMass[2] MMX = {steam.MM,dryair.MM}
          "Molar masses of components";

        MassFraction X_steam "Mass fraction of steam water";
        MassFraction X_air "Mass fraction of air";
        AbsolutePressure p_steam_sat "Partial saturation pressure of steam";
        Modelica.SIunits.TemperatureDifference dT
          "Temperature difference used to compute enthalpy";
      equation
        assert(T >= 200.0 and T <= 423.15, "
Temperature T is not in the allowed range
200.0 K <= (T ="   + String(T) + " K) <= 423.15 K
required from medium model \""         + mediumName + "\".");

        MM = 1/(Xi[Water]/MMX[Water]+(1.0-Xi[Water])/MMX[Air]);

        p_steam_sat = min(saturationPressure(T),0.999*p);

        X_steam  = Xi[Water]; // There is no liquid in this medium model
        X_air    = 1-Xi[Water];

        dT = T - reference_T;
        h = dT*dryair.cp * X_air +
           (dT * steam.cp + h_fg) * X_steam;
        R = dryair.R*X_air + steam.R*X_steam;

        // Equation for ideal gas, from h=u+p*v and R*T=p*v, from which follows that  u = h-R*T.
        // u = h-R*T;
        // However, in this medium, the gas law is d/dStp=p/pStp, from which follows using h=u+pv that
        // u= h-p*v = h-p/d = h-pStp/dStp
        u = h-pStp/dStp;

        // In this medium model, the density depends only
        // on temperature, but not on pressure.
        //  d = p/(R*T);
        d/dStp = p/pStp;

        state.p = p;
        state.T = T;
        state.X = X;

        phi = p/p_steam_sat*Xi[Water]/(Xi[Water] + k_mair*X_air);
      end BaseProperties;

    redeclare function density "Gas density"
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output Density d "Density";
    algorithm
      d :=state.p*dStp/pStp;
      annotation (smoothOrder=5, Documentation(info="<html>
Density is computed from pressure, temperature and composition in the thermodynamic state record applying the ideal gas law.
</html>"));
    end density;

    redeclare function extends dynamicViscosity
        "Return the dynamic viscosity of dry air"
    algorithm
      eta := 4.89493640395e-08 * state.T + 3.88335940547e-06;
      annotation (
      smoothOrder=99,
    Documentation(info="<html>
<p>
This function returns the dynamic viscosity.
</p>
<h4>Implementation</h4>
<p>
The function is based on the 5th order polynomial 
of 
<a href=\"modelica://Modelica.Media.Air.MoistAir.dynamicViscosity\">
Modelica.Media.Air.MoistAir.dynamicViscosity</a>.
However, for the typical range of temperatures encountered
in building applications, a linear function sufficies.
This implementation is therefore the above 5th order polynomial,
linearized around <i>20</i>&deg;C.
The relative error of this linearization is 
<i>0.4</i>% at <i>-20</i>&deg;C,
and less then
<i>0.2</i>% between  <i>-5</i>&deg;C and  <i>+50</i>&deg;C.
</p>
</html>",
    revisions="<html>
<ul>
<li>
December 19, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
    end dynamicViscosity;

    redeclare function enthalpyOfCondensingGas
        "Enthalpy of steam per unit mass of steam"
      extends Modelica.Icons.Function;

      input Temperature T "temperature";
      output SpecificEnthalpy h "steam enthalpy";
    algorithm
      h := (T-reference_T) * steam.cp + h_fg;
      annotation(smoothOrder=5, derivative=der_enthalpyOfCondensingGas);
    end enthalpyOfCondensingGas;

    redeclare replaceable function extends enthalpyOfGas
        "Enthalpy of gas mixture per unit mass of gas mixture"
    algorithm
      h := enthalpyOfCondensingGas(T)*X[Water]
           + enthalpyOfDryAir(T)*(1.0-X[Water]);
    end enthalpyOfGas;

    redeclare replaceable function extends enthalpyOfLiquid
        "Enthalpy of liquid (per unit mass of liquid) which is linear in the temperature"
    algorithm
      h := (T - reference_T)*4186;
      annotation(smoothOrder=5, derivative=der_enthalpyOfLiquid);
    end enthalpyOfLiquid;

    redeclare function enthalpyOfNonCondensingGas
        "Enthalpy of non-condensing gas per unit mass of steam"
      extends Modelica.Icons.Function;

      input Temperature T "temperature";
      output SpecificEnthalpy h "enthalpy";
    algorithm
      h := enthalpyOfDryAir(T);
      annotation(smoothOrder=5, derivative=der_enthalpyOfNonCondensingGas);
    end enthalpyOfNonCondensingGas;

    redeclare function extends enthalpyOfVaporization
        "Enthalpy of vaporization of water"
    algorithm
      r0 := h_fg;
    end enthalpyOfVaporization;

    redeclare function extends gasConstant
        "Return ideal gas constant as a function from thermodynamic state, only valid for phi<1"

    algorithm
        R := dryair.R*(1 - state.X[Water]) + steam.R*state.X[Water];
      annotation (smoothOrder=2, Documentation(info="<html>
The ideal gas constant for moist air is computed from <a href=\"modelica://Modelica.Media.Air.MoistAir.ThermodynamicState\">thermodynamic state</a> assuming that all water is in the gas phase.
</html>"));
    end gasConstant;

    redeclare function extends pressure
        "Returns pressure of ideal gas as a function of the thermodynamic state record"

    algorithm
      p := state.p;
      annotation (smoothOrder=2, Documentation(info="<html>
Pressure is returned from the thermodynamic state record input as a simple assignment.
</html>"));
    end pressure;

    redeclare function extends isobaricExpansionCoefficient
        "Isobaric expansion coefficient beta"
    algorithm
      beta := 0;
    annotation (
    Documentation(info="<html>
<p>
This function returns the isobaric expansion coefficient at constant pressure,
which is zero for this medium.
The isobaric expansion coefficient at constant pressure is
</p>
<p align=\"center\" style=\"font-style:italic;\">
&beta;<sub>p</sub> = - 1 &frasl; v &nbsp; (&part; v &frasl; &part; T)<sub>p</sub> = 0,
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
        "Isothermal compressibility factor"
    algorithm
      kappa := -1/state.p;
    annotation (
    Documentation(info="<html>
<p>
This function returns the isothermal compressibility coefficient.
The isothermal compressibility is
</p>
<p align=\"center\" style=\"font-style:italic;\">
&kappa;<sub>T</sub> = -1 &frasl; v &nbsp; (&part; v &frasl; &part; p)<sub>T</sub>
  = -1 &frasl; p,
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

    redeclare function extends saturationPressure
        "Saturation curve valid for 223.16 <= T <= 373.16 (and slightly outside with less accuracy)"

    algorithm
      psat := IDEAS.Utilities.Psychrometrics.Functions.saturationPressure(Tsat);
      annotation(Inline=false,smoothOrder=5);
    end saturationPressure;

    redeclare function extends specificEntropy
        "Return the specific entropy, only valid for phi<1"

      protected
        Modelica.SIunits.MoleFraction[2] Y "Molar fraction";
    algorithm
        Y := massToMoleFractions(
             state.X, {steam.MM,dryair.MM});
        s := specificHeatCapacityCp(state) * Modelica.Math.log(state.T/reference_T)
             - Modelica.Constants.R *
             sum(state.X[i]/MMX[i]*
                 Modelica.Math.log(max(Y[i], Modelica.Constants.eps)) for i in 1:2);
      annotation (
        Inline=false,
        Documentation(info="<html>
<p>
This function computes the specific entropy.
</p>
<p>
The specific entropy of the mixture is obtained from
<p align=\"center\" style=\"font-style:italic;\">
s = s<sub>s</sub> + s<sub>m</sub>,
</p>
<p>
where
<i>s<sub>s</sub></i> is the entropy change due to the state change 
(relative to the reference temperature) and
<i>s<sub>m</sub></i> is the entropy change due to mixing
of the dry air and water vapor.
</p>
<p>
The entropy change due to change in state is obtained from
<p align=\"center\" style=\"font-style:italic;\">
s<sub>s</sub> = c<sub>v</sub> ln(T/T<sub>0</sub>) + R ln(v/v<sub>0</sub>) <br/>
= c<sub>v</sub> ln(T/T<sub>0</sub>) + R ln(&rho;<sub>0</sub>/&rho;)
</p>
<p>If we assume <i>&rho; = p<sub>0</sub>/(R T)</i>, 
and because <i>c<sub>p</sub> = c<sub>v</sub> + R</i>,
we can write
</p>
<p align=\"center\" style=\"font-style:italic;\">
s<sub>s</sub> = c<sub>v</sub> ln(T/T<sub>0</sub>) + R ln(T/T<sub>0</sub>) <br/>
=c<sub>p</sub> ln(T/T<sub>0</sub>).
</p>
<p>
Next, the entropy of mixing is obtained from a reversible isothermal
expansion process. Hence,
</p>
<p align=\"center\" style=\"font-style:italic;\">
  s<sub>m</sub> = -R &sum;<sub>i</sub>( X<sub>i</sub> &frasl; M<sub>i</sub> 
  ln(Y<sub>i</sub>)),
</p>
<p>
where <i>R</i> is the gas constant,
<i>X</i> is the mass fraction,
<i>M</i> is the molar mass, and
<i>Y</i> is the mole fraction.
</p>
<p>
To obtain the state for a given pressure, entropy and mass fraction, use
<a href=\"modelica://IDEAS.Media.Air.setState_psX\">
IDEAS.Media.Air.setState_psX</a>.
</p>
<h4>Limitations</h4>
<p>
This function is only valid for a relative humidity below 100%.
</p>
</html>",     revisions="<html>
<ul>
<li>
November 27, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
    end specificEntropy;

    redeclare function extends density_derp_T
        "Return the partial derivative of density with respect to pressure at constant temperature"
    algorithm
      ddpT := dStp/pStp;
    annotation (
    Documentation(info="<html>
<p>
This function returns the partial derivative of density
with respect to pressure at constant temperature.
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
      ddTp := 0;

      annotation (smoothOrder=99, Documentation(info=
                       "<html>
<p>
This function computes the derivative of density with respect to temperature 
at constant pressure.
</p>
</html>",     revisions=
    "<html>
<ul>
<li>
December 18, 2013, by Michael Wetter:<br/>
First implementation.
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
with respect to mass fraction.
This value is zero because in this medium, density is proportional
to pressure, but independent of the species concentration.
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
        "Specific heat capacity of gas mixture at constant pressure"
    algorithm
      cp := dryair.cp*(1-state.X[Water]) +steam.cp*state.X[Water];
        annotation(derivative=der_specificHeatCapacityCp);
    end specificHeatCapacityCp;

    redeclare replaceable function extends specificHeatCapacityCv
        "Specific heat capacity of gas mixture at constant volume"
    algorithm
      cv:= dryair.cv*(1-state.X[Water]) +steam.cv*state.X[Water];
        annotation(derivative=der_specificHeatCapacityCv);
    end specificHeatCapacityCv;

    redeclare function setState_dTX
        "Return thermodynamic state as function of density d, temperature T and composition X"
      extends Modelica.Icons.Function;
      input Density d "Density";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "Thermodynamic state";

    algorithm
        // Note that d/dStp = p/pStp, hence p = d*pStp/dStp
        state := if size(X, 1) == nX then
                   ThermodynamicState(p=d*pStp/dStp, T=T, X=X)
                 else
                   ThermodynamicState(p=d*pStp/dStp,
                                      T=T,
                                      X=cat(1, X, {1 - sum(X)}));
        annotation (smoothOrder=2, Documentation(info="<html>
The <a href=\"modelica://Modelica.Media.Interfaces.PartialMixtureMedium.ThermodynamicState\">thermodynamic state record</a> is computed from density d, temperature T and composition X.
</html>"));
    end setState_dTX;

    redeclare function extends setState_phX
        "Return thermodynamic state as function of pressure p, specific enthalpy h and composition X"
    algorithm
      state := if size(X, 1) == nX then
        ThermodynamicState(p=p, T=temperature_phX(p, h, X), X=X)
     else
        ThermodynamicState(p=p, T=temperature_phX(p, h, X), X=cat(1, X, {1 - sum(X)}));
      annotation (smoothOrder=2, Documentation(info="<html>
The <a href=\"modelica://Modelica.Media.Interfaces.PartialMixtureMedium.ThermodynamicState\">
thermodynamic state record</a> is computed from pressure p, specific enthalpy h and composition X.
</html>"));
    end setState_phX;

    redeclare function extends setState_pTX
        "Return thermodynamic state as function of p, T and composition X or Xi"
    algorithm
        state := if size(X, 1) == nX then
                    ThermodynamicState(p=p, T=T, X=X)
                 else
                    ThermodynamicState(p=p, T=T, X=cat(1, X, {1 - sum(X)}));
        annotation (smoothOrder=2, Documentation(info="<html>
The <a href=\"modelica://Modelica.Media.Interfaces.PartialMixtureMedium.ThermodynamicState\">
thermodynamic state record</a> is computed from pressure p, temperature T and composition X.
</html>"));
    end setState_pTX;

    redeclare function extends setState_psX
        "Return the thermodynamic state as function of p, s and composition X or Xi"
      protected
        Modelica.SIunits.MassFraction[2] X_int=
          if size(X, 1) == nX then X else cat(1, X, {1 - sum(X)})
          "Mass fraction";
        Modelica.SIunits.MoleFraction[2] Y "Molar fraction";
        Modelica.SIunits.Temperature T "Temperature";
    algorithm
       Y := massToMoleFractions(
             X_int, {steam.MM,dryair.MM});
        // The next line is obtained from symbolic solving the
        // specificEntropy function for T.
        // In this formulation, we can set T to any value when calling
        // specificHeatCapacityCp as cp does not depend on T.
        T := 273.15 * Modelica.Math.exp((s + Modelica.Constants.R *
               sum(X_int[i]/MMX[i]*
                 Modelica.Math.log(max(Y[i], Modelica.Constants.eps)) for i in 1:2))
                 / specificHeatCapacityCp(setState_pTX(p=p,
                                                       T=273.15,
                                                       X=X_int)));

        state := ThermodynamicState(p=p,
                                    T=T,
                                    X=X_int);

    annotation (
    Inline=false,
    Documentation(info="<html>
<p>
This function returns the thermodynamic state based on pressure, 
specific entropy and mass fraction.
</p>
<p>
The state is computed by symbolically solving
<a href=\"modelica://IDEAS.Media.Air.specificEntropy\">
IDEAS.Media.Air.specificEntropy</a>
for temperature.
</p>
</html>",     revisions="<html>
<ul>
<li>
November 27, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
    end setState_psX;

    redeclare replaceable function extends specificEnthalpy
        "Compute specific enthalpy from pressure, temperature and mass fraction"
    algorithm
      h := (state.T - reference_T)*dryair.cp * (1 - state.X[Water]) +
           ((state.T-reference_T) * steam.cp + h_fg) * state.X[Water];
      annotation(Inline=false,smoothOrder=5);
    end specificEnthalpy;

    redeclare replaceable function specificEnthalpy_pTX "Specific enthalpy"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "Pressure";
      input Modelica.SIunits.Temperature T "Temperature";
      input Modelica.SIunits.MassFraction X[:] "Mass fractions of moist air";
      output Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy at p, T, X";

    algorithm
      h := specificEnthalpy(setState_pTX(p, T, X));
      annotation(smoothOrder=5,
                 inverse(T=temperature_phX(p, h, X)));
    end specificEnthalpy_pTX;

    redeclare replaceable function extends specificGibbsEnergy
        "Specific Gibbs energy"
    algorithm
      g := specificEnthalpy(state) - state.T*specificEntropy(state);
    end specificGibbsEnergy;

    redeclare replaceable function extends specificHelmholtzEnergy
        "Specific Helmholtz energy"
    algorithm
      f := specificEnthalpy(state) - gasConstant(state)*state.T - state.T*specificEntropy(state);
    end specificHelmholtzEnergy;

    redeclare function extends isentropicEnthalpy
        "Return the isentropic enthalpy"
    algorithm
      h_is := specificEnthalpy(setState_psX(
                p=p_downstream,
                s=specificEntropy(refState),
                X=refState.X));
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

    redeclare function extends specificInternalEnergy
        "Specific internal energy"
      extends Modelica.Icons.Function;
    algorithm
      u := specificEnthalpy(state) - pStp/dStp;
    end specificInternalEnergy;

    redeclare function extends temperature
        "Return temperature of ideal gas as a function of the thermodynamic state record"
    algorithm
      T := state.T;
      annotation (smoothOrder=2, Documentation(info="<html>
Temperature is returned from the thermodynamic state record input as a simple assignment.
</html>"));
    end temperature;

    redeclare function extends molarMass "Return the molar mass"
    algorithm
        MM := 1/(state.X[Water]/MMX[Water]+(1.0-state.X[Water])/MMX[Air]);
        annotation (
    smoothOrder=99,
    Documentation(info="<html>
<p>
This function returns the molar mass.
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

    redeclare replaceable function temperature_phX
        "Compute temperature from specific enthalpy and mass fraction"
        extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "specific enthalpy";
      input MassFraction[:] X "mass fractions of composition";
      output Temperature T "temperature";
    algorithm
      T := reference_T + (h - h_fg * X[Water])
           /((1 - X[Water])*dryair.cp + X[Water] * steam.cp);
      annotation(smoothOrder=5,
                 inverse(h=specificEnthalpy_pTX(p, T, X)),
                 Documentation(info="<html>
Temperature as a function of specific enthalpy and species concentration.
The pressure is input for compatibility with the medium models, but the temperature
is independent of the pressure.
</html>"));
    end temperature_phX;

    redeclare function extends thermalConductivity
        "Thermal conductivity of dry air as a polynomial in the temperature"
    algorithm
      lambda := Modelica.Media.Incompressible.TableBased.Polynomials_Temp.evaluate(
          {(-4.8737307422969E-008), 7.67803133753502E-005, 0.0241814385504202},
       Modelica.SIunits.Conversions.to_degC(state.T));
    end thermalConductivity;

    //////////////////////////////////////////////////////////////////////
    // Protected classes.
    // These classes are only of use within this medium model.
    // Equipment models generally have no need to access them.
    // Therefore, they are made protected. This also allows to redeclare the
    // medium model with another medium model that does not provide an
    // implementation of these classes.
    protected
      record GasProperties
        "Coefficient data record for properties of perfect gases"
        extends Modelica.Icons.Record;

        Modelica.SIunits.MolarMass MM "Molar mass";
        Modelica.SIunits.SpecificHeatCapacity R "Gas constant";
        Modelica.SIunits.SpecificHeatCapacity cp
          "Specific heat capacity at constant pressure";
        Modelica.SIunits.SpecificHeatCapacity cv = cp-R
          "Specific heat capacity at constant volume";
        annotation (
          defaultComponentName="gas",
          Documentation(preferredView="info", info="<html>
<p>
This data record contains the coefficients for perfect gases.
</p>
</html>"),     revisions=
            "<html>
<ul>
<li>
November 21, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>");
      end GasProperties;

      // In the assignments below, we compute cv as OpenModelica
      // cannot evaluate cv=cp-R as defined in GasProperties.
      constant GasProperties dryair(
        R =    Modelica.Media.IdealGases.Common.SingleGasesData.Air.R,
        MM =   Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM,
        cp =   1006,
        cv =   1006-Modelica.Media.IdealGases.Common.SingleGasesData.Air.R)
        "Dry air properties";
      constant GasProperties steam(
        R =    Modelica.Media.IdealGases.Common.SingleGasesData.H2O.R,
        MM =   Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM,
        cp =   1860,
        cv =   1860-Modelica.Media.IdealGases.Common.SingleGasesData.H2O.R)
        "Steam properties";

      constant Real k_mair =  steam.MM/dryair.MM "Ratio of molar weights";

      constant Modelica.SIunits.MolarMass[2] MMX={steam.MM,dryair.MM}
        "Molar masses of components";

      constant Modelica.SIunits.SpecificEnergy h_fg = 2501014.5
        "Latent heat of evaporation of water";

    replaceable function der_enthalpyOfLiquid
        "Temperature derivative of enthalpy of liquid per unit mass of liquid"
      extends Modelica.Icons.Function;
      input Temperature T "Temperature";
      input Real der_T "Temperature derivative";
      output Real der_h "Derivative of liquid enthalpy";
    algorithm
      der_h := 4186*der_T;
    end der_enthalpyOfLiquid;

    function der_enthalpyOfCondensingGas
        "Derivative of enthalpy of steam per unit mass of steam"
      extends Modelica.Icons.Function;
      input Temperature T "Temperature";
      input Real der_T "Temperature derivative";
      output Real der_h "Derivative of steam enthalpy";
    algorithm
      der_h := steam.cp*der_T;
    end der_enthalpyOfCondensingGas;

    replaceable function enthalpyOfDryAir
        "Enthalpy of dry air per unit mass of dry air"
      extends Modelica.Icons.Function;

      input Temperature T "Temperature";
      output SpecificEnthalpy h "Dry air enthalpy";
    algorithm
      h := (T - reference_T)*dryair.cp;
      annotation(smoothOrder=5, derivative=der_enthalpyOfDryAir);
    end enthalpyOfDryAir;

    replaceable function der_enthalpyOfDryAir
        "Derivative of enthalpy of dry air per unit mass of dry air"
      extends Modelica.Icons.Function;
      input Temperature T "Temperature";
      input Real der_T "Temperature derivative";
      output Real der_h "Derivative of dry air enthalpy";
    algorithm
      der_h := dryair.cp*der_T;
    end der_enthalpyOfDryAir;

    replaceable function der_enthalpyOfNonCondensingGas
        "Derivative of enthalpy of non-condensing gas per unit mass of steam"
      extends Modelica.Icons.Function;
      input Temperature T "Temperature";
      input Real der_T "Temperature derivative";
      output Real der_h "Derivative of steam enthalpy";
    algorithm
      der_h := der_enthalpyOfDryAir(T, der_T);
    end der_enthalpyOfNonCondensingGas;

    replaceable function der_specificHeatCapacityCp
        "Derivative of specific heat capacity of gas mixture at constant pressure"
      extends Modelica.Icons.Function;
        input ThermodynamicState state "Thermodynamic state";
        input ThermodynamicState der_state "Derivative of thermodynamic state";
        output Real der_cp(unit="J/(kg.K.s)")
          "Derivative of specific heat capacity";
    algorithm
      der_cp := (steam.cp-dryair.cp)*der_state.X[Water];
    end der_specificHeatCapacityCp;

    replaceable function der_specificHeatCapacityCv
        "Derivative of specific heat capacity of gas mixture at constant volume"
      extends Modelica.Icons.Function;
        input ThermodynamicState state "Thermodynamic state";
        input ThermodynamicState der_state "Derivative of thermodynamic state";
        output Real der_cv(unit="J/(kg.K.s)")
          "Derivative of specific heat capacity";
    algorithm
      der_cv := (steam.cv-dryair.cv)*der_state.X[Water];
    end der_specificHeatCapacityCv;

      annotation (preferredView="info", Documentation(info="<html>
<p>
This medium package models moist air using a gas law in which pressure and temperature
are independent, which often leads to significantly faster and more robust computations. 
The specific heat capacities at constant pressure and at constant volume are constant.
The air is assumed to be not saturated.
</p>
</html>",     revisions="<html>
<ul>
<li>
November 16, 2013, by Michael Wetter:<br/>
Revised and simplified the implementation.
</li>
<li>
November 14, 2013, by Michael Wetter:<br/>
Removed function
<code>HeatCapacityOfWater</code>
which is neither needed nor implemented in the
Modelica Standard Library.
</li>
<li>
November 13, 2013, by Michael Wetter:<br/>
Removed non-used computations in <code>specificEnthalpy_pTX</code> and
in <code>temperature_phX</code>.
</li>
<li>
March 29, 2013, by Michael Wetter:<br/>
Added <code>final standardOrderComponents=true</code> in the
<code>BaseProperties</code> declaration. This avoids an error
when models are checked in Dymola 2014 in the pedenatic mode.
</li>
<li>
April 12, 2012, by Michael Wetter:<br/>
Added keyword <code>each</code> to <code>Xi(stateSelect=...</code>.
</li>
<li>
April 4, 2012, by Michael Wetter:<br/>
Added redeclaration of <code>ThermodynamicState</code> to avoid a warning
during model check and translation.
</li>
<li>
August 3, 2011, by Michael Wetter:<br/>
Fixed bug in <code>u=h-R*T</code>, which is only valid for ideal gases. 
For this medium, the function is <code>u=h-pStd/dStp</code>.
</li>
<li>
January 27, 2010, by Michael Wetter:<br/>
Fixed bug in <code>else</code> branch of function <code>setState_phX</code>
that lead to a run-time error when the constructor of this function was called.
</li>
<li>
January 22, 2010, by Michael Wetter:<br/>
Added implementation of function
<a href=\"modelica://IDEAS.Media.GasesPTDecoupled.MoistAirUnsaturated.enthalpyOfNonCondensingGas\">
enthalpyOfNonCondensingGas</a> and its derivative.
<li>
January 13, 2010, by Michael Wetter:<br/>
Fixed implementation of derivative functions.
</li>
<li>
August 28, 2008, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
    end AirPTDecoupled;

    package Examples "Collection of models that test the media models"
      extends Modelica.Icons.ExamplesPackage;

      model AirPTDecoupledDerivativeCheck
        "Model that tests the derivative implementation"
        extends Modelica.Icons.Example;

         package Medium = IDEAS.Media.Air;

          Modelica.SIunits.SpecificEnthalpy hLiqSym "Liquid phase enthalpy";
          Modelica.SIunits.SpecificEnthalpy hLiqCod "Liquid phase enthalpy";
          Modelica.SIunits.SpecificEnthalpy hSteSym "Water vapor enthalpy";
          Modelica.SIunits.SpecificEnthalpy hSteCod "Water vapor enthalpy";
          Modelica.SIunits.SpecificEnthalpy hAirSym "Dry air enthalpy";
          Modelica.SIunits.SpecificEnthalpy hAirCod "Dry air enthalpy";
          Modelica.SIunits.SpecificHeatCapacity cpSym "Specific heat capacity";
          Modelica.SIunits.SpecificHeatCapacity cpCod "Specific heat capacity";
          Modelica.SIunits.SpecificHeatCapacity cvSym "Specific heat capacity";
          Modelica.SIunits.SpecificHeatCapacity cvCod "Specific heat capacity";
          constant Real conv(unit="K/s") = 1
          "Conversion factor to satisfy unit check";
      initial equation
           hLiqSym = hLiqCod;
           hSteSym = hSteCod;
           hAirSym = hAirCod;
           cpSym   = cpCod;
           cvSym   = cvCod;
      equation
          hLiqCod=Medium.enthalpyOfLiquid(conv*time);
          der(hLiqCod)=der(hLiqSym);
          assert(abs(hLiqCod-hLiqSym) < 1E-2, "Model has an error");

          hSteCod=Medium.enthalpyOfCondensingGas(conv*time);
          der(hSteCod)=der(hSteSym);
          assert(abs(hSteCod-hSteSym) < 1E-2, "Model has an error");

          hAirCod=Medium.enthalpyOfNonCondensingGas(conv*time);
          der(hAirCod)=der(hAirSym);
          assert(abs(hAirCod-hAirSym) < 1E-2, "Model has an error");

          cpCod=Medium.specificHeatCapacityCp(
            Medium.setState_pTX(
               p=1e5,
               T=conv*time,
               X={0.1}));
          der(cpCod)=der(cpSym);
          assert(abs(cpCod-cpSym) < 1E-2, "Model has an error");

           cvCod=Medium.specificHeatCapacityCv(
            Medium.setState_pTX(
               p=1e5,
               T=conv*time,
               X={0.1}));
          der(cvCod)=der(cvSym);
          assert(abs(cvCod-cvSym) < 1E-2, "Model has an error");

         annotation(Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}})),
      experiment(StartTime=273.15, StopTime=373.15),
      __Dymola_Commands(file="modelica://IDEAS/Resources/Scripts/Dymola/Experimental/Media/Examples/AirPTDecoupledDerivativeCheck.mos"
              "Simulate and plot"),
            Documentation(info="<html>
<p>
This example checks whether the function derivative
is implemented correctly. If the derivative implementation
is not correct, the model will stop with an assert statement.
</p>
</html>",         revisions="<html>
<ul>
<li>
November 20, 2013, by Michael Wetter:<br/>
Removed check of <code>enthalpyOfDryAir</code> as this function
is protected and should therefore not be accessed from outside the class.
</li>
<li>
May 12, 2008, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
      end AirPTDecoupledDerivativeCheck;

      model AirPTDecoupledProperties
        "Model that tests the implementation of the fluid properties"
        extends Modelica.Icons.Example;
        extends IDEAS.Media.Examples.BaseClasses.FluidProperties(
          redeclare package Medium =
              IDEAS.Experimental.Media.AirPTDecoupled,
          TMin=273.15-30,
          TMax=273.15+60);

        Modelica.SIunits.SpecificEnthalpy hLiq "Specific enthalpy of liquid";

      equation
        // Check the implementation of the base properties
        basPro.state.p=p;
        basPro.state.T=T;
        basPro.state.X[1]=X[1];

        hLiq = Medium.enthalpyOfLiquid(T);
        if Medium.nX == 1 then
          assert(abs(h-hLiq) < 1e-8, "Error in enthalpy computation.");
        end if;
         annotation(Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}})),
      experiment(StopTime=1),
      __Dymola_Commands(file="modelica://IDEAS/Resources/Scripts/Dymola/Experimental/Media/Examples/AirPTDecoupledProperties.mos"
              "Simulate and plot"),
            Documentation(info="<html>
<p>
This example checks thermophysical properties of the medium.
</p>
</html>",
      revisions="<html>
<ul>
<li>
December 19, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
      end AirPTDecoupledProperties;

      model AirPTDecoupledTemperatureEnthalpyInversion
        "Model to check computation of h(T) and its inverse"
        extends Modelica.Icons.Example;
        extends
          IDEAS.Media.Examples.BaseClasses.TestTemperatureEnthalpyInversion(
          redeclare package Medium = IDEAS.Media.Air);
        annotation (
      experiment(StopTime=1.0),
      __Dymola_Commands(file="modelica://IDEAS/Resources/Scripts/Dymola/Experimental/Media/Examples/AirPTDecoupledTemperatureEnthalpyInversion.mos"
              "Simulate and plot"),
          Documentation(info="<html>
<p>
This model tests whether the inversion of temperature and enthalpy 
is implemented correctly.
If <i>T &ne; T(h(T))</i>, the model stops with an error.
</p>
</html>",       revisions="<html>
<ul>
<li>
November 21, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
      end AirPTDecoupledTemperatureEnthalpyInversion;

      model AirPTDecoupledTestImplementation
        "Model that tests the medium implementation"
        extends Modelica.Icons.Example;
        extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
           redeclare package Medium = IDEAS.Media.Air);

            annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                  -100,-100},{100,100}})),
      experiment(StopTime=1.0),
      __Dymola_Commands(file="modelica://IDEAS/Resources/Scripts/Dymola/Experimental/Media/Examples/AirPTDecoupledTestImplementation.mos"
              "Simulate and plot"),
          Documentation(info="<html>
This is a simple test for the medium model. It uses the test model described in
<a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition.TestOfMedium\">
Modelica.Media.UsersGuide.MediumDefinition.TestOfMedium</a>.
</html>",       revisions="<html>
<ul>
<li>
May 12, 2008, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
      end AirPTDecoupledTestImplementation;
    annotation (preferredView="info", Documentation(info="<html>
<p>
This package contains examples that test the media packages in
<a href=\"modelica://IDEAS.Experimental.Media\">
IDEAS.Experimental.Media</a>.
</p>
</html>"));
    end Examples;
    annotation (preferredView="info", Documentation(info="<html>
<p>
This package contains models that are experimental. 
</p>
</html>"));
  end Media;
  annotation (preferredView="info", Documentation(info="<html>
<p>
This package contains models that are experimental. 
They may be included in the <code>IDEAS</code> library
if they have been shown to be useful.
For example, this package may include new media models
so that numerical benchmarks can be conducted easily in order
to evaluate whether addition of the media is desirable or not.
</p>
</html>"));
end Experimental;
