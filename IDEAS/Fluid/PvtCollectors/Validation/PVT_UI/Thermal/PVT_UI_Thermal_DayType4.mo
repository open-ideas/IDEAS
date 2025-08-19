within IDEAS.Fluid.PVTCollectors.Validation.PVT_UI.Thermal;
model PVT_UI_Thermal_DayType4
  "Test model for Unglazed Rear-Insulated PVT Collector"
  extends PVT_UI_Thermal_DayType1
                            (pvtTyp="Typ4", T_start=48.60870229 + 273.15);
  annotation (
__Dymola_Commands(file="modelica://IDEAS/Resources/Scripts/Dymola/Fluid/PVTCollectors/Validation/PVT_UI/Thermal/PVT_UI_Thermal_DayType4.mos"
        "Simulate and plot"),
 experiment(
      StartTime=17837640,
      StopTime=17872560.0,
      Interval=60,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"));
end PVT_UI_Thermal_DayType4;
