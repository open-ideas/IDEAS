within IDEAS.UsersGuide.ReleaseNotes;
class Version_2_0_0 "Version_2_0_0"
  extends Modelica.Icons.ReleaseNotes;
  annotation (Documentation(info="<html>
<p>
IDEAS 2.0.0 was released on September 28, 2018. Highlights of this release compared to v1.0.0 are:
</p>
<ul>
<li>
Unit tests have been automated. 
When a developer makes a pull request against the master, unit tests are run automatically using Travis CI. 
This greatly simplifies the development process when no unit test results change.
</li>
<li>
IDEAS has been updated to IBPSA version 3.0. This includes a new heat pump model and a thoroughly updated borefield model.
</li>
<li>
Some old models have been removed, and the library has been cleaned up in general.
</li>
<li>
New example models and unit tests have been added that better demonstrate how IDEAS can be used. In general, the documentation of the library has improved.
</li>
<li>
The OuterWall model now natively supports shading from external buildings using the BuildingShade model.
</li>
<li>
The InternalWall model now has the option to simulate natural convection through open doors or cavities.
</li>
<li>
The license has been modified from MSL2 to BSD3.
</li>
<li>
LIDEAS has been merged into IDEAS. LIDEAS contains code for linearising an IDEAS building envelope model and for exporting it as a state space model. 
For more details, see http://www.ep.liu.se/ecp/118/005/ecp1511851.pdf
</li>
</ul>
<p>
Detailed release notes:
</p>
<ul>
<li>
The RectangularZoneTemplate has been extended considerably. Some changes are not reverse compatible.<br/>
Internal walls can no longer be combined with a window.<br/>
A building shade option has been added for outer walls.<br/>
An option has been added to completely drop one of the surfaces of the model.<br/>
An option has been added to override the default wall lengths.<br/>
An option to add a wall entirely enclosed by the zone has been added.<br/>
The Window model has been made replaceable such that a fully configured window can easily be used.<br/>
An option for adding a cavity to internal walls has been added.<br/>
An option to add a cavity to internal walls has been added.<br/>
An option has been added to include an internal wall that is completely surrounded by the zone.<br/>
External proBus connectors are now vectors.
</li>
<li>
The EmbeddedPipe model has been modified:<br/>
The parameter useSimplifiedRt has been removed.<br/>
The implementation now has final alpha=0 in the PrescribedHeatFlowRate blocks, which can significantly reduce the size of algebraic loops that are formed.
</li>
<li>
A bug has been solved in the BuildingShade model that caused it to only work correctly for south-oriented surfaces.
</li>
<li>
A bug has been solved in the computation of the absolute humidity. 
The shading models now compute the impact on the diffuse solar irradiation more accurately. 
Although the used models are relatively simple, they are more accurate than the previous implementation, which disregarded the influence completely.
</li>
<li>
Several bugs have been solved in the implementation of the Adsolair internal controller, which caused the unit not to work as intended.
</li>
<li>
A bug has been fixed where the Zone model did not work when the air medium did not contain water vapour.
</li>
<li>
The zone model now has several options for defining the occupancy internally. 
A fixed occupancy, a table, or an external input can be used. 
The relevant block is replaceable such that users can write their own occupancy models.
</li>
<li>
Fixed the propagation of T_start in MonoLayerDynamic.
</li>
<li>
A bug has been fixed where the shading control input of the window model was not displayed correctly.
</li>
<li>
Two new shading models have been added: a horizontal fin shading model and the combination of a horizontal fin shading model with an overhang.
</li>
<li>
ThreeWayValveMotor now also has a valve leakage since the old implementation can lead to singularities when the flow rate is exactly zero.
</li>
<li>
The azimuth angle computation has been modified such that the argument of an arcsin cannot become larger than 1 due to roundoff/numerical errors. 
This caused models to crash in very rare occasions.
</li>
<li>
Atmospheric pressure and relative humidity have been added to the weather bus since these variables are sometimes used to set the boundary conditions of a zone using a Boundary_pT.
</li>
<li>
Fixed a bug in RunningMeanTemperatureEN15251 where the model output is incorrect for non-zero start times.
</li>
<li>
A bug was fixed to correctly propagate the parameters energyDynamicsAir and mSenFac into the zone air model.
</li>
<li>
The StrobeInfoManager has been modified such that it also works for negative simulation times.
</li>
<li>
A dry air medium for MPC applications has been added.
</li>
<li>
The unit test tolerances have been decrease from the default of 1e-4 to 1e-6 to achieve more consistent results in the automated unit tests. 
LSodar is now used instead of DASSL.
</li>
<li>
The zone air states now have a nominal attribute such that the state variables are better scaled when using implicit integrators. 
Similarly, the nominal values of the FluidPorts have been set.
</li>
<li>
OuterWall can now be used as a floor.
</li>
<li>
A bug has been corrected in the BESTEST weather file.
</li>
<li>
Many old models have been removed and examples that depend on them have been updated to better illustrate how IDEAS can/should be used.
</li>
<li>
The OuterWall model now also supports the computation of shading cast by external objects buildings. 
Future work should extend the set of supported shading models.
</li>
<li>
The SimInfoManager now exposes the same WeatherBus of the one used in the LBL Buildings library. 
The Buildings library solar thermal collectors are thus natively supported.
</li>
<li>
IDEAS is now licensed under BSD3.
</li>
<li>
Added multiple asserts that avoid the improper use of IDEAS models.
</li>
<li>
Added an output for the CO2 concentration in the Zone model, which outputs zero when the Zone Medium does not contain CO2.
</li>
<li>
The window model has been extended such that it can be configured to consist of nWin identical windows. 
This makes it easier to correctly configure the shading of multiple identical windows. 
The heat flow rates are simply scaled by nWin.
</li>
<li>
IDEAS 2.0 is based on IBPSA 3.0, which includes general performance and documentation improvements. Notable additions from the IBPSA library are:<br/>
A heat pump model that implements a detailed thermodynamic cycle has been added.<br/>
A thermal storage tank model has been added.<br/>
A geothermal bore field model has been added.<br/>
A model has been added for directly writing .csv result files. These result files can also be used as an input for a CombiTimeTable.
</li>
<li>
IDEAS now supports multiple trace substances for the zone model, i.e. other trace substances than CO2 are also supported.
</li>
<li>
The Zone models now have the option for computing thermal heat gains due to lighting. 
Various zone types are supported, which determine the illuminance requirements. 
The lighting type determines the electrical power required for this illuminance. 
A lighting controller determines whether the lighting is enabled. 
</li>
</ul>
</html>"));
end Version_2_0_0;
