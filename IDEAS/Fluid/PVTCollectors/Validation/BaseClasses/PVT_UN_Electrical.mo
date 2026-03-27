within IDEAS.Fluid.PVTCollectors.Validation.BaseClasses;
model PVT_UN_Electrical
  extends PVT_UI_Electrical_DayType1(
    replaceable package Medium = IDEAS.Media.Antifreeze.PropyleneGlycolWater(
      property_T = 293.15,
      X_a = 0.43),
    redeclare record PVTData = IDEAS.Fluid.PVTCollectors.Data.Uncovered.UN_Validation,
    T_start = 17.086651 + 273.15,
    eleLosFac = 0.07,
    til = 0.34906585039887,
    azi = 0,
    idxTFlu = 2,
    idxMFlow = 3,
    idxGtil = 4,
    idxWinSpe = 10,
    idxTAmb = 5,
    idxMeaPel = 19,
    meaFile = "modelica://IDEAS/Resources/Data/Fluid/PVTCollectors/Validation/PVT_UN/PVT_UN_measurements_" + week + ".txt",
    datPVTCol = datPVTCol);

  parameter String week = "week1";

  // Redeclare the collector to the UN version
  redeclare IDEAS.Fluid.PVTCollectors.Validation.PVT_UN.PVTCollectorValidation pvtCol(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=T_start,
    show_T=true,
    azi=0,
    til=0.34906585039887,
    rho=0.2,
    nColType=IDEAS.Fluid.SolarCollectors.Types.NumberSelection.Number,
    nPanels=1,
    per=datPVTCol,
    eleLosFac=eleLosFac);
end PVT_UN_Electrical;
