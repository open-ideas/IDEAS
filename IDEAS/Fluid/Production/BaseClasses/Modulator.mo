within IDEAS.Fluid.Production.BaseClasses;
model Modulator "Calculate the modulation of the heater."

  //Extensions
  //****************************************************************************
  extends dataHandler;

  //Parameters and constants
  //****************************************************************************
  parameter Boolean useQSet=false
    "Set to true to use a setpoint for Q instead of T";

  //Variables
  //****************************************************************************
  Modelica.SIunits.Power QMax
    "Maximum thermal power at 100% modulation for the given input conditions";
  Modelica.SIunits.Power QAsked(start=0) "Desired power of the heatsource";

  //Interfaces
  //****************************************************************************
  Modelica.Blocks.Interfaces.RealInput u
    "Required heat or temperature setpoint"
    annotation (Placement(transformation(extent={{-130,40},{-90,80}}),
        iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-60})));
  Modelica.Blocks.Interfaces.RealOutput modulation
    "required modulation of the heater"
    annotation (Placement(transformation(extent={{80,40},{120,80}}),
        iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,64})));

  //Components
  //****************************************************************************
  Utilities.Tables.InterpolationTable3D table(space=data.space) if
       not data.usePolynomial
    annotation (Placement(transformation(extent={{26,40},{46,60}})));

equation
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
      X={100, m_flow_eff, T_eff},
      n=data.n,
      k=data.k)/data.etaRef*data.QNomRef;
  else
    table.u1 = T_eff;
    table.u2 = m_flow_eff;
    table.u3 = 100;
    QMax = table.y/data.etaRef*data.QNomRef;
  end if;

  //Calculation of the modulation
  modulation = QAsked/QMax;

  connect(port_a, senTem.port_a) annotation (Line(
      points={{-100,0},{-60,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem.port_b, port_b) annotation (Line(
      points={{-40,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None));
                                                                      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Ellipse(
          extent={{-60,-60},{60,60}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Line(
          points={{-100,0},{-60,0}},
          color={0,0,0},
          smooth=Smooth.None,
          thickness=0.5),
        Line(
          points={{60,0},{90,0}},
          color={0,0,0},
          smooth=Smooth.None,
          thickness=0.5),
        Line(
          points={{0,60},{0,44}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{60,0},{42,0}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-42,0},{-60,0}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-38,18},{-54,26}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-20,36},{-30,52}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{30,52},{20,36}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{38,18},{54,26}},
          color={0,0,0},
          smooth=Smooth.None),
        Polygon(
          points={{-4,50},{-4,0},{4,0},{4,50},{-4,50}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-4,4},{4,-4}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}));
end Modulator;
