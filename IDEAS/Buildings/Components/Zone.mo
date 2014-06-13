within IDEAS.Buildings.Components;
model Zone "thermal building zone"
  extends IDEAS.Buildings.Components.Interfaces.StateZone;
  replaceable package Air = IDEAS.Media.Air
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "Medium properties of the zonal air and all air flowports"
      annotation (choicesAllMatching = true);
  parameter Modelica.SIunits.Volume V "Total zone air volume";
  parameter Real n50(min=0.01)=0.4
    "n50 value cfr airtightness, i.e. the ACH at a pressure diffence of 50 Pa";
  parameter Real corrCV=5 "Multiplication factor for the zone air capacity";
  parameter Modelica.SIunits.Area surCapInt
    "Heat exchange surface of internal dry thermal mass";
  parameter Modelica.SIunits.Temperature TOpStart=297.15;
  parameter Boolean linear=true;
  final parameter Modelica.SIunits.Power QNom=1012*1.204*V/3600*n50/20*(273.15
       + 21 - sim.Tdes) "Design heat losses at reference outdoor temperature";
  final parameter Modelica.SIunits.MassFlowRate m_flow_nominal = 0.1*1.224*V/3600;
  Modelica.SIunits.Temperature TAir=senTem.T;
  Modelica.SIunits.Temperature TStar=radDistr.TRad;
protected
  IDEAS.Buildings.Components.BaseClasses.ZoneLwGainDistribution radDistr(final
      nSurf=nSurf) "distribution of radiative internal gains" annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=-90,
        origin={-54,-44})));
  BaseClasses.AirLeakage airLeakage(
    redeclare replaceable package Medium = Air,
    m_flow_nominal=V/3600*n50/20,
    V=V,
    n50=0.1)
    annotation (Placement(transformation(extent={{34,62},{54,82}})));
  IDEAS.Buildings.Components.BaseClasses.ZoneLwDistribution radDistrLw(final
      nSurf=nSurf, final linear=linear)
    "internal longwave radiative heat exchange" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-54,-10})));
  Modelica.Blocks.Math.Sum sum(
    nin=2,
    k={0.5,0.5},
    y(start=TOpStart))
    annotation (Placement(transformation(extent={{0,-66},{12,-54}})));
