within IDEAS.Buildings.Components.LightingType.BaseClasses;
partial record PartialLighting
  "Record for defining the lighting type"
  extends Modelica.Icons.Record;

  parameter Real radFra(min=0,max=1)
    "Radiant fraction of lighting heat exchange";

  parameter Modelica.Units.SI.LuminousEfficacy K
    "Luminous efficacy, specifies the lm/W (lumen per watt) of the installed lighting";

  final parameter Real conFra(min=0, max=1) = 1-radFra
    "Convective fraction of lighting heat exchange";
  annotation (Documentation(revisions="<html>
<ul>
<li>
April 3, 2023 by Jelger Jansen:<br/>
Removed protected section and replaced by a final parameter. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1314\">#1314</a>.
</li>
<li>
September 26, 2018 by Iago Cupeiro:<br/>
First implementation
See <a href=\"https://github.com/open-ideas/IDEAS/issues/879\">#879</a>.
</li>
</ul>
</html>", info="<html>
<p>This record may be used to describe the relevant parameters of the lighting installation of a determined zone, i.e. the luminous efficacy (in<i> lm/W</i>) and the fraction between the convective and radiative heat gains.</p>
</html>"));

end PartialLighting;
