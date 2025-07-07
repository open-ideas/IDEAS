within IDEAS.Fluid.PVTCollectors.Validation.BaseClasses;
block ISO9806QuasiDynamicHeatLossValidation
  "Validation variant with term‑by‑term breakdown of quasi‑dynamic heat loss"

  extends IDEAS.Fluid.PVTCollectors.BaseClasses.ISO9806QuasiDynamicHeatLoss;

  // —— Diagnostic internal variables ——
  Real c1_c2_term(unit="W")
    "Contribution from c1–c2 (steady‑state) term";
  Real c3_term(unit="W")
    "Contribution from wind‑speed dependence (c3)";
  Real c4_term(unit="W")
    "Contribution from sky long‑wave (c4)";
  Real c6_term(unit="W")
    "Contribution from wind–irradiance coupling (c6)";
  Real EL_term(unit="W/m2")
    "Sky long‑wave irradiance difference (HHorIR – σ·TEnv⁴)";

  // —— Cumulative sums ——
  Real pvt_st_st(unit="W") "Steady‑state loss (c1–c2)";
  Real pvt_c3(   unit="W") "Steady‑state + c3";
  Real pvt_c4(   unit="W") "Steady‑state + c3 + c4";
  Real pvt_c6(   unit="W") "Total quasi‑dynamic loss";

equation
  // term-by-term breakdown
  c1_c2_term = sum(A_c/nSeg * { dT[i]*(c1 - c2*dT[i]) for i in 1:nSeg});
  c3_term    = sum(A_c/nSeg * { dT[i]*c3*winSpePla        for i in 1:nSeg});
  c4_term    = sum(A_c/nSeg * { c4*(HHorIR - sigma*TEnv^4) for i in 1:nSeg});
  c6_term    = sum(A_c/nSeg * { -c6*winSpePla*HGloTil     for i in 1:nSeg});
  EL_term    = HHorIR - sigma*TEnv^4;

  // cumulative contributions
  pvt_st_st = c1_c2_term;
  pvt_c3    = pvt_st_st + c3_term;
  pvt_c4    = pvt_c3    + c4_term;
  pvt_c6    = pvt_c4    + c6_term;

  annotation (
    defaultComponentName="heaLosStcVal",
    Documentation(info = "
<html>
  <p>
    Extends the standard quasi‑dynamic heat‑loss model 
    (<a href=\"modelica://IDEAS.Fluid.PVTCollectors.BaseClasses.ISO9806QuasiDynamicHeatLoss\">IDEAS.Fluid.PVTCollectors.BaseClasses.ISO9806QuasiDynamicHeatLoss</a>).  
    For validation purposes, this block adds:
  </p>
  <ul>
    <li>A term‑by‑term breakdown of each thermal loss contribution;</li>
    <li>Cumulative sums showing how each additional term builds up to the total heat loss.</li>
  </ul>
</html>
", revisions="<html>
  <ul>
   <li>
      July 7, 2025, by Lone Meertens:<br/>
      First implementation PVT model; tracked in 
      <a href=\"https://github.com/open-ideas/IDEAS/issues/1436\">
        IDEAS #1436
      </a>.
    </li>
  </ul>
</html>"));
end ISO9806QuasiDynamicHeatLossValidation;
