within IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.GeneralData;
record GeneralGeoCool
  "General record for validation bore field using GeoCool project data"
extends Records.General(
    pathMod="IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.GeneralData.GeneralGeoCool",
    pathCom=Modelica.Utilities.Files.loadResource("modelica://IDEAS/Fluid/HeatExchangers/GroundHeatExchangers/Borefield/Data/GeneralData/GeneralGeoCool.mo"),
    m_flow_nominal_bh=2790/3600/6,
    rBor=0.15/2,
    hBor=50,
    nbBh=6,
    nbSer=1,
    cooBh={{0,0},{3,0},{6,0},{0,3},{3,3},{6,3}},
    rTub=0.0254/2,
    kTub=0.38,
    eTub=0.0023,
    xC=0.07,
    T_start=273.15+19.5,
    tStep=600);
    //todo:  kTub, eTub unknown!
end GeneralGeoCool;
