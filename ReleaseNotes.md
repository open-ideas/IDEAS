## IDEAS v3.0.0
IDEAS 3 has been released on May 3rd, 2022. It includes:
 - A conversion of IDEAS v2.2.2 to MSL 4.0.0. 
 - An update of IBPSA models to commit f36e99e064c162dc9772137e7d9990f52b6f59c9. 
 - Support for Dymola 2022x.
 - An update of the default weather file for #1239.
 - An update of the README.md on the front page of GitHub.

## IDEAS v2.2.2
IDEAS 2.2.2 has been released on April 2nd, 2022. It is the final release that supports the Modelica Standard v3.3 and MSL v3 before updating to MSL 4.0.0. Only few changes were performed. Most importantly, some compatibility fixes for OpenModelica were added.

## IDEAS v2.2.1
IDEAS 2.2.1 has been released on September 20th, 2021. This update includes an IBPSA merge up to commit f15e041c818bfc38b5b32aa8ad8e3e119ffc92de, which fixes crashes when using the weather data reader together with the weather file Brussels.mos for the most recent versions of Dymola.

## IDEAS v2.2
IDEAS 2.2 has been release on June 9th, 2021. The most notable changes are:
+ Interzonal airflow support has been added. See the SimInfoManager documentation for more details.
+ IBPSA has been update to commit 443cb50b7ce58ac1585688
+ Emulator models have been added for the IBPSA project 1 WP 1.2 BOPTEST.
+ A tutorial has been added in IDEAS.Examples.Tutorial
+ Unit test results have been updated to Dymola 2020.
+ The default n50 value has been increased from 0.4 to 3 ACH.
+ The default IDEAS weather file has been changed since the old file data was shifted by one hour. The new file source is IWEC.

### Detailed release notes:
- An implementaiton has been added for a VAV model that has additional parameters for indicating the minimum and maximum VAV flow rate.
- An implementation has been added for a shading controller that considers the solar irradiation on an inclined surface instead of on a horizontal surface.
- An implementation has been added for a simple clock.
- The number of default glazing system options has been reduced.
- The zone Medium now equals IDEAS.Media.Air by default.
- Revised the implmeentation of ExteriorSolarAbsorption such that no initial equation is needed.
- Improved the orientation detection functionality for horizontal surfaces.
- The heat of evaporation of water has been changed to a more accurate value in the internal gains model.
- The thermostatic radiator valve implementation has been revised to avoid numerical problems.
- Improved errors and warnings in various models.
- The specific heat capacity of DryAir was wrong. This has been fixed.
- Various other changes to the EmbeddedPipe model.
- BESTEST results have been updated.
- The glazing and frame thermal mass has been split for numerical reasons.
- The external convection implementation of surfaces has been revised.
- An 'inverse Perez model' has been added, which computes global and diffuse solar irradiation from 3 distinct measurements on an inclined surface.
- The zone icon now displays the number of connected surfaces.
- Inclination and/or azimuth angles can now be indicated using bullets (for S/E/N/W, etc) instead of manually filling in the exact value.
- Fixed a division by zero in ThreeWayValveMotor.
- Fixed a bug in the indirect evaporative heat exchanger that caused it to fail for balanced flow rates.
- A tool has been added for validating a window U value according to EN673, see IDEAS/Buildings/Components/Validations/WindowEN673.mo.
- A new boundary model has been added that internally sets the exterior air boundary conditions: OutsideAir.
- Cleaned up old glazing records.
- Users are now warned about missing coatings in glazing systems. The warning can be disabled.
- Fixed an issue where dp_nominal=0 caused a division by zero in the EmbeddedPipe.
- Fixed an issue where the TSensor output of the zone was on top of the ppm output.
- Fixed OpenModelica import errors.
- Revised the mixing implementation of ThreeWayValveMotor.
- Propagated mSenFac in ThreeWayValveMotor.
- Updates to PPD12 model.
- Reenabled pressure drop by default in EmbeddedPipe.
- A reasonable default humidity has been added for the Fanger comfort model when dry air is used.
- A bug has been fixed in the BuildingShade model that caused negative shading fractions.
- Added an assert that verifies the correct flow direction of the EmbeddedPipe.
- Instead of 0, now a sensible initial state for the CO2 concentration has been added for zones.
- An option has been added for scaling the number of occupants input of a zone by the zone surface area.
- The lateral displacement of horizontal fins can now be controlled instead of controlling the horizontal fin angle.
- An inconsistency in the computation of CO2 concentrations has been fixed.
- The impact of horizontal fin shading on the diffuse solar irradiation is modelled in more detail.

