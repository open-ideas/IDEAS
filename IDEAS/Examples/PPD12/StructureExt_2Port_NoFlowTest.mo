within IDEAS.Examples.PPD12;
model StructureExt_2Port_NoFlowTest "Constant temperature, no wind boundary conditions"
  parameter Modelica.Units.SI.Temperature T_start = 283.15 "10 degrees";
  extends IDEAS.Examples.PPD12.StructureExt_2Port(
hallway(T_start=T_start, TeAvg=T_start, TiAvg=T_start, dTeAvg=0, dTiAvg=0),
living(T_start=T_start, TeAvg=T_start, TiAvg=T_start, dTeAvg=0, dTiAvg=0),
Diner(T_start=T_start, TeAvg=T_start, TiAvg=T_start, dTeAvg=0, dTiAvg=0),
Porch(T_start=T_start, TeAvg=T_start, TiAvg=T_start, dTeAvg=0, dTiAvg=0),
bedRoom1(T_start=T_start, TeAvg=T_start, TiAvg=T_start, dTeAvg=0, dTiAvg=0),
bathRoom(T_start=T_start, TeAvg=T_start, TiAvg=T_start, dTeAvg=0, dTiAvg=0),
stairWay(T_start=T_start, TeAvg=T_start, TiAvg=T_start, dTeAvg=0, dTiAvg=0),
bedRoom2(T_start=T_start, TeAvg=T_start, TiAvg=T_start, dTeAvg=0, dTiAvg=0),
bedRoom3(T_start=T_start, TeAvg=T_start, TiAvg=T_start, dTeAvg=0, dTiAvg=0),
Roof1(T_start=T_start),
out1(T_start=T_start),
Roof2(T_start=T_start),
out2(T_start=T_start),
com1(T_start=T_start),
cei1(T_start=T_start),
cei2(T_start=T_start),
cei3(T_start=T_start),
winBed3(T_start=T_start),
sim(filNam=
    Modelica.Utilities.Files.loadResource("modelica://IDEAS/Resources/weatherdata/IdealBoundaryConditions.mos")));
end StructureExt_2Port_NoFlowTest;