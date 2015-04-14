within IDEAS.Fluid.Production.Interfaces.BaseClasses;
model QAsked
  //Parameters
  parameter Boolean useQSet=false "Set to true to use Q as an input";
  replaceable package Medium =
    Modelica.Media.Interfaces.PartialMedium "Medium in the component"
      annotation (choicesAllMatching = true);

  Modelica.Blocks.Interfaces.RealInput u annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-118,0}),  iconTransformation(
        extent={{-9,-9},{9,9}},
        rotation=0,
        origin={-109,-1})));
  Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={108,0}),  iconTransformation(
        extent={{-9,-9},{9,9}},
        rotation=0,
        origin={105,1})));
  Modelica.Blocks.Interfaces.RealInput h_in(unit="J/kg") annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,80}),iconTransformation(
        extent={{-9,-9},{9,9}},
        rotation=0,
        origin={-109,91})));
  Modelica.Blocks.Interfaces.RealInput m_flow(unit="kg/s") annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-118,-80}),iconTransformation(
        extent={{-9,-9},{9,9}},
        rotation=0,
        origin={-109,-81})));
equation
 if not useQSet then
    y = IDEAS.Utilities.Math.Functions.smoothMax(0, m_flow*(Medium.specificEnthalpy(Medium.setState_pTX(Medium.p_default, u, Medium.X_default)) - h_in), 10);
 else
    y = u;
 end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                         graphics={Rectangle(extent={{-100,100},{100,-100}},
            lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255}),
                                  Text(
          extent={{80,-60},{-60,60}},
          lineColor={0,0,255},
          textString="Q/T?")}),
                              Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics));
end QAsked;
