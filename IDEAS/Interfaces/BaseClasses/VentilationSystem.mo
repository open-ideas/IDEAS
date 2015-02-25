within IDEAS.Interfaces.BaseClasses;
partial model VentilationSystem

  extends IDEAS.Interfaces.BaseClasses.PartialSystem;

  outer Modelica.Fluid.System system
  annotation (Placement(transformation(extent={{-180,80},{-160,100}})));

  replaceable package Medium = IDEAS.Experimental.Media.AirPTDecoupled
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "Medium in the component"
      annotation (choicesAllMatching = true);

  // Building characteristics  //////////////////////////////////////////////////////////////////////////

  parameter Integer nZones(min=1)
    "Number of conditioned thermal building zones";
  parameter Integer nLoads(min=0) = 1 "Number of electric loads";
  parameter Real[nZones] VZones "Conditioned volumes of the zones";

  parameter Modelica.SIunits.Power[ nZones] Q_design=zeros(nZones)
    "Design heat loss due to ventilation";//must be calculated depending on the case

  // Interfaces  ///////////////////////////////////////////////////////////////////////////////////////

  Modelica.Blocks.Interfaces.RealInput[nZones] TSensor(final quantity="ThermodynamicTemperature",unit="K",displayUnit="degC", min=0)
    "Sensor temperature of the zones" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-204,-60})));
  Fluid.Interfaces.FlowPort_b[nZones] flowPort_Out(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-210,-30},{-190,-10}})));
  Fluid.Interfaces.FlowPort_a[nZones] flowPort_In(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-210,10},{-190,30}})));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{200,100}}), graphics={
        Rectangle(
          extent={{-200,100},{202,-100}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={191,0,0}),
        Polygon(
          points={{6,62},{32,48},{32,18},{34,18},{44,26},{44,-26},{10,-24},{42,
              -42},{42,-74},{76,-40},{76,56},{48,76},{46,76},{6,62}},
          lineColor={127,0,0},
          smooth=Smooth.None,
          fillColor={127,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{6,62},{6,30},{32,18}},
          color={127,0,0},
          smooth=Smooth.None),
        Line(
          points={{10,-24},{10,-56},{42,-74}},
          color={127,0,0},
          smooth=Smooth.None),
        Line(
          points={{202,100},{202,-100}},
          color={85,170,255},
          smooth=Smooth.None)}), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-200,-100},{200,100}}),
                                         graphics));
end VentilationSystem;
