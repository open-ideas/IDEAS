within IDEAS.Buildings.Components.Interfaces;
connector AreaPort "Port for summing wall surface areas"
  Modelica.SIunits.Area A_tot "Total Area";
  flow Modelica.SIunits.Area A "Area";

  Modelica.SIunits.Area A_add_tot "Total Area";
  flow Modelica.SIunits.Area A_add "Area";

  Modelica.SIunits.VolumeFlowRate V50_cust "total custome assigned flowrate through surfaces connected to the outdoors";
  flow Modelica.SIunits.VolumeFlowRate v50 "custome assigned volume flow rate of each surface, 0 if not custome ";


  annotation (Documentation(info="<html>

</html>"));
end AreaPort;
