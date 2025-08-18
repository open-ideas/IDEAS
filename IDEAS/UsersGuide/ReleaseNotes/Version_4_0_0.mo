within IDEAS.UsersGuide.ReleaseNotes;
class Version_4_0_0 "Version_4_0_0"
  extends Modelica.Icons.ReleaseNotes;
  annotation (Documentation(info="<html>
<p>
IDEAS v4.0.0 has been released on August xx, 2025.
</p>
<h4>Highlights</h4>
<ul>
<li>
A new IDEAS logo has been developed and added to the README and Modelica package
</li>
<li>
The IDEAS.Buildings.Data package has been revised, and a new library of building envelope constructions with different insulation levels has been added.
This package allows the selection of building constructions (Constructions, Frames, Glazing, Insulation, Materials) based on their classification in the EPC framework.
</li>
<li>
Significant improvements to the IDEAS.Examples.Tutorial.DetailedHouse tutorial.
</li>
<li>
A additional interzonal air flow model has been developed.
</li>
<li>
The DHW tap model has been significantly improved.</li>
<li>
PVT model?
</li>
</ul>

<h4>Detailed release notes</h4>
<ul>
<li>
<li>
Revised embedded pipe model.
</li>
<li>
Merged latest version of IBPSA library has been merged (commit b6cff3bfe523804f88615c885326b244ba2d923a).
</li>
<li>
Added a redesigned IDEAS logo to the README and Modelica package
</li>
<li>
Updated wind speed modifier calculation according to ASHRAE2005 and changed the 
default local terrain type to unshielded in IDEAS.BoundaryConditions.Interfaces.PartialSimInfoManager.
</li>
<li>
Cleaned and extended the IDEAS User's Guide.
</li>
<li>
Redeclared <code>locGain</code> parameter of floor construction type 
in IDEAS.Examples.IBPSA.SingleZoneResidentialHydronicHeatPump.
</li>
<li>
Fixed OMEdit scripting errors.
</li>
<li>
Corrected errors in IDEAS.Buildings.Data.Constructions.FloorOnGround.
</li>
<li>
Added OuterWall as a construction type for a floor.
</li>
<li>
Improved repository: removing unused scripts and unused images, and replacing 
equation images with inline equations.
</li>
<li>
Improved graphics of IDEAS.Examples.DetailedResidentialNoHeating.
</li>
<li>
Added <code>Ctrl_to_beta_internal=0</code> when not using beta 
input in IDEAS.Buildings.Components.Shading.HorizontalFins. Otherwise, 
the variable is undefined, resulting in a singular system.
</li>
<li>
Added missing m_flow connections in IDEAS.Buildings.Components.Shading.Box.
</li>
<li>
Added a new library of building envelope constructions with different insulation 
levels in IDEAS.Buildings.Data package.
This package allows the selection of building constructions (Constructions, 
Frames, Glazing, Insulation, Materials) based on their classification in the EPC framework.
</li>
<li>
Removed import \"package\" statements and added Modelica.package explicitly.
<li>
<li>
Fixed translation warnings.
</li>
<li>
Improved IDEAS.Examples.Tutorial.DetailedHouse tutorial.
</li>
<li>
Corrected ventilation mass flow rate calculation and updated
nominal pressure drop in heat exchanger in IDEAS.Templates.ConstantAirFlowRecup 
and VentilationSystem.
</li>
<li>
Fixed error with Medium in RectangularZoneTemplate.
</li>
<li>
Changed unit of parameter <code>dT_nominal</code> to <code>Modelica.Units.SI.TemperatureDifference 
in IDEAS.Fluid.Actuators.Valves.Simplified.Thermostatic3WayValve.
</li>
<li>
Updated calculation of transmission design losses to allow custom indoor design 
temperatures.
</li>
<li>
Added interzonal air flow model.
</li>
<li>
Resolved error in screen model by replacing Ctrl by Ctrl_internal.
</li>
<li>
Removed limiter block in screen model.
</li>
<li>
Updated scripts and buildingsPy for executing IBPSA merges.
</li>
<li>
Updated asserts for ZoneLwDistribution.
</li>
<li>
Added T_start_ground parameter to slabOnGround model.
</li>
<li>
Improved DHW tap model.
</li>
<li>
Resolved error with internalwall in PDD12 model.
</li>
</ul>
</html>"));
end Version_4_0_0;
