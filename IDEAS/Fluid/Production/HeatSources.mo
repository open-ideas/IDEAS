within IDEAS.Fluid.Production;
package HeatSources
  model HeatPumpAirWater
    //Extensions
    extends IDEAS.Fluid.Production.BaseClasses.Partial3DHeatSource(
        tableInput1(y=TinPrimary-273.15),
        tableInput2(y=ToutSecondary-273.15),
      redeclare Data.HeatPumpAirWaterData data);

    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics));
  end HeatPumpAirWater;

  model Boiler
    //Extensions
    extends IDEAS.Fluid.Production.BaseClasses.Partial3DHeatSource(
      tableInput1(y=ToutSecondary - 273.15),
      tableInput2(y=massFlowSecondary*kgps2lph),
      redeclare Data.PerformanceMaps.Boilers.Boiler data);

    //Parameters
    constant Real kgps2lph=3600/Medium.density(Medium.setState_pTX(Medium.p_default, Medium.T_default, Medium.X_default))*1000;

    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics));
  end Boiler;

  model HeatPumpWaterWater

    //Extensions
    extends IDEAS.Fluid.Production.BaseClasses.Partial2DHeatSource(
      redeclare replaceable Data.VitoCal300GBWS301dotA08 data,
      tableInput1(y=TinPrimary),
      tableInput2(y=ToutSecondary));

    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics));
  end HeatPumpWaterWater;
end HeatSources;
