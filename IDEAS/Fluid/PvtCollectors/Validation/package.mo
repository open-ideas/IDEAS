within IDEAS.Fluid.PVTCollectors;
package Validation "Collection of validation models"
  extends Modelica.Icons.ExamplesPackage;

annotation (preferredView="info", Documentation(info="<html>
  <p>
  This package provides validation models for the classes in 
  <a href=\"modelica://IDEAS.Fluid.PVTCollectors\">IDEAS.Fluid.PvtCollectors</a>.
  </p>

  <p>
  The validation examples use experimental data from two types of unglazed PVT collectors:
  </p>
  <ul>
    <li><b>UI</b>: Uncovered PVT collector with rear insulation</li>
    <li><b>UN</b>: Uncovered PVT collector without rear insulation</li>
  </ul>

  <p>
  These are implemented in the subpackages <code>PVT1</code> and <code>PVT2</code>, respectively.
  </p>

  <p>
  The purpose of these models is to assess the accuracy and limitations of the quasi-dynamic PVT model 
  (<code>IDEAS.Fluid.PvtCollectors.QuasiDynamicPvtCollector</code>) under realistic conditions. 
  This is done by driving the model with experimental input data and comparing the simulated outputs 
  with measured results.
  </p>

  <h4>References</h4>
  <ul>
    <li>Meertens, L., Jansen, J., Helsen, L. (2025). “Development and Experimental Validation of a Quasi-Dynamic PVT Modelica Model.” Proc. Modelica Conf. 2025.</li>
  </ul>
  </html>"));
end Validation;
