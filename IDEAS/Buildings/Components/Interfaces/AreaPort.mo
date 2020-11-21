within IDEAS.Buildings.Components.Interfaces;
connector AreaPort "Port for summing wall surface areas"
  Modelica.SIunits.Area A_tot "Total Area";
  flow Modelica.SIunits.Area A "Area";

  Modelica.SIunits.Area A_def_tot "Total area with default assignment";
  flow Modelica.SIunits.Area A_def "Area with default assignment";

  Real V50_cust( unit="m3/h") "Total custom assigned flowrate through surfaces connected to the outdoors";
  flow Real v50( unit="m3/h")  "Custom assigned volume flow rate of each surface, 0 if not custom ";


  annotation (Documentation(info="<html>

</html>"));
end AreaPort;
