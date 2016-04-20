within IDEAS.Electrical.Data.Batteries;
record AGM_PbAcid = IDEAS.Electrical.Data.Interfaces.BatteryType (
    eta_in=0.95,
    eta_out=0.98,
    eta_c=0.82,
    eta_d=1,
    alpha_sd=0.05,
    e_c=1,
    e_d=1) "AGM PbAcid";
