within IDEAS.Buildings.Components.Interfaces;
model SetArea "Block for setting area of the surface"
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.SIunits.Area A "Zone volume";

  IDEAS.Buildings.Components.Interfaces.AreaPort areaPort
    "Port for setting volume"
     annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Blocks.Interfaces.RealInput v50
    "v50 value"
   annotation (Placement(transformation(extent={{-126,48},{-86,88}})));
  Modelica.Blocks.Interfaces.RealInput nonCust
    annotation (Placement(transformation(extent={{-126,6},{-86,46}})));
  Modelica.Blocks.Interfaces.BooleanInput custom_n50
    "Is the zones n50 custom?"
     annotation (Placement(transformation(extent={{-126,-30},{-86,10}})));

protected
  parameter Real v50_ini(unit="m3/h",fixed=false)
    "v50 if flow is custom, else 0";


initial equation
  if nonCust>0 and not custom_n50 then
    v50_ini=0;
  else
    v50_ini=v50;
  end if;


equation
  areaPort.A=A;
  areaPort.A_def=A*nonCust*(if custom_n50 then 0 else 1); // if surface is not custom, then the area is communicated, else 0
  areaPort.v50=v50_ini; //v50 if the surface has a custome v50, else 0

end SetArea;
