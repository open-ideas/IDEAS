within ;
package IDEAS "Integrated District Energy Assessment Simulation"

extends Modelica.Icons.Package;

annotation (
  uses(Modelica(version="4.0.0")),
  Icon(graphics),
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
</html>"));
end IDEAS;
