within IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.FillingData;
record FillingINFRAX "Filling data for INFRAX bore field"
  extends Records.Filling(
    pathMod="IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.FillingData.FillingINFRAX",
    pathCom=Modelica.Utilities.Files.loadResource("modelica://IDEAS/Fluid/HeatExchangers/GroundHeatExchangers/Borefield/Data/FillingData/FillingINFRAX.mo"),
    k=2.35,
    d=1490,
    c=840);

    //On 200L grout is the borehole filling composition
    //- 25 kg blast furnace cement
    //- 15 kg bentonite cement stable
    //- 80 kg of quartz sand (30 micr.)
    //- 125 l of water
end FillingINFRAX;
