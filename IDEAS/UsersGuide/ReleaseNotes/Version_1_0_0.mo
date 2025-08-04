within IDEAS.UsersGuide.ReleaseNotes;
class Version_1_0_0 "Version_1_0_0"
  extends Modelica.Icons.ReleaseNotes;
  annotation (Documentation(info="<html>
<p>
Major changes compared to v0.3.0 are:
</p>
<ul>
<li>
IDEAS 1.0.0 is based on Annex 60 version 1.0.
</li>
<li>
The IDEAS packages have been restructured to be more in line with the Annex 60 package structure.<br/>
IDEAS.Constants has been replaced by IDEAS.Types<br/>
The SimInfoManager has been moved to IDEAS.BoundaryConditions<br/>
Interfaces such as HeatingSystem and BaseCircuits have been moved to IDEAS.Templates 
</li>
<li>
Setting up new Construction records has been simplified. Parameter values nLay and nGain are now inferred from other parameters.
</li>
<li>
Added optional parameter incLastLay to Construction records. Users may use this to double-check if InternalWalls are connected as intended.
</li>
<li>
Changed possible connections of internal gains to surfaces.
</li>
<li>
Improved convection and thermal radiation equations for accuracy and computational speed.
</li>
<li>
Added an option to the zone model for evaluating thermal comfort.
</li>
<li>
Added an option to the zone model for computing the sensible and latent heat gains from occupants.
</li>
<li>
The zone air model is now replaceable such that custom models may be created.
</li>
<li>
Added a zone template that allows adding a rectangular zone, including four walls, four optional windows, a floor, and a ceiling.
</li>
<li>
Renamed some variables. A conversion script is provided to update user models.<br/>
TStar has been renamed to TRad in the zone model.<br/>
flowPort_Out and flowPort_In have been renamed in the zone model, heating system, ventilation system and structure models.<br/>
Some Annex 60 models were renamed.
</li>
<li>
Added example model of a terraced house in IDEAS.Examples.PPD12
</li>
<li>
Added twin house validation models in IDEAS.Examples.TwinHouse
</li>
<li>
Added solar irradiation model for window frames.
</li>
<li>
Added optional thermal bridge model for windows.
</li>
<li>
Extended implementation of building shade model.
</li>
<li>
Fixed bug in view factor implementation.
</li>
<li>
Updated documentation for many models in IDEAS.Buildings
</li>
<li>
Added thermostatic valve model: IDEAS.Fluid.Actuators.Valves.TwoWayTRV
</li>
<li>
Removed insulationType and insulationThickness parameters. These should now be defined in the Construction records.
</li>
<li>
Harmonised implementation of Perez solar irradiation model with Annex 60 implementation.
</li>
<li>
Cleaned up implementation of BESTEST models.
</li>
<li>
Added new, specialised window types.
</li>
<li>
Added options for model linearisation.
</li>
<li>
Improved accuracy of the model that computes internal longwave radiation.
</li>
<li>
Improved accuracy of the model that computes exterior sky temperature.
</li>
<li>
Moved the Electrical package into the Experimental package since this package contains broken models.
</li>
<li>
Added unit tests for templates.
</li>
<li>
Added Menerga Adsolair model.
</li>
</ul>
</html>"));
end Version_1_0_0;
