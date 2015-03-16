within IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.SoilData;
record Sand "Sand soil material for GeoCool validation"
  extends Records.Filling(
    pathMod=
        "IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.SoilData.Sand",
    pathCom=Modelica.Utilities.Files.loadResource(
        "modelica://IDEAS/Fluid/HeatExchangers/GroundHeatExchangers/Borefield/Data/SoilData/Sand.mo"),
    k=1.43,
    d=1600,
    c=2250000/1600);

end Sand;
