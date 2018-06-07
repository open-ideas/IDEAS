within IDEAS.Examples.PPD12;
model SimInfoManagerPpd12 "SimInfoManager for PPD12"
  extends BoundaryConditions.Interfaces.PartialSimInfoManager(
    filNam="/home/parallels/Documents/Documents/Huis/Metingen/data.csv",
    final filDir="",
    final useTmy3Reader = false);

Modelica.Blocks.Sources.CombiTimeTable comTimTab(
    tableOnFile=true,
    tableName="data",
    columns=2:32,
    fileName=filNam)
    annotation (Placement(transformation(extent={{-80,-100},{-60,-80}})));
  Real okta;
  Real solGloCle =  max(0,910*Modelica.Math.cos(radSol[1].incAng.incAng)-30)
    "Unshaded solar irradiation";
equation
  // Kasten and Czeplak from https://www.tandfonline.com/doi/abs/10.1080/14786450701549824
  okta = comTimTab.y[6];
  solDirPer= solDirHor/Modelica.Math.cos(radSol[1].incAng.incAng);
  solDirHor = solGloHor-solDirHor;
  solDifHor = solGloHor*(0.3+0.7*(okta/8)^2);
  solGloHor = solGloCle*(1-0.75*(okta/8)^3.4);
  irr = 0;

  Te = comTimTab.y[15]+273.15;
  TeAv = Te;
  Tground=TdesGround;
  summer = timMan.summer;
  relHum = comTimTab.y[2]/100;
  TDewPoi = -1e5;
  timLoc = timMan.timLoc;
  timSol = timMan.timSol;
  timCal = timMan.timCal;

  Tsky = Te - (23.8 - 0.2025*(Te - 273.15)*(1 - 0.87*Fc));
  Fc = 0.2;
  Va = comTimTab.y[4];


  annotation (
    defaultComponentName="sim",
    defaultComponentPrefixes="inner",
    missingInnerMessage=
        "Your model is using an outer \"sim\" component. An inner \"sim\" component is not defined. For simulation drag IDEAS.BoundaryConditions.SimInfoManager into your model.",
    Icon(graphics={
        Bitmap(extent={{22,-8},{20,-8}}, fileName="")}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Documentation(info="<html>
<p>
The SimInfoManager manages all simulation information. 
It loads TMY3 weather data files and applies transformations 
for computing the solar irradiance on the zone surfaces. 
</p>
<h4>Typical use and important parameters</h4>
<ul>
<li>Parameters <code>filNam</code> and <code>filDir</code> can be used to set the path to the TMY3 weather file.</li>
<li>Parameters <code>lat</code> and <code>lon</code> can be used to set the location of the building
using latitude and longitude coordiantes.
These coordinates are used for calculating the solar position, not for choosing the correct weather data!</li>
</ul>
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
<li>Conservation of energy within the building can be checked by setting <code>computeConservationOfEnergy=true</code>.
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
</ul>
</html>", revisions="<html>
<ul>
<li>
June 14, 2015, Filip Jorissen:<br/>
Added documentation
</li>
</ul>
</html>"));
end SimInfoManagerPpd12;
