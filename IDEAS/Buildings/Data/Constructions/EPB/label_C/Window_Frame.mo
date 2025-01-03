within IDEAS.Buildings.Data.Constructions.EPB.label_C;
record Window_Frame    "Frame data of Window"
    extends IDEAS.Buildings.Data.Interfaces.Frame(
    present=true,
    U_value=3.210619815982335,
    redeclare parameter IDEAS.Buildings.Components.ThermalBridges.LineLosses briTyp(psi=0.06, len=4.419343590975968));
end Window_Frame;