### Acknowledgements
- We thank Ian Beausoleil-Morrison for his contribution to the exterior surface convection modelling.
- We thank Klaas de Jonge for his contribution to the interzonal air flow implementation modelling.
- We thank all participants of IBPSA project 1 and Michael Wetter in particular for their contributions to the IBPSA library.
- We thank VLAIO (HBC 2018.2092), the EU (grant number 723649 - MPC-; GT) and KU Leuven (project C32/18/063) for their financial support which made this development possible.


## IDEAS v2.1
IDEAS 2.1 has been released on February 28th, 2019. The most important changes are:

+ IBPSA has been updated up to commit 2d6a5a6ff80.
+ The twin house example model has been re-added to the library.
+ The PPD12 examples now includes a model that compares a rule based controller with a model predictive controller.

### Detailed release notes:
1. Deprecated IDEAS.Fluid.Actuators.Valves.Simplified.ThreeWayValve.
2. Extended IDEAS.Buildings.Components.Shading.BuildingShade with a parameter for configuring partial shading.
3. Added a two-way and three-way valve with a mixed linear-equal percentage opening characteristic.
4. Added a bypass for the PPD12 air handling unit.
5. Modified the way how initial equations are defined for wall models. This avoids duplicate initial equations.
6. Fixed a bug in the zone model when allowFlowReversal was set to false.
7. Added the option for setting a fixed boudnary condition temperature in BoundaryWall.
8. Added a utility that automatically checks the git version of library dependencies when running a model, for enhanced version checking of models.
9. Revised the implementation of the thermostatic radiator valve model such that it is smooth.
10. Revised documentation in ExteriorSolarAbsorption.
11. Fixed a compatibility bug with OpenModelica.
12. Removed reference to non-existent parameter in RectangularZoneTemplate.


## IDEAS v2.0
IDEAS 2.0 has been released on September 28th, 2018. Highlights of this release compared to v1.0 are:

+ Unit tests have been automated. When a developer makes a pull request against the master, unit tests are run automatically using Travis CI. This greatly simplifies the development process when no unit test results change.
+ IDEAS has been updated to IBPSA version 3.0. This includes a new heat pump model and a thoroughly updated borefield model.
+ Some old models have been removed and the library has been cleaned up in general.
+ New example models and unit tests have been added that better demonstrate how IDEAS can be used. In general, the documentation of the library has improved.
+ The `OuterWall` model now natively supports shading from external buildings using the BuildingShade model.
+ The `InternalWall` model now has the option to simulate natural convection through open doors or cavities.
+ The license has been modified from MSL2 to BSD3.
+ LIDEAS has been merged into IDEAS. LIDEAS contains code for linearizing an IDEAS building envelope model and for exporting it as a state space model. For more details see http://www.ep.liu.se/ecp/118/005/ecp1511851.pdf


### Detailed release notes:
1. The `RectangularZoneTemplate` has been extended considerably. Some changes are not reverse compatible.
   + Internal walls can no longer be combined with a window.
   + A building shade option has been added for outer walls.
   + An option has been added to completely drop one of the surfaces of the model.
   + An option has been added to override the default wall lengths.
   + An option to add a wall that is entirely enclosed by the zone.
   + The `Window` model has been made replaceable such that a fully configured window can easily be used.
   + An option for adding a cavity to internal walls has been added.
   + An option has been added for including an internal wall that is completely surrounded by the zone.
   + External proBus connectors are now vectors.
