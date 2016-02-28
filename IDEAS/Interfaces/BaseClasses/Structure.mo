within IDEAS.Interfaces.BaseClasses;
partial model Structure "Partial model for building structure models"

  outer IDEAS.BoundaryConditions.SimInfoManager sim
    "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{130,-100},{150,-80}})));

  replaceable package Medium = IDEAS.Media.Air
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "Medium in the component"
      annotation (choicesAllMatching = true);

  // Building characteristics  //////////////////////////////////////////////////////////////////////////

  parameter Integer nZones(min=1)
    "Number of conditioned thermal zones in the building";
  parameter Integer nEmb(min=0) "Number of embedded systems in the building";
  parameter Modelica.SIunits.Area ATrans=100
    "Transmission heat loss area of the residential unit";
  parameter Modelica.SIunits.Area[nZones] AZones = ones(nZones)*100
    "Conditioned floor area of the zones";
  parameter Modelica.SIunits.Volume[nZones] VZones = AZones .*3
    "Conditioned volume of the zones based on external dimensions";
  final parameter Modelica.SIunits.Length C=sum(VZones)/ATrans
    "Building compactness";

  parameter Modelica.SIunits.Temperature[nZones] T_start = fill(Medium.T_default,nZones)
    "Operative zonal start temperatures";

  parameter Modelica.SIunits.Power[ nZones] Q_design=zeros(nZones)
    "Design heat loss of zones";//must be filled in in the Building interface, e.g.: QDesign={building.zone1.Q_design,building.zone2.Q_design}

  // Interfaces  ///////////////////////////////////////////////////////////////////////////////////////

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nZones] heatPortCon
    "Internal zone nodes for convective heat gains" annotation (Placement(
        transformation(extent={{140,10},{160,30}}), iconTransformation(extent={
            {140,10},{160,30}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nZones] heatPortRad
    "Internal zones node for radiative heat gains" annotation (Placement(
        transformation(extent={{140,-30},{160,-10}}), iconTransformation(extent=
           {{140,-30},{160,-10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b[nEmb] heatPortEmb
    "Construction nodes for heat gains by embedded layers" annotation (
      Placement(transformation(extent={{140,50},{160,70}}), iconTransformation(
          extent={{140,50},{160,70}})));
  Modelica.Blocks.Interfaces.RealOutput[nZones] TSensor(final quantity="ThermodynamicTemperature",unit="K",displayUnit="degC", min=0)
    "Sensor temperature of the zones"
    annotation (Placement(transformation(extent={{146,-70},{166,-50}})));
  Fluid.Interfaces.FlowPort_b[nZones] flowPort_Out(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-30,90},{-10,110}})));
  Fluid.Interfaces.FlowPort_a[nZones] flowPort_In(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{10,90},{30,110}})));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-80,
            -100},{150,100}}), graphics={
        Polygon(
          points={{-60,100},{-60,80},{-80,80},{-80,-80},{-60,-80},{-60,-100},{70,
              -100},{110,100},{-60,100}},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Ellipse(
          extent={{-80,100},{-40,60}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-80,-60},{-40,-100}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{110,-60},{150,-100}},
          fillColor={202,202,202},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Ellipse(
          extent={{110,100},{150,60}},
          fillColor={202,202,202},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{110,100},{70,-100},{130,-100},{130,-80},{150,-80},{150,80},{130,
              80},{130,100},{110,100}},
          fillColor={202,202,202},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(points={{-42,-20}}, color={135,135,135}),
        Line(points={{14,62},{14,42}}, color={255,255,255}),
        Line(points={{14,20},{14,-20},{14,-20},{60,-20}}, color={255,255,255}),
        Line(points={{80,-20},{108,-20}}, color={255,255,255}),
        Line(points={{-42,0},{-22,0}}, color={255,255,255}),
        Line(points={{-2,0},{14,0}}, color={255,255,255}),
        Line(
          points={{10,10},{8,2},{4,-4},{-2,-8},{-10,-10}},
          color={255,255,255},
          origin={98,30},
          rotation=-90),
        Line(
          points={{0,-10},{0,10}},
          color={255,255,255},
          origin={98,40},
          rotation=-90),
        Line(points={{-2,0},{-4,-8},{-8,-14},{-14,-18},{-22,-20}}, color={255,255,
              255}),
        Line(points={{-22,-20},{-22,0}}, color={255,255,255}),
        Line(points={{108,40},{108,62},{-42,62},{-42,-60},{108,-60},{108,20}},
            color={255,255,255})}),         Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-80,-100},{150,100}}),  graphics));

end Structure;
