within IDEAS.Fluid.Production.Interfaces.Data;
record VitoCal300GBWS301dotA08
  extends BaseClasses.PartialNonModulatingRecord(
    useTinPrimary=true,
    useTinSecondary=true,
    QNomRef=8000,
    heat={{0,268.15,273.15,275.15,283.15,288.15},{308.15,4.02,4.65,4.94,6.13,
        6.87},{318.15,3.02,3.45,3.69,4.66,5.27},{328.15,0,2.65,2.82,3.52,3.96},
        {333.15,0,0,2.44,3.06,3.45}},
    power={{0, 268.15,273.15,275.15,283.15,288.15},
            {308.15, 1710, 1690, 1690, 1680, 1670},
            {318.15, 2170, 2150, 2140, 2100, 2080},
            {328.15, 0, 2690, 2680, 2630, 2600},
            {333.15, 0, 0, 2950, 2920, 2900}});

end VitoCal300GBWS301dotA08;
