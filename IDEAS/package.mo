within ;
package IDEAS "Integrated District Energy Assessment Simulation"

extends Modelica.Icons.Package;

annotation (
  version="3.0.0",
  versionDate="2022-05-03",
  dateModified="2022-05-03",
  uses(Modelica(version="4.0.0")),
  Icon(graphics),
  conversion(
    from(version="0.3",
         to="1.0",
         script="modelica://IDEAS/Resources/Scripts/Conversion/ConvertIDEAS_from_0.3_to_1.0.mos"), 
    from(version="2.2.1", 
         to="3.0.0",
         script="modelica://IDEAS/Resources/Scripts/Conversion/ConvertIDEAS_from_2.2.1_to_3.0.0.mos")),
  preferredView="info",
  Documentation(info="<html>
<p>Licensed by KU Leuven and 3E</p>
<p>Copyright &copy; 2013-2023, KU Leuven and 3E. </p>
<p>
This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>;
For license information, view our <a href=\"https://github.com/open-ideas/IDEAS\">github page</a>.
</p>
</html>"));
end IDEAS;
