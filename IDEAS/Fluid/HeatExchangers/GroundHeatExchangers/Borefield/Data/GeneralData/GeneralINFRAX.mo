within IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.GeneralData;
record GeneralINFRAX
  "INFRAX parameters of the geometrical configuration of the borefield"
extends Records.General(
    pathMod="IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.GeneralData.GeneralINFRAX",
    pathCom=Modelica.Utilities.Files.loadResource("modelica://IDEAS/Fluid/HeatExchangers/GroundHeatExchangers/Borefield/Data/GeneralData/GeneralINFRAX.mo"),
    m_flow_nominal_bh=10.55/38,
    rBor=0.15/2,
    hBor=94,
    nbBh=38,
    nbSer=1,
    singleUTube = false,
    parallel2UTube = true,
    cooBh={{3, 0},{9, 0},{15, 0},{21, 0},{27, 0},{33, 0},{39, 0},{45, 0},{51, 0},
           {0, sqrt(45)},{6, sqrt(45)},{12, sqrt(45)},{18, sqrt(45)},{24, sqrt(45)},{36, sqrt(45)},{42, sqrt(45)},{48, sqrt(45)},{54, sqrt(45)},
           {3, 2*sqrt(45)},{9, 2*sqrt(45)},{15, 2*sqrt(45)},{21, 2*sqrt(45)},{27, 2*sqrt(45)},{33, 2*sqrt(45)},{39, 2*sqrt(45)},{45, 2*sqrt(45)},{51, 2*sqrt(45)},
           {48, 3*sqrt(45)},{51, 4*sqrt(45)},{48, 5*sqrt(45)},{51, 6*sqrt(45)},{48, 7*sqrt(45)},{51, 8*sqrt(45)},{48, 9*sqrt(45)},{51, 10*sqrt(45)},{48, 11*sqrt(45)},{51, 12*sqrt(45)},{48, 13*sqrt(45)}},
    rTub=0.032/2,
    kTub=0.42,
    eTub=0.003,
    xC=rTub*sqrt(2),
    T_start=273.15+15,
    use_Rb = true,
    Rb = 0.094);

                     //Assumming Double U is placed in center of BH
                 //Thermal conductivity of HPDE
                         // data sheet
                 // building plans
                               //building plans                                                                                                    //undeep boreholes
                                                                                                    //deep boreholes
                 // data sheet
               // external sources
                 // data sheet
                  // assuming pipe is symmetrically spaced
end GeneralINFRAX;
