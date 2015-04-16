within IDEAS.Fluid.Production.Interfaces.BaseClasses;
partial model Partial2DHeatSource
  //Extensions
  extends PartialHeatSource(
    final QNomRef=data.QNomRef,
    useTinPrimary=data.useTinPrimary,
    useToutPrimary=data.useToutPrimary,
    useTinSecondary=data.useTinSecondary,
    useToutSecondary=data.useToutSecondary,
    useMassFlowPrimary=data.useMassFlowPrimary);

  //Variables
  Modelica.SIunits.Power QEvaporator "The evaporator power";
  Modelica.SIunits.Power QCondensor "The condensor power";
  Real modulationInit "The scaling of the heater power";
  Real modulation;

  //Components
  Modelica.Blocks.Tables.CombiTable2D heatTable(table=data.heat)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Blocks.Tables.CombiTable2D powerTable(table=data.power)
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  replaceable PartialNonModulatingRecord data
    constrainedby
    IDEAS.Fluid.Production.Interfaces.BaseClasses.PartialNonModulatingRecord
    annotation (choicesAllMatching=true, Placement(transformation(extent={{70,-94},{90,-74}})));
  Modelica.Blocks.Sources.RealExpression tableInput1
    annotation (Placement(transformation(extent={{-80,-10},{-40,10}})));
  Modelica.Blocks.Sources.RealExpression tableInput2
    annotation (Placement(transformation(extent={{-80,-30},{-40,-10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow PCondensor
    annotation (Placement(transformation(extent={{66,-10},{86,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow PEvaporator
    annotation (Placement(transformation(extent={{66,-50},{86,-30}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=QCondensor)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=QEvaporator)
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
equation

  //Determine modulation
  if on then
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
    deltaX=0.1)/100;

  //Heat powers
  QCondensor = modulation*(heatTable.y*scaler-QLossesToCompensate);
  QEvaporator = modulation*(powerTable.y*scaler - (QCondensor + QLossesToCompensateE));

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

  connect(PCondensor.Q_flow,realExpression1. y) annotation (Line(
      points={{66,0},{61,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(PEvaporator.Q_flow,realExpression2. y) annotation (Line(
      points={{66,-40},{61,-40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(PCondensor.port, heatPort) annotation (Line(
      points={{86,0},{100,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(PEvaporator.port, heatPortEMock) annotation (Line(
      points={{86,-40},{100,-40}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={Text(
          extent={{-80,-24},{-40,-60}},
          lineColor={0,127,0},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid,
          textString="TinSecondary
ToutSecondary
massFlowSecondary
TinPrimary
ToutPrimary
massFlowPrimary")}));
end Partial2DHeatSource;
