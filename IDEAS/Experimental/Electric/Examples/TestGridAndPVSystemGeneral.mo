within IDEAS.Experimental.Electric.Examples;
model TestGridAndPVSystemGeneral
  "Test to see if Grid and PV(from file) work as it should"
extends Modelica.Icons.Example;
  Photovoltaics.PVSystemGeneral pVSystemGeneral(numPha=3, redeclare
      Data.PvPanels.SanyoHIP230HDE1                pvPanel)
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  inner IDEAS.BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Distribution.AC.Grid_3P                             gridGeneral(
    VSource=(230*1.02) + 0*Modelica.ComplexMath.j,
    redeclare Data.Grids.Ieee34_AL120                grid,
    redeclare Data.TransformerImp.Transfo_100kVA transformer,
    traTCal=true)
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
equation
      connect(pVSystemGeneral.pin, gridGeneral.gridNodes3P[:, 2]) annotation (Line(
      points={{-39.8,74},{-30,74},{-30,10},{-40,10}},
      color={85,170,255},
      smooth=Smooth.None));
  annotation (Documentation(revisions="<html>
<ul>
<li>
February 7, 2025, by Jelger Jansen:<br/>
Added <code>Modelica.ComplexMath.</code> to one or multiple parameter(s) due to the removal of <code>import</code> in IDEAS/Experimental/Electric/package.mo.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1415\">#1415</a> .
</li>
<li>
May 22, 2022, by Filip Jorissen:<br/>
Removed experiment annotation to avoid failing OMC tests.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1254\">
#1254</a>
</li>
</ul>
</html>"));
end TestGridAndPVSystemGeneral;
