within ;
package IDEAS "Integrated District Energy Assessment Simulation"

import      Modelica.Units.SI;

annotation (
  uses(Modelica(version="4.0.0")),
  version="3.0.0",
  versionDate="2022-05-03",
  dateModified = "2022-05-03",
  conversion(
 from(version={"0.2"},
      script="modelica://IDEAS/Resources/Scripts/convertIdeas030to100.mos",
      to="2.2.1"), from(version="2.2.1", script=
          "modelica://IDEAS/Resources/Scripts/ConvertFromIDEAS_2.2.1.mos")),
  Documentation(info="<html>
<p>Licensed by KU Leuven and 3E</p>
<p>Copyright &copy; 2013-2023, KU Leuven and 3E. </p>
<p>
This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>;
For license information, view our <a href=\"https://github.com/open-ideas/IDEAS\">github page</a>.
</p>
</html>"),
  Icon(graphics={
      Polygon(
        points={{-60,0},{60,0},{60,-90},{-60,-90},{-60,0}},
        lineColor={0,0,0},
        lineThickness=1),
      Polygon(
        points={{-40,0},{-40,0}},
        lineColor={0,0,0},
        lineThickness=1),
      Polygon(
        points={{-36,20},{36,20},{60,0},{-60,0},{-36,20}},
        lineColor={0,0,0},
        lineThickness=1),
      Polygon(
        points={{-60,0},{-50,-22},{50,-22},{60,0},{-60,0}},
        lineColor={0,0,0},
        lineThickness=1,
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Polygon(
        points={{60,0},{36,20},{46,22},{74,0},{60,0}},
        lineColor={0,0,0},
        lineThickness=1,
        fillColor={255,255,255},
        fillPattern=FillPattern.None),
      Polygon(
        points={{-36,20},{36,20},{42,30},{-40,30},{-36,20}},
        lineColor={0,0,0},
        lineThickness=1,
        fillColor={255,255,255},
        fillPattern=FillPattern.None),
      Polygon(
        points={{-36,20},{-54,22},{-84,0},{-60,0},{-36,20}},
        lineColor={0,0,0},
        lineThickness=1,
        fillColor={255,255,255},
        fillPattern=FillPattern.None),
      Bitmap(extent={{-40,-84},{40,-26}}, fileName=
            "modelica://IDEAS/Resources/Images/idea.png"),
      Bitmap(extent={{-80,0},{80,90}}, fileName=
            "modelica://IDEAS/Resources/Images/house.png")}));
end IDEAS;
