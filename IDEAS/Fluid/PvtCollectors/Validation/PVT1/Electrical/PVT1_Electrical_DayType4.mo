within IDEAS.Fluid.PvtCollectors.Validation.PVT1.Electrical;
model PVT1_Electrical_DayType4
  "Test model for Unglazed Rear-Insulated PVT Collector"
  extends PVT1_Electrical_DayType1(pvtTyp="Typ4", T_start=48.60870229 + 273.15);
  annotation (experiment(
      StartTime=17837640,
      StopTime=17872560.0,
      Interval=60,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"));
end PVT1_Electrical_DayType4;
