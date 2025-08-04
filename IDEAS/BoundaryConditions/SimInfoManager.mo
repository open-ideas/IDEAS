within IDEAS.BoundaryConditions;
model SimInfoManager
  "Simulation information manager for handling time and climate data required in each for simulation."
  extends BoundaryConditions.Interfaces.PartialSimInfoManager(
    Te = TDryBul.y,TeAv = Te,
    Tground=TdesGround,
    relHum = phiEnv.y,
    TDewPoi = TDewPoiData.y,
    Tsky = TBlaSkyData.y,
    Va = winSpeData.y,
    Vdir = winDirData.y);

protected
  Modelica.Blocks.Routing.RealPassThrough HDirNorData;
  Modelica.Blocks.Routing.RealPassThrough HGloHorData;
  Modelica.Blocks.Routing.RealPassThrough HDiffHorData;
  Modelica.Blocks.Routing.RealPassThrough TDryBulData;
  Modelica.Blocks.Routing.RealPassThrough relHumData;
  Modelica.Blocks.Routing.RealPassThrough TDewPoiData;
  Modelica.Blocks.Routing.RealPassThrough nOpaData;
  Modelica.Blocks.Routing.RealPassThrough winSpeData;
  Modelica.Blocks.Routing.RealPassThrough winDirData;
  Modelica.Blocks.Routing.RealPassThrough TBlaSkyData;
