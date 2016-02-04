within IDEAS.Electrical.Distribution.AC.BaseClasses;
model BranchLenTyp
  "A branch specified by its type of cable (ELECTAPub.GridsLib.LVCable) and its length in meters"
  extends IDEAS.Electrical.Distribution.AC.BaseClasses.Branch(
    R=typ.RCha*mulFac*len,
    X=typ.XCha*mulFac*len,
    prescribedHeatFlow);

  parameter Real mulFac=1;

  replaceable parameter IDEAS.Electrical.Data.Cables.PvcAl16 typ constrainedby
    IDEAS.Electrical.Data.Interfaces.Cable;

  //  parameter IDEAS.Electric.Data.Interfaces.Cable typ = IDEAS.Electric.Data.Cables.PvcAl16()
  //    "Cable type";
  parameter Modelica.SIunits.Length len=10 "Cable length";

end BranchLenTyp;
