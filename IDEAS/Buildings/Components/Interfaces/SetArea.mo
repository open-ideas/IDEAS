within IDEAS.Buildings.Components.Interfaces;
model SetArea "Block for setting area of the surface"
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.SIunits.Area A "Zone volume";
  AreaPort areaPort "Port for setting volume"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));

equation
  areaPort.A=A;

end SetArea;
