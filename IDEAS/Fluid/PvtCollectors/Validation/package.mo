within IDEAS.Fluid.PVTCollectors;
package Validation "Collection of validation models"
  extends Modelica.Icons.ExamplesPackage;

annotation (preferredView="info", Documentation(info="<html>
  <p>
  This package provides validation models for the classes in 
  <a href=\"modelica://IDEAS.Fluid.PVTCollectors\">IDEAS.Fluid.PVTCollectors</a>.
  </p>

  <p>
  The validation examples use experimental data from two types of unglazed PVT collectors:
  </p>
  <ul>
    <li><b>UI</b>: Uncovered PVT collector with rear insulation</li>
    <li><b>UN</b>: Uncovered PVT collector without rear insulation</li>
  </ul>

  <p>
  These are implemented in the subpackages a href=\"modelica://IDEAS.Fluid.PVTCollectors.Validation.PVT_UI\">PVT_UI</a> and <a href=\"modelica://IDEAS.Fluid.PVTCollectors.Validation.PVT_UN\">PVT_UN</a>, respectively.
  The naming convention used in this implementation (<code>PVT_UI</code> and <code>PVT_UN</code>) 
  corresponds to the datasets referred to as <code>PVT1</code> and <code>PVT2</code> 
  in Meertens et al. (2025), where they are described in detail.
  </p>

  <p>
  The purpose of these models is to assess the accuracy and limitations of the quasi-dynamic PVT model 
  (<a href=\"modelica://IDEAS.Fluid.PvtCollectors.QuasiDynamicPvtCollector\">IDEAS.Fluid.PvtCollectors.QuasiDynamicPvtCollector</a>) under realistic conditions. 
  This is done by driving the model with experimental input data and comparing the simulated outputs 
  with measured results.
  </p>

  <h4>References</h4>
  <ul>
   <li>
  Meertens, L., Jansen, J., Helsen, L. (2025). “Development and Experimental Validation of an Unglazed Photovoltaic-Thermal Collector Modelica Model that only needs Datasheet Parameters”, submitted to the 16th International Modelica & FMI Conference, Lucerne, Switzerland, Sep 8–10, 2025.
  </li>
  </ul>
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
end Validation;
