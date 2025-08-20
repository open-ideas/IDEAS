within IDEAS.UsersGuide.ReleaseNotes;
class Version_4_0_0 "Version_4_0_0"
  extends Modelica.Icons.ReleaseNotes;
  annotation (Documentation(info="<html>
<p>
IDEAS v4.0.0 has been released on August 20, 2025.
</p>
<h4>Highlights</h4>
<ul>
<li>
A new IDEAS logo has been developed and added to the README and Modelica package.
</li>
<li>
The <code>IDEAS.Buildings.Data</code> package has been revised, 
and a new library of building envelope constructions with different insulation levels has been added.
This package allows the selection of building constructions (Constructions, Frames, Glazing, Insulation, Materials) 
based on their classification in the EPC framework.
</li>
<li>
Significant improvements to the <code>IDEAS.Examples.Tutorial.DetailedHouse</code> tutorial.
</li>
<li>
A two-port interzonal airflow model has been developed, allowing to model the stack effect in buildings.
</li>
<li>
The DHW tap model has been significantly improved (<code>IDEAS.Fluid.Taps</code>).
</li>
<li>
A dynamic Photovoltaic-Thermal (PVT) model has been added (<code>IDEAS.Fluid.PVT</code>), 
including an extensive documentation and validation.
</li>
</ul>

<h4>Detailed release notes</h4>
<ul>
<li>
<li>
Merged latest version of IBPSA library has been merged (commit b6cff3bfe523804f88615c885326b244ba2d923a).
</li>
<li>
Added a dynamic Photovoltaic-Thermal (PVT) collector model (<code>IDEAS.Fluid.PVT</code>), 
including an extensive documentation and validation.
</li>
<li>
Revised and corrected the embedded pipe model.
</li>
<li>
Added a redesigned IDEAS logo to the README and Modelica package.
</li>
<li>
Updated the wind speed modifier calculation according to ASHRAE2005 and changed the 
default local terrain type to <code>Unshielded</code> in 
<code>IDEAS.BoundaryConditions.Interfaces.PartialSimInfoManager</code>.
</li>
<li>
Cleaned up and extended the IDEAS User's Guide.
</li>
<li>
Updated some models of <code>IDEAS.Buildings.Components</code> to avoid scripting errors in OpenModelica.
</li>
<li>
Updated <code>IDEAS.Examples.IBPSA.SingleZoneResidentialHydronicHeatPump</code> to fix the compatibility with OpenModelica.
</li>
<li>
Corrected errors in <code>IDEAS.Buildings.Data.Constructions.FloorOnGround</code>. 
Due to this change, the <code>locGain</code> parameter of <code>conTypFlo</code> 
in <code>IDEAS.Examples.IBPSA.SingleZoneResidentialHydronicHeatPump</code> had to be redeclared.
</li>
<li>
Added <code>OuterWall</code> as a possible construction type for a floor.
</li>
<li>
Cleaned up the repository by removing unused scripts, files, and images, 
and replacing equation images with inline equations.
</li>
<li>
Improved the graphical representation of <code>IDEAS.Examples.DetailedResidentialNoHeating</code> 
in the Diagram view of Dymola.
</li>
<li>
Added missing <code>m_flow</code> connections in <code>IDEAS.Buildings.Components.Shading.Box</code>.
</li>
<li>
Updated the existing IDEAS building constructions (<code>IDEAS.Buildings.Data.Constructions</code>) 
and added new building envelope data packages (Constructions, Frames, Glazing, Insulation, Materials).
This package allows the selection of building constructions based on their classification in the EPC framework.
</li>
<li>
Removed import \"package\" statements from some models and explicitly replaced it by <code>Modelica.package</code>, 
e.g. <code>Modelica.Units.SI</code>.
</li>
<li>
Updated models to avoid translation warnings when using <code>IDEAS.Buildings.Components.Examples.CavityInternalWall</code>.
</li>
<li>
Moved the existing tutorial to <code>IDEAS.Examples.Tutorial.DetailedHouse</code> 
and thoroughly revised its content.
</li>
<li>
Corrected ventilation mass flow rate calculation and updated nominal pressure drop
in <code>IDEAS.Templates.Ventilation.ConstantAirFlowRecup</code>.
</li>
<li>
Updated <code>Medium</code> package implementation in <code>IDEAS.Buildings.Components.Interfaces.PartialZone</code>
to avoid errors with <code>IDEAS.Buildings.Components.RectangularZoneTemplate</code>.
</li>
<li>
Changed unit of parameter <code>dT_nominal</code> to <code>Modelica.Units.SI.TemperatureDifference</code>
in <code>IDEAS.Fluid.Actuators.Valves.Simplified.Thermostatic3WayValve</code>.
</li>
<li>
Updated calculation of transmission design losses in the <code>IDEAS.Buildings.Components</code> models 
to allow custom indoor design temperatures.
</li>
<li>
Removed invalid <code>Shading</code> for <code>IDEAS.Buildings.Components.Shading.Interfaces.ShadingType</code>.
</li>
<li>
Replaced non-linear limiter block in screen models (<code>IDEAS.Buildings.Components.Shading</code>) 
by a proper control signal implementation and assert.
</li>
<li>
Updated scripts and BuildingsPy for merging IBPSA into IDEAS.
</li>
<li>
Updated view factor asserts in 
<code>IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.ZoneLwDistribution</code> 
to guard against non-physical geometries.
</li>
<li>
Added <code>T_start_ground</code> parameter to the <IDEAS.Buildings.Components.SlabOnGround</code> model.
</li>
<li>
Revised the DHW tap model (<code>IDEAS.Fluid.Taps</code>).
</li>
<li>
Fixed wrong construction type and zone height for <code>IDEAS.Examples.PPD12.Structure</code>.
</li>
<li>
Removed duplicate parameter declarations in <code>IDEAS.Buildings.Components.Interfaces.PartialZone</code>
and <code>IDEAS.Fluid.Actuators.Valves.Simplified.ThreeWayValveMotor</code>.
</li>
<li>
Fixed bug in <code>IDEAS.Templates.Heating.BaseClasses.HysteresisHeating</code>.
</li>
<li>
Updated the CI runner used for unit tests.
</li>
<li>
Created a BOPTEST branch which is up-to-date with the master branch except for the expandable connectors (see change below)
as OpenModelica does not yet support expandable connectors.
</li>
<li>
Change <code>IDEAS.Buildings.Components.Interfaces</code> connectors to expandable
to avoid errors in Wolfram System Modeler and to improve compatibility with the Modelica language specification.
</li>
<li>
Added a file containing the Belpex spot price for 2021.
</li>
<li>
Added a weather file containing data measured at the Vliet building (Heverlee, Belgium) in 2021.
</li> 
<li>
Added a two-port interzonal airflow implementation to model stack-effect. 
On top of this, an assert was added to do a first check of the floor heights as provided by the user.
</li>
<li>
Added cavity support for ceilings and floors.
</li>
<li>
Modelled air layer between screen and window that heats up.
</li>
<li>
Updated several models to be compatible with OpenModelica.
</li> 
<li>
Updated U-value of window frames (<code>IDEAS.Buildings.Data.Frames</code>) and added references.
</li>
<li>
Updated material properties (<code>IDEAS.Buildings.Data</code>) and added references.
</li>
<li>
Fixed illegal connections for Modelon Impact in
<code>IDEAS.Examples.TwinHouses.BaseClasses.Structures.TwinhouseN2</code>.
</li>
</ul>
</html>"));
end Version_4_0_0;
