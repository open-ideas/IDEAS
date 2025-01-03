within IDEAS.Buildings.Data.Constructions.EPB.label_B;
record Window_Frame    "Frame data of Window"
    extends IDEAS.Buildings.Data.Interfaces.Frame(
    present=true,
    U_value=5.9,
    redeclare parameter IDEAS.Buildings.Components.ThermalBridges.LineLosses briTyp(psi=0.06, len=3.5176479597266095));
end Window_Frame;
