within IDEAS.Fluid.Production.Data.PerformanceMaps.Boilers;
record CHP

//Extensions
  extends IDEAS.Fluid.Production.BaseClasses.PartialNonModulatingRecord(
    useTin2=false,
    efficiencyData=true,
    QNomRef=10100,
    etaRef=0.96,
    heat={
      { 0,     0.5,    0.75,   1},
      { 30.0,  0.655,  0.656,  0.670},
      { 40.0,  0.616,  0.617,  0.631},
      { 50.0,  0.576,  0.577,  0.591},
      { 60.0,  0.537,  0.538,  0.552},
      { 65.0,  0.517,  0.518,  0.532}},
    power={
      { 0,     0.5,    0.75,   1},
      { 30.0,  0.203,  0.238,  0.270},
      { 40.0,  0.203,  0.238,  0.270},
      { 50.0,  0.203,  0.238,  0.270},
      { 60.0,  0.203,  0.238,  0.270},
      { 65.0,  0.203,  0.238,  0.270}},
    m2 = 400,
    m2_flow_nominal = 0.15,
    dp2_nominal = 0);

end CHP;
