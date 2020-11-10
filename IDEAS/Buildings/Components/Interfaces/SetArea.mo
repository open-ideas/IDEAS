within IDEAS.Buildings.Components.Interfaces;
model SetArea "Block for setting area of the surface"
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.SIunits.Area A "Zone volume";



  AreaPort areaPort "Port for setting volume"  annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Blocks.Interfaces.RealInput v50   annotation (Placement(transformation(extent={{-126,48},{-86,88}})));

protected
  parameter Modelica.SIunits.VolumeFlowRate v50_ini(fixed=false);
  parameter Real q50_custome(fixed=false);

initial equation
  v50_ini=v50;

  if v50_ini>0 then
    q50_custome=0;
  else
    q50_custome=1;
  end if;

equation
  areaPort.A=A;
  areaPort.A_add=A*q50_custome;
  areaPort.v50=v50_ini;




end SetArea;
