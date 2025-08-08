within IDEAS.Fluid.PVTCollectors.Validation.PVT2.BaseClasses;
block MyReaderTMY3 "Reader for TMY3 weather data"

  IDEAS.BoundaryConditions.WeatherData.Bus weaBus "Weather data bus" annotation (Placement(transformation(extent={{
            290,-10},{310,10}}), iconTransformation(extent={{190,-10},{210,10}})));

  //--------------------------------------------------------------
  parameter String filNam="" "Name of weather data file" annotation (
    Dialog(loadSelector(filter="Weather files (*.mos)",
                        caption="Select weather file")));

  parameter Boolean computeWetBulbTemperature = true
    "If true, then this model computes the wet bulb temperature"
    annotation(Evaluate=true);

  //--------------------------------------------------------------
  // Atmospheric pressure
  parameter IDEAS.BoundaryConditions.Types.DataSource pAtmSou=IDEAS.BoundaryConditions.Types.DataSource.Parameter
    "Atmospheric pressure"
    annotation (Evaluate=true, HideResult=true, Dialog(tab="Data source"));
  parameter Modelica.Units.SI.Pressure pAtm=101325
    "Atmospheric pressure (used if pAtmSou=Parameter)"
    annotation (Dialog(tab="Data source"));
  Modelica.Blocks.Interfaces.RealInput pAtm_in(
    final quantity="Pressure",
    final unit="Pa",
    displayUnit="Pa") if (pAtmSou == IDEAS.BoundaryConditions.Types.DataSource.Input)
    "Input pressure"
    annotation (Placement(transformation(extent={{-240,254},{-200,294}}),
        iconTransformation(extent={{-240,254},{-200,294}})));

  //--------------------------------------------------------------
  // Dry bulb temperature
  parameter IDEAS.BoundaryConditions.Types.DataSource TDryBulSou=IDEAS.BoundaryConditions.Types.DataSource.File
    "Dry bulb temperature"
    annotation (Evaluate=true, HideResult=true, Dialog(tab="Data source"));
  parameter Modelica.Units.SI.Temperature TDryBul(displayUnit="degC") = 293.15
    "Dry bulb temperature (used if TDryBul=Parameter)"
    annotation (Dialog(tab="Data source"));
  Modelica.Blocks.Interfaces.RealInput TDryBul_in(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") if (TDryBulSou == IDEAS.BoundaryConditions.Types.DataSource.Input)
    "Input dry bulb temperature"
    annotation (Placement(transformation(extent={{-240,160},{-200,200}})));

  //--------------------------------------------------------------
  // Dew point temperature
  parameter IDEAS.BoundaryConditions.Types.DataSource TDewPoiSou=IDEAS.BoundaryConditions.Types.DataSource.File
    "Dew point temperature"
    annotation (Evaluate=true, HideResult=true, Dialog(tab="Data source"));
  parameter Modelica.Units.SI.Temperature TDewPoi(displayUnit="degC") = 283.15
    "Dew point temperature (used if TDewPoi=Parameter)"
    annotation (Dialog(tab="Data source"));
  Modelica.Blocks.Interfaces.RealInput TDewPoi_in(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") if (TDewPoiSou == IDEAS.BoundaryConditions.Types.DataSource.Input)
    "Input dew point temperature"
    annotation (Placement(transformation(extent={{-240,204},{-200,244}})));

  //--------------------------------------------------------------
  // Black body sky temperature
  parameter IDEAS.BoundaryConditions.Types.DataSource TBlaSkySou=IDEAS.BoundaryConditions.Types.DataSource.File
    "Black-body sky temperature" annotation (Evaluate=true, HideResult=true, Dialog(tab="Data source"));
  parameter Modelica.Units.SI.Temperature TBlaSky=273.15
    "Black-body sky temperature (used if TBlaSkySou=Parameter)"
    annotation (Dialog(tab="Data source"));
  Modelica.Blocks.Interfaces.RealInput TBlaSky_in(
    final quantity="ThermodynamicTemperature",
    displayUnit="degC",
    final unit="K")
 if (TBlaSkySou == IDEAS.BoundaryConditions.Types.DataSource.Input)
    "Black-body sky temperature"
    annotation (Placement(transformation(extent={{-240,120},{-200,160}}),
        iconTransformation(extent={{-240,120},{-200,160}})));
  //--------------------------------------------------------------
  // Relative humidity
  parameter IDEAS.BoundaryConditions.Types.DataSource relHumSou=IDEAS.BoundaryConditions.Types.DataSource.File
    "Relative humidity" annotation (Evaluate=true, HideResult=true, Dialog(tab="Data source"));
  parameter Real relHum(
    min=0,
    max=1,
    unit="1") = 0.5 "Relative humidity (used if relHum=Parameter)"
    annotation (Dialog(tab="Data source"));
  Modelica.Blocks.Interfaces.RealInput relHum_in(
    min=0,
    max=1,
    unit="1") if (relHumSou == IDEAS.BoundaryConditions.Types.DataSource.Input)
    "Input relative humidity"
    annotation (Placement(transformation(extent={{-240,80},{-200,120}}),
        iconTransformation(extent={{-240,80},{-200,120}})));
  //--------------------------------------------------------------
  // Wind speed
  parameter IDEAS.BoundaryConditions.Types.DataSource winSpeSou=IDEAS.BoundaryConditions.Types.DataSource.File
    "Wind speed" annotation (Evaluate=true, HideResult=true, Dialog(tab="Data source"));
  parameter Modelica.Units.SI.Velocity winSpe(min=0) = 1
    "Wind speed (used if winSpe=Parameter)"
    annotation (Dialog(tab="Data source"));
  Modelica.Blocks.Interfaces.RealInput winSpe_in(
    final quantity="Velocity",
    final unit="m/s",
    min=0) if (winSpeSou == IDEAS.BoundaryConditions.Types.DataSource.Input)
    "Input wind speed"
    annotation (Placement(transformation(extent={{-240,-98},{-200,-58}}),
        iconTransformation(extent={{-240,-98},{-200,-58}})));
  //--------------------------------------------------------------
  // Wind direction
  parameter IDEAS.BoundaryConditions.Types.DataSource winDirSou=IDEAS.BoundaryConditions.Types.DataSource.File
    "Wind direction" annotation (Evaluate=true, HideResult=true, Dialog(tab="Data source"));
  parameter Modelica.Units.SI.Angle winDir=1.0
    "Wind direction (used if winDir=Parameter)"
    annotation (Dialog(tab="Data source"));
  Modelica.Blocks.Interfaces.RealInput winDir_in(
    final quantity="Angle",
    final unit="rad",
    displayUnit="deg") if (winDirSou == IDEAS.BoundaryConditions.Types.DataSource.Input)
    "Input wind direction"
    annotation (Placement(transformation(extent={{-240,-140},{-200,-100}}),
        iconTransformation(extent={{-240,-140},{-200,-100}})));
  //--------------------------------------------------------------
  // Infrared horizontal radiation
  parameter IDEAS.BoundaryConditions.Types.DataSource HInfHorSou=IDEAS.BoundaryConditions.Types.DataSource.File
    "Infrared horizontal radiation" annotation (Evaluate=true, HideResult=true, Dialog(tab="Data source"));
  parameter Modelica.Units.SI.HeatFlux HInfHor=0.0
    "Infrared horizontal radiation (used if HInfHorSou=Parameter)"
    annotation (Dialog(tab="Data source"));
  Modelica.Blocks.Interfaces.RealInput HInfHor_in(
    final quantity="RadiantEnergyFluenceRate",
    final unit="W/m2") if (HInfHorSou == IDEAS.BoundaryConditions.Types.DataSource.Input)
    "Input infrared horizontal radiation"
    annotation (Placement(transformation(extent={{-240,-180},{-200,-140}}),
        iconTransformation(extent={{-240,-180},{-200,-140}})));

   parameter IDEAS.BoundaryConditions.Types.RadiationDataSource HSou=IDEAS.BoundaryConditions.Types.RadiationDataSource.Input_HDirNor_HGloHor
    "Global, diffuse, and direct normal radiation"
     annotation (Evaluate=true, HideResult=true, Dialog(tab="Data source"));
  //--------------------------------------------------------------
  // Global horizontal radiation
  Modelica.Blocks.Interfaces.RealInput HGloHor_in(
    final quantity="RadiantEnergyFluenceRate",
    final unit="W/m2")
      if (HSou == IDEAS.BoundaryConditions.Types.RadiationDataSource.Input_HGloHor_HDifHor or
          HSou == IDEAS.BoundaryConditions.Types.RadiationDataSource.Input_HDirNor_HGloHor)
    "Input global horizontal radiation"
    annotation (Placement(transformation(extent={{-240,-320},{-200,-280}}),
        iconTransformation(extent={{-240,-280},{-200,-240}})));
  //--------------------------------------------------------------
  // Diffuse horizontal radiation
  Modelica.Blocks.Interfaces.RealInput HDifHor_in(
    final quantity="RadiantEnergyFluenceRate",
    final unit="W/m2")
      if (HSou == IDEAS.BoundaryConditions.Types.RadiationDataSource.Input_HGloHor_HDifHor or
          HSou == IDEAS.BoundaryConditions.Types.RadiationDataSource.Input_HDirNor_HDifHor)
    "Input diffuse horizontal radiation"
    annotation (Placement(transformation(extent={{-240,-240},{-200,-200}}),
        iconTransformation(extent={{-240,-210},{-200,-170}})));
  //--------------------------------------------------------------
  // Direct normal radiation
  Modelica.Blocks.Interfaces.RealInput HDirNor_in(final quantity="RadiantEnergyFluenceRate",
      final unit="W/m2")
      if (HSou == IDEAS.BoundaryConditions.Types.RadiationDataSource.Input_HDirNor_HDifHor or
          HSou == IDEAS.BoundaryConditions.Types.RadiationDataSource.Input_HDirNor_HGloHor)
    "Input direct normal radiation"
    annotation (Placement(transformation(extent={{-240,-280},{-200,-240}}),
        iconTransformation(extent={{-240,-240},{-200,-200}})));

//--------------------------------------------------------------
  // Ceiling height
  parameter IDEAS.BoundaryConditions.Types.DataSource ceiHeiSou=IDEAS.BoundaryConditions.Types.DataSource.File
    "Ceiling height" annotation (Evaluate=true, HideResult=true, Dialog(tab="Data source"));
  parameter Real ceiHei(
    final quantity="Height",
    final unit="m",
    displayUnit="m") = 20000 "Ceiling height (used if ceiHei=Parameter)"
    annotation (Dialog(tab="Data source"));
  Modelica.Blocks.Interfaces.RealInput ceiHei_in(
    final quantity="Height",
    final unit="m",
    displayUnit="m") if (ceiHeiSou == IDEAS.BoundaryConditions.Types.DataSource.Input)
    "Input ceiling height"
    annotation (Placement(transformation(extent={{-240,-10},{-200,30}}),
        iconTransformation(extent={{-240,-10},{-200,30}})));
  //--------------------------------------------------------------
  // Total sky cover
  parameter IDEAS.BoundaryConditions.Types.DataSource totSkyCovSou=IDEAS.BoundaryConditions.Types.DataSource.File
    "Total sky cover" annotation (Evaluate=true, HideResult=true, Dialog(tab="Data source"));
  parameter Real totSkyCov(
    min=0,
    max=1,
    unit="1") = 0.5
    "Total sky cover (used if totSkyCov=Parameter). Use 0 <= totSkyCov <= 1"
    annotation (Dialog(tab="Data source"));
  Modelica.Blocks.Interfaces.RealInput totSkyCov_in(
    min=0,
    max=1,
    unit="1") if (totSkyCovSou == IDEAS.BoundaryConditions.Types.DataSource.Input)
    "Input total sky cover"
    annotation (Placement(transformation(extent={{-240,-58},{-200,-18}}),
        iconTransformation(extent={{-240,-58},{-200,-18}})));
  // Opaque sky cover
  parameter IDEAS.BoundaryConditions.Types.DataSource opaSkyCovSou=IDEAS.BoundaryConditions.Types.DataSource.File
    "Opaque sky cover" annotation (Evaluate=true, HideResult=true, Dialog(tab="Data source"));
  parameter Real opaSkyCov(
    min=0,
    max=1,
    unit="1") = 0.5
    "Opaque sky cover (used if opaSkyCov=Parameter). Use 0 <= opaSkyCov <= 1"
    annotation (Dialog(tab="Data source"));
  Modelica.Blocks.Interfaces.RealInput opaSkyCov_in(
    min=0,
    max=1,
    unit="1") if (opaSkyCovSou == IDEAS.BoundaryConditions.Types.DataSource.Input)
    "Input opaque sky cover"
    annotation (Placement(transformation(extent={{-240,32},{-200,72}}),
        iconTransformation(extent={{-240,32},{-200,72}})));

  parameter IDEAS.BoundaryConditions.Types.SkyTemperatureCalculation
    calTSky=IDEAS.BoundaryConditions.Types.SkyTemperatureCalculation.TemperaturesAndSkyCover
    "Model choice for black-body sky temperature calculation" annotation (
    choicesAllMatching=true,
    Evaluate=true,
    Dialog(tab="Advanced", group="Sky temperature"));

  final parameter Modelica.Units.SI.Angle lon(displayUnit="deg") =
    IDEAS.BoundaryConditions.WeatherData.BaseClasses.getLongitudeTMY3(filNam)
    "Longitude";
  final parameter Modelica.Units.SI.Angle lat(displayUnit="deg") =
    IDEAS.BoundaryConditions.WeatherData.BaseClasses.getLatitudeTMY3(filNam)
    "Latitude";
  final parameter Modelica.Units.SI.Time timZon(displayUnit="h") =
    IDEAS.BoundaryConditions.WeatherData.BaseClasses.getTimeZoneTMY3(filNam)
    "Time zone";
  final parameter Modelica.Units.SI.Length alt(displayUnit="m") =
    IDEAS.BoundaryConditions.WeatherData.BaseClasses.getAltitudeLocationTMY3(
    filNam) "Location altitude above sea level";

protected
  final parameter Modelica.Units.SI.Time[2] timeSpan=
      IDEAS.BoundaryConditions.WeatherData.BaseClasses.getTimeSpanTMY3(filNam,
      "tab1") "Start time, end time of weather data";

  Modelica.Blocks.Tables.CombiTable1Ds datRea(
    final tableOnFile=true,
    final tableName="tab1",
    final fileName=filNam,
    verboseRead=false,
    final smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    final columns={2,3,4,5,6,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,
        28,29,30,8}) "Data reader"
    annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));

  IDEAS.BoundaryConditions.WeatherData.BaseClasses.SourceSelector pAtmSel(
    final datSou=pAtmSou,
    final p=pAtm) "Source selection for atmospheric pressure"
    annotation (Placement(transformation(extent={{0,260},{20,280}})));
  IDEAS.BoundaryConditions.WeatherData.BaseClasses.SourceSelector TDewPoiSel(
    final datSou=TDewPoiSou,
    final p=TDewPoi)
    "Source selection for dewpoint temperature pressure"
    annotation (Placement(transformation(extent={{92,-240},{112,-220}})));
  IDEAS.BoundaryConditions.WeatherData.BaseClasses.SourceSelector TDryBulSel(
    final datSou=TDryBulSou,
    final p=TDryBul)
    "Source selection for drybulb temperature pressure"
    annotation (Placement(transformation(extent={{92,-200},{112,-180}})));
  IDEAS.BoundaryConditions.WeatherData.BaseClasses.SourceSelector TBlaSkySel(
    final datSou=TBlaSkySou,
    final p=TBlaSky)
    "Source selection for sky black body radiation"
    annotation (Placement(transformation(extent={{240,-180},{260,-160}})));
  IDEAS.BoundaryConditions.WeatherData.BaseClasses.SourceSelector relHumSel(
    final datSou=relHumSou,
    final p=relHum)
    "Source selection for relative humidity"
    annotation (Placement(transformation(extent={{120,20},{140,40}})));
  IDEAS.BoundaryConditions.WeatherData.BaseClasses.SourceSelector opaSkyCovSel(
    final datSou=opaSkyCovSou,
    final p=opaSkyCov)
    "Source selection for opaque sky cover"
    annotation (Placement(transformation(extent={{120,-160},{140,-140}})));
  IDEAS.BoundaryConditions.WeatherData.BaseClasses.SourceSelector ceiHeiSel(
    final datSou=ceiHeiSou,
    final p=ceiHei)
    "Source selection for ceiling height"
    annotation (Placement(transformation(extent={{120,-120},{140,-100}})));
  IDEAS.BoundaryConditions.WeatherData.BaseClasses.SourceSelector totSkyCovSel(
    final datSou=totSkyCovSou,
    final p=totSkyCov)
    "Source selection for total sky cover"
    annotation (Placement(transformation(extent={{120,-40},{140,-20}})));
  IDEAS.BoundaryConditions.WeatherData.BaseClasses.SourceSelector winSpeSel(
    final datSou=winSpeSou,
    final p=winSpe)
    "Source selection for wind speed"
    annotation (Placement(transformation(extent={{120,-80},{140,-60}})));
  IDEAS.BoundaryConditions.WeatherData.BaseClasses.SourceSelector winDirSel(
    final datSou=winDirSou,
    final p=winDir)
    "Source selection for wind speed"
    annotation (Placement(transformation(extent={{120,-280},{140,-260}})));
  IDEAS.BoundaryConditions.WeatherData.BaseClasses.SourceSelector horInfRadSel(
    final datSou=HInfHorSou,
    final p=HInfHor)
    "Source selection for horizontal infrared radiation"
    annotation (Placement(transformation(extent={{120,60},{140,80}})));
  IDEAS.BoundaryConditions.WeatherData.BaseClasses.SourceSelectorRadiation souSelRad(
    final datSou=HSou)
    "Source selection for solar irradiation"
    annotation (Placement(transformation(extent={{120,180},{140,200}})));

  IDEAS.BoundaryConditions.WeatherData.BaseClasses.CheckDryBulbTemperature
    cheTemDryBul "Check dry bulb temperature "
    annotation (Placement(transformation(extent={{160,-200},{180,-180}})));
  IDEAS.BoundaryConditions.WeatherData.BaseClasses.CheckDewPointTemperature
    cheTemDewPoi "Check dew point temperature"
    annotation (Placement(transformation(extent={{160,-240},{180,-220}})));
  Modelica.Blocks.Math.Gain conRelHum(final k=0.01)
    if relHumSou == IDEAS.BoundaryConditions.Types.DataSource.File
    "Convert the relative humidity from percentage to [0, 1] "
    annotation (Placement(transformation(extent={{40,14},{60,34}})));
  IDEAS.BoundaryConditions.WeatherData.BaseClasses.CheckPressure chePre "Check the air pressure"
    annotation (Placement(transformation(extent={{160,260},{180,280}})));
  IDEAS.BoundaryConditions.WeatherData.BaseClasses.LimiterRelativeHumidity limRelHum
    "Limiter for relative humidity"
    annotation (Placement(transformation(extent={{160,20},{180,40}})));
  IDEAS.BoundaryConditions.WeatherData.BaseClasses.LimiterTotalSkyCover limTotSkyCov
    "Limits the total sky cover"
    annotation (Placement(transformation(extent={{160,-40},{180,-20}})));
  IDEAS.BoundaryConditions.WeatherData.BaseClasses.LimiterOpaqueSkyCover limOpaSkyCov
    "Limits the opaque sky cover"
    annotation (Placement(transformation(extent={{160,-160},{180,-140}})));
  IDEAS.BoundaryConditions.WeatherData.BaseClasses.LimiterCeilingHeight limCeiHei "Limits the ceiling height"
    annotation (Placement(transformation(extent={{160,-120},{180,-100}})));
  IDEAS.BoundaryConditions.WeatherData.BaseClasses.LimiterWindSpeed limWinSpe "Limits the wind speed"
    annotation (Placement(transformation(extent={{160,-80},{180,-60}})));
  IDEAS.BoundaryConditions.WeatherData.BaseClasses.LimiterHorizontalInfraredIrradiation limHorInfRad
    "Limits the horizontal infrared irradiation"
    annotation (Placement(transformation(extent={{160,60},{180,80}})));
  IDEAS.BoundaryConditions.WeatherData.BaseClasses.LimiterWindDirection limWinDir
    "Limits the wind direction"
    annotation (Placement(transformation(extent={{160,-280},{180,-260}})));
  IDEAS.BoundaryConditions.SkyTemperature.BlackBody TBlaSkyCom(final calTSky=calTSky)
    if TBlaSkySou == IDEAS.BoundaryConditions.Types.DataSource.File
    "Computation of the black-body sky temperature"
    annotation (Placement(transformation(extent={{240,-220},{260,-200}})));
  IDEAS.Utilities.Time.ModelTime modTim "Model time"
    annotation (Placement(transformation(extent={{-160,-10},{-140,10}})));
  Modelica.Blocks.Math.Add add30Min
    "Add 30 minutes to time to shift weather data reader"
    annotation (Placement(transformation(extent={{-112,180},{-92,200}})));
  Modelica.Blocks.Sources.Constant con30Min(final k=2.5)
    "Constant used to shift weather data reader"
    annotation (Placement(transformation(extent={{-160,186},{-140,206}})));
  IDEAS.BoundaryConditions.WeatherData.BaseClasses.LocalCivilTime locTim(
      final lon=lon, final timZon=timZon) "Local civil time"
    annotation (Placement(transformation(extent={{-120,-160},{-100,-140}})));
  Modelica.Blocks.Tables.CombiTable1Ds datRea30Min(
    final tableOnFile=true,
    final tableName="tab1",
    final fileName=filNam,
    verboseRead=false,
    final smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    final columns=9:11) "Data reader with 30 min offset for solar irradiation"
    annotation (Placement(transformation(extent={{-50,180},{-30,200}})));
  IDEAS.BoundaryConditions.WeatherData.BaseClasses.ConvertTime conTimMin(final
      weaDatStaTim=timeSpan[1], final weaDatEndTim=timeSpan[2])
    "Convert simulation time to calendar time"
    annotation (Placement(transformation(extent={{-80,180},{-60,200}})));
  IDEAS.BoundaryConditions.WeatherData.BaseClasses.ConvertTime conTim(
    final weaDatStaTim = timeSpan[1],
    final weaDatEndTim = timeSpan[2])
    "Convert simulation time to calendar time"
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  IDEAS.BoundaryConditions.WeatherData.BaseClasses.EquationOfTime eqnTim "Equation of time"
    annotation (Placement(transformation(extent={{-120,-120},{-100,-100}})));
  IDEAS.BoundaryConditions.WeatherData.BaseClasses.SolarTime solTim "Solar time"
    annotation (Placement(transformation(extent={{-88,-140},{-68,-120}})));

  Modelica.Blocks.Math.UnitConversions.From_deg conWinDir
    "Convert the wind direction unit from [deg] to [rad]"
    annotation (Placement(transformation(extent={{40,-286},{60,-266}})));
  Modelica.Blocks.Math.UnitConversions.From_degC conTDryBul
    annotation (Placement(transformation(extent={{40,-200},{60,-180}})));

  Modelica.Blocks.Math.UnitConversions.From_degC conTDewPoi
    "Convert the dew point temperature form [degC] to [K]"
    annotation (Placement(transformation(extent={{40,-240},{60,-220}})));
  IDEAS.BoundaryConditions.SolarGeometry.BaseClasses.AltitudeAngle altAng "Solar altitude angle"
    annotation (Placement(transformation(extent={{-28,-226},{-8,-206}})));
   IDEAS.BoundaryConditions.SolarGeometry.BaseClasses.ZenithAngle zenAng
                      "Zenith angle"
    annotation (Placement(transformation(extent={{-70,-226},{-50,-206}})));
   IDEAS.BoundaryConditions.SolarGeometry.BaseClasses.Declination decAng "Declination angle"
    annotation (Placement(transformation(extent={{-120,-220},{-100,-200}})));
   IDEAS.BoundaryConditions.SolarGeometry.BaseClasses.SolarHourAngle
    solHouAng "Solar hour angle"
    annotation (Placement(transformation(extent={{-120,-250},{-100,-230}})));
  Latitude latitude(final latitude=lat) "Latitude"
    annotation (Placement(transformation(extent={{-150,-290},{-130,-270}})));
  Longitude longitude(final longitude=lon) "Longitude"
    annotation (Placement(transformation(extent={{-120,-282},{-100,-262}})));
  Altitude altitude(final Altitude=alt) "Altitude"
    annotation (Placement(transformation(extent={{226,94},{246,114}})));
  //---------------------------------------------------------------------------
  // Optional instanciation of a block that computes the wet bulb temperature.
  // This block may be needed for evaporative cooling towers.
  // By default, it is enabled. This introduces a nonlinear equation, but
  // we have not observed an increase in computing time because of this equation.
  IDEAS.Utilities.Psychrometrics.TWetBul_TDryBulPhi tWetBul_TDryBulXi(
      redeclare package Medium = IDEAS.Media.Air,
      TDryBul(displayUnit="degC")) if computeWetBulbTemperature
    annotation (Placement(transformation(extent={{240,-60},{260,-40}})));

  //---------------------------------------------------------------------------
  // Conversion blocks for sky cover
  Modelica.Blocks.Math.Gain conTotSkyCov(final k=0.1)
    if totSkyCovSou == IDEAS.BoundaryConditions.Types.DataSource.File
    "Convert sky cover from [0...10] to [0...1]"
    annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
  Modelica.Blocks.Math.Gain conOpaSkyCov(final k=0.1)
    if opaSkyCovSou == IDEAS.BoundaryConditions.Types.DataSource.File
    "Convert sky cover from [0...10] to [0...1]"
    annotation (Placement(transformation(extent={{40,-166},{60,-146}})));
  IDEAS.BoundaryConditions.WeatherData.BaseClasses.CheckBlackBodySkyTemperature cheTemBlaSky(TMin=0)
    "Check black body sky temperature"
    annotation (Placement(transformation(extent={{240,-140},{260,-120}})));

  // Blocks that are added in order to set the name of the output signal,
  // which then is displayed in the GUI of the weather data connector.
  block Latitude "Generate constant signal of type Real"
    extends Modelica.Blocks.Icons.Block;

    parameter Modelica.Units.SI.Angle latitude "Latitude";

    Modelica.Blocks.Interfaces.RealOutput y(
      unit="rad",
      displayUnit="deg") "Latitude of the location"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  equation
    y = latitude;
    annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-81,32},{84,-24}},
          textColor={0,0,0},
            textString="Latitude")}),
    Documentation(info="<html>
<p>
Block to output the latitude of the location.
This block is added so that the latitude is displayed
with a comment in the GUI of the weather bus connector.
</p>
<h4>Implementation</h4>
<p>
If
<a href=\"modelica://Modelica.Blocks.Sources.Constant\">
Modelica.Blocks.Sources.Constant</a> where used, then
the comment for the latitude would be \"Connector of Real output signal\".
As this documentation string cannot be overwritten, a new block
was implemented.
</p>
</html>", revisions="<html>
<ul>
<li>
January 4, 2016, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
  end Latitude;

  block Longitude "Generate constant signal of type Real"
    extends Modelica.Blocks.Icons.Block;

    parameter Modelica.Units.SI.Angle longitude "Longitude";

    Modelica.Blocks.Interfaces.RealOutput y(
      unit="rad",
      displayUnit="deg") "Longitude of the location"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  equation
    y = longitude;
    annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-81,32},{84,-24}},
          textColor={0,0,0},
            textString="Longitude")}),
    Documentation(info="<html>
<p>
Block to output the longitude of the location.
This block is added so that the longitude is displayed
with a comment in the GUI of the weather bus connector.
</p>
<h4>Implementation</h4>
<p>
If
<a href=\"modelica://Modelica.Blocks.Sources.Constant\">
Modelica.Blocks.Sources.Constant</a> where used, then
the comment for the longitude would be \"Connector of Real output signal\".
As this documentation string cannot be overwritten, a new block
was implemented.
</p>
</html>", revisions="<html>
<ul>
<li>
January 4, 2016, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
  end Longitude;

  block Altitude "Generate constant signal of type Real"
    extends Modelica.Blocks.Icons.Block;

    parameter Modelica.Units.SI.Length Altitude
      "Location altitude above sea level";

    Modelica.Blocks.Interfaces.RealOutput y(
      unit="m") "Location altitude above sea level"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  equation
    y = Altitude;
    annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-81,32},{84,-24}},
          textColor={0,0,0},
            textString="Altitude")}),
    Documentation(info="<html>
<p>
Block to output the altitude of the location.
This block is added so that the altitude is displayed
with a comment in the GUI of the weather bus connector.
</p>
<h4>Implementation</h4>
<p>
If
<a href=\"modelica://Modelica.Blocks.Sources.Constant\">
Modelica.Blocks.Sources.Constant</a> where used, then
the comment for the Altitude would be \"Connector of Real output signal\".
As this documentation string cannot be overwritten, a new block
was implemented.
</p>
</html>", revisions="<html>
<ul>
<li>
May 2, 2021, by Ettore Zanetti:<br/>
First implementation.
</li>
</ul>
</html>"));
  end Altitude;
equation

  connect(modTim.y, add30Min.u2) annotation (Line(points={{-139,0},{-128,0},{-128,
          184},{-114,184}}, color={0,0,127}));
  connect(con30Min.y, add30Min.u1)
    annotation (Line(points={{-139,196},{-114,196}}, color={0,0,127}));
  connect(add30Min.y, conTimMin.modTim)
    annotation (Line(points={{-91,190},{-82,190}}, color={0,0,127}));
  connect(conTimMin.calTim, datRea30Min.u)
    annotation (Line(points={{-59,190},{-52,190}}, color={0,0,127}));
  connect(modTim.y, locTim.cloTim) annotation (Line(
      points={{-139,6.10623e-16},{-128,6.10623e-16},{-128,-150},{-122,-150}},
      color={0,0,127}));
  connect(modTim.y, conTim.modTim) annotation (Line(
      points={{-139,6.10623e-16},{-128,6.10623e-16},{-128,-30},{-102,-30}},
      color={0,0,127}));
  connect(conTim.calTim, datRea.u) annotation (Line(
      points={{-79,-30},{-72,-30}},
      color={0,0,127}));
  connect(modTim.y, eqnTim.nDay) annotation (Line(
      points={{-139,6.10623e-16},{-128,6.10623e-16},{-128,-110},{-122,-110}},
      color={0,0,127}));
  connect(eqnTim.eqnTim, solTim.equTim) annotation (Line(
      points={{-99,-110},{-94,-110},{-94,-124},{-90,-124}},
      color={0,0,127}));
  connect(locTim.locTim, solTim.locTim) annotation (Line(
      points={{-99,-150},{-96,-150},{-96,-135.4},{-90,-135.4}},
      color={0,0,127}));
  connect(datRea.y[11], conWinDir.u) annotation (Line(
      points={{-49,-30},{20,-30},{20,-276},{38,-276}},
      color={0,0,127}));
  connect(datRea.y[1], conTDryBul.u) annotation (Line(
      points={{-49,-30},{20,-30},{20,-190},{38,-190}},
      color={0,0,127}));
  connect(datRea.y[2], conTDewPoi.u) annotation (Line(
      points={{-49,-30},{20,-30},{20,-230},{38,-230}},
      color={0,0,127}));
  connect(conRelHum.u, datRea.y[3]) annotation (Line(points={{38,24},{20,24},{20,
          -30},{-49,-30}},    color={0,0,127}));

  connect(decAng.decAng, zenAng.decAng)
                                  annotation (Line(
      points={{-99,-210},{-72,-210},{-72,-210.6}},
      color={0,0,127}));
  connect(solHouAng.solHouAng, zenAng.solHouAng)  annotation (Line(
      points={{-99,-240},{-80,-240},{-80,-220.8},{-72,-220.8}},
      color={0,0,127}));
  connect(solHouAng.solTim, solTim.solTim) annotation (Line(
      points={{-122,-240},{-140,-240},{-140,-174},{-10,-174},{-10,-130},{-67,-130}},
      color={0,0,127}));
  connect(decAng.nDay, modTim.y) annotation (Line(
      points={{-122,-210},{-134,-210},{-134,-180},{0,-180},{0,6.10623e-16},{-139,
          6.10623e-16}},
      color={0,0,127}));
  connect(zenAng.zen, altAng.zen) annotation (Line(
      points={{-49,-216},{-30,-216}},
      color={0,0,127}));

  connect(limOpaSkyCov.nOpa, TBlaSkyCom.nOpa) annotation (Line(points={{181,-150},
          {220,-150},{220,-213},{238,-213}}, color={0,0,127}));
  connect(limRelHum.relHum, tWetBul_TDryBulXi.phi) annotation (Line(points={{181,30},
          {220,30},{220,-50},{239,-50}}, color={0,0,127}));

  connect(pAtmSel.y, chePre.PIn)
    annotation (Line(points={{21,270},{158,270}},   color={0,0,127}));
  connect(pAtmSel.uCon, pAtm_in) annotation (Line(points={{-1,278},{-110,278},{-110,
          274},{-220,274}}, color={0,0,127}));
  connect(datRea.y[4], pAtmSel.uFil) annotation (Line(points={{-49,-30},{-20,-30},
          {-20,262},{-1,262}}, color={0,0,127}));
  connect(cheTemDewPoi.TIn, TDewPoiSel.y)
    annotation (Line(points={{158,-230},{113,-230}}, color={0,0,127}));
  connect(TDewPoiSel.uFil, conTDewPoi.y) annotation (Line(points={{91,-238},{76,
          -238},{76,-230},{61,-230}}, color={0,0,127}));
  connect(TDewPoiSel.uCon, TDewPoi_in) annotation (Line(points={{91,-222},{82,-222},
          {82,146},{-168,146},{-168,224},{-220,224}}, color={0,0,127}));
  connect(TDryBulSel.y, cheTemDryBul.TIn)
    annotation (Line(points={{113,-190},{158,-190}}, color={0,0,127}));
  connect(TDryBulSel.uFil, conTDryBul.y) annotation (Line(points={{91,-198},{70,
          -198},{70,-190},{61,-190}}, color={0,0,127}));
  connect(TDryBulSel.uCon, TDryBul_in) annotation (Line(points={{91,-182},{78,-182},
          {78,142},{-176,142},{-176,180},{-220,180}}, color={0,0,127}));

  connect(TBlaSkySel.y, cheTemBlaSky.TIn) annotation (Line(points={{261,-170},{270,
          -170},{270,-148},{230,-148},{230,-130},{238,-130}}, color={0,0,127}));
  connect(TBlaSkyCom.TBlaSky, TBlaSkySel.uFil) annotation (Line(points={{261,-210},
          {268,-210},{268,-186},{232,-186},{232,-178},{239,-178}}, color={0,0,127}));
  connect(TBlaSky_in, TBlaSkySel.uCon) annotation (Line(points={{-220,140},{74,140},
          {74,-168},{228,-168},{228,-162},{239,-162}}, color={0,0,127}));
  connect(relHumSel.y, limRelHum.u)
    annotation (Line(points={{141,30},{158,30}}, color={0,0,127}));
  connect(relHumSel.uFil, conRelHum.y)
    annotation (Line(points={{119,22},{90,22},{90,24},{61,24}},
                                                 color={0,0,127}));
  connect(relHum_in, relHumSel.uCon) annotation (Line(points={{-220,100},{110,100},
          {110,38},{119,38}}, color={0,0,127}));
  connect(conOpaSkyCov.y, opaSkyCovSel.uFil)
    annotation (Line(points={{61,-156},{90,-156},{90,-158},{119,-158}},
                                                    color={0,0,127}));
  connect(opaSkyCov_in, opaSkyCovSel.uCon) annotation (Line(points={{-220,52},{70,
          52},{70,-142},{119,-142}}, color={0,0,127}));
  connect(ceiHeiSel.y, limCeiHei.u)
    annotation (Line(points={{141,-110},{158,-110}}, color={0,0,127}));
  connect(ceiHeiSel.uFil, datRea.y[16]) annotation (Line(points={{119,-118},{20,
          -118},{20,-30},{-49,-30}}, color={0,0,127}));
  connect(ceiHeiSel.uCon, ceiHei_in) annotation (Line(points={{119,-102},{-40,-102},
          {-40,-90},{-180,-90},{-180,10},{-220,10}}, color={0,0,127}));
  connect(totSkyCovSel.uFil, conTotSkyCov.y) annotation (Line(points={{119,-38},
          {100,-38},{100,-30},{61,-30}}, color={0,0,127}));
  connect(totSkyCovSel.uCon, totSkyCov_in) annotation (Line(points={{119,-22},{108,
          -22},{108,-50},{-190,-50},{-190,-38},{-220,-38}}, color={0,0,127}));
  connect(totSkyCovSel.y, limTotSkyCov.u)
    annotation (Line(points={{141,-30},{158,-30}}, color={0,0,127}));
  connect(winSpeSel.y, limWinSpe.u)
    annotation (Line(points={{141,-70},{158,-70}}, color={0,0,127}));
  connect(conTotSkyCov.u, datRea.y[13])
    annotation (Line(points={{38,-30},{-49,-30}}, color={0,0,127}));
  connect(winSpeSel.uFil, datRea.y[12]) annotation (Line(points={{119,-78},{-20,
          -78},{-20,-30},{-49,-30}}, color={0,0,127}));
  connect(winSpeSel.uCon, winSpe_in) annotation (Line(points={{119,-62},{-190,-62},
          {-190,-78},{-220,-78}}, color={0,0,127}));
  connect(winDirSel.y, limWinDir.u)
    annotation (Line(points={{141,-270},{158,-270}}, color={0,0,127}));
  connect(conWinDir.y, winDirSel.uFil)
    annotation (Line(points={{61,-276},{90,-276},{90,-278},{119,-278}},
                                                    color={0,0,127}));
  connect(winDirSel.uCon, winDir_in) annotation (Line(points={{119,-262},{66,-262},
          {66,-80},{-190,-80},{-190,-120},{-220,-120}}, color={0,0,127}));
  connect(conOpaSkyCov.u, datRea.y[14]) annotation (Line(points={{38,-156},{20,-156},
          {20,-30},{-49,-30}},       color={0,0,127}));
  connect(horInfRadSel.y, limHorInfRad.u) annotation (Line(points={{141,70},{158,
          70}},                      color={0,0,127}));
  connect(horInfRadSel.uFil, datRea.y[26]) annotation (Line(points={{119,62},{20,
          62},{20,-30},{-49,-30}},  color={0,0,127}));
  connect(horInfRadSel.uCon, HInfHor_in) annotation (Line(points={{119,78},{-174,
          78},{-174,-160},{-220,-160}},  color={0,0,127}));

  connect(souSelRad.HDifHorFil, datRea30Min.y[3]) annotation (Line(points={{119,199},
          {44,199},{44,190},{-29,190}}, color={0,0,127}));
  connect(souSelRad.HDifHorIn, HDifHor_in) annotation (Line(points={{119,196},{
          98,196},{98,166},{-170,166},{-170,-220},{-220,-220}},
                                                             color={0,0,127}));
  connect(souSelRad.HDirNorFil, datRea30Min.y[2]) annotation (Line(points={{119,192},
          {44,192},{44,190},{-29,190}}, color={0,0,127}));
  connect(souSelRad.HDirNorIn, HDirNor_in) annotation (Line(points={{119,188},{
          100,188},{100,160},{-168,160},{-168,-260},{-220,-260}},
                                                              color={0,0,127}));
  connect(souSelRad.HGloHorIn, HGloHor_in) annotation (Line(points={{119,181},{
          102,181},{102,156},{-164,156},{-164,-300},{-220,-300}},
                                                              color={0,0,127}));
  connect(souSelRad.zen, zenAng.zen) annotation (Line(points={{124,179},{124,
          152},{-40,152},{-40,-216},{-49,-216}},
                                            color={0,0,127}));
  connect(souSelRad.HGloHorFil, datRea30Min.y[1]) annotation (Line(points={{119,
          184},{44,184},{44,190},{-29,190}}, color={0,0,127}));

  connect(TBlaSkyCom.HHorIR, limHorInfRad.HHorIR) annotation (Line(points={{238,
          -218},{220,-218},{220,70},{181,70}}, color={0,0,127}));

  connect(opaSkyCovSel.y, limOpaSkyCov.u)
    annotation (Line(points={{141,-150},{158,-150}}, color={0,0,127}));
  connect(cheTemDryBul.TDryBul, TBlaSkyCom.TDryBul) annotation (Line(points={{
          181,-190},{220,-190},{220,-202},{238,-202}}, color={0,0,127}));
  connect(cheTemDryBul.TDryBul, tWetBul_TDryBulXi.TDryBul) annotation (Line(
        points={{181,-190},{220,-190},{220,-42},{239,-42}}, color={0,0,127}));

  connect(chePre.pAtm, tWetBul_TDryBulXi.p) annotation (Line(points={{181,270},
          {220,270},{220,-58},{239,-58}}, color={0,0,127}));

  connect(cheTemDewPoi.TDewPoi, TBlaSkyCom.TDewPoi) annotation (Line(points={{
          181,-230},{220,-230},{220,-207},{238,-207}}, color={0,0,127}));

  // Connections to weather data bus
  connect(cheTemDryBul.TDryBul, weaBus.TDryBul) annotation (Line(points={{181,-190},
          {220,-190},{220,0.05},{300.05,0.05}},
                                             color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(cheTemDewPoi.TDewPoi, weaBus.TDewPoi) annotation (Line(points={{181,-230},
          {280,-230},{280,0.05},{300.05,0.05}},
                                             color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(tWetBul_TDryBulXi.TWetBul, weaBus.TWetBul) annotation (Line(
      points={{261,-50},{280,-50},{280,0.05},{300.05,0.05}},
      color={0,0,127}), Text(
      textString="%second",
      index=1,
      extent={{6,3},{6,3}}));

  connect(limRelHum.relHum, weaBus.relHum) annotation (Line(points={{181,30},{280,
          30},{280,0.05},{300.05,0.05}},
                            color={0,0,127}), Text(
      textString="%second",
      index=1,
      extent={{6,3},{6,3}}));

  connect(souSelRad.HDirNor, weaBus.HDirNor) annotation (Line(points={{141,190},
          {220,190},{220,0.05},{300.05,0.05}},
                                      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(souSelRad.HDifHor, weaBus.HDifHor) annotation (Line(points={{141,197.8},
          {220,197.8},{220,0.05},{300.05,0.05}},
                                        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(souSelRad.HGloHor, weaBus.HGloHor) annotation (Line(points={{141,182},
          {220,182},{220,0.05},{300.05,0.05}},
                                      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(cheTemBlaSky.TBlaSky, weaBus.TBlaSky) annotation (Line(points={{261,-130},
          {280,-130},{280,0.05},{300.05,0.05}},
                                             color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(limHorInfRad.HHorIR, weaBus.HHorIR) annotation (Line(points={{181,70},
          {220,70},{220,0.05},{300.05,0.05}},
                                     color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(limWinSpe.winSpe, weaBus.winSpe) annotation (Line(points={{181,-70},{220,
          -70},{220,0.05},{300.05,0.05}},
                                 color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(limWinDir.winDir, weaBus.winDir) annotation (Line(points={{181,-270},{
          280,-270},{280,0.05},{300.05,0.05}},
                                  color={0,0,127}), Text(
      textString="%second",
      index=1,
      extent={{6,3},{6,3}}));

  connect(limCeiHei.ceiHei, weaBus.ceiHei) annotation (Line(points={{181,-110},{
          220,-110},{220,0.05},{300.05,0.05}},
                                      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(limTotSkyCov.nTot, weaBus.nTot) annotation (Line(points={{181,-30},{220,
          -30},{220,0.05},{300.05,0.05}},
                                 color={0,0,127}), Text(
      textString="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(limOpaSkyCov.nOpa, weaBus.nOpa) annotation (Line(points={{181,-150},{220,
          -150},{220,0.05},{300.05,0.05}},
                                  color={0,0,127}), Text(
      textString="%second",
      index=1,
      extent={{6,3},{6,3}}));

  connect(modTim.y, weaBus.cloTim) annotation (Line(
      points={{-139,0},{34.75,0},{34.75,0.05},{300.05,0.05}},
      color={0,0,127}), Text(
      textString="%second",
      index=1,
      extent={{6,3},{6,3}}));

  connect(solTim.solTim, weaBus.solTim) annotation (Line(
      points={{-67,-130},{-10,-130},{-10,0.05},{300.05,0.05}},
      color={0,0,127}), Text(
      textString="%second",
      index=1,
      extent={{6,3},{6,3}}));

  connect(altAng.alt, weaBus.solAlt) annotation (Line(
      points={{-7,-216},{0,-216},{0,-290},{290,-290},{290,0.05},{300.05,0.05}},
      color={0,0,127}));
  connect(zenAng.zen, weaBus.solZen) annotation (Line(
      points={{-49,-216},{-40,-216},{-40,-290},{290,-290},{290,0.05},{300.05,0.05}},
      color={0,0,127}));
  connect(decAng.decAng, weaBus.solDec) annotation (Line(
      points={{-99,-210},{-90,-210},{-90,-290},{290,-290},{290,0.05},{300.05,0.05}},
      color={0,0,127}));
  connect(solHouAng.solHouAng, weaBus.solHouAng) annotation (Line(
      points={{-99,-240},{-90,-240},{-90,-290},{290,-290},{290,0.05},{300.05,0.05}},
      color={0,0,127}));
  connect(longitude.y, weaBus.lon) annotation (Line(
      points={{-99,-272},{-90,-272},{-90,-290},{290,-290},{290,0.05},{300.05,0.05}},
      color={0,0,127}));
  connect(latitude.y, weaBus.lat) annotation (Line(
      points={{-129,-280},{-124,-280},{-124,-290},{290,-290},{290,0.05},{300.05,
          0.05}},
      color={0,0,127}));
  connect(altitude.y, weaBus.alt) annotation (Line(points={{247,104},{290,104},{
          290,0.05},{300.05,0.05}},
                           color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(chePre.pAtm, weaBus.pAtm) annotation (Line(points={{181,270},{220,270},
          {220,0.05},{300.05,0.05}},
                            color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(latitude.y, zenAng.lat) annotation (Line(points={{-129,-280},{-124,
          -280},{-124,-290},{-90,-290},{-90,-216},{-72,-216}}, color={0,0,127}));
    annotation (
    defaultComponentName="weaDat",
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-200},{200,200}},
        initialScale=0.05), graphics={
        Rectangle(
          extent={{-200,200},{200,-200}},
          lineColor={124,142,255},
          fillColor={124,142,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-162,270},{138,230}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          visible=(pAtmSou == IDEAS.BoundaryConditions.Types.DataSource.Input),
          extent={{-190,216},{-164,184}},
          lineColor={0,0,127},
          textString="p"),
        Text(
          visible=(TDryBulSou == IDEAS.BoundaryConditions.Types.DataSource.Input),
          extent={{-194,162},{-118,118}},
          lineColor={0,0,127},
          textString="TDryBul"),
        Text(
          visible=(relHumSou == IDEAS.BoundaryConditions.Types.DataSource.Input),
          extent={{-190,92},{-104,66}},
          lineColor={0,0,127},
          textString="relHum"),
        Text(
        visible=(winSpeSou == IDEAS.BoundaryConditions.Types.DataSource.Input),
          extent={{-196,44},{-110,2}},
          lineColor={0,0,127},
          textString="winSpe"),
        Text(
          visible=(winDirSou == IDEAS.BoundaryConditions.Types.DataSource.Input),
          extent={{-192,-18},{-106,-60}},
          lineColor={0,0,127},
          textString="winDir"),
        Text(
        visible=(HSou ==  IDEAS.BoundaryConditions.Types.RadiationDataSource.Input_HGloHor_HDifHor or HSou == IDEAS.BoundaryConditions.Types.RadiationDataSource.Input_HDirNor_HGloHor),
        extent={{-202,-88},{-112,-108}},
          lineColor={0,0,127},
          textString="HGloHor"),
        Text(visible=(HSou == IDEAS.BoundaryConditions.Types.RadiationDataSource.Input_HGloHor_HDifHor or HSou == IDEAS.BoundaryConditions.Types.RadiationDataSource.Input_HDirNor_HDifHor),
        extent={{-202,-142},{-116,-164}},
          lineColor={0,0,127},
          textString="HDifHor"),
        Text(
        visible=(HSou == IDEAS.BoundaryConditions.Types.RadiationDataSource.Input_HDirNor_HGloHor or HSou == IDEAS.BoundaryConditions.Types.RadiationDataSource.Input_HDirNor_HDifHor),
        extent={{-200,-186},{-126,-214}},
          lineColor={0,0,127},
          textString="HDirNor"),
        Ellipse(
          extent={{-146,154},{28,-20}},
          lineColor={255,220,220},
          lineThickness=1,
          fillPattern=FillPattern.Sphere,
          fillColor={255,255,0}),
        Polygon(
          points={{94,106},{77.9727,42.9844},{78,42},{110,52},{138,50},{164,38},
              {182,-28},{138,-102},{10,-110},{-140,-106},{-166,-30},{-150,24},{-102,
              26},{-78.2109,8.1582},{-78,8},{-92,70},{-58,120},{34,140},{94,106}},
          lineColor={220,220,220},
          lineThickness=0.1,
          fillPattern=FillPattern.Sphere,
          smooth=Smooth.Bezier,
          fillColor={230,230,230}),
        Text(
          extent={{140,-106},{-126,-192}},
          textColor={255,255,255},
          textString=DynamicSelect("", String(weaBus.TDryBul-273.15, format=".1f")))}),
    Documentation(
  info="<html>
<p>
This model is adapted from 
<a href=\"modelica://IDEAS.BoundaryConditions.WeatherData.ReaderTMY3\">
IDEAS.BoundaryConditions.WeatherData.ReaderTMY3</a> 
to support weather data with a <b>5-second time resolution</b>.
</p>

<p>
The original ReaderTMY3 component assumes a 1-hour timestep, but this adapted version 
modifies internal interpolation and data handling to allow for high-frequency simulation,
enabling more accurate validation with finely-resolved weather files.
</p>

<p>
Other functionality is retained as in the base class. 
Refer to the original model for detailed documentation of general behavior.
</p>
</html>",
  revisions="<html>
<ul>
  <li>
    July 7, 2025 by Lone Meertens:<br/>
    Adapted ReaderTMY3 to allow weather data input at 5-second intervals for validation purposes.<br/>
    Tracked in 
    <a href=\"https://github.com/open-ideas/IDEAS/issues/1436\">#1436</a>.
  </li>
</ul>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false,
     extent={{-200,-300},{300,300}})));
end MyReaderTMY3;
