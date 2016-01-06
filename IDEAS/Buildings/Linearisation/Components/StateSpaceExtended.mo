within IDEAS.Buildings.Linearisation.Components;
model StateSpaceExtended
  "State space model for structure. The model requires extended B and D matrices (B_ext = [B Ax0] and D_ext = [D Cx0]) in order to include the initial conditions."
  extends BaseClasses.partial_StateSpace;
  parameter Integer nout = 3
    "Number of outputs. This should be equal to stateSpace.nout, but Dymola return an error as the number of output cannot be checked";
  parameter Real[nout] y0 = 293.15*ones(stateSpace.nout)
    "Initial y corresponding to initial x0";

  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{10,-40},{-10,-20}})));
  Modelica.Blocks.Sources.Constant y_correction[nout](k=y0)
    annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
  Modelica.Blocks.Math.Add add[nout]
    annotation (Placement(transformation(extent={{34,-10},{54,10}})));
equation
  connect(const.y, stateSpace.u[end]) annotation (Line(points={{-11,-30},{-20,-30},
          {-20,0},{-12,0}}, color={0,0,127}));
  connect(stateSpace.y, add.u1)
    annotation (Line(points={{11,0},{20,0},{20,6},{32,6}}, color={0,0,127}));
  connect(y_correction.y, add.u2) annotation (Line(points={{11,-60},{20,-60},{20,
          -6},{32,-6}}, color={0,0,127}));
  connect(add.y, y)
    annotation (Line(points={{55,0},{104,0},{104,0}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),Documentation(info="<html>
<p>
This model is simulate a state space model which have B and D matrices including the initial condition x0.
This is particullarly usefull for reduced order models where you do not know the initial state.
The system equations are then:</p>
<p>
x+ = Ax + [B x0] [u 1].T
</p>
<p>
y = Cx + [D y0] [u 1].T
</p>
<p>
In order to get the reduced order model, look at \"Resources\\Matlab\\dymola_ROM.m\".
</html>",revisions="<html>
<ul>
<li>
July, 2015 by Damien Picard:<br/>
First implementation
</li>
</ul>
</html>"));
end StateSpaceExtended;
