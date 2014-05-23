within IDEAS.Buildings.Components;
model OuterWall "Opaque building envelope construction"

  extends IDEAS.Buildings.Components.Interfaces.StateWall;

  replaceable Data.Constructions.CavityWall constructionType
    constrainedby Data.Interfaces.Construction(final insulationType=
        insulationType, final insulationTickness=insulationThickness)
    "Type of building construction" annotation (
    __Dymola_choicesAllMatching=true,
    Placement(transformation(extent={{-38,72},{-34,76}})),
    Dialog(group="Construction details"));

  replaceable Data.Insulation.Rockwool insulationType constrainedby
    Data.Interfaces.Insulation(final d=insulationThickness)
    "Type of thermal insulation" annotation (
    __Dymola_choicesAllMatching=true,
    Placement(transformation(extent={{-38,84},{-34,88}})),
    Dialog(group="Construction details"));
  parameter Modelica.SIunits.Length insulationThickness=0.05
    "Thermal insulation thickness"
    annotation (Dialog(group="Construction details"));
  parameter Modelica.SIunits.Area AWall "Total wall area";
  parameter Modelica.SIunits.Angle inc
    "Inclination of the wall, i.e. 90deg denotes vertical";
  parameter Modelica.SIunits.Angle azi
    "Azimuth of the wall, i.e. 0deg denotes South";

  final parameter Real U_value=1/(1/8 + sum(constructionType.mats.R) + 1/25)
    "Wall U-value";
  final parameter Modelica.SIunits.Power QNom=U_value*AWall*(273.15 + 21 - sim.Tdes)
    "Design heat losses at reference outdoor temperature";

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_emb
    "port for gains by embedded active layers"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));

  //protected
  IDEAS.Climate.Meteo.Solar.RadSol radSol(
    final inc=inc,
    final azi=azi,
    final A=AWall)
    "determination of incident solar radiation on wall based on inclination and azimuth"
    annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));
  IDEAS.Buildings.Components.BaseClasses.MultiLayerOpaque layMul(
    final A=AWall,
    final inc=inc,
    final nLay=constructionType.nLay,
    final mats=constructionType.mats,
    final locGain=constructionType.locGain)
    "declaration of array of resistances and capacitances for wall simulation"
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  IDEAS.Buildings.Components.BaseClasses.ExteriorConvection extCon(final A=
        AWall)
    "convective surface heat transimission on the exterior side of the wall"
    annotation (Placement(transformation(extent={{-20,-60},{-40,-40}})));
  IDEAS.Buildings.Components.BaseClasses.InteriorConvection intCon(final A=
        AWall, final inc=inc)
    "convective surface heat transimission on the interior side of the wall"
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  IDEAS.Buildings.Components.BaseClasses.ExteriorSolarAbsorption solAbs(final A=
       AWall)
    "determination of absorbed solar radiation by wall based on incident radiation"
    annotation (Placement(transformation(extent={{-20,-40},{-40,-20}})));
  IDEAS.Buildings.Components.BaseClasses.ExteriorHeatRadidation extRad(final A=
        AWall, inc=inc)
    "determination of radiant heat exchange with the environment and sky"
    annotation (Placement(transformation(extent={{-20,-20},{-40,0}})));

