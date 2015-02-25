within IDEAS.Fluid.Production.BaseClasses;
model HeatSource "Partial model to handle common aspects for heater data"

  extends IDEAS.Fluid.Interfaces.PartialTwoPortInterface;

  //Parameters and constants
  //****************************************************************************
  parameter Modelica.SIunits.Power QNom "Nominal power of the heater";
  final parameter Types.MassFlow mUnit=data.mUnit
    "Unit of massflow for the input";
  final parameter Types.Temperature TUnit=data.TUnit
    "Unit of temperature for the input";

  parameter Boolean useQSet=false
    "Set to true to use a setpoint for Q instead of T";

  constant Real m3ps2kgps=1000 "Conversion from m3/s to kg/s";
  constant Real kgps2lph=3600/Medium.density(Medium.setState_pTX(Medium.p_default, Medium.T_default, Medium.X_default))*m3ps2kgps
    "Conversion from kg/s to l/h";

  //Variables
  //****************************************************************************
  Modelica.SIunits.Power QMax
    "Maximum thermal power at 100% modulation for the given input conditions";
  Modelica.SIunits.Power QAsked(start=0) "Desired power of the heatsource";
  Modelica.SIunits.Power QLossesToCompensate "Environmental heat losses";
  Real modulation "Modulation rate of the heater";
  Real eta "Final efficiency of the heater";

  Real m_flow_scaled = IDEAS.Utilities.Math.Functions.smoothMax(
    x1=m_flow,
    x2=0,
    deltaX=m_flow_nominal/10000)*QNom/data.QNomRef "Mass flow rate, scaled with the original and the actual nominal power of 
    the boiler";

  Real m_flow_eff "Massflow as input for the efficiency calculation";
  Real T_eff "Temperat as input for the efficiency calculation";

  Real u1 "First input to the table/polynomial";
  Real u2 "Second input to the table/polynomial";
  Real u3 if data.isModulating "Third input to the table/polynomial";

  //Components
  //****************************************************************************
  replaceable DataInterface data "Data of the heater"
    annotation (Placement(transformation(extent={{-98,-98},{-78,-78}})));
  Sensors.TemperatureTwoPort senTem
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));

  Utilities.Tables.InterpolationTable3D table(space=data.space) if
       not data.usePolynomial
    annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  Utilities.Tables.InterpolationTable3D tableQ(space=data.space) if
       not data.usePolynomial
    annotation (Placement(transformation(extent={{-10,36},{10,56}})));
  Modelica.Blocks.Tables.CombiTable2D table2 if not data.isModulating
    annotation (Placement(transformation(extent={{-10,8},{10,28}})));
  Modelica.Blocks.Interfaces.RealInput u annotation (Placement(transformation(
          extent={{-122,40},{-82,80}}),
                                      iconTransformation(extent={{-120,60},{-80,
            100}})));
  Modelica.Blocks.Interfaces.BooleanInput on annotation (Placement(
        transformation(extent={{-120,20},{-80,60}}), iconTransformation(extent={
            {-120,20},{-80,60}})));

