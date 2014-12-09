within IDEAS.Fluid.Production.Data.PerformanceMaps;
record Boiler2D "Example of 2D performance table for condensing boiler"

  extends IDEAS.Fluid.Production.BaseClasses.PartialData(
    use_2DHeatSource = true,
    QNomRef=10100,
    etaRef=0.922,
    modulationMin=10,
    modulationStart=20,
    TMax=273.15+80,
    TMin=273.15+20,
    table=[0, 100, 400, 700, 1000, 1300; 20.0, 0.9015, 0.9441, 0.9599, 0.9691,
          0.9753; 30.0, 0.8824, 0.9184, 0.9324, 0.941, 0.9471; 40.0, 0.8736,
          0.8909, 0.902, 0.9092, 0.9143; 50.0, 0.8676, 0.8731, 0.8741, 0.8746,
          0.8774; 60.0, 0.8, 0.867, 0.8681, 0.8686, 0.8689; 70.0, 0.8, 0.8609,
          0.8619, 0.8625, 0.8628; 80.0, 0.8, 0.8547, 0.8558, 0.8563, 0.8566]);

end Boiler2D;
