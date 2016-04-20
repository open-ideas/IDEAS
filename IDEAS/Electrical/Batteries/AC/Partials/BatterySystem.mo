within IDEAS.Electrical.Batteries.AC.Partials;
partial model BatterySystem
  "Parial model to be used for battery storage or electric vehicles"
  replaceable parameter IDEAS.Electrical.Data.Interfaces.BatteryType technology
    "Choose a battery type" annotation (choicesAllMatching=true);

parameter Integer numPha=1 "Number of phases simulated" annotation (choices(
      choice=1 "Single Phase",
      choice=3 "Three Phase",
      __Dymola_radioButtons=true));

// Individual parameters
  parameter Real EBat(final quantity="Energy", final unit="kW.h",displayUnit="kW.h")
    "Total battery capacity in [kW.h]";
  parameter Modelica.SIunits.Efficiency SoC_start "Start battery SoC";
  parameter Modelica.SIunits.Efficiency DOD_max "Maximum discharge [%/100]";

  IDEAS.Electrical.BaseClasses.AC.WattsLaw wattsLaw(numPha=numPha) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,30})));

  IDEAS.Electrical.Batteries.Battery battery(
    delta_sd=technology.delta_sd,
    SoC_start=SoC_start,
    EBat=3600000*EBat,
    eta_out=technology.eta_out,
    eta_in=technology.eta_in,
    eta_c=technology.eta_c,
    eta_d=technology.eta_d)
    annotation (Placement(transformation(extent={{60,0},{80,20}})));

  annotation (Icon, Diagram(graphics));

end BatterySystem;
