within IDEAS.Fluid.Production.Data.PerformanceMaps;
record Boiler1D "Example of 1D performance table for condensing boiler"
  extends IDEAS.Fluid.Production.BaseClasses.PartialData(
    use_1DHeatSource = true,
    QNomRef=10100,
    etaRef=0.922,
    modulationMin=10,
    modulationStart=20,
    TMax=273.15+80,
    TMin=273.15+20,
    table=[
      20,30,40,50,60,70,80;
      0.9969,0.9671,0.9293,0.8831,0.8562,0.8398,0.8374]);

end Boiler1D;
