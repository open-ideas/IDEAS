within IDEAS.Buildings.Data.Glazing.EPC;
package LabelC "Library of EPC label C building glazing system"

  extends Modelica.Icons.MaterialPropertiesPackage;

annotation (Documentation(info="<html>
<p>
The glazing system has been chosen for an EPC label C window with a total U-value of <i>3 W/m²K</i>
(<a href=\"https://energyville.be/wp-content/uploads/2024/12/VEKA_hybride-WP_eindrapport_final.pdf\">ref</a>).
</p>
Since the target U-value for label C is <i>3 W/m²K</i>, the EpcSingle option (<i>U = 5.8</i>) was discarded.
EpcDouble (<i>U = 2.9</i>) was selected as it best aligns with the desired performance range.
<p>
</html>"));
end LabelC;
