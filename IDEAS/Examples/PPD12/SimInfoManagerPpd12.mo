within IDEAS.Examples.PPD12;
model SimInfoManagerPpd12 "SimInfoManager for PPD12"
  extends BoundaryConditions.Interfaces.PartialSimInfoManager(
    filNam="/home/parallels/Documents/Documents/Huis/Metingen/data2.csv",
    incAndAziInBus={{IDEAS.Types.Tilt.Ceiling,0},{IDEAS.Types.Tilt.Wall,IDEAS.Types.Azimuth.S+ang},
                         {IDEAS.Types.Tilt.Wall,IDEAS.Types.Azimuth.W+ang},{IDEAS.Types.Tilt.Wall,IDEAS.Types.Azimuth.N+ang},{IDEAS.Types.Tilt.Wall,IDEAS.Types.Azimuth.E+ang}, {IDEAS.Types.Tilt.Floor,0}},
    weaDat(
      totSkyCovSou=IDEAS.BoundaryConditions.Types.DataSource.Input,
      computeWetBulbTemperature=false,
      TDryBulSou=IDEAS.BoundaryConditions.Types.DataSource.Input,
      relHumSou=IDEAS.BoundaryConditions.Types.DataSource.Input,
      winSpeSou=IDEAS.BoundaryConditions.Types.DataSource.Input,
      calTSky=IDEAS.BoundaryConditions.Types.SkyTemperatureCalculation.TemperaturesAndSkyCover,
      winDirSou=IDEAS.BoundaryConditions.Types.DataSource.Input,
      TDewPoiSou=IDEAS.BoundaryConditions.Types.DataSource.Input,
      ceiHeiSou=IDEAS.BoundaryConditions.Types.DataSource.Parameter,
      opaSkyCovSou=IDEAS.BoundaryConditions.Types.DataSource.Parameter,
      HInfHorSou=IDEAS.BoundaryConditions.Types.DataSource.Parameter,
      pAtmSou=IDEAS.BoundaryConditions.Types.DataSource.Input,
      HSou=IDEAS.BoundaryConditions.Types.RadiationDataSource.Input_HDirNor_HDifHor));
  parameter Modelica.SIunits.Angle ang = 0 "Rotation angle of surfaces with respect to compass, clockwise";

Modelica.Blocks.Sources.CombiTimeTable comTimTab(
    tableOnFile=true,
    tableName="tab1",
    fileName=filNam,
    columns=2:35,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-140,-40},{-120,-20}})));

  Modelica.Blocks.Sources.RealExpression relHumExp(y=relHum)
    annotation (Placement(transformation(extent={{-140,-58},{-120,-38}})));
  Modelica.Blocks.Math.Gain deg2rad(k=Modelica.Constants.pi/180)
    annotation (Placement(transformation(extent={{-118,-60},{-110,-52}})));
  Utilities.Psychrometrics.pW_X       humRat(
                         use_p_in=false)
    annotation (Placement(transformation(extent={{-120,-90},{-100,-70}})));
  Utilities.Psychrometrics.TDewPoi_pW       TDewPoi1
    annotation (Placement(transformation(extent={{-80,-90},{-60,-70}})));
  Modelica.Blocks.Routing.RealPassThrough TBlaSkyData;
  Modelica.Blocks.Math.Gain hPa(k=100) "Hectopascal to pascal"
    annotation (Placement(transformation(extent={{-116,-24},{-108,-16}})));
equation
  // Kasten and Czeplak from https://www.tandfonline.com/doi/abs/10.1080/14786450701549824
  Te = comTimTab.y[1];
  TeAv = Te;
  Tground=TdesGround;
  relHum = comTimTab.y[2]/100;
  TDewPoi = -1e5;
  Tsky = TBlaSkyData.y;
  Va = comTimTab.y[4];

  connect(TBlaSkyData.u, weaBus1.TBlaSky);
  connect(comTimTab.y[1], weaDat.TDryBul_in) annotation (Line(points={{-119,-30},
          {-110,-30},{-110,-41},{-101,-41}}, color={0,0,127}));
  connect(relHumExp.y, weaDat.relHum_in) annotation (Line(points={{-119,-48},{-101,
          -48},{-101,-45}}, color={0,0,127}));
  connect(comTimTab.y[4], weaDat.winSpe_in) annotation (Line(points={{-119,-30},
          {-110,-30},{-110,-53.9},{-101,-53.9}}, color={0,0,127}));
  connect(deg2rad.y, weaDat.winDir_in)
    annotation (Line(points={{-109.6,-56},{-101,-56}}, color={0,0,127}));
  connect(deg2rad.u, comTimTab.y[5]) annotation (Line(points={{-118.8,-56},{-119,
          -56},{-119,-30}}, color={0,0,127}));
  connect(weaDat.totSkyCov_in, comTimTab.y[6]) annotation (Line(points={{-101,-51.9},
          {-119,-51.9},{-119,-30}}, color={0,0,127}));
  connect(comTimTab.y[7], weaDat.HGloHor_in) annotation (Line(points={{-119,-30},
          {-120,-30},{-120,-63},{-101,-63}}, color={0,0,127}));
  connect(weaDat.HDirNor_in, comTimTab.y[8]) annotation (Line(points={{-101,-61},
          {-119,-61},{-119,-30}}, color={0,0,127}));
  connect(humRat.p_w, TDewPoi1.p_w)
    annotation (Line(points={{-99,-80},{-81,-80}}, color={0,0,127}));
  connect(XiEnv.X[1], humRat.X_w) annotation (Line(points={{1,30},{2,30},{2,-68},
          {-121,-68},{-121,-80}}, color={0,0,127}));
  connect(TDewPoi1.T, weaDat.TDewPoi_in) annotation (Line(points={{-59,-80},{-50,
          -80},{-50,-24},{-101,-24},{-101,-38.8}}, color={0,0,127}));
  connect(hPa.u, comTimTab.y[3]) annotation (Line(points={{-116.8,-20},{-118,
          -20},{-118,-30},{-119,-30}}, color={0,0,127}));
  connect(hPa.y, weaDat.pAtm_in) annotation (Line(points={{-107.6,-20},{-104,
          -20},{-104,-36.3},{-101,-36.3}}, color={0,0,127}));
  connect(weaDat.HDifHor_in, comTimTab.y[9]) annotation (Line(points={{-101,-57.6},
          {-119,-57.6},{-119,-30}}, color={0,0,127}));
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
