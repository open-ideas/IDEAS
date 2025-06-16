within IDEAS.Fluid.PvtCollectors.Validation.PVT1.Thermal;
model PVT1_Thermal_DayType2
  extends PVT1_Thermal_DayType1
                            (pvtTyp="Typ2", T_start=24.79173678 + 273.15);
  annotation (experiment(
      StartTime=17228880,
      StopTime=17270040.0,
      Interval=60,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"));
end PVT1_Thermal_DayType2;
