within IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.SoilData;
record SoilINFRAX "Soil properties for INFRAX borefield"
  extends Records.Soil(
    pathMod="IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.SoilData.SoilINFRAX",
    pathCom=Modelica.Utilities.Files.loadResource("modelica://IDEAS/Fluid/HeatExchangers/GroundHeatExchangers/Borefield/Data/SoilData/SoilINFRAX.mo"),
    k=1.34,
    c=2180,
    d=1785);

end SoilINFRAX;