equation
  connect(radSol.solDir, solAbs.solDir) annotation (Line(
      points={{-50,-24},{-40,-24}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(radSol.solDif, solAbs.solDif) annotation (Line(
      points={{-50,-28},{-40,-28}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(extCon.port_a, layMul.port_a) annotation (Line(
      points={{-20,-50},{-16,-50},{-16,-30},{-10,-30}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(solAbs.port_a, layMul.port_a) annotation (Line(
      points={{-20,-30},{-10,-30}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(extRad.port_a, layMul.port_a) annotation (Line(
      points={{-20,-10},{-16,-10},{-16,-30},{-10,-30}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(layMul.port_b, intCon.port_a) annotation (Line(
      points={{10,-30},{20,-30}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(layMul.iEpsSw_a, solAbs.epsSw) annotation (Line(
      points={{-10,-26},{-14,-26},{-14,-24},{-20,-24}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(layMul.iEpsLw_a, extRad.epsLw) annotation (Line(
      points={{-10,-22},{-14,-22},{-14,-4},{-20,-4}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(port_emb, layMul.port_gain) annotation (Line(
      points={{0,-100},{0,-40}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(intCon.port_b, surfCon_a) annotation (Line(
      points={{40,-30},{50,-30}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(layMul.port_b, surfRad_a) annotation (Line(
      points={{10,-30},{16,-30},{16,-60},{50,-60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(layMul.iEpsSw_b, propsBus_a.epsSw) annotation (Line(
      points={{10,-26},{14,-26},{14,40},{50,40}},
      color={0,0,127},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(layMul.iEpsLw_b, propsBus_a.epsLw) annotation (Line(
      points={{10,-22},{12,-22},{12,40},{50,40}},
      color={0,0,127},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(layMul.area, propsBus_a.area) annotation (Line(
      points={{0,-20},{0,-20},{0,40},{50,40}},
      color={0,0,127},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-50,-100},{50,100}}),
        graphics={
        Polygon(
          points={{-50,60},{-30,60},{-30,80},{50,80},{50,100},{-50,100},{-50,60}},
          pattern=LinePattern.None,
          lineThickness=0.5,
          smooth=Smooth.None,
          fillColor={175,175,175},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-30,-70},{-50,-20}},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.Backward,
          pattern=LinePattern.None),
        Line(
          points={{-50,60},{-50,66},{-50,100},{50,100}},
          color={175,175,175},
          smooth=Smooth.None),
        Line(
          points={{-50,60},{-30,60},{-30,80},{50,80}},
          color={175,175,175},
          smooth=Smooth.None),
        Line(
          points={{-50,-20},{-30,-20},{-30,-70},{-30,-70},{52,-70}},
          color={175,175,175},
          smooth=Smooth.None),
        Line(
          points={{-50,-20},{-50,-90},{50,-90}},
          color={175,175,175},
          smooth=Smooth.None),
        Line(
          points={{-44,60},{-30,60},{-30,80},{-28,80},{50,80}},
          pattern=LinePattern.None,
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{-44,-20},{-30,-20},{-30,-70}},
          pattern=LinePattern.None,
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{-44,60},{-44,-20}},
          smooth=Smooth.None,
          color={175,175,175})}),
    Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-100,-100},{100,
            100}}), graphics),
    Documentation(info="<html>
<p><h4><font color=\"#008000\">General description</font></h4></p>
<p><h5>Goal</h5></p>
<p>The <code>OuterWall.mo</code> model describes the transient behaviour of opaque builiding enelope constructions. The description of the thermal response of a wall is structured as in the 3 different occurring processes, i.e. the heat balance of the exterior surface, heat conduction between both surfaces and the heat balance of the interior surface.</p>
<p><h5>Description</h5></p>
<p>For the purpose of dynamic building simulation, the partial differential equation of the continuous time and space model of heat transport through a solid is most often simplified into ordinary differential equations with a finite number of parameters representing only one-dimensional heat transport through a construction layer. Within this context, the wall is modeled with lumped elements, i.e. a model where temperatures and heat fluxes are determined from a system composed of a sequence of discrete resistances and capacitances R_{n+1}, C_{n}. The number of capacitive elements $n$ used in modeling the transient thermal response of the wall denotes the order of the lumped capacitance model.</p>
<p>The heat balance of the exterior surface is determined as Q_{net} = Q_{c} + Q_{SW} + Q_{LW,e} + Q_{LW,sky} where Q_{net} denotes the heat flow into the wall, Q_{c} denotes heat transfer by convection, Q_{SW} denotes short-wave absorption of direct and diffuse solar light, Q_{LW,e} denotes long-wave heat exchange with the environment and Q_{nLW,sky} denotes long-wave heat exchange with the sky. The exterior convective heat flow is computed as Q_{c} = 5,01.A.v_{10}^{0.85}.(T_{db}-T{s}) where A is the surface area, T_{db} is the dry-bulb exterior air temperature, T_{s} is the surface temperature and v_{10} is the wind speed in the undisturbed flow at 10 meter above the ground and where the stated correlation is valid for a v_{10} range of [0.15,7.5] meter per second <a href=\"IDEAS.Buildings.UsersGuide.References\">[Defraeye 2011]</a>. The v_{10}-dependent term denoting the exterior convective heat transfer coefficient h_{ce} is determined as max(f(v_{10}), 5.6) in order to take into account buoyancy effects at low wind speeds <a href=\"IDEAS.Buildings.UsersGuide.References\">[Jurges 1924]</a>. Longwave radiation between the surface and environment Q_{LW,e} is determined as Q_{LW,e} = sigma.e.A.( T_{s}^4 - F_{sky}.T_{sky}^4 - (1-F_{sky})T_{db}^4 ) as derived from the Stefan-Boltzmann law wherefore sigma the Stefan-Boltzmann constant <a href=\"IDEAS.Buildings.UsersGuide.References\">[Mohr 2008]</a>, e the longwave emissivity of the exterior surface, F_{sky} the radiant-interchange configuration factor between the surface and sky <a href=\"IDEAS.Buildings.UsersGuide.References\">[Hamilton 1952]</a>, and the surface and the environment respectively and T_{s} and T_{sky} are the exterior surface and sky temperature respectively. Shortwave solar irradiation absorbed by the exterior surface is determined as Q_{SW} = e_{SW}.A.E_{SW} where e_{SW} is the shortwave absorption of the surface and E_{SW} the total irradiation on the depicted surface. </p>
<p>The heat balance of the interior surface is determined as Q_{net} = Q_{c} + Sum(Q_{SW,i}) + Sum(Q_{LW,i}) where Q_{net} denotes the heat flow into the wall, Q_{c} denotes heat transfer by convection, Q_{SW,i} denotes short-wave absorption of direct and diffuse solar light netering the interior zone through windows and Q_{LW,i} denotes long-wave heat exchange with the surounding interior surfaces. </p>
<p>The surface heat resistances <img src=\"modelica://IDEAS/Images/equations/equation-mp9YB9Y0.png\" alt=\"R_s\"/> for the exterior and interior surface respectively are determined as 1/R_{s} = A.h_{c} where A is the surface area and where h_ {c} is the exterior and interior convective heat transfer coefficient. The interior natural convective heat transfer coefficient h_{c,i} <img src=\"modelica://IDEAS/Images/equations/equation-eZGZlJrg.png\" alt=\"h_ci\"/> is computed for each interior surface as h_{c,i} = n1.D^{n2}.(T_{a}-T_{s})^{n3} where D is the characteristic length of the surface, T_{a} is the indoor air temperature and n are correlation coefficients. These parameters {n1, n2, n3} are identical to {1.823,-0.121,0.293} for vertical surfaces <a href=\"IDEAS.Buildings.UsersGuide.References\">[Khalifa 2001]</a>, {2.175,-0.076,0.308} for horizontal surfaces wherefore the heat flux is in the same direction as the buoyancy force <a href=\"IDEAS.Buildings.UsersGuide.References\">[Khalifa 2001]</a>, and {2.72,-,0.13} for horizontal surfaces wherefore the heat flux is in the opposite direction as the buoyancy force <a href=\"IDEAS.Buildings.UsersGuide.References\">[Awbi 1999]</a>. The interior natural convective heat transfer coefficient is only described as function of the temperature difference. </p>
<p>Similar to the thermal model for heat transfer through a wall, a thermal circuit formulation for the direct radiant exchange between surfaces can be derived <a href=\"IDEAS.Buildings.UsersGuide.References\">[Buchberg 1955, Oppenheim 1956]</a>. The resulting heat exchange by longwave radiation between two surface s_{i} and s_{j} can be described as Q_{si,sj} = sigma.A_{si}.(T_{si}^{4}-T_{sj}^{4})/((1-e_{si})/e_{si} + 1/F_{si,sj} + A_{si}/sum(A_{si}) ) as derived from the Stefan-Boltzmann law wherefore e_{si} and e_{sj} are the emissivity of surfaces s_{i} and s_{j} respectively, F_{si,sj} is radiant-interchange configuration factor <a href=\"IDEAS.Buildings.UsersGuide.References\">[Hamilton 1952]</a> between surfaces s_{i} and s_{j} , A_{i} and A_{j} are the areas of surfaces s_{i} and s_{j} respectively, sigma is the Stefan-Boltzmann constant <a href=\"IDEAS.Buildings.UsersGuide.References\">[Mohr 2008]</a> and R_{i} and T_{j} are the surface temperature of surfaces s_{i} and s_{j} respectively. The above description of longwave radiation for a room or thermal zone results in the necessity of a very detailed input, i.e. the configuration between all surfaces needs to be described by their shape, position and orientation in order to define F_{si,sj}, and difficulties to introduce windows and internal gains in the zone of interest. Simplification is achieved by means of a delta-star transformation <a href=\"IDEAS.Buildings.UsersGuide.References\">[Kenelly 1899]</a> and by definition of a (fictive) radiant star node in the zone model. Literature <a href=\"IDEAS.Buildings.UsersGuide.References\">[Liesen 1997]</a> shows that the overall model is not significantly sensitive to this assumption. The heat exchange by longwave radiation between surface <img src=\"modelica://IDEAS/Images/equations/equation-Mjd7rCtc.png\" alt=\"s_i\"/> and the radiant star node in the zone model can be described as Q_{si,sj} = sigma.A_{si}.(T_{si}^{4}-T_{sr}^{4})/((1-e_{si})/e_{si} + A_{si}/sum(A_{si}) ) = sigma where e_{si} is the emissivity of surface s_{i}, A_{si} is the area of surface s_{i}, sum(A_{si}) is the sum of areas for all surfaces s_{i} of the thermal zone, sigma is the Stefan-Boltzmann constant <a href=\"IDEAS.Buildings.UsersGuide.References\">[Mohr 2008]</a> and T_{si} and T_{sr} are the temperatures of surfaces <img src=\"modelica://IDEAS/Images/equations/equation-olgnuMEg.png\" alt=\"s_i\"/> and the radiant star node respectively. Absorption of shortwave solar radiation on the interior surface is handled equally as for the outside surface. Determination of the receiving solar radiation on the interior surface after passing through windows is dealt with in the zone model.</p>
<p><h4><font color=\"#008000\">Validation </font></h4></p>
<p>By means of the <code>BESTEST.mo</code> examples in the <code>Validation.mo</code> package.</p>
</html>"));
end OuterWall;
