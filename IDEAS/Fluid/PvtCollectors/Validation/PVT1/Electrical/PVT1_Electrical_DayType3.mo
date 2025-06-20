within IDEAS.Fluid.PvtCollectors.Validation.PVT1.Electrical;
model PVT1_Electrical_DayType3
  "Test model for Unglazed Rear-Insulated PVT Collector"
  extends PVT1_Electrical_DayType1(pvtTyp="Typ3", T_start=36.70783953 + 273.15);
  annotation (experiment(
      StartTime=17747640,
      StopTime=17788560.0,
      Interval=60,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"));
end PVT1_Electrical_DayType3;
