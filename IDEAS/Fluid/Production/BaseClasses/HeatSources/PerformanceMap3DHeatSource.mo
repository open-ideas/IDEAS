within IDEAS.Fluid.Production.BaseClasses.HeatSources;
model PerformanceMap3DHeatSource
  "Heat source based on data from a 3D performance map"
  //Extensions
  extends IDEAS.Fluid.Production.BaseClasses.PartialHeatSource(redeclare replaceable
      Data.PerformanceMaps.Boiler3D data);

  //Parameters en Constants
  constant Real kgps2lph=3600/Medium.density(Medium.setState_pTX(Medium.p_default, Medium.T_default, Medium.X_default))*1000
    "Conversion from kg/s to l/h";

  //Components
  Utilities.Tables.InterpolationTable3D interpolationTable(space=data.space)
    "Interpolation table to determine the efficiency at a modulation grade"
    annotation (Placement(transformation(extent={{-12,-58},{8,-38}})));
  Utilities.Tables.InterpolationTable3D interpolationTableQMax(space=data.space)
    "Interpolation table to determine the maximum possible power output at 100% modulation"
    annotation (Placement(transformation(extent={{-12,-88},{8,-68}})));

equation
  //Calculation of the efficiency at 100% modulation
  interpolationTableQMax.u1 = THxIn-273.15;
  interpolationTableQMax.u2 = m_flowHx_scaled*kgps2lph;
  interpolationTableQMax.u3 = 100;

  //Calculation of the efficiency at the required modulation grade
  interpolationTable.u1 = THxIn-273.15;
  interpolationTable.u2 = m_flowHx_scaled*kgps2lph;
  interpolationTable.u3 = modulation;

  //Calcualation of the heat powers
  QMax = interpolationTableQMax.y/etaRef*QNom;

  //Final heat power of the heat source
  eta = if on_internal then interpolationTable.y else 0;

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end PerformanceMap3DHeatSource;
