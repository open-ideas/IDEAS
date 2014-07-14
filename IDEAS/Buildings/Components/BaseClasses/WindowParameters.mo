within IDEAS.Buildings.Components.BaseClasses;
record WindowParameters
  extends Modelica.Icons.Record;
  parameter Modelica.SIunits.Angle inc(displayUnit="degree") "inclination";
  parameter Modelica.SIunits.Angle azi(displayUnit="degree") "azimuth";
  parameter Modelica.SIunits.Angle lat(displayUnit="degree");
  parameter Modelica.SIunits.Area A;

  parameter Real frac "Area fraction of the window frame";

//    replaceable record Glazing =  IDEAS.Buildings.Data.Glazing.Ins2
//     "Glazing type"
//      annotation (__Dymola_choicesAllMatching=true, Dialog(group=
//            "Construction details"));
//    Glazing glazing;
end WindowParameters;
