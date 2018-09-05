within IDEAS.Buildings.Components.LightingType.LightingHeatDist;
record NonInCeilingFluorescentLuminaire
  "Non-in-ceiling fluorescent luminaire"
  extends
    IDEAS.Buildings.Components.LightingType.BaseClasses.PartialLightingHeatDist(
      spaFra=1.0, radFra=0.54);

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
Lighting gains distribution for non-in-ceiling fluoreecent luminaire
</p>
</html>"));
end NonInCeilingFluorescentLuminaire;