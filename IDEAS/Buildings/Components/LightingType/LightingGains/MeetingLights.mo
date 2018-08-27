within IDEAS.Buildings.Components.LightingType.LightingGains;
record MeetingLights
  "Properties for typical meeting/conference rooms"
  extends
    IDEAS.Buildings.Components.LightingType.BaseClasses.PartialLightingGains(
      W_per_sqm=13.3);

  annotation (Documentation(revisions="<html>
<ul>
<li>
July 18, 2016 by Filip Jorissen:<br/>
First implementation
</li>
</ul>
</html>", info="<html>
<p>
See documentation in IDEAS.Buildings.Components.OccupancyType.PartialOccupancyType.
This model is based on Fanger and Ashrae Fundamentals (2009).
</p>
<h4>References</h4>
<ul>
<li>
ASHRAE Handbook, Fundamentals.
 American Society of Heating, Refrigerating and Air-Conditioning Engineers,
Chapter 18, Internal Heat Gains; pages 18.4; Atlanta, USA, 2009.
</li>
</ul>
</html>"));
end MeetingLights;