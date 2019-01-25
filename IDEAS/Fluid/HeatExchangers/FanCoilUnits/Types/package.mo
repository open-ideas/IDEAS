within IDEAS.Fluid.HeatExchangers.FanCoilUnits;
package Types
  extends Modelica.Icons.TypesPackage;

  type FCUConfigurations = enumeration(
    TwoPipeHea
    "Configuration for a 2-piped fan coil unit for heating",
    TwoPipeCoo
    "Configuration for a 2-piped fan coil unit for cooling",
    FourPipe
    "Configuration for a 4-piped fan coil unit ")
    "Enumaration to define the fan coil unit configurations"
  annotation (Documentation(info="<html>
<p>
Enumeration that defines the configuration in the fan-coil unit.
</p>
<p>
The following configurations are available in this enumeration:
</p>
<table summary=\"summary\" border=\"1\">
<tr><th>Enumeration</th><th>Description</th></tr>
<tr><td>TwoPipeHea</td><td>Configuration for a 2-piped fan coil unit for heating</td></tr>

<tr><td>TwoPipeCoo</td><td>Configuration for a 2-piped fan coil unit for cooling</td></tr>
<tr><td>FourPipe</td><td>Configuration for a 4-piped fan coil unit for heating and cooling</td></tr>
</table>
</html>",
  revisions="<html>
<ul>
<li>
January 21, 2019, by Iago Cupeiro:<br/>
First implementation.
</li>
</ul>
</html>"));
end Types;
