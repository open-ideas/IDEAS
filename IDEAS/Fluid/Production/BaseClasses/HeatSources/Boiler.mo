within IDEAS.Fluid.Production.BaseClasses.HeatSources;
model Boiler
  import IDEAS;
  //Extensions
  extends IDEAS.Fluid.Production.Interfaces.BaseClasses.Partial3DHeatSource(
    tableInput1(y=ToutSecondary - 273.15),
    tableInput2(y=massFlowSecondary*kgps2lph),
    redeclare IDEAS.Fluid.Production.Data.BoilerData data);

  //Parameters
  constant Real kgps2lph=3600/Medium.density(Medium.setState_pTX(Medium.p_default, Medium.T_default, Medium.X_default))*1000;

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end Boiler;
