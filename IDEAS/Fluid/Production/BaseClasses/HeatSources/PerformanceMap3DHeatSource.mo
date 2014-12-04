within IDEAS.Fluid.Production.BaseClasses.HeatSources;
model PerformanceMap3DHeatSource
  "Heat source based on data from a 3D performance map"
  //Extensions
  extends IDEAS.Fluid.Production.BaseClasses.PartialHeatSource(
    modulating=true);

  //Parameters en Constants
  constant Real kgps2lph=3600/Medium.density(Medium.setState_pTX(Medium.p_default, Medium.T_default, Medium.X_default))*1000
    "Conversion from kg/s to l/h";
  parameter IDEAS.Utilities.Tables.Space space
    "The 3D space containing the performance data";

  //Components
  Utilities.Tables.InterpolationTable3D interpolationTable(space=space)
    "Interpolation table to determine the efficiency at a modulation grade"
    annotation (Placement(transformation(extent={{-10,12},{10,32}})));
  Utilities.Tables.InterpolationTable3D interpolationTableQMax(space=space)
    "Interpolation table to determine the maximum possible power output at 100% modulation"
    annotation (Placement(transformation(extent={{-10,-24},{10,-4}})));

equation
  //Calculation of the efficiency at 100% modulation
  interpolationTableQMax.u1 = THxIn-273.15;
  interpolationTableQMax.u2 = m_flowHx_scaled*kgps2lph;
  interpolationTableQMax.u3 = 100;

  //Calculation of the efficiency at the required modulation grade
  interpolationTable.u1 = THxIn-273.15;
  interpolationTable.u2 = m_flowHx_scaled*kgps2lph;
  interpolationTable.u3 = modulation;

  //Calculation of the modulation
  release = if noEvent(m_flow > Modelica.Constants.eps) then 0.0 else 1.0;
  modulationInit = QAsked/QMax*100;
    hysteresis.u = modulationInit;
  modulation =   if avoidEvents then onOff_internal_filtered * IDEAS.Utilities.Math.Functions.smoothMin(modulationInit, 100, deltaX=0.1) elseif hysteresis.y and noEvent(release<0.5) then IDEAS.Utilities.Math.Functions.smoothMin(modulationInit, 100, deltaX=0.1) else 0;

  //Calcualation of the heat powers
  QMax = interpolationTableQMax.y/etaRef*QNom;
  QAsked = IDEAS.Utilities.Math.Functions.smoothMax(0, m_flow*(Medium.specificEnthalpy(Medium.setState_pTX(Medium.p_default, TSet, Medium.X_default)) -hIn), 10);
  QLossesToCompensate = if noEvent(modulation > Modelica.Constants.eps) then UALoss*(heatPort.T - sim.Te) else 0;

  //Final heat power of the heat source
  eta = interpolationTable.y;
  heatPort.Q_flow = -eta/etaRef*modulation/100*QNom - QLossesToCompensate;
  PFuel = if noEvent(release < 0.5) and noEvent(eta>Modelica.Constants.eps) then -heatPort.Q_flow/eta else 0;

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end PerformanceMap3DHeatSource;
