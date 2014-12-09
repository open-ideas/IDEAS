within IDEAS.Fluid.Production.Data.Polynomials;
record Boiler2ndDegree
  //Extensions
  extends IDEAS.Fluid.Production.BaseClasses.PartialData(
     use_polynomial = true,
     QNomRef=10100,
     etaRef=0.922,
     modulationMin=10,
     modulationStart=20,
     TMax=273.15+80,
     TMin=273.15+20,
     beta={1.10801352268,-0.00139459489796,7.84565873015e-05,-0.00560282142857,-4.15816326533e-07,3.9307142857e-07,1.587e-05,-3.86712018138e-08,-4.29261904761e-07,2.67019047619e-05},
     powers={{2,0,0,0},{1,1,0,0},{1,0,1,0},{1,0,0,1},{0,2,0,0},{0,1,1,0},{0,1,0,1},{0,0,2,0},{0,0,1,1},{0,0,0,2}});

end Boiler2ndDegree;