2. The `EmbeddedPipe` model has been modified:
   + The parameter useSimplifiedRt has been removed.
   + The implementation now has final alpha=0 in the PrescribedHeatFlowRate blocks, which can significantly reduce the size of algebraic loops that are formed.
3. A bug has been solved in the `BuildingShade` model that caused it to only work correctly for south oriented surfaces.
4. A bug has been solved in the computation of the absolute humidity.
The shading models now compute the impact on the diffuse solar irradiation more accurately. Although the used models are relatively simple, they are more accurate than the previous implementation, which disregarded the influence completely.
5. Several bugs have been solved in the implementation of the Adsolair internal controller, which caused the unit not to work as intended.
6. A bug has been fixed where the Zone model did not work when the air medium does not contain water vapor.
7. The zone model now has several options for defining the occupancy internally. A fixed occupancy, a table, or an external input can be used. The relevant block is replaceable such that users can write their own occupancy models.
8. Fixed the propagation of T_start in MonoLayerDynamic.
9. A bug has been fixed where the shading control input of the window model was not displayed correctly.
10. Two new shading models have been added: a horizontal fin shading model and the combination of a horizontal fin shading model with an overhang.
11. ThreeWayValveMotor now also has a valve leakage since the old implementation can lead to singularities when the flow rate is exactly zero.
12. The azimuth angle computation has been modified such that the argument of an arcsin cannot become larger than 1 due to roundoff/numerical errors. This caused models to crash in very rare occasions.
13. Atmospheric pressure and relative humidity have been added to the weather bus since these variables are sometimes used to set the boundary conditions of a zone using a Boundary_pT.
14. Fixed a bug in RunningMeanTemperatureEN15251 where the model output is incorrect for non-zero start times.
15. Parameters energyDynamicsAir and mSenFac were not propagated correctly into the zone air model. This is now fixed.
16. The StrobeInfoManager has been modified such that it also works for negative simulation times.
17. A dry air medium for MPC applications has been added.
18. The unit test tolerances have been decrease from the default of 1e-4 to 1e-6 to achieve more consistent results in the automated unit tests. LSodar is now used instead of DASSL.
19. The zone air states now have a nominal attribute such that the state variables are better scaled when using implicit integrators. Similarly, the nominal values of the FluidPorts have been set.
20. We now allow an OuterWall to be used as a floor.
21. A bug has been corrected in the BESTEST weather file.
22. Many old models have been removed and examples that depend on them have been updated to better illustrate how IDEAS can/should be used.
23. The OuterWall model now also supports the computation of shading cast by external objects buildings. Future work should extend the set of supported shading models.
24. The SimInfoManager has been modified such that it now exposes the same WeatherBus as the one that is used in the LBL Buildings library. The Buildings library solar thermal collectors are thus natively supported.
25. IDEAS is now licensed under BSD3.
26. Added multiple asserts that avoid the improper use of IDEAS models.
27. Added an output for the CO2 concentration in the Zone model, which outputs zero when the Zone Medium does not contain CO2.
28. The window model has been extended such that it can be configured to consist of nWin identical windows. This makes it easier to correctly configure the shading of multiple identical windows. The heat flow rates are simply scaled by nWin.
29. IDEAS 2.0 is based on IBPSA 3.0, which includes general performance and documentation improvements. Notable additions from the IBPSA library are:
   + A heat pump model that implements a detailed thermodynamic cycle has been added.
   + A thermal storage tank model has been added.
   + A geothermal bore field model has been added.
   + A model has been added for directly writing .csv result files. These result files can also be used as an input for a CombiTimeTable.
30. IDEAS now supports multiple trace substances for the zone model. I.e. other trace substances than CO2 are also supported.
31. The Zone models now have the option for computing thermal heat gains due to lighting. Various zone types are supported, which determine the illuminance requirements. The lighting type determines the electrical power required for this illuminance. A lighting controller determines whether the lighting is enabled.


