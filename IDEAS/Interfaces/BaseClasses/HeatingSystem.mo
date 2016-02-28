within IDEAS.Interfaces.BaseClasses;
partial model HeatingSystem "Partial heating/cooling system"

  extends IDEAS.Interfaces.BaseClasses.PartialSystem;

  replaceable package Medium=IDEAS.Media.Water;

  // *********** Building characteristics and  interface ***********
  // --- General
  parameter Integer nZones(min=1)
    "Number of conditioned thermal zones in the building";
  // --- Boolean declarations
  parameter Boolean isHea=true "true if system is able to heat";
  parameter Boolean isCoo=false "true if system is able to cool";
  parameter Boolean isDH=false "true if the system is connected to a DH grid";
  parameter Boolean InInterface = false;

  parameter Modelica.SIunits.Power[nZones] Q_design
    "Total design heat load for heating system based on heat losses" annotation(Dialog(enable=InInterface));

  // --- Ports
  parameter Integer nConvPorts(min=0) = nZones
    "Number of ports in building for convective heating/cooling";
  parameter Integer nRadPorts(min=0) = nZones
    "Number of ports in building for radiative heating/cooling";
  parameter Integer nEmbPorts(min=0) = nZones
    "Number of ports in building for embedded systems";

  // --- Sensor
  parameter Integer nTemSen(min=0) = nZones
    "number of temperature inputs for the system";

  // *********** Outputs ***********
  // --- Thermal
  Modelica.SIunits.Power QHeaSys if isHea
    "Total energy use forspace heating + DHW, if present)";
  Modelica.SIunits.Power QCooTotal if isCoo "Total cooling energy use";

  // *********** Interface ***********
  // --- thermal
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nConvPorts] heatPortCon
    "Nodes for convective heat gains"
    annotation (Placement(transformation(extent={{-210,10},{-190,30}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nRadPorts] heatPortRad
    "Nodes for radiative heat gains"
    annotation (Placement(transformation(extent={{-210,-30},{-190,-10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b[nEmbPorts] heatPortEmb
    "Construction nodes for heat gains by embedded layers"
    annotation (Placement(transformation(extent={{-210,50},{-190,70}})));

  // --- Sensor
  Modelica.Blocks.Interfaces.RealInput[nTemSen] TSensor(
    final quantity="ThermodynamicTemperature",
    unit="K",
    displayUnit="degC",
    min=0) "Sensor temperature" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-204,-60})));
  Modelica.Blocks.Interfaces.RealInput mDHW60C
    "mFlow for domestic hot water, at 60 degC" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={80,-104}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,-102})));

  Modelica.Blocks.Interfaces.RealInput[nZones] TSet(
    final quantity="ThermodynamicTemperature",
    unit="K",
    displayUnit="degC",
    min=0) "Setpoint temperature for the zones" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,-104}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-102})));

  // --- fluid
  Fluid.Interfaces.FlowPort_a flowPort_supply(redeclare package Medium = Medium)
    if                                           isDH
    "Supply water connection to the DH grid"
    annotation (Placement(transformation(extent={{150,-110},{170,-90}})));
  Fluid.Interfaces.FlowPort_b flowPort_return(redeclare package Medium = Medium)
    if                                           isDH
    "Return water connection to the DH grid"
    annotation (Placement(transformation(extent={{110,-110},{130,-90}})));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{
            200,220}}),
                    graphics={
        Polygon(
          points={{-200,200},{-180,200},{-180,220},{160,220},{96,-100},{-180,-100},
              {-180,-80},{-200,-80},{-200,200}},
          pattern=LinePattern.None,
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Polygon(
          points={{96,-100},{180,-100},{180,-78},{200,-78},{200,200},{180,200},{
              180,220},{160,220},{96,-100}},
          fillColor={255,145,145},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{-186,188},{-186,188}},
          lineColor={0,0,0},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Line(points={{180,100}}, color={0,0,0}),
        Ellipse(extent={{50,-10},{90,-50}}, lineColor={255,255,255}),
        Polygon(points={{50,-30},{82,-14},{82,-46},{50,-30}},
                                                           lineColor={255,255,255}),
        Line(points={{0,-20}}, color={162,29,33}),
        Polygon(points={{-108,28},{-88,-12},{-108,-12},{-88,28},{-108,28}},
            lineColor={255,255,255}),
        Line(points={{50,-30},{-98,-30},{-98,-12}},
                                                  color={255,255,255}),
        Line(points={{-46,78}}, color={162,29,33}),
        Line(points={{-118,100}}, color={162,29,33}),
        Line(points={{-98,28},{-98,148}},   color={255,255,255}),
        Polygon(points={{-64,28},{-44,-12},{-64,-12},{-44,28},{-64,28}},
            lineColor={255,255,255}),
        Line(points={{-54,28},{-54,148}}, color={255,255,255}),
        Line(points={{-54,-30},{-54,-30},{-54,-12}},
                                                  color={255,255,255}),
        Polygon(points={{-22,28},{-2,-12},{-22,-12},{-2,28},{-22,28}},
            lineColor={255,255,255}),
        Line(points={{-12,28},{-12,148}}, color={255,255,255}),
        Line(points={{-12,-30},{-12,-30},{-12,-12}},
                                                  color={255,255,255}),
        Polygon(points={{18,28},{38,-12},{18,-12},{38,28},{18,28}},
            lineColor={255,255,255}),
        Line(points={{28,28},{28,148}}, color={255,255,255}),
        Line(points={{28,-30},{28,-30},{28,-12}}, color={255,255,255}),
        Line(points={{90,-30},{112,-30}},
                                     color={255,255,255}),
        Ellipse(
          extent={{-200,220},{-160,180}},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Ellipse(
          extent={{-200,-60},{-160,-100}},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Ellipse(
          extent={{160,-60},{200,-100}},
          fillColor={255,145,145},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Ellipse(
          extent={{160,220},{200,180}},
          fillColor={255,145,145},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0})}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-200},
            {200,220}})),
    Documentation(info="<html>
<p><b>Description</b> </p>
<p>Interface model for a complete multi-zone heating system (with our without domestic hot water and solar system).</p>
<p>This model defines the ports used to link a heating system with a building, and the basic parameters that most heating systems will need to have. The model is modular as a function of the number of zones <i>nZones. </i></p>
<p>Two sets of heatPorts are defined:</p>
<p><ol>
<li><i>heatPortCon[nZones]</i> and <i>heatPortRad[nZones]</i> for convective respectively radiative heat transfer to the building. </li>
<li><i>heatPortEmb[nZones]</i> for heat transfer to TABS elements in the building. </li>
</ol></p>
<p>The model also defines <i>TSensor[nZones]</i> and <i>TSet[nZones]</i> for the control, and a nominal power <i>QNom[nZones].</i></p>
<p>There is also an input for the DHW flow rate, <i>mDHW60C</i>, but this can be unconnected if the system only includes heating and no DHW.</p>
<p><h4>Assumptions and limitations </h4></p>
<p><ol>
<li>See the different extensions of this model in <a href=\"modelica://IDEAS.Thermal.HeatingSystems\">IDEAS.Thermal.HeatingSystems</a></li>
</ol></p>
<p><h4>Model use</h4></p>
<p><ol>
<li>Connect the heating system to the corresponding heatPorts of a <a href=\"modelica://IDEAS.Interfaces.BaseClasses.Structure\">structure</a>. </li>
<li>Connect <i>TSet</i> and <i>TSensor</i> and <i>plugLoad. </i></li>
<li>Connect <i>plugLoad </i> to an inhome grid.  A<a href=\"modelica://IDEAS.Interfaces.BaseClasses.CausalInhomeFeeder\"> dummy inhome grid like this</a> has to be used if no inhome grid is to be modelled. </li>
<li>Set all parameters that are required, depending on which implementation of this interface is used. </li>
</ol></p>
<p><h4>Validation </h4></p>
<p>No validation performed.</p>
<p><h4>Example </h4></p>
<p>See the <a href=\"modelica://IDEAS.Thermal.HeatingSystems.Examples\">heating system examples</a>. </p>
</html>"));
end HeatingSystem;
