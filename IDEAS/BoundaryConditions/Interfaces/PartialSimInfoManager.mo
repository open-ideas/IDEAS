within IDEAS.BoundaryConditions.Interfaces;
partial model PartialSimInfoManager
  "Partial providing structure for SimInfoManager"
  parameter String filDir = Modelica.Utilities.Files.loadResource("modelica://IDEAS") + "/Inputs/"
    "Directory containing the weather data file, default under IDEAS/Inputs/";
  parameter String filNam = "Uccle.TMY" "Name of weather data file"
    annotation(Dialog(enable=useTmy3Reader));
  parameter Modelica.SIunits.Angle lat(displayUnit="deg") = 0.88749992463912
    "latitude of the locatioin";
  parameter Modelica.SIunits.Angle lon(displayUnit="deg") = 0.075921822461753;
  parameter Modelica.SIunits.Time timZonSta(displayUnit="h") = 3600
    "standard time zone";
  parameter Integer numAzi=4 "Number of azimuth angles that are calculated"
    annotation(Dialog(tab="Incidence angles"));
  parameter Boolean computeConservationOfEnergy = false
    "Add equations for verifying conservation of energy"
    annotation(Evaluate=true,Dialog(tab="Conservation of energy"));
  parameter Boolean strictConservationOfEnergy = false
    "This adds an assert statement to make sure that energy is conserved"
    annotation(Evaluate=true,Dialog(tab="Conservation of energy", enable = computeConservationOfEnergy));
  parameter Boolean openSystemConservationOfEnergy = false
    "Compute conservation of energy for open system"
    annotation(Evaluate=true,Dialog(tab="Conservation of energy", enable = computeConservationOfEnergy));

  parameter Modelica.SIunits.Energy Emax = 1
    "Error bound for violation of conservation of energy"
    annotation(Evaluate=true,Dialog(tab="Conservation of energy", enable = strictConservationOfEnergy));
  final parameter String filNamClim=filDir + filNam;

  parameter Boolean useTmy3Reader = true
    "Set to false if you do not want to use the TMY3 reader for providing data";
  final parameter Modelica.SIunits.Temperature Tdes = -8 + 273.15
    "design outdoor temperature";

  final parameter Modelica.SIunits.Temperature TdesGround = 10 + 273.15
    "design ground temperature";
  parameter SI.Angle offsetAzi=0 "Offset for the azimuth angle series"
    annotation(Dialog(tab="Incidence angles"));
  parameter SI.Angle ceilingInc = IDEAS.Types.Tilt.Ceiling
    "Ceiling inclination angle"
    annotation(Dialog(tab="Incidence angles"));
  parameter Modelica.SIunits.Temperature Tenv_nom= 280
    "Nominal ambient temperature, only used when linearising equations";

public
  Modelica.SIunits.Irradiance solDirPer
    "direct irradiation on normal to solar zenith";
  Modelica.SIunits.Irradiance solDirHor
    "direct irradiation on horizontal surface";
  Modelica.SIunits.Irradiance solDifHor
    "difuse irradiation on horizontal surface";
  Modelica.SIunits.Irradiance solGloHor "global irradiation on horizontal";
  Modelica.SIunits.Temperature Te
    "ambient outdoor temperature for determination of sky radiation exchange";
  Modelica.SIunits.Temperature Tsky "effective overall sky temperature";
  Modelica.SIunits.Temperature TeAv
    "running average of ambient outdoor temperature of the last 5 days, not yet implemented";
  Modelica.SIunits.Temperature Tground "ground temperature";
  Modelica.SIunits.Velocity Va "air velocity";
  Real Fc "cloud factor";
  Modelica.SIunits.Irradiance irr "Irradiance";
  Boolean summer;

  Real relHum(final unit="1") "Relative humidity";
  Modelica.SIunits.Temperature TDewPoi "Dewpoint";

  Boolean day=true;

  Modelica.SIunits.Time timLoc "Local time";
  Modelica.SIunits.Time timSol "Solar time";
  Modelica.SIunits.Time timCal "Calendar time";

  Modelica.SIunits.Energy Etot "Total internal energy";
  Modelica.SIunits.Energy Qint "Total energy from boundary";

  Real hCon=IDEAS.Utilities.Math.Functions.spliceFunction(x=Va-5, pos= 7.1*abs(Va)^(0.78), neg = 4.0*Va + 5.6, deltax=0.5);
  Real TePow4 = Te^4;
  Real TskyPow4 = Tsky^4;
  Real angDec=asin(-sin(23.45*Modelica.Constants.pi/180)*cos((timLoc/86400 +
    10)*2*Modelica.Constants.pi/365.25));
  Real angHou =  (timSol/3600 - 12)*2*Modelica.Constants.pi/24;
  Real angZen = acos(cos(lat)*cos(angDec)*cos(angHou) + sin(lat)*sin(angDec));

