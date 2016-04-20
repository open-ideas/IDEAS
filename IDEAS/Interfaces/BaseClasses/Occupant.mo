within IDEAS.Interfaces.BaseClasses;
partial model Occupant

  extends IDEAS.Interfaces.BaseClasses.PartialSystem;

  parameter Integer nZones(min=1) "number of conditioned thermal zones";
  parameter Integer nLoads(min=0) = 1 "number of electric loads";

  parameter Integer id=1 "id-number on extern data references";

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nZones] heatPortCon
    "Nodes for convective heat gains" annotation (Placement(transformation(
          extent={{-210,10},{-190,30}}),iconTransformation(extent={{-210,10},{
            -190,30}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nZones] heatPortRad
    "Nodes for radiative heat gains" annotation (Placement(transformation(
          extent={{-210,-30},{-190,-10}}),iconTransformation(extent={{-210,-30},
            {-190,-10}})));
  Modelica.Blocks.Interfaces.RealOutput[nZones] TSet(
    final quantity="ThermodynamicTemperature",
    unit="K",
    displayUnit="degC",
    min=0) "Setpoint temperature for the zones" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,100}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,100})));

  Modelica.Blocks.Interfaces.RealOutput mDHW60C
    "mFlow for domestic hot water, at 60 degC" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,100}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,100})));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{200,100}}),
                         graphics={
        Polygon(
          points={{-200,80},{-180,80},{-180,100},{160,100},{120,-100},{-180,
              -100},{-180,-80},{-200,-80},{-200,80}},
          pattern=LinePattern.None,
          fillColor={221,234,196},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Polygon(
          points={{40,60},{58,-58},{40,60}},
          pattern=LinePattern.None,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{4,50},{4,-52},{44,-52},{44,50},{4,50}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{4,0},{-46,50},{-46,-52},{4,0}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-200,100},{-160,60}},
          fillColor={221,234,196},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-200,-60},{-160,-100}},
          fillColor={221,234,196},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{160,-60},{200,-100}},
          fillColor={210,227,177},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Ellipse(
          extent={{160,100},{200,60}},
          fillColor={210,227,177},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{160,100},{120,-100},{180,-100},{180,-80},{200,-80},{200,80},
              {180,80},{180,100},{160,100}},
          fillColor={210,227,177},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None)}),
                                 Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-200,-100},{200,100}})));
end Occupant;
