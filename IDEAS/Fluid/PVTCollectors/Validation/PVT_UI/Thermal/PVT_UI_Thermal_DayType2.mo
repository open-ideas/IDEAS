within IDEAS.Fluid.PVTCollectors.Validation.PVT_UI.Thermal;
model PVT_UI_Thermal_DayType2
  "Test model for Unglazed Rear-Insulated PVT Collector"
  extends PVT_UI_Thermal_DayType1
                            (pvtTyp="Typ2", T_start=24.79173678 + 273.15);
  annotation (
__Dymola_Commands(file="modelica://IDEAS/Resources/Scripts/Dymola/Fluid/PVTCollectors/Validation/PVT_UI/Thermal/PVT_UI_Thermal_DayType2.mos"
        "Simulate and plot"),
 experiment(
      StartTime=17228880,
      StopTime=17270040.0,
      Interval=60,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"));
end PVT_UI_Thermal_DayType2;
