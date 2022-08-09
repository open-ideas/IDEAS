within IDEAS.Buildings.Components.BaseClasses.ConductiveHeatTransfer;
model MultiLayer "multiple material layers in series"

  parameter Modelica.Units.SI.Area A 
    "total multilayer area";
  parameter Modelica.Units.SI.Angle inc
    "Inclinination angle of the multilayer at port_a";
  parameter Integer nLay(min=1) "number of layers";
  parameter IDEAS.Buildings.Data.Interfaces.Material[nLay] mats
    "array of layer materials";
  parameter Integer nGain = 0 "Number of gains";
  parameter Boolean linIntCon=false
    "Linearise interior convection inside air layers / cavities in walls";
  final parameter Modelica.Units.SI.ThermalInsulance R=sum(monLay.R)
    "total specific thermal resistance";
  final parameter Modelica.Units.SI.HeatCapacity C=sum(mats.d .* mats.rho .*
      mats.c*A) "Total heat capacity of the layers" annotation (Evaluate=true);
  parameter Modelica.Units.SI.Temperature T_start[nLay]=ones(nLay)*293.15
    "Start temperature from port_b to port_a"
    annotation (Evaluate=true, Dialog(group="Dynamics"));
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial
    "Static (steady state) or transient (dynamic) thermal conduction model"
    annotation(Evaluate=true, Dialog(group="Dynamics"));
  parameter Boolean disableInitPortA= false
    "Remove initial equation at port a"
    annotation(Evaluate=true, Dialog(group="Dynamics"));
  parameter Boolean disableInitPortB= false
    "Remove initial equation at port b"
    annotation(Evaluate=true, Dialog(group="Dynamics"));
  parameter SI.TemperatureDifference dT_nom_air=1
    "Nominal temperature difference for air layers, used for linearising Rayleigh number"
    annotation(Dialog(enable=linIntCon));
  parameter Boolean checkCoatings = false
    "Check whether air layers have a coating";
  final parameter Modelica.Units.SI.Emissivity parEpsSw_a = mats[nLay].epsSw_a
    "Shortwave emissivity parameter for face a";
  final parameter Modelica.Units.SI.Emissivity parEpsSw_b =  mats[1].epsSw_b
    "Shortwave emissivity parameter for face b";
  final parameter Modelica.Units.SI.Emissivity parEpsLw_a =  mats[nLay].epsLw_a
    "Longwave emissivity parameter for face a";
  final parameter Modelica.Units.SI.Emissivity parEpsLw_b =  mats[1].epsLw_b
    "Longwave emissivity parameter for face b";

  Modelica.Units.SI.Energy E=sum(monLay.E)
    "Total internal energy";

  IDEAS.Buildings.Components.BaseClasses.ConductiveHeatTransfer.MonoLayer[nLay]
    monLay(
    each final A=A,
    each final inc=inc,
    final T_start=T_start,
    final mat=mats,
    each linIntCon=linIntCon,
    epsLw_a=cat(
        1,
        mats[2:nLay].epsLw_b,
        {0.85}),
    epsLw_b=cat(
        1,
        {0.85},
        mats[1:nLay - 1].epsLw_a),
    each energyDynamics=energyDynamics,
    each checkCoating = checkCoatings,
    each dT_nom_air=dT_nom_air) "Individual layers"
    annotation (Placement(transformation(extent={{-10,10},{10,-10}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_gain[nLay]
    "Port for gains by embedded layers"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    "Thermal connector for face a of the layers"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b
    "Thermal connector for face b of the layers"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealOutput iEpsLw_b
    "Output of the longwave emissivity of port b"
    annotation (Placement(transformation(extent={{90,70},{110,90}})));
  Modelica.Blocks.Interfaces.RealOutput iEpsSw_b
    "Output of the shortwave emissivity of port b"
    annotation (Placement(transformation(extent={{90,30},{110,50}})));
  Modelica.Blocks.Interfaces.RealOutput iEpsLw_a
    "Output of the shortwave emissivity of port a"
    annotation (Placement(transformation(extent={{-90,70},{-110,90}})));
  Modelica.Blocks.Interfaces.RealOutput iEpsSw_a
    "Output of the shortwave emissivity of port a"
    annotation (Placement(transformation(extent={{-90,30},{-110,50}})));
  Modelica.Blocks.Interfaces.RealOutput area=A
    "Output connector for the surface area of each face" annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={0,100})));
initial equation
  // This code sets initial equations for the outer states of each monolayer.
  // These initial equations are not added at the monoLayer level
  // since then two adjacent monolayers may set an initial equation for the
  // same port, which causes warnings when the initial equations are consistent
  // and errors otherwise.
  // Moreover, multiple multiLayers may be connected to each other, such as in
  // the SlabOnGround model. For this case the parameter disableInitPortB is added.
  for i in 1:nLay loop
    if monLay[i].isDynamic then
      if i>1 or not disableInitPortB then
        monLay[i].port_b.T=T_start[i];
      end if;
    end if;
    if monLay[i].isDynamic and (if i==nLay then not disableInitPortA else not monLay[i+1].isDynamic) then
      monLay[i].port_a.T=T_start[i];
    end if;
  end for;

equation
  // Last layer of monLay is connected to port_a
  connect(port_a, monLay[nLay].port_a)
    annotation (Line(points={{-100,0},{-100,0},{-10,0}}, color={191,0,0}));
  for j in 1:nLay - 1 loop
    connect(monLay[nLay - j + 1].port_b, monLay[nLay - j].port_a);
  end for;
  connect(port_b, monLay[1].port_b)
    annotation (Line(points={{100,0},{10,0}}, color={191,0,0}));

  connect(monLay.port_gain, port_gain) annotation (Line(points={{0,-10},{0,-10},
          {0,-60},{0,-100}}, color={191,0,0}));

  iEpsLw_a = mats[nLay].epsLw_a;
  iEpsSw_a = mats[nLay].epsSw_a;
  iEpsLw_b = mats[1].epsLw_b;
  iEpsSw_b = mats[1].epsSw_b;

  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Icon(graphics={
        Rectangle(
          extent={{-90,80},{20,-80}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward,
          pattern=LinePattern.None),
        Text(
          extent={{-150,113},{150,73}},
          textString="%name",
          lineColor={0,0,255}),
        Rectangle(
          extent={{20,80},{40,-80}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Forward,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{40,80},{80,-80}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward,
          pattern=LinePattern.None),
        Line(
          points={{20,80},{20,-80}},
          pattern=LinePattern.None,
          smooth=Smooth.None),
        Line(
          points={{40,80},{40,-80}},
          pattern=LinePattern.None,
          smooth=Smooth.None),
        Ellipse(
          extent={{-40,-42},{40,38}},
          lineColor={127,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-39,40},{39,-40}},
          lineColor={127,0,0},
          fontName="Calibri",
          origin={0,-1},
          rotation=90,
          textString="S")}),
    Documentation(info="<html>
</html>", revisions="<html>
<ul>
<li>
August 9, 2022, by Filip Jorissen:<br/>
Updated documentation and added parameters for issue
<a href=\"https://github.com/open-ideas/IDEAS/issues/1270\">#1270</a>.
</li>
<li>
September 9, 2019, by Kristoff Six:<br/>
Updated with <code>checkCoatings</code> for issue
<a href=\"https://github.com/open-ideas/IDEAS/issues/1038\">#1038</a>.
</li>
<li>
January 25, 2019, by Filip Jorissen:<br/>
Revised initial equation implementation.
See issue <a href=https://github.com/open-ideas/IDEAS/issues/971>#971</a>.
</li>
<li>
March 8, 2016, by Filip Jorissen:<br/>
Fixed bug in output of iEpsLw and iEpsSw for issue 464.
</li>
<li>
February 10, 2016, by Filip Jorissen and Damien Picard:<br/>
Revised implementation: now only one MultiLayer component exists.
</li>
</ul>
</html>"));
end MultiLayer;
