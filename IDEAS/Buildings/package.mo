within IDEAS;
package Buildings "Transient building models and model components"


extends Modelica.Icons.Package;









annotation (Icon(graphics={
        Rectangle(
          extent={{68,68},{-68,-72}},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(
          points={{-68,68},{68,68}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Rectangle(
          extent={{-40,-72},{40,-82}},
          lineThickness=0.5,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-30,-82},{68,20},{68,-44},{40,-72},{40,-82},{-30,-82},{-30,
            -82}},
          lineThickness=0.5,
          smooth=Smooth.None,
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-68,68},{-68,-72},{-40,-72},{-40,-82},{40,-82},{40,-72},{68,
            -72},{68,68}},
          color={0,0,0},
          smooth=Smooth.None,
          thickness=0.5)}));
end Buildings;
