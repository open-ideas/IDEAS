within IDEAS.Buildings.Data.Constructions;
package EPC "Library of building envelope constructions with different insulation levels"
  annotation (Documentation(info="<html>
<p>
The insulation levels and U-values are based on the TABULA building typology, 
the analyis of the EPC database, and the data from 'EPB in cijfers' 
(<a href=\"https://energyville.be/wp-content/uploads/2024/12/VEKA_hybride-WP_eindrapport_final.pdf\">ref</a>).
</p>
The U-values are translated to a corresponding set of construction layers and 
materials according to De Jaeger et al. approach: starting from an initial 
construction and initial U-value, the desired U-value is reached upgrading 
different layers and materials (<a href=\"https://publications.ibpsa.org/proceedings/usim/2018/papers/usim2018_004.pdf\">ref</a>). 
</p>
As an example for the outer wall, the first upgrade concerns the inner heavy masonry layer. 
The required thickness of this layer to reach the desired U-value is calculated and 
compared to the predefined maximal thickness of this layer, determining the final thickness. 
If the new U-value does not yet satisfy the desired U-value, a non-ventilated air cavity 
with a maximal thickness of 2.5 cm is added. 
The resistance is calculated following EN ISO 6946. If the new U-value still does 
not satisfy the desired U-value, mineral wool is added until the sampled U-value is reached. 
A similar approach can be used for the ground floor and roof. 
</html>",revisions="<html>
<ul>
<li>
Jan 3, 2025, by Anna Dell'Isola:<br/>
First implementation. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1267\">#1267</a>.
</li>
</ul>
</html>"));
end EPC;