public
  Fluid.MixingVolumes.MixingVolumeMoistAir vol(
    V=V,
    m_flow_nominal=m_flow_nominal,
    redeclare replaceable package Medium = Air,
    nPorts=4)                                  annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-34,78})));
  Fluid.Interfaces.FlowPort_b flowPort_Out(redeclare replaceable package Medium
      =                                                                           Air)
    annotation (Placement(transformation(extent={{-30,90},{-10,110}})));
  Fluid.Interfaces.FlowPort_a flowPort_In(redeclare replaceable package Medium
      =                                                                          Air)
    annotation (Placement(transformation(extent={{10,90},{30,110}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCap(C=1012*1.204*V
        *(corrCV-1), T(start=TOpStart))
    "Internal thermal capacity (=thermal mass)"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-10,12})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor senTem
    annotation (Placement(transformation(extent={{0,-52},{-16,-36}})));
  Modelica.Blocks.Sources.Constant mWatFloVol(k=0)
    annotation (Placement(transformation(extent={{-70,48},{-58,60}})));
  Modelica.Blocks.Sources.Constant TWatFloVol(k=293)
    annotation (Placement(transformation(extent={{-70,26},{-58,38}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor resInt(G=3.076*surCapInt)
    "Resistance between internal mass and air, based on surface and internal convective heat exchange coefficient"
                                                                                                        annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=90,
        origin={10,-10})));
equation
  connect(surfRad, radDistr.radSurfTot) annotation (Line(
      points={{-100,-60},{-74,-60},{-74,-26},{-54,-26},{-54,-34}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(radDistr.iSolDir, iSolDir) annotation (Line(
      points={{-58,-54},{-58,-80},{-20,-80},{-20,-100}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(radDistr.iSolDif, iSolDif) annotation (Line(
      points={{-54,-54},{-54,-76},{20,-76},{20,-100}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(radDistr.radGain, gainRad) annotation (Line(
      points={{-50.2,-54},{-50,-54},{-50,-72},{80,-72},{80,-60},{100,-60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(surfRad, radDistrLw.port_a) annotation (Line(
      points={{-100,-60},{-74,-60},{-74,-26},{-54,-26},{-54,-20}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(sum.y, TSensor) annotation (Line(
      points={{12.6,-60},{59.3,-60},{59.3,0},{106,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(radDistr.TRad, sum.u[1]) annotation (Line(
      points={{-44,-44},{-22,-44},{-22,-60.6},{-1.2,-60.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(propsBus.area, radDistr.area) annotation (Line(
      points={{-100,40},{-82,40},{-82,-40},{-64,-40}},
      color={127,0,0},
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(propsBus.area, radDistrLw.A) annotation (Line(
      points={{-100,40},{-82,40},{-82,-14},{-64,-14}},
      color={127,0,0},
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(propsBus.epsLw, radDistrLw.epsLw) annotation (Line(
      points={{-100,40},{-82,40},{-82,-10},{-64,-10}},
      color={127,0,0},
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(propsBus.epsLw, radDistr.epsLw) annotation (Line(
      points={{-100,40},{-82,40},{-82,-44},{-64,-44}},
      color={127,0,0},
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(propsBus.epsSw, radDistr.epsSw) annotation (Line(
      points={{-100,40},{-82,40},{-82,-48},{-64,-48}},
      color={127,0,0},
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(vol.heatPort, gainCon) annotation (Line(
      points={{-34,68},{-34,-30},{100,-30}},
      color={191,0,0},
      smooth=Smooth.None));
for i in 1:nSurf loop
  connect(surfCon[i], vol.heatPort) annotation (Line(
      points={{-100,-30},{-34,-30},{-34,68}},
      color={191,0,0},
      smooth=Smooth.None));
end for;
  connect(flowPort_In, vol.ports[1]) annotation (Line(
      points={{20,100},{20,75},{-24,75}},
      color={0,128,255},
      smooth=Smooth.None));
  connect(flowPort_Out, vol.ports[2]) annotation (Line(
      points={{-20,100},{-20,77},{-24,77}},
      color={0,128,255},
      smooth=Smooth.None));
  connect(senTem.port, gainCon) annotation (Line(
      points={{0,-44},{10,-44},{10,-30},{100,-30}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(senTem.T, sum.u[2]) annotation (Line(
      points={{-16,-44},{-18,-44},{-18,-59.4},{-1.2,-59.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(airLeakage.port_a, vol.ports[3]) annotation (Line(
      points={{34,72},{6,72},{6,79},{-24,79}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(airLeakage.port_b, vol.ports[4]) annotation (Line(
      points={{54,72},{56,72},{56,81},{-24,81}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(mWatFloVol.y, vol.mWat_flow) annotation (Line(
      points={{-57.4,54},{-42,54},{-42,66}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TWatFloVol.y, vol.TWat) annotation (Line(
      points={{-57.4,32},{-38,32},{-38,66},{-38.8,66}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatCap.port, resInt.port_b) annotation (Line(
      points={{4.44089e-16,12},{10,12},{10,-2}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(resInt.port_a, gainCon) annotation (Line(
      points={{10,-18},{10,-30},{100,-30}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
         graphics),
    Documentation(info="<html>
<h4><span style=\"color:#008000\">General description</span></h4>
<h5>Goal</h5>
<p>Also the thermal response of a zone can be divided into a convective, longwave radiative and shortwave radiative process influencing both thermal comfort in the depicted zone as well as the response of adjacent wall structures.</p>
<h5>Description</h5>
<p>The air within the zone is modeled based on the assumption that it is well-stirred, i.e. it is characterized by a single uniform air temperature. This is practically accomplished with the mixing caused by the air distribution system. The convective gains and the resulting change in air temperature T_{a} of a single thermal zone can be modeled as a thermal circuit. The resulting heat balance for the air node can be described as c_{a}.V_{a}.dT_{a}/dt = som(Q_{ia}) + sum(h_{ci}.A_{si}.(T_{a}-T_{si})) + sum(m_{az}.(h_{a}-h_{az})) + m_{ae}(h_{a}-h_{ae}) + m_{sys}(h_{a}-h_{sys}) wherefore h_{a} is the specific air enthalpy and where T_{a} is the air temperature of the zone, c_{a} is the specific heat capacity of air at constant pressure, V_{a} is the zone air volume, Q_{a} is a convective internal load, R_{si} is the convective surface resistance of surface s_{i}, A_{si} is the area of surface s_{i}, T_{si} the surface temperature of surface s_{i}, m_{az} is the mass flow rate between zones, m_{ae} is the mass flow rate between the exterior by natural infiltrationa and m_{sys} is the mass flow rate provided by the ventilation system. </p>
<p>Infiltration and ventilation systems provide air to the zones, undesirably or to meet heating or cooling loads. The thermal energy provided to the zone by this air change rate can be formulated from the difference between the supply air enthalpy and the enthalpy of the air leaving the zone <img src=\"modelica://IDEAS/Images/equations/equation-jiSQ22c0.png\" alt=\"h_a\"/>. It is assumed that the zone supply air mass flow rate is exactly equal to the sum of the air flow rates leaving the zone, and all air streams exit the zone at the zone mean air temperature. The moisture dependence of the air enthalpy is neglected.</p>
<p>A multiplier for the zone capacitance f_{ca} is included. A f_{ca} equaling unity represents just the capacitance of the air volume in the specified zone. This multiplier can be greater than unity if the effect of internal thermal mass is to be considered (furniture, unmodelled internall walls, equipment). This multiplier is constant throughout the simulation and is set to 5.0 if the value is not defined <a href=\"IDEAS.Buildings.UsersGuide.References\">[Masy 2008]</a>.  The additional capacitance is modelled as a thermal capacity, coupled to the air mixing volume through a thermal inductance.  The value of this thermal conductance is 3.076 * surCapInt.  surCapInt is a parmeter to be provided by the modeller and represents the estimated contact suface of the thermal mass with the zone air.  A fix convective heat transfer coefficient of 3.076 is assumed.  </p>
<p>The exchange of longwave radiation in a zone has been previously described in the building component models and further considering the heat balance of the interior surface. Here, an expression based on <i>radiant interchange configuration factors</i> or <i>view factors</i> is avoided based on a delta-star transformation and by definition of a <i>radiant star temperature</i> T_{rs}. Literature <a href=\"IDEAS.Buildings.UsersGuide.References\">[Liesen 1997]</a> shows that the overall model is not significantly sensitive to this assumption. ThisT_{rs} can be derived from the law of energy conservation in the radiant star node as sum(Q_{si,rs}) must equal zero. Long wave radiation from internal sources are dealt with by including them in the heat balance of the radiant star node resulting in a diffuse distribution of the radiative source.</p>
<p>Transmitted shortwave solar radiation is distributed over all surfaces in the zone in a prescribed scale. This scale is an input value which may be dependent on the shape of the zone and the location of the windows, but literature <a href=\"IDEAS.Buildings.UsersGuide.References\">[Liesen 1997]</a> shows that the overall model is not significantly sensitive to this assumption.</p>
<h4><span style=\"color:#008000\">Validation </span></h4>
<p>By means of the <code>BESTEST.mo</code> examples in the <code>Validation.mo</code> package.</p>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),     graphics));
end Zone;
