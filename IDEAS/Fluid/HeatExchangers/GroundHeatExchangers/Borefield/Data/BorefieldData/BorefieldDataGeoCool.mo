within IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.BorefieldData;
record BorefieldDataGeoCool =
                          Records.BorefieldData (
    pathMod = "IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.BorefieldData.BorefieldDataGeoCool",
    pathCom = Modelica.Utilities.Files.loadResource("modelica://IDEAS/Fluid/HeatExchangers/GroundHeatExchangers/Borefield/Data/BorefieldData/BorefieldDataGeoCool.mo"),
    redeclare replaceable record Soi =
        IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.SoilData.Sand,
    redeclare replaceable record Fil =
        IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.FillingData.Sand,
    redeclare replaceable record Gen =
        IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.GeneralData.GeneralGeoCool)
  "BorefieldData record for bore field validation using data from GeoCool project";
