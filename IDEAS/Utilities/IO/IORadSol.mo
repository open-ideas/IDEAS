within IDEAS.Utilities.IO;
model IORadSol "solar angle to surface"
  extends IDEAS.Climate.Meteo.Solar.RadSol(final inc=outWallPar.inc, final azi=outWallPar.azi,final lat=outWallPar.lat,final A=outWallPar.A);
  parameter IDEAS.Buildings.Components.BaseClasses.OuterWallParameters outWallPar;

end IORadSol;
