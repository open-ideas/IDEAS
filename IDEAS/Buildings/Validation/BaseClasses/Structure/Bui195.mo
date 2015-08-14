within IDEAS.Buildings.Validation.BaseClasses.Structure;
model Bui195 "BESTEST Building model case 195"

  extends IDEAS.Interfaces.BaseClasses.Structure(
    final nZones=1, final nEmb=0,
    ATrans=1,
    VZones={gF.V});

protected
  IDEAS.Buildings.Components.Zone gF(
    V=129.6,
    nSurf=6,
    n50=0,
    corrCV=0.822,
    T_start=293.15,
    redeclare package Medium = Medium)
                annotation (Placement(transformation(extent={{40,0},{80,40}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{120,-70},{140,-50}})));
  IDEAS.Buildings.Components.OuterWall[4] wall(
    redeclare final parameter Data.Constructions.LightWall_195 constructionType,
    redeclare final parameter Data.Insulation.fiberglass insulationType,
    final azi={IDEAS.Constants.North,IDEAS.Constants.East,IDEAS.Constants.South,
        IDEAS.Constants.West},
    final insulationThickness={0.066,0.066,0.066,0.066},
    final inc={IDEAS.Constants.Wall,IDEAS.Constants.Wall,IDEAS.Constants.Wall,
        IDEAS.Constants.Wall},
    final AWall={21.6,16.2,21.6,16.2})
                               annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=90,
        origin={-49,-14})));

  IDEAS.Buildings.Components.BoundaryWall floor(
    redeclare final parameter Data.Constructions.LightFloor constructionType,
    redeclare final parameter Data.Insulation.insulation insulationType,
    final insulationThickness=1.003,
    final AWall=48,
    final inc=IDEAS.Constants.Floor,
    final azi=IDEAS.Constants.South) annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=90,
        origin={-19,-14})));
  IDEAS.Buildings.Components.OuterWall roof(
    redeclare final parameter Data.Constructions.LightRoof_195 constructionType,
    redeclare final parameter Data.Insulation.fiberglass insulationType,
    final insulationThickness=0.1118,
    final AWall=48,
    final inc=IDEAS.Constants.Ceiling,
    final azi=IDEAS.Constants.South) annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=90,
        origin={-79,-14})));

equation
  connect(gF.gainCon, temperatureSensor.port) annotation (Line(
      points={{80,14},{100,14},{100,-60},{120,-60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(gF.gainCon, heatPortCon[1]) annotation (Line(
      points={{80,14},{120,14},{120,20},{150,20}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(gF.gainRad, heatPortRad[1]) annotation (Line(
      points={{80,8},{120,8},{120,-20},{150,-20}},
      color={191,0,0},
      smooth=Smooth.None));

  connect(roof.propsBus_a, gF.propsBus[1]) annotation (Line(
      points={{-83,-9},{-83,31.3333},{40,31.3333}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(wall.propsBus_a, gF.propsBus[2:5]) annotation (Line(
      points={{-53,-9},{-53,26},{40,26}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(floor.propsBus_a, gF.propsBus[6]) annotation (Line(
      points={{-23,-9},{-23,24.6667},{40,24.6667}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(temperatureSensor.T, TSensor[1]) annotation (Line(
      points={{140,-60},{156,-60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(flowPort_Out[1], gF.flowPort_Out) annotation (Line(
      points={{-20,100},{-20,60},{56,60},{56,40}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(flowPort_In[1], gF.flowPort_In) annotation (Line(
      points={{20,100},{20,62},{64,62},{64,40}},
      color={0,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-150,
            -100},{150,100}}), graphics));
end Bui195;
