within IDEAS.Buildings.Components.Interfaces;
connector AreaPort "Port for summing wall surface areas"
  Modelica.SIunits.Area A_tot "Total Area";
  flow Modelica.SIunits.Area A "Area";

  Modelica.SIunits.Area A_add_tot "Total Area";
  flow Modelica.SIunits.Area A_add "Area";

  Real V50_cust( unit="m3/h") "total custome assigned flowrate through surfaces connected to the outdoors";
  flow Real v50( unit="m3/h")  "custome assigned volume flow rate of each surface, 0 if not custome ";


  annotation (Documentation(info="<html>

</html>"));
end AreaPort;
