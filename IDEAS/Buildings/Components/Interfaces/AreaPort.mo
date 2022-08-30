within IDEAS.Buildings.Components.Interfaces;
connector AreaPort "Port for summing wall surface areas"
  Modelica.Units.SI.Area A_tot "Total Area";
  flow Modelica.Units.SI.Area A "Area";

  Modelica.Units.SI.Area A_def_tot "Total area with default assignment";
  flow Modelica.Units.SI.Area A_def "Area with default assignment";

  Real V50_cust( unit="m3/h") "Total custom assigned v50 value";
  flow Real v50( unit="m3/h")  "Custom assigned v50 value";


  annotation (Documentation(info="<html>

</html>"));
end AreaPort;
