within IDEAS.Examples.Tutorial;
model Example3 "Adding occupant and lighting"
  extends Example2(zone(
      redeclare replaceable Buildings.Components.Occupants.Fixed occNum(nOccFix=1),
      redeclare Buildings.Components.OccupancyType.OfficeWork occTyp,
      redeclare Buildings.Components.RoomType.Office rooTyp,
      redeclare Buildings.Components.LightingType.LED ligTyp,
      redeclare Buildings.Components.LightingControl.OccupancyBased ligCtr));
end Example3;
