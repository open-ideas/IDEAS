within IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.BorefieldData;
record INFRAX_bF =
    Records.BorefieldData (
    pathMod = "IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.BorefieldData.INFRAX_bF",
    pathCom = Modelica.Utilities.Files.loadResource("modelica://IDEAS/Fluid/HeatExchangers/GroundHeatExchangers/Borefield/Data/BorefieldData/INFRAX_bF.mo"),
    redeclare replaceable record Soi = SoilData.SoilINFRAX,
    redeclare replaceable record Fil = FillingData.FillingINFRAX,
    redeclare replaceable record Gen = GeneralData.GeneralINFRAX)
  "INFRAX borefield (38x94m doble U)";
