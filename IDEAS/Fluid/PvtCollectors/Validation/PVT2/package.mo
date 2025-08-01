within IDEAS.Fluid.PVTCollectors.Validation;
package PVT2
    annotation (preferredView="info", Documentation(info=
    "<html>
  <p>
  This package contains validation models for the PVT2 collector (Meertens et al., 2025), an uncovered and uninsulated PVT collector, based on experimental data from a long-term outdoor test campaign in Austria (Veynandt et al., 2023).
  </p>

  <p>
  The dataset spans 58 consecutive summer days with 5-second resolution, capturing a wide range of operating conditions. Notably, the test period includes days with several hours of very high wind speeds, reaching up to 10–12&nbsp;m/s, which significantly affect convective heat losses.
  </p>

  <p>
  The package includes two models:
  </p>
  <ul>
    <li><code>Thermal</code>: Validates thermal output using the quasi-dynamic ISO 9806 formulation.</li>
    <li><code>Electrical</code>: Validates electrical output using the PVWatts V5 formulation.</li>
  </ul>

  <p>
  Due to the absence of rear insulation and the continuous operation of the circulation pump, also during periods of negative thermal output, the raw energy deviation of +53.1 % 
  is not representative of real-world operation. In practice, the pump would only be activated when thermal gains exceed losses. When filtered to periods with positive thermal output, 
  the deviation improves to +6.85%. This filtered metric provides a more meaningful assessment of the model performance.
  </p>

  <p>
  The electrical model shows excellent agreement with measurements, with a normalized MAE of 5.2% and nRMSE of 9.9%. The model is robust to variations in <code>U<sub>AbsFluid</sub></code>, confirming the reliability of the datasheet-based estimation method.
  </p>
  </html>",
revisions="<html>
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
end PVT2;
