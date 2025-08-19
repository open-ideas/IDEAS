within IDEAS.UsersGuide.ReleaseNotes;
class Version_2_1_0 "Version_2_1_0"
  extends Modelica.Icons.ReleaseNotes;
  annotation (Documentation(info="<html>
<p>
IDEAS 2.1.0 was released on February 28, 2019. The most important changes are:
</p>
<ul>
<li>
IBPSA has been updated up to commit 2d6a5a6ff80.
</li>
<li>
The twin house example model has been re-added to the library.
</li>
<li>
The PPD12 example now includes a model that compares a rule-based controller with a model predictive controller.
</li>
</ul>
<p>
Detailed release notes:
</p>
<ul>
<li>
Deprecated IDEAS.Fluid.Actuators.Valves.Simplified.ThreeWayValve.
</li>
<li>
Extended IDEAS.Buildings.Components.Shading.BuildingShade with a parameter for configuring partial shading.
</li>
<li>
Added a two-way and three-way valve with a mixed linear-equal percentage opening characteristic.
</li>
<li>
Added a bypass for the PPD12 air handling unit.
</li>
<li>
Modified the way how initial equations are defined for wall models. This avoids duplicate initial equations.
</li>
<li>
Fixed a bug in the zone model when allowFlowReversal was set to false.
</li>
<li>
Added an option to set a fixed boundary condition temperature in BoundaryWall.
</li>
<li>
Added a utility that automatically checks the git version of library dependencies when running a model, for enhanced version checking of models.
</li>
<li>
Revised the implementation of the thermostatic radiator valve model such that it is smooth.
</li>
<li>
Revised documentation in ExteriorSolarAbsorption.
</li>
<li>
Fixed a compatibility bug with OpenModelica.
</li>
<li>
Removed reference to non-existent parameter in RectangularZoneTemplate.
</li>
</ul>
</html>"));
end Version_2_1_0;
