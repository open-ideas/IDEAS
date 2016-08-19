within IDEAS.Buildings.Components.BaseClasses.ConvectiveHeatTransfer;
model MonoLayerAir
  "Heat transfer correlations (convection and radiation) for air cavities"

  parameter Modelica.SIunits.Area A "Surface area";
  parameter Modelica.SIunits.Angle inc "Inclination of surface at port a";
  parameter Modelica.SIunits.Length d "Cavity width";

  parameter Modelica.SIunits.Emissivity epsLw_a
    "Longwave emissivity of material connected at port_a";
  parameter Modelica.SIunits.Emissivity epsLw_b
    "Longwave emissivity on material connected at port_b";
  parameter Modelica.SIunits.TemperatureDifference dT_nominal = 1
    "Nominal temperature difference, used for linearising Rayleigh number"
    annotation(Evaluate=true);
  parameter Modelica.SIunits.ThermalConductivity k = 0.026
    "Thermal conductivity of medium, default for air, T=20C";

  parameter Modelica.Media.Interfaces.Types.IsobaricExpansionCoefficient beta = 3.43e-3
    "Thermal expansion coefficient of medium, default for air, T=20C"
    annotation(Dialog(group="Advanced"));
  parameter Modelica.SIunits.KinematicViscosity nu = 15e-6
    "Kinematic viscosity of medium, default for air, T=20C"
    annotation(Dialog(group="Advanced"));
  parameter Modelica.SIunits.ThermalDiffusivity alpha = 22e-6
    "Thermal diffusivity of medium, default for air, T=300K"
    annotation(Dialog(group="Advanced"));
  parameter Boolean linearise = true
    "Linearise Grashoff number around expected nominal temperature difference"
    annotation(Evaluate=true);

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  Modelica.SIunits.ThermalConductance G=h*A + A*5.86*(1/((1/epsLw_a) + (1/epsLw_b) - 1));
  //when linearising we assume that Nu is the average Nu for positive and negative temperature differences
  Real Nu=
    if ceiling or floor then
      if linearise or (port_a.T-port_b.T>0 and ceiling or port_a.T-port_b.T<=0 and floor) then
        1 + (1.44*(1-1708/Ra)+((Ra/5830)^(1/3)-1))*(if linearise then 0.5 else 1)
      else 1
    elseif vertical then
      (if Ra>5e4
        then 0.0673838*Ra^(1/3)
      elseif Ra>1e4
        then 0.028154*Ra^0.41399
      else 1+1.75967e-10*Ra^2.2984755)
    else 1 "Correlations from Hollands et al. and Wright et al.";

protected
  final parameter Boolean ceiling=IDEAS.Utilities.Math.Functions.isAngle(inc,IDEAS.Types.Tilt.Ceiling)
    "true if ceiling"
    annotation(Evaluate=true);
  final parameter Boolean floor=IDEAS.Utilities.Math.Functions.isAngle(inc,IDEAS.Types.Tilt.Floor)
    "true if floor"
    annotation(Evaluate=true);
  final parameter Boolean vertical=IDEAS.Utilities.Math.Functions.isAngle(inc,IDEAS.Types.Tilt.Wall)
    annotation(Evaluate=true);

  Real Ra = max(1,Modelica.Constants.g_n*beta*(if linearise then abs(dT_nominal) else abs(port_a.T-port_b.T))*d^3/nu/alpha);
  Modelica.SIunits.CoefficientOfHeatTransfer h = Nu*k/d;

public
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_emb "Internal port"
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
equation
  if not (ceiling or floor or vertical) then
    assert(false, "Could not find suitable correlation for air cavity! Please change the inclination to wall, ceiling or floor or remove the air layer.",
         level=AssertionLevel.warning);
  end if;

  port_a.Q_flow + port_b.Q_flow + port_emb.Q_flow=0;
  port_a.Q_flow = G*(port_a.T - port_b.T);
  port_emb.T=(port_a.T+port_b.T)/2;
  annotation (Icon(graphics={
        Rectangle(
          extent={{-70,80},{-100,-80}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward,
          pattern=LinePattern.None),
        Line(points={{-70,20},{66,20}}, color={191,0,0}),
        Line(points={{-50,80},{-50,-80}}, color={0,127,255}),
        Line(points={{-70,-20},{66,-20}}, color={191,0,0}),
        Line(points={{46,30},{66,20}}, color={191,0,0}),
        Line(points={{46,10},{66,20}}, color={191,0,0}),
        Line(points={{46,-10},{66,-20}}, color={191,0,0}),
        Line(points={{46,-30},{66,-20}}, color={191,0,0}),
        Line(points={{-20,80},{-20,-80}},
                                      color={0,127,255}),
        Line(points={{20,80},{20,-80}}, color={0,127,255}),
        Line(points={{50,80},{50,-80}}, color={0,127,255}),
        Line(points={{-50,80},{-60,60}},   color={0,127,255}),
        Line(points={{-50,80},{-40,60}},   color={0,127,255}),
        Line(points={{-20,80},{-30,60}},color={0,127,255}),
        Line(points={{-20,80},{-10,60}},color={0,127,255}),
        Line(points={{20,-80},{10,-60}}, color={0,127,255}),
        Line(points={{20,-80},{30,-60}}, color={0,127,255}),
        Line(points={{50,-80},{40,-60}}, color={0,127,255}),
        Line(points={{50,-80},{60,-60}}, color={0,127,255}),
        Text(
          extent={{-148,-88},{152,-128}},
          textString="%name",
          lineColor={0,0,255}),
        Line(
          points={{-70,80},{-70,-80}},
          color={0,0,0},
          thickness=0.5),
        Line(points={{-50,64},{-60,44}},   color={0,127,255}),
        Line(points={{-50,64},{-40,44}},   color={0,127,255}),
        Line(points={{50,-60},{60,-40}},color={0,127,255}),
        Line(points={{50,-60},{40,-40}},color={0,127,255}),
        Rectangle(
          extent={{100,80},{70,-80}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward,
          pattern=LinePattern.None),
        Line(
          points={{70,80},{70,-80}},
          color={0,0,0},
          thickness=0.5)}), Documentation(info="<html>
<p>Correlation sources:</p>
<pre><span style=\"font-family: Courier New,courier;\">Horizontal:</span>
<span style=\"font-family: Courier New,courier;\">K.G.T. Hollands, G.D. Raithby, L. Konicek, Correlation equations for free convection heat transfer in horizontal layers of air and water, International Journal of Heat and Mass Transfer, Volume 18, Issues 7&ndash;8, July&ndash;August 1975, Pages 879-884, ISSN 0017-9310, http://dx.doi.org/10.1016/0017-9310(75)90179-9.</span>
<span style=\"font-family: Courier New,courier;\">(http://www.sciencedirect.com/science/article/pii/0017931075901799)</span>

<span style=\"font-family: Courier New,courier;\">Vertical:</span>
<span style=\"font-family: Courier New,courier;\">Wright, J. 1996. A correlation to quantify convective heat transfer between vertical window glazings, ASHRAE Transactions, 102(1): 940-946.</span></pre>
</html>", revisions="<html>
<ul>
<li>
February 10, 2016, by Filip Jorissen and Damien Picard:<br/>
Revised implementation.
</li>
<li>
November 15, 2015, by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
end MonoLayerAir;
