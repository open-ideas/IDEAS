within IDEAS.Fluid.Production.BaseClasses;
model QAsked
  "Model to calculate the amount of heat needed to achieve a set temperature"

  //Parameters
  parameter Boolean useQSet=false "Set to true to use Q as an input";
  parameter Boolean reversible=false;
  replaceable package Medium =
    Modelica.Media.Interfaces.PartialMedium "Medium in the component"
      annotation (choicesAllMatching = true);

  Modelica.Blocks.Interfaces.RealInput u "Input signal. Can be Q or T" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,0}),  iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,52})));
  Modelica.Blocks.Interfaces.RealOutput y
    "Heat necessary to achieve the set temperature"                                       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,0}),  iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,0})));
  Modelica.Blocks.Interfaces.RealInput h_in(unit="J/kg")
    "Enthalpy value of the fluid"                                                      annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-122,38}),iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-108,20})));
  Modelica.Blocks.Interfaces.RealInput m_flow(unit="kg/s")
    "Massflow of the fluid"                                                        annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-118,-80}),iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-108,-20})));

 Modelica.Blocks.Interfaces.BooleanInput rev if reversible
    "Reverse the heat pump"                                                         annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={60,108}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-58,52})));
protected
  Modelica.Blocks.Interfaces.BooleanOutput rev_internal;
equation
  if reversible then
    connect(rev,rev_internal);
  else
    rev_internal = false;
  end if;
 if not useQSet then
    if rev_internal then
      y = IDEAS.Utilities.Math.Functions.smoothMin(0, m_flow*(Medium.specificEnthalpy(Medium.setState_pTX(Medium.p_default, u, Medium.X_default)) - h_in), 10);
    else
      y = IDEAS.Utilities.Math.Functions.smoothMax(0, m_flow*(Medium.specificEnthalpy(Medium.setState_pTX(Medium.p_default, u, Medium.X_default)) - h_in), 10);
    end if;
 else
    y = u;
 end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                         graphics={Rectangle(extent={{-100,40},{100,-40}},
            lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255}),
                                  Text(
          extent={{80,-60},{-60,60}},
          lineColor={0,0,255},
          textString="Q/T?"),
        Text(
          extent={{-86,32},{-66,12}},
          lineColor={0,0,255},
          textString="h"),
        Text(
          extent={{-86,-8},{-66,-28}},
          lineColor={0,0,255},
          textString="m")}),  Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics));
end QAsked;