equation
  //Variable settings
  //****************************************************************************
  //Use the right massflow conversion
  if mUnit == Types.MassFlow.m3ps then
    m_flow_eff = m_flow_scaled;
  end if;
  if mUnit == Types.MassFlow.kgps then
    m_flow_eff = m_flow_scaled*m3ps2kgps;
  end if;
  if mUnit == Types.MassFlow.lph then
    m_flow_eff = m_flow_scaled*m3ps2kgps*kgps2lph;
  end if;

  //Use the right temperature conversion
  if TUnit == Types.Temperature.C then
    T_eff = senTem.T - 273.15;
  end if;
  if TUnit == Types.Temperature.K then
    T_eff = senTem.T;
  end if;

  //Use the right inputs
  if data.typeU1 == Types.Inputs.MassFlow then
    u1 = m_flow_eff;
  end if;
  if data.typeU1 == Types.Inputs.Modulation then
    u1 = modulation;
  end if;
  if data.typeU2 == Types.Inputs.TPrimary then
    u2 = T_eff;
  end if;
  if data.typeU2 == Types.Inputs.Modulation then
    u2 = modulation;
  end if;
  if data.typeU3 == Types.Inputs.TPrimary then
    u3 = T_eff;
  end if;
  if data.typeU3 == Types.Inputs.MassFlow then
    u3 = m_flow_eff;
  end if;

  //HeatPort calculation if modulating
  //****************************************************************************
  if data.isModulating then
    //Calculation of QAsked
    if useQSet then
      QAsked = u;
    else
      QAsked = IDEAS.Utilities.Math.Functions.smoothMax(
        0,
        m_flow*(Medium.specificEnthalpy(
          Medium.setState_pTX(
            Medium.p_default, u, Medium.X_default)) -port_a.h_outflow), 10);
    end if;

    //Calculation of QMax
    if data.usePolynomial then
      QMax = IDEAS.Fluid.Production.BaseClasses.PolynomialDimensions(
        beta=data.beta,
        powers=data.powers,
        X={u3, u2, u1},
        n=data.n,
        k=data.k)/data.etaRef*data.QNomRef;
    else
      table.u1 = u1;
      table.u2 = u2;
      table.u3 = 100;
      QMax = table.y/data.etaRef*data.QNomRef;
    end if;

    //Calculation of the modulation
    modulation = QAsked/QMax;

    //Calculation of the efficiency at the required modulation grade
    tableQ.u1 = u1;
    tableQ.u2 = u2;
    tableQ.u3 = modulation;

    //Final heat power of the heat source
    eta = if on then tableQ.y else 0;
    heatPort.Q_flow = -eta/data.etaRef*modulation/100*QNom - QLossesToCompensate;
    PFuel = if noEvent(release < 0.5) and noEvent(eta>Modelica.Constants.eps) then -heatPort.Q_flow/eta else 0;

  //HeatPort calculation if not modulating
  //****************************************************************************
  else
    table2.u1 = u1;
    table2.u2 = u2;

    eta = table2.y;

    //Final heat power of the heat source
    heatPort.Q_flow = -eta/data.etaRef*QNom - QLossesToCompensate;
    PFuel = if noEvent(release < 0.5) and noEvent(eta>Modelica.Constants.eps) then -heatPort.Q_flow/eta else 0;
  end if;

  //HeatPort environmental losses
  //****************************************************************************
  QLossesToCompensate = if noEvent(modulation > Modelica.Constants.eps) then UALoss*(heatPort.T - sim.Te) else 0;

  connect(port_a, senTem.port_a) annotation (Line(
      points={{-100,0},{-60,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem.port_b, port_b) annotation (Line(
      points={{-40,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None));

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics),
              Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Line(
          points={{-46,-3.30779e-015},{50,0}},
          color={191,0,0},
          thickness=0.5,
          origin={-20,-10},
          rotation=90),
        Line(
          points={{-46,-3.30779e-015},{50,0}},
          color={191,0,0},
          thickness=0.5,
          origin={20,-10},
          rotation=90),
        Line(
          points={{-20,-56},{0,-76}},
          color={191,0,0},
          thickness=0.5),
        Line(
          points={{0,-76},{20,-56}},
          color={191,0,0},
          thickness=0.5),
        Polygon(
          points={{-15,-20},{-15,20},{15,0},{-15,-20}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid,
          origin={21,54},
          rotation=90),
        Polygon(
          points={{-15,-20},{-15,20},{15,0},{-15,-20}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid,
          origin={-21,54},
          rotation=90),
        Rectangle(
          extent={{-10,40},{10,-40}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid,
          origin={0,80},
          rotation=90),
        Line(
          points={{-38,-46},{28,34}},
          color={0,0,0},
          smooth=Smooth.None,
          origin={-12,-14},
          rotation=90),
        Polygon(
          points={{-8,12},{12,-8},{8,-12},{-12,8},{-8,12}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          origin={-46,16},
          rotation=90)}), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics));
end HeatSource;
