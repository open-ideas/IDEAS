within IDEAS.Buildings.Data.Constructions.EPB.label_A;
record Window_Frame    "Frame data of Window"
    extends IDEAS.Buildings.Data.Interfaces.Frame(
    present=true,
    U_value=1.6875812692659027,
    redeclare parameter IDEAS.Buildings.Components.ThermalBridges.LineLosses briTyp(psi=0.06, len=3.824108964701916));
end Window_Frame;
