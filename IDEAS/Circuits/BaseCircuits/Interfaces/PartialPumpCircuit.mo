within IDEAS.Circuits.BaseCircuits.Interfaces;
model PartialPumpCircuit

  // Parameters ----------------------------------------------------------------

  parameter Integer tauPump = 30
    "Time constant of the pump if dynamicBalance is true" annotation(Dialog(
                   group = "Pump parameters"));
  parameter Boolean addPowerToMedium = false "Add heat to the medium" annotation(Dialog(
                   group = "Pump parameters"));

  // Extensions ----------------------------------------------------------------

  extends PartialFlowCircuit(redeclare
      Fluid.Movers.BaseClasses.PartialFlowMachine flowRegulator(
      tau=tauPump,
      energyDynamics=energyDynamics,
      massDynamics=massDynamics,
      dynamicBalance=dynamicBalance,
      addPowerToMedium=addPowerToMedium));

  annotation (Icon(graphics={
        Ellipse(extent={{-20,80},{20,40}},lineColor={0,0,127},
          fillColor={0,127,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,94},{4,80},{0,64}},
          color={0,255,128},
          smooth=Smooth.None),
        Polygon(
          points={{-12,76},{-12,44},{20,60},{-12,76}},
          lineColor={0,0,127},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}));
end PartialPumpCircuit;
