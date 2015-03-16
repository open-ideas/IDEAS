within IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.FillingData;
record Sand "Sand filling material for GeoCool validation"
  extends Records.Filling(
    pathMod=
        "IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.FillingData.Sand",
    pathCom=Modelica.Utilities.Files.loadResource(
        "modelica://IDEAS/Fluid/HeatExchangers/GroundHeatExchangers/Borefield/Data/FillingData/Sand.mo"),
    k=1.6,
    d=1600,
    c=3000000/1600);

end Sand;
