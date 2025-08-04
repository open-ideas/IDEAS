within IDEAS.UsersGuide.ReleaseNotes;
class Version_0_3_0 "Version_0_3_0"
  extends Modelica.Icons.ReleaseNotes;
  annotation (Documentation(info="<html>
<p>Major changes compared to v0.2.0 are:</p>
<ul>
<li>
Added code for checking conservation of energy
</li>
<li>
Added options for linear/non-linear radiative heat exchange and convection for exterior and interior faces of walls and floors/ceilings. 
Respective correlations have been changed.
</li>
<li>
Improved overall efficiency and reduced warnings.
</li>
<li>
The emissivity of window coatings must now be specified as a property of the solid (glass sheet) and not as a property of the gas between the glass sheets. 
This is only relevant if you create your own glazing.
</li>
<li>
Merged Annex 60 library up to commit d7749e3
</li>
<li>
Expanded unit tests
</li>
<li>
Improved implementation of Koschenz's model for TABS and added an option to discretize TABS sections.
</li>
<li>
Added new building shade components.
</li>
<li>
Removed inefficient code that would lead to numerical Jacobians in the grid.
</li>
<li>
Added new AC and DC electrical models.
</li>
</ul>
</html>"));
end Version_0_3_0;
