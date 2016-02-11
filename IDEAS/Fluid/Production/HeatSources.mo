within IDEAS.Fluid.Production;
package HeatSources
  model HeatPumpAirWater
    //Extensions
    extends IDEAS.Fluid.Production.BaseClasses.Partial3DHeatSource(
      tableInput1(y=Tin1 - 273.15),
      tableInput2(y=Tout2 - 273.15),
      redeclare Data.PerformanceMaps.HeatPumps.HPAW
                                          data);

    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics));
  end HeatPumpAirWater;

  model Boiler
    //Extensions
    extends IDEAS.Fluid.Production.BaseClasses.Partial3DHeatSource(
      tableInput1(y=Tout2 - 273.15),
      tableInput2(y=m_flow2*kgps2lph),
      redeclare Data.PerformanceMaps.Boilers.Boiler data);

    //Parameters
    constant Real kgps2lph=3600/Medium.density(Medium.setState_pTX(Medium.p_default, Medium.T_default, Medium.X_default))*1000;

    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics));
  end Boiler;

  model HeatPumpWaterWater

    //Extensions
    extends IDEAS.Fluid.Production.BaseClasses.Partial2DHeatSource(
      redeclare replaceable
        Data.PerformanceMaps.HeatPumps.VitoCal300GBWS301dotA45 data,
      tableInput1(y=Tin1),
      tableInput2(y=Tout2));

    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics));
  end HeatPumpWaterWater;

  model CHP

    //Extensions
    extends IDEAS.Fluid.Production.BaseClasses.Partial2DHeatSource(
      redeclare replaceable Data.PerformanceMaps.Boilers.CHP   data,
      tableInput1(y=1),
      tableInput2(y=Tin2));

    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics));
  end CHP;

  model Heater "Heater from DeSchipjes"
    //Extensions
    extends IDEAS.Fluid.Production.BaseClasses.Partial3DHeatSource(
      tableInput1(y=Tout2 - 273.15),
      tableInput2(y=m_flow2*kgps2lph),
      redeclare Data.PerformanceMaps.Boilers.Boiler data);

    //Parameters
    constant Real kgps2lph=3600/Medium.density(Medium.setState_pTX(Medium.p_default, Medium.T_default, Medium.X_default))*1000;

    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics));
  end Heater;
end HeatSources;
