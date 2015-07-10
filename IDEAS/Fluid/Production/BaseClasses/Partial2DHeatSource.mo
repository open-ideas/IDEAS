within IDEAS.Fluid.Production.BaseClasses;
partial model Partial2DHeatSource
  import IDEAS;
  //Extensions
  extends IDEAS.Fluid.Production.BaseClasses.PartialHeatSource(
    final QNomRef=data.QNomRef,
    useTin2=data.useTin2,
    useTout2=data.useTout2,
    useMassFlow2=data.useMassFlow2,
    useTin1=data.useTin1,
    useTout1=data.useTout1,
    T_max = data.TMax, T_min = data.TMin);

  //Variables
  Modelica.SIunits.Power Q1 "Primary circuit power";
  Modelica.SIunits.Power Q2 "Secondary circuit power";

  Real modulationInit "The scaling of the heater power";
  Real modulation;

  //Components
  Modelica.Blocks.Tables.CombiTable2D heatTable(table=data.heat)
    "Table containing the heat data"
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Blocks.Tables.CombiTable2D powerTable(table=data.power)
    "Table containing the power/fuel data"
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  replaceable IDEAS.Fluid.Production.BaseClasses.PartialNonModulatingRecord
    data constrainedby
    IDEAS.Fluid.Production.BaseClasses.PartialNonModulatingRecord
    "Record holding the heater data and the performance map"                                                               annotation (
      choicesAllMatching=true, Placement(transformation(extent={{70,-94},{90,-74}})));
  Modelica.Blocks.Sources.RealExpression tableInput1
    "Name of the first independent variable of the performance table"
    annotation (Placement(transformation(extent={{-80,-10},{-40,10}})));
  Modelica.Blocks.Sources.RealExpression tableInput2
    "Name of the second independent variable of the performance table"
    annotation (Placement(transformation(extent={{-80,-30},{-40,-10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow P1
    annotation (Placement(transformation(extent={{66,-10},{86,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow P2
    annotation (Placement(transformation(extent={{66,-50},{86,-30}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=Q1)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=Q2)
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
equation
  if heatPumpWaterWater then
    T_low = heatPort2Mock.T;
  else
    T_low = data.TMin + 10;
  end if;

  //Determine modulation
  if on_internal then
    //Check if the heater can modulate
    if modulating then
      //Check if the modulation is given as an input
      if modulationInput then
        modulationInit=uModulationMock;
      else
        //If not use perfect modulation
        modulationInit=QAsked/QNom*100;
      end if;
    else
      //If the heater cannot modulate set the modulation to 100
      modulationInit=100;
    end if;
  else
    modulationInit = 0;
  end if;

  // Limit the modulation between [0,100] and scale to [0,1]
  modulation = IDEAS.Utilities.Math.Functions.smoothMax(
    x1=IDEAS.Utilities.Math.Functions.smoothMin(
      x1=modulationInit,
      x2=100,
      deltaX=0.1),
    x2=0,
    deltaX=0.1)/100 * modulation_security_internal;

  //Heat powers
  Q1 = modulation*(heatTable.y*scaler + QLossesToCompensate1);
  if heatPumpWaterWater then
    Q2 = modulation*( - ( -powerTable.y*scaler + Q1 + QLossesToCompensate2));
  else
    Q2 = 0;
  end if;

  //Fuel or electricity power
  power = modulation*powerTable.y;

  //Connections
  connect(tableInput1.y, heatTable.u1) annotation (Line(
      points={{-38,0},{-20,0},{-20,6},{-2,6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(tableInput2.y, heatTable.u2) annotation (Line(
      points={{-38,-20},{-10,-20},{-10,-6},{-2,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(tableInput1.y, powerTable.u1) annotation (Line(
      points={{-38,0},{-20,0},{-20,-44},{-2,-44}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(tableInput2.y, powerTable.u2) annotation (Line(
      points={{-38,-20},{-10,-20},{-10,-56},{-2,-56}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(P1.Q_flow,realExpression1. y) annotation (Line(
      points={{66,0},{61,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(P2.Q_flow,realExpression2. y) annotation (Line(
      points={{66,-40},{61,-40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(P1.port, heatPort1) annotation (Line(
      points={{86,0},{100,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(P2.port, heatPort2Mock) annotation (Line(
      points={{86,-40},{100,-40}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={Text(
          extent={{-80,-24},{-40,-60}},
          lineColor={0,127,0},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid,
          textString="Tin1
Tout1
massFlow1
Tin2
Tout2
massFlow2")}));
end Partial2DHeatSource;