public
  Modelica.Blocks.Sources.RealExpression hour(y=angHou) "Hour angle"
    annotation (Placement(transformation(extent={{-124,34},{-104,54}})));
  Modelica.Blocks.Sources.RealExpression dec(y=angDec) "declination angle"
    annotation (Placement(transformation(extent={{-124,22},{-104,42}})));
  Modelica.Blocks.Sources.RealExpression solDirPerExp(y=solDirPer)
    "Perpendicular direct solar radiation"
    annotation (Placement(transformation(extent={{-124,10},{-104,30}})));
protected
  final parameter Boolean DST = true
    "boolean to take into account daylight saving time";
  final parameter Integer yr = 2014 "depcited year for DST only";

  final parameter Boolean BesTest = Modelica.Utilities.Strings.isEqual(filNam, "BesTest.txt")
    "boolean to determine if this simulation is a BESTEST simulation";

  parameter SI.Angle inc[numAzi + 1]=cat(
      1,
      fill(ceilingInc,1),
      fill(IDEAS.Types.Tilt.Wall, numAzi)) "surface inclination";

  IDEAS.BoundaryConditions.Climate.Time.SimTimes timMan(
    timZonSta=timZonSta,
    lon=lon,
    DST=false,
    ifSolCor=true)
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));

  BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
  filNam=filNamClim,
  lat=lat,
  lon=lon,
  timZon=timZonSta,
  datRea1(tableName="data"),
  datRea(tableName="data")) if useTmy3Reader
    annotation (Placement(transformation(extent={{-80,-100},{-60,-80}})));
  Utilities.Psychrometrics.X_pTphi XiEnv(use_p_in=false)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Sources.RealExpression phiEnv(y=relHum)
    annotation (Placement(transformation(extent={{-124,-22},{-104,-2}})));
  Modelica.Blocks.Sources.RealExpression TEnv(y=Te)
    annotation (Placement(transformation(extent={{-124,-6},{-104,14}})));
  BoundaryConditions.Climate.Meteo.Solar.BaseClasses.RelativeAirMass
    relativeAirMass
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  BoundaryConditions.Climate.Meteo.Solar.BaseClasses.SkyBrightness
    skyBrightness
    annotation (Placement(transformation(extent={{-52,40},{-32,60}})));
  BoundaryConditions.Climate.Meteo.Solar.BaseClasses.SkyClearness skyClearness
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));

  BoundaryConditions.Climate.Meteo.Solar.BaseClasses.SkyBrightnessCoefficients
    skyBrightnessCoefficients
    annotation (Placement(transformation(extent={{-26,60},{-6,80}})));

  Modelica.Blocks.Sources.RealExpression zenithAngle(y=angZen)
    annotation (Placement(transformation(extent={{-124,46},{-104,66}})));
  Modelica.Blocks.Sources.RealExpression solGloHorIn(y=solGloHor)
    annotation (Placement(transformation(extent={{-124,78},{-104,98}})));
  Modelica.Blocks.Sources.RealExpression solDifHorIn(y=solDifHor)
    annotation (Placement(transformation(extent={{-124,62},{-104,82}})));

public
  Buildings.Components.Interfaces.WeaBus
                                     weaBus(numSolBus=numAzi + 1)
    annotation (Placement(transformation(extent={{50,18},{70,38}})));
  BoundaryConditions.Climate.Meteo.Solar.ShadedRadSol[numAzi + 1] radSol(
    inc=inc,
    azi=cat(
        1,
        fill(ceilingInc, 1),
        fill(offsetAzi, numAzi) + (0:numAzi - 1)*Modelica.Constants.pi*2/numAzi),
    each numAzi=numAzi,
    each lat=lat)
    annotation (Placement(transformation(extent={{20,40},{40,60}})));

  Modelica.Blocks.Sources.RealExpression TskyPow4Expr(y=TskyPow4)
    "Power 4 of sky temperature"
    annotation (Placement(transformation(extent={{-124,92},{-104,112}})));
  Modelica.Blocks.Sources.RealExpression TePow4Expr(y=TePow4)
    "Power 4 of ambient temperature"
    annotation (Placement(transformation(extent={{-124,106},{-104,126}})));
  Modelica.Blocks.Sources.RealExpression hConExpr(y=hCon)
    "Exterior convective heat transfer coefficient"
    annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
  Modelica.Blocks.Sources.RealExpression TdesExpr(y=Tdes)
    annotation (Placement(transformation(extent={{-20,-20},{0,0}})));

  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=10e6);
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Qgai
    "Thermal gains in model"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  IDEAS.Buildings.Components.BaseClasses.ConservationOfEnergy.EnergyPort E
    "Model internal energy"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));

  Modelica.Blocks.Sources.RealExpression CEnv(y=0)
    "Concentration of trace substance in surroundings"
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
initial equation
  Etot=0;