equation


  connect(HDirNorData.u, weaDatBus.HDirNor);
  connect(HGloHorData.u, weaDatBus.HGloHor);
  connect(HDiffHorData.u, weaDatBus.HDifHor);
  connect(TDryBulData.u, weaDatBus.TDryBul);
  connect(relHumData.u, weaDatBus.relHum);
  connect(TDewPoiData.u, weaDatBus.TDewPoi);
  connect(nOpaData.u, weaDatBus.nOpa);
  connect(winSpeData.u, weaDatBus.winSpe);
  connect(winDirData.u, weaDatBus.winDir);
  connect(TBlaSkyData.u, weaDatBus.TBlaSky);
  annotation (
    defaultComponentName="sim",
    defaultComponentPrefixes="inner",
    missingInnerMessage=
        "Your model is using an outer \"sim\" component. An inner \"sim\" component is not defined. For simulation drag IDEAS.BoundaryConditions.SimInfoManager into your model.",
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}),
         graphics={
        Bitmap(extent={{22,-8},{20,-8}}, fileName="")}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,160}})),
    Documentation(info="<html>
<p>
The SimInfoManager manages all simulation information. 
It loads TMY3 weather data files and applies transformations 
for computing the solar irradiance on the zone surfaces. 
</p>
<h4>Typical use and important parameters</h4>
Parameters <code>filNam</code> and <code>filDir</code> can be used to set the path to the TMY3 weather file.
This file should include the latitude, longitude and time zone corresponding to the weather file.
See the included weather files for the correct format.
<h4>Options</h4>
<ul>
<li>
IDEAS contains an efficient implementation for computing the solar 
incidence angles on surfaces that are part of large building models.
When a model has many parallel surfaces the default implementation computes
the solar irradiance separately for each of these surfaces, 
while the result for all of them should be the same.
The SimInfoManager computes five default orientations (azimuth angels): 
south, west, east, north and horizontal.
Whenever a surface needs the solar incidence angels for one of these orientations
these precomputed values will be used.
The default orientations can be changed using parameters 
<code>incAndAziInBus</code>.
<code>incAndAziInBus</code> determines for which inclination and azimuth the solar radiation is pre-computed.
</li>
<li>
Conservation of energy within the building can be checked by setting <code>computeConservationOfEnergy=true</code>.
Conservation of energy is checked by computing the internal energy for 
all components that are within \"the system\" and by adding to this the 
integral of all heat flows entering/leaving the system.
There are two options for choosing the extent of the system based 
on parameter <code>openSystemConservationOfEnergy</code>. 
Either conservation of energy for a closed system is computed, 
or it is computed for an open system. <br/>
When choosing the closed system the conservation of energy 
check should always work when using IDEAS as intended. 
In this case conservation of energy is only checked for all components in the <code>Buildings</code> package. 
I.e. all heat flows at embedded ports <code>port_emb</code> of walls, 
fluid ports of the zones, <code>zone.gainCon</code> and <code>zone.gainRad</code> are 
considered to be a heat gain to the system and every other component 
is considered to be outside of the system for which conservation of energy is checked. <br/>
When computing an open system by setting <code>openSystemConservationOfEnergy=true</code> 
these heat flow rates are not taken into account because they are assumed 
to flow between components that are both within the bounds of the system.
The user then needs to choose how large the system is and he should make sure that
all heat flow rates entering the system are added to <code>sim.Qgai.Q_flow</code> and 
that all internal energy of the system is added to <code>sim.E.E</code>.
</li>
<li>
The default latitude and longitude, which are read by the TMY3 reader, can be overwritten. 
This should only be done if a custom weather data reader instead 
of the TMY3 weather data reader is used.
</li>
</ul>
<h4>TMY3 weather data files</h4>
IDEAS uses TMY3 input files. 
The default weather file 'BEL_VLG_Uccle.064470_TMYx.2007-2021.mos' contains weather information from https://climate.onebuilding.org 
for the weather station in Uccle, near the Brussels region in Belgium.
For detailed documentation see 
<a href=\"modelica://IDEAS.BoundaryConditions.WeatherData.ReaderTMY3\">IDEAS.BoundaryConditions.WeatherData.ReaderTMY3</a>.
<h4>Interzonal airflow</h4>
<p>
IDEAS supports several levels of detail for simulating interzonal airflow and air infiltration,
which can be selected by setting the value of the parameter <code>interzonalAirFlowType</code>. 
</p>
<p>
By <b>default</b>, <code>interzonalAirFlowType=None</code> and a fixed <i>n50</i> value is assumed for each zone.
The <i>n50</i> value represents the airtightness of a building or building zone.
It is equal to the number of air changes per hour (due to air leakage) at a pressure difference of 50 Pa,
and is expressed in <i>h<sup>-1</sup></i>.
The corresponding <b>fixed mass flow rate</b> is divided by a fixed factor <code>n50toAch</code> and is pushed
into (with ambient properties) and extracted from each zone model.
In practice, however, air infiltration depends on the wind pressure and temperature differences,
and occurs only in zones that have an exterior/outer wall or windows. 
The other <code>interzonalAirFlowType</code> options model this effect in more detail.
</p>
<p>
When setting <code>unify_n50=true</code> while <code>interzonalAirFlowType=None</code>,
the <i>n50</i> values are automatically redistributed across the zones as described below
and a corrected fixed infiltration flow rate is assumed.
While this implementation is more detailed and comes at no added computational cost, 
it is disabled by default for backward compatibility reasons.
</p>
<p>
When <code>interzonalAirFlowType=OnePort</code> or <code>interzonalAirFlowType=TwoPort</code>,
by default, the <code>OuterWall</code> and <code>Window</code> leakage coefficients 
are computed using the building's <i>n50</i> value set in the <code>SimInfoManager</code>.
The zone volumes are added together to compute the total nominal air infiltration
at a 50 Pa pressure difference based on the building's <i>n50</i> value set by the user. 
Then, the total exterior building area, 
which is the sum of the area of all <code>OuterWall</code> and <code>Window</code> components,
is used to compute an average <i>q50</i> value.
The <i>q50</i> value represents the airtightness of a surface.
It is equal to the average air leakage flow per hour at a pressure difference of 50 Pa per surface area, 
and is expressed in <i>m<sup>3</sup>/h/m<sup>2</sup></i>.
Each airflow path is represented by an <code>IDEAS.Airflow.Multizone.Point_m_flow</code> class
which will compute the real air flow rates at lower pressure differences.
</p>
<p>
When a custom <i>q50</i> value for a wall or window is known, it can be 
assigned by the user using the parameters <code>use_custom_q50</code> and <code>custom_q50</code>.
The algorithm considers these <i>q50</i> values as known and recomputes all remaining <i>q50</i> values
such that the imposed <i>n50</i> value at the building level is reached.
</p>
<p>
In a similar way, the total <i>n50</i> value for one zone can be forced by using
the zone parameters <code>use_custom_n50</code> and <code>n50</code>.
In this case, the <code>q50</code> parameter values of the outer surfaces
connected to that zone will correspond to the custom <code>n50</code> parameter value of the zone. 
Subsequently, all other zones and surfaces will be adjusted such that
the building's total air leakage still corresponds to the building's <i>n50</i> value. 
</p>
<h5>One-port implementation</h5>
<p>
In case <code>interzonalAirFlowType=OnePort</code>, then one flow path is 
used to model the air exchange through each surface
and through cavities in internal walls (open doors).
No buoyancy driven airflow (stack-effect) is modelled in this case.
This implementation is recommended when naturally driven airflows 
are expected to be negligble (e.g. limited building height, good airtightness)
or when the HVAC system pressure differences and 
corresponding air flow rates are of higher orders of magnitude.
More information regarding the one-port implementation can be found in [DeJonge2021].
</p>
<h5>Two-port implementation</h5>
<p>
When <code>interzonalAirFlowType=TwoPorts</code>, then two flow paths are
used for each external surface and 
buoyancy/temperature driven airflow (stack-effect) is added by consistent implementation 
of the <code>IDEAS.Airflow.Multizone.MediumColumnReversible</code> class. 
This increases the level of detail at the cost of having to solve a more complex flow network, 
thereby allowing the more detailed modelling of multi-zone air flow. 
In this implementation, larger openings (e.g. open doors in internal walls or open windows) 
are represented by the <code>IDEAS.Airflow.Multizone.DoorDiscretizedOperable</code> class. 
It is important to set the parameters <code>hFloor</code> and <code>hZone</code> correctly at zone level.
</p>
<h5>Wind speed</h5>
<p>
The wind pressure depends on the wind speed, but this one is typically measured at a meteorological station.
The wind speed at the building is different from this measured one due to the local terrain and elevation effects.
This is taken into account by the wind speed modifier coefficient <i>C<sub>s</sub></i>,
which is calculated as [CONTAM2020]:
</p>
<p align=\"center\" style=\"font-style:italic;\">
  C<sub>s</sub> =  A<sub>0</sub><sup>2</sup> &#183; (H/H<sub>ref</sub>)<sup>2a</sup></span>
</p>
<p>
where <i>H</i> is the building height,
<i>H<sub>ref</sub></i> is the height at which the wind speed is measured,
<i>A<sub>0</sub></i> is the local terrain constant,
and <i>a</i> is the velocity profile exponent.
<p> 
The AHRAE Fundamentals handbook of 1993 provided values for <i>A<sub>0</sub></i> and <i>a</i>
for different terrain types (e.g. urban and suburban).
Since the 2005 version of the ASHRAE Fundamentals handbook [ASHRAE2005],
the wind boundary layer thickness <i>&delta;</i> is reported
instead of the coefficient <i>A<sub>0</sub></i>.
However, the latter can be calculated from the former as [CONTAM2020]:
</p>
<p align=\"center\" style=\"font-style:italic;\">
  A<sub>0</sub> = (&delta;<sub>ref</sub>/H<sub>ref</sub>)<sup>a<sub>ref</sub></sup> &#183; (H<sub>ref</sub>/&delta;)<sup>a<sub>ref</sub></sup></span>
</p>
<p>
where <i>&delta;<sub>ref</sub>, H<sub>ref</sub>, and a<sub>ref</sub></i> are the
wind boundary layer thickness, wind measurement height, and velocity profile exponent
at the meteorological station, respectively.
</p>
<p>
The model allows to set the terrain type parameter <code>locTer</code> to
<code>Urban</code>, <code>Suburban</code>, <code>Unshielded</code>, or <code>Custom</code>.
For the former three, coefficients <i>a</i> and <i>&delta;</i> are taken from [ASHRAE2005]
and <i>A<sub>0</sub></i> is calculated using the equation above, assuming 
a meteorological station in an unshielded area.
The height at which the wind is measured (<i>H<sub>ref</sub></i>) is set by the parameter <code>Hwind</code>.
If <code>Custom</code> is selected, the user needs to provide values for <i>a</i> and <i>A<sub>0</sub></i>.
<table summary=\"summary\" border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr>
<th>Terrain type</th>
<th><i>a</i></th>
<th><i>&delta;</i> [<i>m</i>]</th>
<th><i>A<sub>0</sub></i></th>
</tr>
<tr>
<td>Urban (large city center)</td>
<td>0.33</td>
<td>460</td>
<td><i>(270/H<sub>ref</sub>)<sup>0.14</sup> &#183; (H<sub>ref</sub>/460)<sup>0.33</sup></i></td>
</tr>
<tr>
<td>Suburban</td>
<td>0.22</td>
<td>370</td>
<td><i>(270/H<sub>ref</sub>)<sup>0.14</sup> &#183; (H<sub>ref</sub>/370)<sup>0.22</sup></i></td>
</tr>
<tr>
<td>Unshielded (default)</td>
<td>0.14</td>
<td>270</td>
<td><i>(270/H<sub>ref</sub>)<sup>0.14</sup> &#183; (H<sub>ref</sub>/270)<sup>0.14</sup></i></td>
</tr>
<tr>
<td>Custom</td>
<td><i>a<sub>custom</sub></i></td>
<td>/</td>
<td><i>A<sub>0,custom</sub></i></td>
</tr>
</table>
<h4>References</h4>
<p>
[ASHRAE2005]<br/>
American Society of Heating Refrigerating and Air-Conditioning Engineers.<br/>
2005 ASHRAE handbook: Fundamentals, SI Edition.<br/>
Atlanta: American Society of Heating, Refrigerating and Air-Conditioning Engineers, 2005.<br/>
</p>
<p>
[CONTAM2020]<br/>
W. Stuart Dols and Brian J. Polidoro.<br.>
CONTAM User Guide and Program Documentation: Version 3.4.<br/>
Washington, DC: US Department of Commerce, National Institute of Standards and Technology, 2015.<br/>
<a href=\"https://doi.org/10.6028/NIST.TN.1887r1\">doi:10.6028/NIST.TN.1887r1</a>.
</p>
<p>
[DeJonge2021]<br/>
Klaas De Jonge, Filip Jorissen, Lieve Helsen and Jelle Laverge.<br/>
Wind-Driven Air Flow Modelling in Modelica: Verification and Implementation in the IDEAS Library.<br/>
Proceedings of Building Simulation 2021: 17th Conference Of IBPSA. Bruges, Belgium, September, 2021.<br/>
<a href=\"https://doi.org/10.26868/25222708.2021.30165\">doi:10.26868/25222708.2021.30165</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
July 10, 2025, by Klaas De Jonge:<br/>
Update the interzonal airflow documentation.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1347\">#1347</a>.
</li>
<li>
July 9, 2025, by Jelger Jansen:<br/>
Update documentation related to wind speed modifier calculation.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1340\">#1340</a>.
</li>
<li>
April 16, 2021 by Filip Jorissen:<br/>
Changed the default weather file to Brussels.mos
and revised the documentation accordingly.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1209\">
#1209</a> for more details.
</li>
<li>
June 30, 2020 by Filip Jorissen:<br/>
Overridable assignments of variables of PartialSimInfoManager.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1148\">
#1148</a>
</li>
<li>
November 28, 2019 by Ian Beausoleil-Morrison:<br/>
Make wind direction available on WeaBus.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1089\">
#1089</a>
</li>
<li>
January 21, 2019 by Filip Jorissen:<br/>
Improved documentation by adding weather data reader
reference and more TMY3 file examples.
This is for
<a href=\"https://github.com/open-ideas/IDEAS/issues/956\">#956</a>.
</li>
<li>
June 7, 2018 by Filip Jorissen:<br/>
Overwriting TSky, Va and Fc from the extends clause
such that they can be overwriten again in BESTEST SimInfoManager.
This is for
<a href=\"https://github.com/open-ideas/IDEAS/issues/838\">#838</a>.
</li>
<li>
June 14, 2015, Filip Jorissen:<br/>
Added documentation
</li>
</ul>
</html>"));
end SimInfoManager;
