within IDEAS.Experimental.Electric.Distribution.AC.Examples;
model TestGridGeneral3P
  extends Modelica.Icons.Example;
  IDEAS.Experimental.Electric.Distribution.AC.Examples.Components.SinePower
    risingflankSingle1[3](amplitude=4000)
    annotation (Placement(transformation(extent={{40,0},{60,20}})));

  IDEAS.Experimental.Electric.Distribution.AC.Grid_3P grid3PGeneral(
    redeclare IDEAS.Experimental.Electric.Data.Grids.TestGrid2Nodes grid,
    redeclare IDEAS.Experimental.Electric.Data.TransformerImp.Transfo_250kVA
      transformer,
    traTCal=true)
    annotation (Placement(transformation(extent={{-36,0},{-16,20}})));
  inner IDEAS.BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-92,74},{-72,94}})));
equation

  connect(grid3PGeneral.gridNodes3P[:, 2], risingflankSingle1.nodes)
    annotation (Line(
      points={{-16,10},{40,10}},
      color={85,170,255},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}),
            graphics), Documentation(revisions="<html>
<ul>
<li>
May 22, 2022, by Filip Jorissen:<br/>
Removed experiment annotation to avoid failing OMC tests.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1254\">
#1254</a>
</li>
</ul>
</html>"));
end TestGridGeneral3P;
