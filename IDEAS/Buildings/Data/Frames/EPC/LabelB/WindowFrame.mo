within IDEAS.Buildings.Data.Frames.EPC.LabelB;
record WindowFrame "Frame data of Window"
    extends IDEAS.Buildings.Data.Interfaces.Frame(
    present=true,
    U_value=1,
    redeclare parameter IDEAS.Buildings.Components.ThermalBridges.LineLosses briTyp);
 annotation (Documentation(revisions="<html>
<ul>
<li>
January 3, 2025, by Anna Dell'Isola:<br/>
First implementation. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1267\">#1267</a>.
</li>
</ul>
</html>"));
end WindowFrame;
