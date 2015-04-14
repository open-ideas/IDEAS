within IDEAS.Fluid.Production.Interfaces.BaseClasses;
model QAsked_save
  //Extensions
  extends IDEAS.Fluid.Interfaces.PartialTwoPortInterface;

  //Parameters
  parameter Boolean useQSet=false "Set to true to use Q as an input";

  Modelica.Blocks.Interfaces.RealInput u annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-20,108}), iconTransformation(
        extent={{-9,-9},{9,9}},
        rotation=270,
        origin={-21,69})));
  Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,106}), iconTransformation(
        extent={{-9,-9},{9,9}},
        rotation=90,
        origin={21,69})));
equation
  if not useQSet then
    y = IDEAS.Utilities.Math.Functions.smoothMax(0, m_flow*(Medium.specificEnthalpy(Medium.setState_pTX(Medium.p_default, u, Medium.X_default)) -port_b.h_outflow), 10);
 else
    y = u;
  end if;

  connect(port_a, port_b) annotation (Line(
      points={{-100,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                         graphics={Rectangle(extent={{-100,60},{100,-60}},
            lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255}),
                                  Text(
          extent={{80,-60},{-60,60}},
          lineColor={0,0,255},
          textString="Q?")}), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics));
end QAsked_save;
