within IDEAS.Climate.Meteo.Solar;
model RadSolData "Selects or generates correct solar data for this surface"
  parameter SI.Angle inc "inclination";
  parameter SI.Angle azi "azimuth";
  parameter SI.Angle lat "latitude";
  parameter Integer numAzi "Number of irradation data calculated in solBus";
  parameter SI.Angle ceilingInc "Roof inclination angle in solBus";
  parameter SI.Angle offsetAzi
    "Offset azimuth angle of irradation data calculated in solBus";
  parameter Boolean forceWeaBusPassThrough = linearisation
    "Set to true when inputs must be taken from the weather bus, i.e. when linearising"
    annotation(Dialog(group="Linearisation"));
  parameter Boolean linearisation = false
    "Set to true when component is part of a to be linearised model"
  annotation(Dialog(group="Linearisation"));

  parameter Boolean solDataInBus=
   forceWeaBusPassThrough or
   isRoof or
    (inc==IDEAS.Constants.Wall
      and abs(sin((azi-offsetAzi)*numAzi))<0.05)
    "True if solBus contains correct data for this surface"
    annotation(Evaluate=true);
  final parameter Integer solDataIndex=
    if isRoof then
      1 else
      2+integer(floor(mod((azi-offsetAzi)/Modelica.Constants.pi/2,1)*numAzi))
    "Solbus index for this surface";

  Climate.Meteo.Solar.ShadedRadSol radSol(
    final inc=inc,
    final azi=azi,
    lat=lat,
    numAzi=numAzi,
    final outputAngles=not linearisation) if
                      not solDataInBus
    "determination of incident solar radiation on wall based on inclination and azimuth"
    annotation (Placement(transformation(extent={{-94,24},{-74,44}})));

  Modelica.Blocks.Interfaces.RealOutput solDir
    annotation (Placement(transformation(extent={{96,10},{116,30}})));
  Modelica.Blocks.Interfaces.RealOutput solDif
    annotation (Placement(transformation(extent={{96,-10},{116,10}})));

  input IDEAS.Buildings.Components.Interfaces.WeaBus
                                     weaBus(numSolBus=numAzi + 1, outputAngles=
        not linearisation)
    annotation (HideResults=true,Placement(transformation(extent={{90,70},{110,90}})));

  Modelica.Blocks.Interfaces.RealOutput angInc
    annotation (Placement(transformation(extent={{96,-50},{116,-30}})));
  Modelica.Blocks.Interfaces.RealOutput angZen
    annotation (Placement(transformation(extent={{96,-70},{116,-50}})));
  Modelica.Blocks.Interfaces.RealOutput angAzi
    annotation (Placement(transformation(extent={{96,-90},{116,-70}})));
  Modelica.Blocks.Interfaces.RealOutput Tenv "Environment temperature"
    annotation (Placement(transformation(extent={{96,-30},{116,-10}})));
protected
      parameter Boolean isRoof = ceilingInc == inc
    "Surface is a horizontal surface";
protected
  output Buildings.Components.Interfaces.SolBus
                                         solBusDummy1(outputAngles=not
        linearisation) "Required for avoiding warnings?"
                                     annotation (HideResults=true, Placement(
        transformation(extent={{-78,10},{-38,50}})));
public
  Modelica.Blocks.Sources.Constant constAngLin(k=0) if
                                                 linearisation
    "Dummy inputs when linearising. This avoids unnecessary state space inputs."
    annotation (Placement(transformation(extent={{-100,-70},{-80,-50}})));
equation

  connect(radSol.weaBus, weaBus) annotation (Line(
      points={{-94,42},{-94,80},{100,80}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));

  connect(radSol.solBus, solBusDummy1) annotation (Line(
      points={{-74,34},{-66,34},{-66,30},{-58,30}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
      if solDataInBus then
  connect(weaBus.solBus[solDataIndex], solBusDummy1) annotation (Line(
      points={{100.05,80.05},{102,80.05},{102,30},{-58,30}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
      end if;
  connect(solDir, solBusDummy1.iSolDir) annotation (Line(
      points={{106,20},{-58,20},{-58,30.1},{-57.9,30.1}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(solDif, solBusDummy1.iSolDif) annotation (Line(
      points={{106,0},{-57.9,0},{-57.9,30.1}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Tenv, solBusDummy1.Tenv) annotation (Line(
      points={{106,-20},{-57.9,-20},{-57.9,30.1}},
      color={0,0,127},
      smooth=Smooth.None));
  if not linearisation then
    connect(angInc, solBusDummy1.angInc) annotation (Line(
      points={{106,-40},{-57.9,-40},{-57.9,30.1}},
      color={0,0,127},
      smooth=Smooth.None));
    connect(angZen, solBusDummy1.angZen) annotation (Line(
      points={{106,-60},{-57.9,-60},{-57.9,30.1}},
      color={0,0,127},
      smooth=Smooth.None));
    connect(angAzi, solBusDummy1.angAzi) annotation (Line(
      points={{106,-80},{-57.9,-80},{-57.9,30.1}},
      color={0,0,127},
      smooth=Smooth.None));
  end if;
  connect(constAngLin.y, angInc) annotation (Line(points={{-79,-60},{-78,-60},{-78,
          -40},{106,-40}}, color={0,0,127}));
  connect(constAngLin.y, angZen)
    annotation (Line(points={{-79,-60},{-78,-60},{106,-60}}, color={0,0,127}));
  connect(constAngLin.y, angAzi) annotation (Line(points={{-79,-60},{-78,-60},{-78,
          -80},{106,-80}}, color={0,0,127}));

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           Documentation(info="<html>
<p>This model usually takes the appropriate solar data from the bus. If the correct data is not contained by the bus, custom solar data is calculated.</p>
</html>", revisions="<html>
<ul>
<li>
February 10, 2015 by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
end RadSolData;