## IDEAS v1.0
May 5th 2017: IDEAS v1.0.0 has been released.  
February 16th 2018: A [paper describing IDEAS v1.0](http://www.tandfonline.com/doi/full/10.1080/19401493.2018.1428361) has been published on line.

### Release notes
Changes compared to v0.3 include but are not limited to:

0. IDEAS 1.0.0 is based on Annex 60 version 1.0
1. The IDEAS packages have been restructured to be more in line with the Annex 60 package structure.
   + IDEAS.Constants has been replaced by IDEAS.Types
   + The SimInfoManager has been moved to IDEAS.BoundaryConditions
   + Interfaces such as HeatingSystem and BaseCircuits have been moved to IDEAS.Templates
2. Setting up new Construction records has been simplified. Parameter values of nLay and nGain are now inferred from the other parameters and may therefore no longer be assigned.
3. Optional parameter incLastLay has been added to Construction records. Users may use this to double-check if InternalWalls are connected as intended.
4. The way how internal gains may be connected to surfaces has been changed.
5. Convection and thermal radiation equations have been tuned to be more accurate and faster.
6. Added an option to the zone model for evaluating thermal comfort.
7. Added an option to the zone model for computing the sensible and latent heat gains from occupants.
8. The zone air model is now replaceable such that custom models may be created.
9. Some variables have been renamed. A conversion script is provided for converting the user's models to accomodate these changes.
   + TStar has been renamed into TRad in the zone model.
   + flowPort_Out and flowPort_In have been renamed in the zone model, heating system, ventilaiton system and structure models.
   + Some Annex 60 models were renamed.
10. A zone template has been added that allows to add a rectangular zone, including 4 walls, 4 optional windows, a floor and a ceiling.
11. Added example model of a terraced house in IDEAS.Examples.PPD12
12. Added twin house validation models in IDEAS.Examples.TwinHouse
13. Added solar irradiation model for window frames.
14. Added optional thermal bridge model for windows.
15. Extended implementation of building shade model.
16. Fixed bug in view factor implementation.
17. Updated documentation for many models in IDEAS.Buildings
18. Added thermostatic valve model: IDEAS.Fluid.Actuators.Valves.TwoWayTRV
19. Removed insulationType and insulationThickness parameters. These should now be defined in the Construction records.
20. Harmonised implementation of Perez solar irradiation model with Annex 60 implementation.
21. Cleaned up implementation of BESTEST models.
22. Added new, specialised window types.
23. Added options for model linearisation.
24. Improved accuracy of model that computes internal longwave radiation.
25. Improved accuracy of model that computes exterior sky temperature.
26. Moved Electrical package into Experimental package since this package contains broken models.
27. Added unit tests for templates.
28. Added Menerga Adsolair model.

### Tool compatibility
The library is developed using Dymola. Furthermore, changes have been made such that the library can be read using OpenModelica. The building models can be simulated using JModelica too, although not everything is supported yet.

## IDEAS v0.3

IDEAS release v0.3 has been pushed on 2 september 2015. Major changes compared to v0.2 are:

1. Added code for checking conservation of energy
2. Added options for linear / non-linear radiative heat exchange and convection for exterior and interior faces of walls and floors/ceilings. Respective correlations have been changed.
3. Overall improvements resulting in more efficient code and less warnings.
4. The emissivity of window coatings must now be specified as a property of the solid (glass sheet) and not as a property of the gas between the glass sheets. This is only relevant if you create your own glazing.
5. Merged Annex 60 library up to commit d7749e3
6. Expanded unit tests
7. More correct implementation of Koschenz's model for TABS. Also added the option for discretising TABS sections.
8. Added new building shade components.
9. Removed inefficient code that would lead to numerical Jacobians in grid.
10. Added new AC and DC electrical models.
