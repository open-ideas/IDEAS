within IDEAS.Buildings.Components.Shading;
model OverhangAndHFins "Roof overhangs and horizontal fins shading"

  parameter Modelica.SIunits.Length hWin(min=0) "Window height"
    annotation(Dialog(group="Window properties"));
  parameter Modelica.SIunits.Length wWin(min=0) "Window width"
    annotation(Dialog(group="Window properties"));

  parameter Modelica.SIunits.Length wLeft(min=0)
    "Left overhang width measured from the window corner"
    annotation(Dialog(group="Overhang properties"));
  parameter Modelica.SIunits.Length wRight(min=0)
    "Right overhang width measured from the window corner"
    annotation(Dialog(group="Overhang properties"));
  parameter Modelica.SIunits.Length dep(min=0)
    "Overhang depth perpendicular to the wall plane"
    annotation(Dialog(group="Overhang properties"));
  parameter Modelica.SIunits.Length gap(min=0)
    "Distance between window upper edge and overhang lower edge"
    annotation(Dialog(group="Overhang properties"));
  parameter Modelica.SIunits.Angle beta(min=0) "inclination angle of shading fins"
  annotation(Dialog(group="Horizontal fins properties"));
  parameter Modelica.SIunits.Length l(min=0) "distance between shading fins, in meters"
  annotation(Dialog(group="Horizontal fins properties"));
  parameter Modelica.SIunits.Length D(min=0) "size of the fins, in meters"
  annotation(Dialog(group="Horizontal fins properties"));
  parameter Modelica.SIunits.Length w(min=0) "width of the fins, in meters"
  annotation(Dialog(group="Horizontal fins properties"));


  extends IDEAS.Buildings.Components.Shading.Interfaces.DoubleShading(
      redeclare IDEAS.Buildings.Components.Shading.HorizontalFins stateShading1(
        azi=azi,
        beta=beta,
        l=l,
        D=D,
        w=w),
      redeclare IDEAS.Buildings.Components.Shading.Overhang stateShading2(
        azi=azi,
        hWin=hWin,
        wWin=wWin,
        wLeft=wLeft,
        wRight=wRight,
        dep=dep,
        gap=gap));

<p>This model describes the transient behaviour of solar irradiance on a window below a non-fixed horizontal or vertical overhang combined with a controllable screen.</p>
</html>", revisions="<html>
<ul>
<li>
April 207, by Iago Cupeiro Figueroa:<br/>
Now extending from IDEAS.Buildings.Components.Interfaces.DoubleShading.
</li>
<li>
December 2017, by Iago Cupeiro Figueroa:<br/>
First implementation.
</li>
</ul>
</html>"));
end OverhangAndHFins;
