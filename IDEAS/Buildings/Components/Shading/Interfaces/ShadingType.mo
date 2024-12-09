within IDEAS.Buildings.Components.Shading.Interfaces;
type ShadingType = enumeration(
    None
       "None",
    BuildingShade
                "Buildings shade",
    Overhang
           "Overhang",
    SideFins
           "Side fins",
    Box
      "Box: overhang and side fins",
    Screen
         "Screen",
    OverhangAndScreen
                    "Overhang and screen",
    BoxAndScreen
          "Box and screen",
    HorizontalFins
          "Horizontal fins",
    OverhangAndHorizontalFins
          "Overhang and horizontal fins")
  annotation (
  Documentation(revisions="<html>
<ul>
<li>
July 29, 2024, by Jelger Jansen:<br/>
Remove the Shading option.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1368\">#1368</a>.
</li>
<li>
May 4 2018, by Iago Cupeiro:<br/>
Extended with HorizontalFins and OverhangAndHorizontalFins models.
</li>
</ul>
</html>"));
