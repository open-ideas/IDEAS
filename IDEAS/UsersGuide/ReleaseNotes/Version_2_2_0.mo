within IDEAS.UsersGuide.ReleaseNotes;
class Version_2_2_0 "Version_2_2_0"
  extends Modelica.Icons.ReleaseNotes;
  annotation (Documentation(info="<html>
<p>
IDEAS 2.2.0 was released on June 9, 2021. The most notable changes are:
</p>
<ul>
<li>
Interzonal airflow support has been added. See the SimInfoManager documentation for more details.
</li>
<li>
IBPSA has been updated to commit 443cb50b7ce58ac1585688
</li>
<li>
Emulator models have been added for the IBPSA project 1 WP 1.2 BOPTEST.
</li>
<li>
A tutorial has been added in IDEAS.Examples.Tutorial
</li>
<li>
Unit test results have been updated to Dymola 2020.
</li>
<li>
The default n50 value has been increased from 0.4 to 3 ACH.
</li>
<li>
The default IDEAS weather file has been changed since the old file data was shifted by one hour. The new file source is IWEC.
</li>
</ul>
<p>
Detailed release notes:
</p>
<ul>
<li>
An implementation has been added for a VAV model that has additional parameters for indicating the minimum and maximum VAV flow rate.
</li>
<li>
An implementation has been added for a shading controller that considers the solar irradiation on an inclined surface instead of on a horizontal surface.
</li>
<li>
An implementation has been added for a simple clock.
</li>
<li>
The number of default glazing system options has been reduced.
</li>
<li>
The zone Medium now equals IDEAS.Media.Air by default.
</li>
<li>
The implementation of ExteriorSolarAbsorption has been revised such that no initial equation is needed.
</li>
<li>
The orientation detection functionality has been improved for horizontal surfaces.
</li>
<li>
The heat of evaporation of water has been changed to a more accurate value in the internal gains model.
</li>
<li>
The thermostatic radiator valve implementation has been revised to avoid numerical problems.
</li>
<li>
Errors and warnings in various models have been improved.
</li>
<li>
The specific heat capacity of DryAir was wrong. This has been fixed.
</li>
<li>
The EmbeddedPipe model has been improved.
</li>
<li>
BESTEST results have been updated.
</li>
<li>
The glazing and frame thermal mass has been split for numerical reasons.
</li>
<li>
The external convection implementation of surfaces has been revised.
</li>
<li>
An 'inverse Perez model' has been added, which computes global and diffuse solar irradiation from 3 distinct measurements on an inclined surface.
</li>
<li>
The zone icon now displays the number of connected surfaces.
</li>
<li>
Inclination and/or azimuth angles can now be indicated using bullets (for S/E/N/W, etc) instead of manually filling in the exact value.
</li>
<li>
Fixed a division by zero in ThreeWayValveMotor.
</li>
<li>
Fixed a bug in the indirect evaporative heat exchanger that caused it to fail for balanced flow rates.
</li>
<li>
A tool has been added for validating a window U value according to EN673, see IDEAS/Buildings/Components/Validations/WindowEN673.mo.
</li>
<li>
A new boundary model has been added that internally sets the exterior air boundary conditions: OutsideAir.
</li>
<li>
Cleaned up old glazing records.
</li>
<li>
Users are now warned about missing coatings in glazing systems. The warning can be disabled.
</li>
<li>
Fixed an issue where dp_nominal=0 caused a division by zero in the EmbeddedPipe.
</li>
<li>
Fixed an issue where the TSensor output of the zone was on top of the ppm output.
</li>
<li>
Fixed OpenModelica import errors.
</li>
<li>
Revised the mixing implementation of ThreeWayValveMotor.
</li>
<li>
Propagated mSenFac in ThreeWayValveMotor.
</li>
<li>
Updates to PPD12 model.
</li>
<li>
 Re-enabled pressure drop by default in EmbeddedPipe.
</li>
<li>
A reasonable default humidity has been added for the Fanger comfort model when dry air is used.
</li>
<li>
A bug has been fixed in the BuildingShade model that caused negative shading fractions.
</li>
<li>
Added an assert that verifies the correct flow direction of the EmbeddedPipe.
</li>
<li>
A sensible initial state, different from 0, for the CO2 concentration has been added for zones.
</li>
<li>
An option has been added for scaling the number of occupants input of a zone by the zone surface area.
</li>
<li>
The lateral displacement of horizontal fins can now be controlled instead of controlling the horizontal fin angle.
</li>
<li>
An inconsistency in the computation of CO2 concentrations has been fixed.
</li>
<li>
The impact of horizontal fin shading on the diffuse solar irradiation is modelled in more detail.
</li>
</ul>
<p>
Acknowledgements:
</p>
<ul>
<li>
We thank Ian Beausoleil-Morrison for his contribution to the exterior surface convection modelling.
</li>
<li>
We thank Klaas De Jonge for his contribution to the interzonal air flow implementation modelling.
</li>
<li>
We thank all participants of IBPSA project 1 and Michael Wetter in particular for their contributions to the IBPSA library.
</li>
<li>
We thank VLAIO (HBC 2018.2092), the EU (grant number 723649 - MPC-; GT) and KU Leuven (project C32/18/063) for their financial support, which made this development possible.
</li>
</ul>
</html>"));
end Version_2_2_0;
