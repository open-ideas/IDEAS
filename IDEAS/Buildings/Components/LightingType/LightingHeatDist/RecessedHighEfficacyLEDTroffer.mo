within IDEAS.Buildings.Components.LightingType.LightingHeatDist;
record RecessedHighEfficacyLEDTroffer
  "Recessed LED troffer uniform diffuser"
  extends
    IDEAS.Buildings.Components.LightingType.BaseClasses.PartialLightingHeatDist(
      spaFra=0.59, radFra=0.51);

  annotation (Documentation(revisions="<html>
<ul>
<li>
August 28, 2018 by Iago Cupeiro:<br/>
First implementation
See <a href=\"https://github.com/open-ideas/IDEAS/issues/879\">#879</a>.
</li>
</ul>
</html>", info="<html>
<p>
Lighting gains distribution for high-efficacy LED troffer
</p>
</html>"));
end RecessedHighEfficacyLEDTroffer;