equation
  if strictConservationOfEnergy and computeConservationOfEnergy then
    assert(abs(Etot)<Emax, "Conservation of energy violation > Emax J!");
  end if;

  der(Qint) = Qgai.Q_flow;
  Etot=  Qint-E.E;
  E.Etot=Etot;

  connect(TEnv.y,XiEnv. T) annotation (Line(
      points={{-103,4},{-82,4},{-82,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(phiEnv.y,XiEnv. phi) annotation (Line(
      points={{-103,-12},{-82,-12},{-82,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(skyClearness.skyCle,skyBrightnessCoefficients. skyCle) annotation (
      Line(
      points={{-59.4,80},{-56,80},{-56,72},{-26,72}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(skyBrightness.skyBri,skyBrightnessCoefficients. skyBri) annotation (
      Line(
      points={{-32,56},{-30,56},{-30,68},{-26,68}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(relativeAirMass.relAirMas,skyBrightness. relAirMas) annotation (Line(
      points={{-60,56},{-52,56}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(zenithAngle.y, relativeAirMass.angZen) annotation (Line(
      points={{-103,56},{-80,56}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(zenithAngle.y, skyClearness.angZen) annotation (Line(
      points={{-103,56},{-84,56},{-84,86},{-80,86}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(skyBrightnessCoefficients.angZen, skyClearness.angZen) annotation (
      Line(
      points={{-26,76},{-52,76},{-52,96},{-84,96},{-84,86},{-80,86}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(skyClearness.solGloHor, solGloHorIn.y) annotation (Line(
      points={{-80,80},{-88,80},{-88,88},{-103,88}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(solDifHorIn.y, skyClearness.solDifHor) annotation (Line(
      points={{-103,72},{-86,72},{-86,74},{-80,74}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(skyClearness.solDifHor, skyBrightness.solDifHor) annotation (Line(
      points={{-80,74},{-80,66},{-56,66},{-56,50},{-52,50}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(TskyPow4Expr.y, weaBus.TskyPow4) annotation (Line(
      points={{-103,102},{60,102},{60,28}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TePow4Expr.y, weaBus.TePow4) annotation (Line(
      points={{-103,116},{60,116},{60,28}},
      color={0,0,127},
      smooth=Smooth.None));
  for i in 1:numAzi+1 loop
  connect(radSol[i].F2, skyBrightnessCoefficients.F2) annotation (Line(points={{
          19.6,40},{2,40},{2,72},{-6,72}}, color={0,0,127}));
  connect(radSol[i].F1, skyBrightnessCoefficients.F1) annotation (Line(points={{
          19.6,42},{4,42},{4,76},{-6,76}}, color={0,0,127}));
  connect(hour.y, radSol[i].angHou) annotation (Line(points={{-103,44},{-90,44},
          {-90,24},{14,24},{14,48},{19.6,48}}, color={0,0,127}));
  connect(zenithAngle.y, radSol[i].angZen) annotation (Line(points={{-103,56},{-84,
          56},{-84,30},{16,30},{16,46},{19.6,46}}, color={0,0,127}));
  connect(dec.y, radSol[i].angDec) annotation (Line(points={{-103,32},{-92,32},{
          -92,22},{12,22},{12,50},{19.6,50}}, color={0,0,127}));
  connect(radSol[i].solDirPer, solDirPerExp.y) annotation (Line(points={{19.6,60},
          {6,60},{6,20},{-103,20}}, color={0,0,127}));
  connect(radSol[i].solDifHor, solDifHorIn.y) annotation (Line(points={{19.6,56},
          {10,56},{10,28},{-86,28},{-86,72},{-103,72}}, color={0,0,127}));
  connect(solGloHorIn.y, radSol[i].solGloHor) annotation (Line(points={{-103,88},
          {-88,88},{-88,26},{8,26},{8,58},{19.6,58}}, color={0,0,127}));
  connect(TskyPow4Expr.y, radSol[i].TskyPow4)
    annotation (Line(points={{-103,102},{28,102},{28,60.6}}, color={0,0,127}));
  connect(TePow4Expr.y, radSol[i].TePow4) annotation (Line(points={{-103,116},{-90,
          116},{34,116},{34,60.6}}, color={0,0,127}));
  end for;
  connect(skyBrightnessCoefficients.F1, weaBus.F1) annotation (Line(
      points={{-6,76},{4,76},{4,34},{60,34},{60,28}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(skyBrightnessCoefficients.F2, weaBus.F2) annotation (Line(
      points={{-6,72},{2,72},{2,32},{60,32},{60,28}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(solGloHorIn.y, weaBus.solGloHor) annotation (Line(
      points={{-103,88},{-88,88},{-88,26},{60,26},{60,28}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(solDifHorIn.y, weaBus.solDifHor) annotation (Line(
      points={{-103,72},{-86,72},{-86,28},{60,28}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(zenithAngle.y, weaBus.angZen) annotation (Line(
      points={{-103,56},{-84,56},{-84,30},{60,30},{60,28}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(hour.y, weaBus.angHou) annotation (Line(
      points={{-103,44},{-90,44},{-90,24},{60,24},{60,28}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dec.y, weaBus.angDec) annotation (Line(
      points={{-103,32},{-92,32},{-92,22},{60,22},{60,28}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(solDirPerExp.y, weaBus.solDirPer) annotation (Line(
      points={{-103,20},{60,20},{60,28}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TEnv.y, weaBus.Te) annotation (Line(
      points={{-103,4},{-50,4},{-50,-56},{60.05,-56},{60.05,28.05}},
      color={0,0,127},
      smooth=Smooth.None,
      visible=false));
  connect(hConExpr.y, weaBus.hConExt) annotation (Line(
      points={{1,-24},{60.05,-24},{60.05,28.05}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TdesExpr.y, weaBus.Tdes) annotation (Line(
      points={{1,-10},{60.05,-10},{60.05,28.05}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(radSol.solBus, weaBus.solBus) annotation (Line(
      points={{40,50},{60.05,50},{60.05,28.05}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(fixedTemperature.port, Qgai)
    annotation (Line(points={{20,-70},{0,-70},{0,-100}},  color={191,0,0}));

  connect(CEnv.y, weaBus.CEnv) annotation (Line(points={{1,-40},{1,-40},{60,-40},
          {60,28}},      color={0,0,127}));
  connect(XiEnv.X[1], weaBus.X_wEnv)
    annotation (Line(points={{-59,0},{60,0},{60,28}},    color={0,0,127}));
  annotation (
    defaultComponentName="sim",
    defaultComponentPrefixes="inner",
    missingInnerMessage=
        "Your model is using an outer \"sim\" component. An inner \"sim\" component is not defined. For simulation drag IDEAS.BoundaryConditions.SimInfoManager into your model.",
    Icon(graphics={
        Line(points={{-80,-30},{88,-30}}, color={0,0,0}),
        Line(points={{-76,-68},{-46,-30}}, color={0,0,0}),
        Line(points={{-42,-68},{-12,-30}}, color={0,0,0}),
        Line(points={{-8,-68},{22,-30}},  color={0,0,0}),
        Line(points={{28,-68},{58,-30}}, color={0,0,0}),
        Rectangle(
          extent={{-60,76},{60,-24}},
          lineColor={95,95,95},
          fillPattern=FillPattern.Solid,
          fillColor={95,95,95}),
        Rectangle(
          extent={{-50,66},{50,-4}},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255},
          pattern=LinePattern.None),
        Rectangle(
          extent={{-10,-34},{10,-24}},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Polygon(
          points={{-40,-60},{-40,-60}},
          pattern=LinePattern.None,
          smooth=Smooth.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-40,-34},{40,-34},{50,-44},{-52,-44},{-40,-34}},
          smooth=Smooth.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{44,0},{38,40}},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{34,0},{28,12}},
          fillColor={0,127,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{24,0},{18,56}},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{14,0},{8,36}},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{4,0},{-2,12}},
          fillColor={0,127,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-6,0},{-46,0}},
          color={0,0,127},
          smooth=Smooth.None),
        Text(
          extent={{-50,66},{-20,26}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          textStyle={TextStyle.Italic},
          fontName="Bookman Old Style",
          textString="i")}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            120}})),
    Documentation(info="<html>
</html>", revisions="<html>
<ul>
<li>
March 25, 2016 by Filip Jorissen:<br/>
Reworked radSol implementation to use RealInputs instead of weaBus.
This simplifies translation and interpretation.
Also cleaned up connections.
</li>
<li>
January 29, 2015, Filip Jorissen:<br/>
Made changes for allowing a proper implementation of <code>airLeakage</code>.
</li>
<li>
June 14, 2015, Filip Jorissen:<br/>
Adjusted implementation for computing conservation of energy.
</li>
<li>
February 10, 2015 by Filip Jorissen:<br/>
Adjusted implementation for grouping of solar calculations.
</li>
</ul>
</html>"));
end PartialSimInfoManager;
