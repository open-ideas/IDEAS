within IDEAS.Buildings.Components.Interfaces;
model PartialZone "Building zone model"
  extends IDEAS.Buildings.Components.Interfaces.ZoneInterface(
    Qgai(y=(if not sim.computeConservationOfEnergy then 0 elseif sim.openSystemConservationOfEnergy
           then airModel.QGai else gainCon.Q_flow + gainRad.Q_flow + airModel.QGai)),
    Eexpr(y=if sim.computeConservationOfEnergy then E else 0),
    useOccNumInput=occNum.useInput,
    useLigCtrInput=ligCtr.useCtrInput);

  replaceable package Medium = IDEAS.Media.Air constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium in the component"
    annotation (choicesAllMatching = true);
  parameter Boolean use_custom_n50=
    sim.interZonalAirFlowType==IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None
    and not sim.unify_n50
    "if true, a custom n50 value is used instead of a globally computed n50 value" annotation(Dialog(tab="Airflow", group="Airtightness"));

  parameter Real n50(unit="1/h",min=0.01)= sim.n50 "n50 value for this zone"
   annotation(Dialog(tab="Airflow", group="Airtightness"));
  final parameter Real n50_computed(unit="1/h",min=0.01) = n50_int "Computed n50 value";
  parameter Boolean allowFlowReversal=true
    "= true to allow flow reversal in zone, false restricts to design direction (port_a -> port_b)."
    annotation(Dialog(tab="Airflow", group="Air model"));
  parameter Real n50toAch=20 "Conversion fractor from n50 to Air Change Rate"
   annotation(Dialog(tab="Airflow", group="Airtightness"));
  parameter Modelica.Fluid.Types.Dynamics energyDynamicsAir=Modelica.Fluid.Types.Dynamics.FixedInitial
    "Type of energy balance for air model: dynamic (3 initialization options) or steady state";
  parameter Real mSenFac(min=0.1) = 5 "Correction factor for thermal capacity of zone air."
    annotation(Dialog(tab="Advanced",group="Air model"));

  parameter Boolean linIntRad=sim.linIntRad
    "Linearized computation of long wave radiation"
    annotation(Dialog(tab="Advanced", group="Radiative heat exchange"));
  parameter Boolean calculateViewFactor = false
    "Explicit calculation of view factors: works well only for rectangular zones!"
    annotation(Dialog(tab="Advanced", group="Radiative heat exchange"));
  parameter Modelica.Units.SI.Temperature TZon_design=294.15
    "Reference zone temperature for calculation of design heat load"
    annotation (Dialog(group="Design heat load", tab="Advanced"));
  final parameter Modelica.Units.SI.Power QInf_design=1012*1.204*V/3600*n50_int
      /n50toAch*(TZon_design - sim.Tdes)
    "Design heat losses from infiltration at reference outdoor temperature";
  final parameter Modelica.Units.SI.Power QRH_design=A*fRH
    "Additional power required to compensate for the effects of intermittent heating";
  final parameter Modelica.Units.SI.Power Q_design(fixed=false)
    "Total design heat losses for the zone (including transmission, infiltration, and reheating; excluding ventilation)";
  parameter Medium.Temperature T_start=Medium.T_default
    "Start value of temperature"
    annotation(Dialog(tab = "Initialization"));
  parameter Real fRH=11
    "Reheat factor for calculation of design heat load, (EN 12831, table D.10 Annex D)" annotation(Dialog(tab="Advanced",group="Design heat load"));
  parameter Modelica.Units.SI.Temperature Tzone_nom=295.15
    "Nominal zone temperature, used for linearising radiative heat exchange"
    annotation (Dialog(
      tab="Advanced",
      group="Radiative heat exchange",
      enable=linIntRad));
  parameter Modelica.Units.SI.TemperatureDifference dT_nom=-2
    "Nominal temperature difference between zone walls, used for linearising radiative heat exchange"
    annotation (Dialog(
      tab="Advanced",
      group="Radiative heat exchange",
      enable=linIntRad));
  parameter Boolean simVieFac=false "Simplify view factor computation"
    annotation(Dialog(tab="Advanced", group="Radiative heat exchange"));
  parameter Boolean ignAss=false "Ignore asserts to simulate non-physical unit test models"
    annotation(Dialog(tab="Advanced", group="Radiative heat exchange"));

  replaceable ZoneAirModels.WellMixedAir airModel
  constrainedby
    IDEAS.Buildings.Components.ZoneAirModels.BaseClasses.PartialAirModel(
    redeclare package Medium = Medium,
    mSenFac=mSenFac,
    nSurf=nSurf,
    Vtot=V,
    final T_start=T_start,
    allowFlowReversal=allowFlowReversal,
    energyDynamics=energyDynamicsAir,
    massDynamics=if interzonalAirFlow.prescribesPressure or
                    sim.interZonalAirFlowType <> IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None
                 then Modelica.Fluid.Types.Dynamics.SteadyState
                 else energyDynamicsAir,
    nPorts=interzonalAirFlow.nPorts + n_ports_interzonal,
    m_flow_nominal=m_flow_nominal)
    "Zone air model"
    annotation (choicesAllMatching=true,
    Placement(transformation(extent={{-40,20},{-20,40}})),
    Dialog(tab="Airflow",group="Air model"));
  replaceable IDEAS.Buildings.Components.InterzonalAirFlow.Sim interzonalAirFlow
  constrainedby
    IDEAS.Buildings.Components.InterzonalAirFlow.BaseClasses.PartialInterzonalAirFlow(
      redeclare package Medium = Medium,
      final nPortsExt=nPorts,
      V=V,
      n50=n50_int,
      n50toAch=n50toAch,
      m_flow_nominal_vent=m_flow_nominal)
      "Interzonal air flow model"
    annotation (choicesAllMatching = true,Dialog(tab="Airflow",group="Airtightness"),
      Placement(transformation(extent={{-40,60},{-20,80}})));
  replaceable IDEAS.Buildings.Components.Occupants.Fixed occNum
    constrainedby Occupants.BaseClasses.PartialOccupants(
      final A=A,
      final linearise = sim.lineariseDymola)
    "Number of occupants that are present" annotation (
    choicesAllMatching=true,
    Dialog(group="Occupants (optional)"),
    Placement(transformation(extent={{80,22},{60,42}})));

  replaceable parameter IDEAS.Buildings.Components.OccupancyType.OfficeWork occTyp annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{80, 82}, {100, 102}}, rotation = 0)))
    constrainedby
    IDEAS.Buildings.Components.OccupancyType.BaseClasses.PartialOccupancyType
    "Occupancy type, only used for evaluating occupancy model and comfort model"
    annotation (
    choicesAllMatching=true,
    Dialog(group="Occupants (optional)"),
    Placement(transformation(extent={{80,82},{100,102}})));
  replaceable parameter IDEAS.Buildings.Components.RoomType.Generic rooTyp
    constrainedby
    IDEAS.Buildings.Components.RoomType.BaseClasses.PartialRoomType
    "Room type or function, currently only determines the desired lighting intensity"
    annotation (choicesAllMatching=true,
    Dialog(group="Lighting (optional)"),
    Placement(transformation(extent={{32,82},{52,102}})));
  replaceable parameter IDEAS.Buildings.Components.LightingType.None ligTyp
    constrainedby
    IDEAS.Buildings.Components.LightingType.BaseClasses.PartialLighting
    "Lighting type, determines the lighting efficacy/efficiency" annotation (
    choicesAllMatching=true,
    Dialog(group="Lighting (optional)"),
    Placement(transformation(extent={{56,82},{76,102}})));
  replaceable IDEAS.Buildings.Components.Comfort.None comfort
    constrainedby IDEAS.Buildings.Components.Comfort.BaseClasses.PartialComfort(
      occupancyType=occTyp,
      use_phi_in=Medium.nX > 1) "Comfort model" annotation (
    choicesAllMatching=true,
    Dialog(group="Occupants (optional)"),
    Placement(transformation(extent={{20,-20},{40,0}})));
  replaceable IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.ZoneLwGainDistribution
    radDistr(nSurf=nSurf, lineariseJModelica=sim.lineariseJModelica,
    T_start=T_start)
    "Distribution of radiative internal gains"
    annotation (choicesAllMatching=true,Dialog(tab="Advanced",group="Building physics"),Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=-90,
        origin={-50,-50})));
  replaceable IDEAS.Buildings.Components.InternalGains.Occupants intGaiOcc
    constrainedby
    IDEAS.Buildings.Components.InternalGains.BaseClasses.PartialOccupancyGains(
      occupancyType=occTyp,
      redeclare final package Medium = Medium)
    "Internal gains model" annotation (
    choicesAllMatching=true,
    Dialog(tab="Advanced", group="Occupants"),
    Placement(transformation(extent={{40,22},{20,42}})));

  replaceable IDEAS.Buildings.Components.InternalGains.Lighting intGaiLig
    constrainedby
    IDEAS.Buildings.Components.InternalGains.BaseClasses.PartialLightingGains(
      A=A,
      ligTyp=ligTyp,
      rooTyp=rooTyp) "Lighting model" annotation (
    choicesAllMatching=true,
    Dialog(tab="Advanced", group="Lighting"),
    Placement(transformation(extent={{40,52},{20,72}})));

  Modelica.Units.SI.Power QTra_design=sum(propsBusInt.QTra_design)
    "Total design transmission heat losses for the zone";
  Modelica.Blocks.Interfaces.RealOutput TAir(unit="K") = airModel.TAir;
  Modelica.Blocks.Interfaces.RealOutput TRad(unit="K") = radDistr.TRad;
  Modelica.Units.SI.Energy E=airModel.E;

  replaceable IDEAS.Buildings.Components.LightingControl.Fixed ligCtr
    constrainedby
    IDEAS.Buildings.Components.LightingControl.BaseClasses.PartialLightingControl(
      final linearise = sim.lineariseDymola)
    "Lighting control type" annotation (
    choicesAllMatching=true,
    Dialog(group="Lighting (optional)"),
    Placement(transformation(extent={{80,52},{60,72}})));


  IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.ZoneLwDistributionViewFactor
    zoneLwDistributionViewFactor(
      nSurf=nSurf,
      final hZone=hZone,
    linearise=linIntRad or sim.linearise,
    Tzone_nom=Tzone_nom,
    dT_nom=dT_nom)       if calculateViewFactor annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-30,-10})));
  Modelica.Blocks.Math.Add addmWatFlow "Add medium substance mass flow rates, typically moisture" annotation (
    Placement(visible = true, transformation(origin = {-6, 40}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Modelica.Blocks.Math.Add addCFlow[max(Medium.nC,1)](k2 = intGaiOcc.s_co2) "Add tracer mass flow rates"  annotation (
    Placement(visible = true, transformation(origin = {-6, 34}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
protected
  Modelica.Blocks.Sources.RealExpression TRefZon[nSurf](each y=TZon_design)
    "Reference zone temperature for the surfaces connected to this zone, for calculation of design heat load";

  parameter Real n50_int(unit="1/h",min=0.01,fixed= false)
    "n50 value cfr airtightness, i.e. the ACH at a pressure diffence of 50 Pa"
    annotation(Dialog(enable=use_custom_n50,tab="Airflow", group="Airtightness"));
  parameter Integer n_ports_interzonal=
    if sim.interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None then 0
    elseif sim.interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.OnePort then nSurf
    else nSurf*3
      "Number of fluid ports for interzonal air flow modelling"
      annotation(Evaluate=true);
  IDEAS.Buildings.Components.Interfaces.ZoneBus[nSurf] propsBusInt(
    redeclare each final package Medium = Medium,
    each final numIncAndAziInBus=sim.numIncAndAziInBus,
    each final outputAngles=sim.outputAngles,
    each final use_port_1=sim.interZonalAirFlowType <> IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None,
    each final use_port_2=sim.interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts)
    "Dummy propsbus for partial" annotation (Placement(transformation(
        extent={{-20,20},{20,-20}},
        rotation=-90,
        origin={-80,40}), iconTransformation(
        extent={{-20,20},{20,-20}},
        rotation=-90,
        origin={-80,40})));

  IDEAS.Buildings.Components.BaseClasses.RadiativeHeatTransfer.ZoneLwDistribution
    radDistrLw(nSurf=nSurf, final linearise=linIntRad or sim.linearise,
    Tzone_nom=Tzone_nom,
    dT_nom=dT_nom,
    final simVieFac=simVieFac,
    final ignAss=ignAss)                if not calculateViewFactor
    "internal longwave radiative heat exchange" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-50,-10})));
  Modelica.Blocks.Math.Sum add(nin=2, k={0.5,0.5}) "Operative temperature"
    annotation (Placement(transformation(extent={{84,14},{96,26}})));

  Setq50 setq50(
    nSurf=nSurf,
    n50=n50_int,
    V=V,
    q50_corr=sim.q50_def,
    use_custom_n50=use_custom_n50,
    hZone=hZone,
    hFloor=hFloor)
    annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));

model Setq50 "q50 computation for zones"
  extends Modelica.Blocks.Icons.Block;

  parameter Integer nSurf
    "Number of surfaces";
  parameter Real n50
    "n50 value";
    parameter Modelica.Units.SI.Volume V "Zone volume";
  parameter Real q50_corr;
  parameter Boolean use_custom_n50 = false
    " = true, to set custom n50 value for this zone";

  parameter Boolean allSurfacesCustom(fixed=false)
    "Boolean indicating whether all connected surfaces are custom"
    annotation(Evaluate=true);
    final parameter Modelica.Units.SI.Area defaultArea[nSurf](each fixed=false)
      "The surface area for which default q50 is computed";
  parameter Real v50_custom[nSurf](each fixed=false)
    "custom assigned v50 value, else zero";

  parameter Modelica.Units.SI.Length hZone "Zone height: distance between floor and ceiling";
  parameter Modelica.Units.SI.Length hFloor = 0  "Absolute height of zone floor. Relative to the height at which the atmospheric pressure is defined.";

  Modelica.Blocks.Interfaces.RealInput v50_surf[nSurf]
   annotation (Placement(transformation(extent={{-126,28},{-86,68}})));
  Modelica.Blocks.Interfaces.BooleanInput use_custom_q50[nSurf]
    "Equals true if the user assigned a custom q50 value for the surface"
   annotation (Placement(transformation(extent={{-126,60},{-86,100}})));
  Modelica.Blocks.Interfaces.RealInput Area[nSurf]
    "Surface areas"
   annotation (Placement(transformation(extent={{-126,-6},{-86,34}})));
  Modelica.Blocks.Interfaces.BooleanOutput use_custom_n50s[nSurf]
    "Equals true if the surfaces connected to this zone should use the custom q50 value"
   annotation (Placement(transformation(extent={{-98,-38},{-118,-18}})));
  Modelica.Blocks.Interfaces.RealOutput q50_zone[nSurf]
    "Custom q50 value for the surfaces connected to this zone"
   annotation (Placement(transformation(extent={{-98,-60},{-118,-40}})));
  Modelica.Blocks.Interfaces.RealOutput hzone[nSurf]
    "Custom q50 value for the surfaces connected to this zone"
    annotation (Placement(transformation(extent={{-96,-82},{-116,-62}})));
  Modelica.Blocks.Interfaces.RealOutput hfloor[nSurf]
    "Custom q50 value for the surfaces connected to this zone"
    annotation (Placement(transformation(extent={{-96,-106},{-116,-86}})));
initial equation

  for i in 1:nSurf loop
    defaultArea[i] = if use_custom_q50[i] then 0 else Area[i];
    v50_custom[i] = if use_custom_q50[i] then v50_surf[i] else 0;

  end for;
  allSurfacesCustom = max(Modelica.Constants.small, sum(defaultArea)) <= Modelica.Constants.small;

equation
  use_custom_n50s=fill(use_custom_n50,nSurf);

  if use_custom_n50 then
    q50_zone=fill((((n50*V) - sum(v50_custom))/max(Modelica.Constants.small, sum(defaultArea))), nSurf);
  else
    q50_zone=fill(q50_corr,nSurf);
  end if;

    hzone=fill(hZone,nSurf);
    hfloor=fill(hFloor,nSurf);
    annotation (Icon(graphics={Rectangle(
            extent={{-84,80},{82,-80}},
            lineColor={28,108,200},
            fillColor={145,167,175},
            fillPattern=FillPattern.Forward)}));
end Setq50;



initial equation
  n50_int = if use_custom_n50 and not setq50.allSurfacesCustom then n50 else sum(propsBusInt.v50)/V;

  Q_design=QInf_design+QRH_design+QTra_design;
  //Total design load for zone (excluding ventilation losses, these are assumed to be calculated in the ventilation system
  //and should be added afterwards to obtain the total design heat load). See for example IDEAS.Templates.Interfaces.Building.

equation
  if interzonalAirFlow.verifyBothPortsConnected then
    assert(cardinality(port_a)>1 and cardinality(port_b)>1 or cardinality(port_a) == 1 and cardinality(port_b) == 1,
      "WARNING: Only one of the FluidPorts of " + getInstanceName() + " is 
      connected and an 'open' interzonalAirFlow model is used, 
      which means that all injected/extracted air will flow
      through the zone to/from the surroundings, at ambient temperature. 
      This may be unintended.", AssertionLevel.warning);
  end if;


  for i in 1:nSurf loop
    connect(dummy1, propsBusInt[i].Qgai);
    connect(dummy2, propsBusInt[i].E);
end for;
  connect(radDistr.radGain, gainRad) annotation (Line(
      points={{-46.2,-60},{100,-60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(radDistr.TRad, add.u[1]) annotation (Line(
      points={{-40,-50},{-6,-50},{-6,19.7},{82.8,19.7}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(propsBusInt[1:nSurf].area, radDistr.area[1:nSurf]) annotation (Line(
      points={{-80.1,39.9},{-80,39.9},{-80,-58},{-60,-58}},
      color={127,0,0},
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(propsBusInt[1:nSurf].area, radDistrLw.A[1:nSurf]) annotation (Line(
      points={{-80.1,39.9},{-80,39.9},{-80,-14},{-60,-14}},
      color={127,0,0},
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(propsBusInt[1:nSurf].epsLw, radDistrLw.epsLw[1:nSurf]) annotation (
      Line(
      points={{-80.1,39.9},{-80,39.9},{-80,-10},{-60,-10}},
      color={127,0,0},
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(propsBusInt[1:nSurf].epsLw, zoneLwDistributionViewFactor.epsLw[1:
    nSurf]) annotation (Line(
      points={{-80.1,39.9},{-80,39.9},{-80,-10},{-40,-10}},
      color={127,0,0},
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(propsBusInt[1:nSurf].area, zoneLwDistributionViewFactor.A[1:nSurf])
    annotation (Line(
      points={{-80.1,39.9},{-80,39.9},{-80,-14},{-40,-14}},
      color={127,0,0},
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(propsBusInt[1:nSurf].epsLw, radDistr.epsLw[1:nSurf]) annotation (Line(
      points={{-80.1,39.9},{-80,39.9},{-80,-50},{-60,-50}},
      color={127,0,0},
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(propsBusInt[1:nSurf].epsSw, radDistr.epsSw[1:nSurf]) annotation (Line(
      points={{-80.1,39.9},{-80,39.9},{-80,-54},{-60,-54}},
      color={127,0,0},
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  for i in 1:nSurf loop
    connect(radDistr.iSolDir, propsBusInt[i].iSolDir) annotation (Line(
        points={{-54,-60},{-80.1,-60},{-80.1,39.9}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(radDistr.iSolDif, propsBusInt[i].iSolDif) annotation (Line(
        points={{-50,-60},{-50,-64},{-80.1,-64},{-80.1,39.9}},
        color={191,0,0},
        smooth=Smooth.None));
  end for;
  connect(radDistr.radSurfTot, radDistrLw.port_a) annotation (Line(
      points={{-50,-40},{-50,-20}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(zoneLwDistributionViewFactor.inc[1:nSurf], propsBusInt[1:nSurf].inc)
    annotation (Line(
      points={{-34,-1.77636e-15},{-34,4},{-80,4},{-80,39.9},{-80.1,39.9}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(zoneLwDistributionViewFactor.azi[1:nSurf], propsBusInt[1:nSurf].azi)
    annotation (Line(
      points={{-26,-1.77636e-15},{-26,8},{-80,8},{-80,39.9},{-80.1,39.9}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(zoneLwDistributionViewFactor.port_a, radDistr.radSurfTot) annotation (
     Line(
      points={{-30,-20},{-30,-30},{-50,-30},{-50,-40}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(add.y, TSensor) annotation (Line(points={{96.6,20},{98,20},{98,20},{110,
          20}},    color={0,0,127}));
  connect(radDistr.radSurfTot[1:nSurf], propsBusInt[1:nSurf].surfRad)
    annotation (Line(points={{-50,-40},{-50,-30},{-80,-30},{-80,39.9},{-80.1,
          39.9}}, color={191,0,0}));
  connect(airModel.ports_surf[1:nSurf], propsBusInt[1:nSurf].surfCon)
    annotation (Line(points={{-40,30},{-80,30},{-80,40},{-80.1,40},{-80.1,39.9}},
        color={191,0,0}));
  connect(airModel.inc[1:nSurf], propsBusInt[1:nSurf].inc) annotation (Line(
        points={{-40.8,38},{-80,38},{-80,40},{-82,40},{-80.1,40},{-80.1,39.9}},
        color={0,0,127}));
  connect(airModel.azi[1:nSurf], propsBusInt[1:nSurf].azi) annotation (Line(
        points={{-40.8,34},{-80,34},{-80,40},{-80.1,40},{-80.1,39.9}}, color={0,
          0,127}));
  connect(airModel.A[1:nSurf], propsBusInt[1:nSurf].area) annotation (Line(
        points={{-40.6,24},{-80,24},{-80,40},{-80.1,40},{-80.1,39.9}}, color={0,
          0,127}));
  connect(airModel.ports_air[1], gainCon) annotation (Line(points={{-20,30},{2,30},
          {2,-30},{100,-30}}, color={191,0,0}));
  connect(airModel.TAir, add.u[2]) annotation (Line(points={{-19,24},{-10,24},{-10,
          20.3},{82.8,20.3}},  color={0,0,127}));
  connect(radDistr.azi[1:nSurf], propsBusInt[1:nSurf].azi) annotation (Line(
        points={{-60,-42},{-70,-42},{-80,-42},{-80,39.9},{-80.1,39.9}}, color={
          0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(radDistr.inc[1:nSurf], propsBusInt[1:nSurf].inc) annotation (Line(
        points={{-60,-46},{-80,-46},{-80,39.9},{-80.1,39.9}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(intGaiOcc.portCon, airModel.ports_air[1])
    annotation (Line(points={{20,30},{-20,30}}, color={191,0,0}));
  connect(intGaiOcc.portRad, radDistr.radGain) annotation (Line(points={{20,26},
          {4,26},{4,-60},{-46.2,-60}}, color={191,0,0}));
  connect(comfort.TAir, airModel.TAir) annotation (Line(points={{19,0},{-10,0},{
          -10,24},{-19,24}},   color={0,0,127}));
  connect(comfort.TRad, radDistr.TRad) annotation (Line(points={{19,-4},{-6,-4},
          {-6,-50},{-40,-50}}, color={0,0,127}));
  connect(comfort.phi_in, airModel.phi) annotation (Line(points={{19,-8},{-12,-8},{
          -12,26},{-19,26}},   color={0,0,127}));
  connect(occNum.nOcc, intGaiOcc.nOcc)
    annotation (Line(points={{58,32},{41,32}}, color={0,0,127}));
  connect(yOcc, occNum.yOcc) annotation (Line(points={{120,40},{96,40},{96,32},{
          82,32}}, color={0,0,127}));
  connect(uLig, ligCtr.ligCtr) annotation (Line(points={{120,70},{96,70},{96,60},
          {82,60}},color={0,0,127}));
  connect(occNum.nOcc, ligCtr.nOcc) annotation (Line(points={{58,32},{96,32},{96,
          64},{82,64}},
                   color={0,0,127}));
  connect(airModel.port_b, interzonalAirFlow.port_a_interior)
    annotation (Line(points={{-36,40},{-36,60}}, color={0,127,255}));
  connect(airModel.port_a, interzonalAirFlow.port_b_interior)
    annotation (Line(points={{-24,40},{-24,60}}, color={0,127,255}));
  connect(interzonalAirFlow.ports[1:interzonalAirFlow.nPorts], airModel.ports[1:interzonalAirFlow.nPorts]) annotation (Line(points={{
          -29.8,60},{-30,60},{-30,40}}, color={0,127,255}));
  connect(interzonalAirFlow.port_b_exterior, port_b) annotation (Line(points={{-36,80},
          {-36,92},{-60,92},{-60,100}},         color={0,127,255}));
  connect(interzonalAirFlow.port_a_exterior, port_a) annotation (Line(points={{-24,80},
          {-24,84},{60,84},{60,100}},         color={0,127,255}));
  connect(ppm, airModel.ppm) annotation (Line(points={{110,0},{52,0},{52,16},{-8,
          16},{-8,28},{-19,28}}, color={0,0,127}));
  connect(intGaiLig.portRad, gainRad) annotation (Line(points={{20,60},{4,60},{4,
          -60},{100,-60}}, color={191,0,0}));
  connect(intGaiLig.portCon, gainCon) annotation (Line(points={{20,64},{2,64},{2,
          -30},{100,-30}}, color={191,0,0}));
  connect(ligCtr.ctrl, intGaiLig.ctrl)
    annotation (Line(points={{58,62},{41,62}}, color={0,0,127}));
  connect(interzonalAirFlow.portsExt, ports) annotation (Line(points={{-30,80},{
          -30,90},{0,90},{0,100}}, color={0,127,255}));
  if sim.interZonalAirFlowType <> IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None then
    connect(airModel.ports[interzonalAirFlow.nPorts + 1:interzonalAirFlow.nPorts + nSurf], propsBusInt[1:nSurf].port_1) annotation (Line(points={{-30,
          40},{-30,39.9},{-80.1,39.9}}, color={0,127,255}));
  end if;
  if sim.interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.TwoPorts then
    connect(airModel.ports[interzonalAirFlow.nPorts + 1 + nSurf:interzonalAirFlow.nPorts + nSurf*2], propsBusInt[1:nSurf].port_2) annotation (Line(points={{-30,
          40},{-30,39.9},{-80.1,39.9}}, color={0,127,255}));
    connect(airModel.ports[interzonalAirFlow.nPorts + 1 + nSurf*2:interzonalAirFlow.nPorts + nSurf*3], propsBusInt[1:nSurf].port_3) annotation (Line(points={{-30,
          40},{-30,39.9},{-80.1,39.9}}, color={0,127,255}));

  end if;
  connect(setq50.Area, propsBusInt.area) annotation (Line(points={{-60.6,-88.6},
          {-60.6,-89.3},{-80.1,-89.3},{-80.1,39.9}}, color={0,0,127}));
  connect(setq50.v50_surf, propsBusInt.v50) annotation (Line(points={{-60.6,-85.2},
          {-60.6,-84.6},{-80.1,-84.6},{-80.1,39.9}}, color={0,0,127}));
  connect(setq50.use_custom_q50, propsBusInt.use_custom_q50) annotation (Line(points={{-60.6,
          -82},{-80,-82},{-80,39.9},{-80.1,39.9}},
                                              color={0,0,127}));
  connect(setq50.use_custom_n50s, propsBusInt.use_custom_n50) annotation (Line(points={{-60.8,
          -92.8},{-60,-92.8},{-60,-92},{-80.1,-92},{-80.1,39.9}},       color={
          255,0,255}));
  connect(setq50.q50_zone, propsBusInt.q50_zone) annotation (Line(points={{
          -60.8,-95},{-80.1,-95},{-80.1,39.9}}, color={0,0,127}));
  connect(setq50.hzone, propsBusInt.hzone) annotation (Line(points={{-60.6,
          -97.2},{-60.6,-97.8},{-80.1,-97.8},{-80.1,39.9}}, color={0,0,127}));
  connect(setq50.hfloor, propsBusInt.hfloor) annotation (Line(points={{-60.6,
          -99.6},{-60.6,-99.8},{-80.1,-99.8},{-80.1,39.9}}, color={0,0,127}));
  connect(intGaiOcc.mWat_flow, addmWatFlow.u2) annotation(
    Line(points = {{20, 38}, {-2, 38}}, color = {0, 0, 127}));
  connect(addmWatFlow.y, airModel.mWat_flow) annotation(
    Line(points = {{-10, 40}, {-20, 40}, {-20, 38}}, color = {0, 0, 127}));
  connect(addCFlow.y, airModel.C_flow) annotation(
    Line(points = {{-10, 34}, {-20, 34}}, color = {0, 0, 127}, thickness = 0.5));
  connect(addCFlow.u1, intGaiOcc.C_flow) annotation(
    Line(points = {{-2, 36}, {14, 36}, {14, 34}, {20, 34}}, color = {0, 0, 127}, thickness = 0.5));
  for i in 1:max(Medium.nC,1) loop
    connect(addCFlow[i].u2, C_flow) annotation(
    Line(points = {{-2, 32}, {8, 32}, {8, -100}, {120, -100}}, color = {0, 0, 127}));
    if not useCFlowInput then
      addCFlow[i].u2=0;
    end if;
  end for;
  if not useWatFlowInput then
    addmWatFlow.u1=0;
  end if;
  connect(airModel.phi, phi) annotation(
    Line(points = {{-18, 26}, {-12, 26}, {-12, 10}, {110, 10}}, color = {0, 0, 127}));
  connect(addmWatFlow.u1, mWat_flow) annotation(
    Line(points = {{-2, 42}, {10, 42}, {10, -80}, {120, -80}}, color = {0, 0, 127}));
  connect(TRefZon.y, propsBusInt.TRefZon);

  annotation (Placement(transformation(extent={{140,48},{100,88}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
         graphics),
    Documentation(info="<html>
<p>See extending models.</p>
</html>", revisions="<html>
<ul>
<li>
August 18, 2025, by Klaas De Jonge:<br/>
Simplified <code>n50_computed</code> to <code>n50_int</code> since the if statement was a duplicate.
</li>
<li>
November 11, 2024 by Lucas Verleyen:<br/>
Change Medium to IDEAS.Media.Air and use 'constrainedby' for Modelica.Media.Interfaces.PartialMedium.
This is for <a href=https://github.com/open-ideas/IDEAS/issues/1375>#1375</a>.
</li>
<li>
November 7, 2024, by Anna Dell'Isola and Jelger Jansen:<br/>
Add parameter <code>TZon_design</code> to be used when calculating <code>Q_design</code>.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1337\">#1337</a>
</li>
<li>
October 30, 2024, by Klaas De Jonge:<br/>
Modifications for interzonal airflow and stack-effect input. 
</li>
<li>
April 26, 2024 by Jelger Jansen:<br/>
Added parameter <code>ignAss</code> to ignore view factor asserts for non-physical unit test models.
This is for <a href=https://github.com/open-ideas/IDEAS/issues/1272>#1272</a>.
</li> 
<li>
Februari 18, 2024, by Filip Jorissen:<br/>
Modifications for supporting trickle vents and interzonal airflow.
</li>
<li>
January 8, 2024, by Jelger Jansen:<br/>
Added min attribute to <code>mSenFac</code>.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1343\">
#1343</a>
</li>
<li>
July 25, 2023, by Filip Jorissen:<br/>
Added conditional inputs for injecting water or CO2.
Added output phi for the relative humidity.
</li>
<li>
May 29, 2022, by Filip Jorissen:<br/>
Unprotected component for OM compatibility.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1254\">
#1254</a>
</li>
<li>
August 10, 2020, by Filip Jorissen:<br/>
Modifications for supporting interzonal airflow.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1066\">
#1066</a>
</li>
<li>
November 18, 2020, Filip Jorissen:<br/>
Changed default n50 value from 0.4 to 3 and added documentation for n50toAch.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1181\">#1181</a>.
</li>
<li>
September 17, 2020, Filip Jorissen:<br/>
Removed Medium declaration.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1169\">#1169</a>.
</li>
<li>
July 29, 2020, by Filip Jorissen:<br/>
Removed duplicate definition of <code>hZone</code> and <code>A</code>.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1158\">
#1158</a>
</li>
<li>
March 17, 2020, Filip Jorissen:<br/>
Added support for vector fluidport.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1029\">#1029</a>.
</li>
<li>
April 26, 2020, by Filip Jorissen:<br/>
Refactored <code>SolBus</code> to avoid many instances in <code>PropsBus</code>.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1131\">#1131</a>
</li>
<li>
April 26, 2019 by Filip Jorissen:<br/>
Set <code>massDynamics=if interzonalAirFlow.prescribesPressure then Modelica.Fluid.Types.Dynamics.SteadyState</code>
such that the state is removed when the pressure is prescribed.
See <a href=https://github.com/open-ideas/IDEAS/issues/1021>#1021</a>.
</li>
<li>
April 11, 2019 by Filip Jorissen:<br/>
Revised implementation such that default value of relative humidity is
used when using a dry air medium.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1011\">#1011</a>.
</li>
<li>
January 25, 2019 by Filip Jorissen:<br/>
Avoided redundant consistent initial equation for pressure in <code>airModel</code>.
See <a href=https://github.com/open-ideas/IDEAS/issues/971>#971</a>.
</li>
<li>
November 5, 2018 by Filip Jorissen:<br/>
Propagated <code>T_start</code> into <code>radDistr</code>.
</li>
<li>
September 26, 2018 by Iago Cupeiro:<br/>
Implementation of the lighting model
See <a href=\"https://github.com/open-ideas/IDEAS/issues/879\">#879</a>.
</li>
<li>
September 24, 2018 by Filip Jorissen:<br/>
Fixed duplicate declaration of <code>V</code>.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/917\">#917</a>.
</li>
<li>
July 27, 2018 by Filip Jorissen:<br/>
Added output for the CO2 concentration.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/868\">#868</a>.
</li>
<li>
July 11, 2018, Filip Jorissen:<br/>
Propagated <code>m_flow_nominal</code> for setting nominal values 
of <code>h_outflow</code> and <code>m_flow</code>
in <code>FluidPorts</code>.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/859\">#859</a>.
</li>
<li>
May 29, 2018, Filip Jorissen:<br/>
Removed conditional fluid ports for JModelica compatibility.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/834\">#834</a>.
</li>
<li>
April 27, 2018 by Filip Jorissen:<br/>
Modified interfaces for supporting new interzonal air flow models.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/796\">#796</a>.
</li>
<li>
April 12, 2018 by Filip Jorissen:<br/>
Propagated <code>energyDynamicsAir</code>.
See issue <a href=https://github.com/open-ideas/IDEAS/issues/800>#800</a>.
</li>
<li>
March 29, 2018 by Filip Jorissen:<br/>
Propagated <code>mSenFac</code> to <code>airModel</code>.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/792\">#792</a>.
</li>
<li>
March 28, 2018 by Filip Jorissen:<br/>
Added option for introducing state for
radiative temperature.
</li>
<li>
July 26, 2018 by Filip Jorissen:<br/>
Added replaceable block that allows to define
the number of occupants.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/760\">#760</a>.
</li>
<li>
March 21, 2017, by Filip Jorissen:<br/>
Changed linearisation and conservation of energy implementations for JModelica compatibility.
See issue <a href=https://github.com/open-ideas/IDEAS/issues/559>#559</a>.
</li>
<li>
February 1, 2017 by Filip Jorissen:<br/>
Added option for disabling new view factor computation.
See issue
<a href=https://github.com/open-ideas/IDEAS/issues/663>#663</a>.
</li>
<li>
January 24, 2017 by Filip Jorissen:<br/>
Made <code>radDistr</code> replaceable
such that it can be redeclared in experimental models.
</li>
<li>
January 19, 2017 by Filip Jorissen:<br/>
Propagated linearisation parameters for interior radiative heat exchange.
</li>
<li>
August 26, 2016 by Filip Jorissen:<br/>
Added support for conservation of energy of air model.
</li>
<li>
April 30, 2016, by Filip Jorissen:<br/>
Added replaceable air model implementation.
</li>
<li>
March, 2015, by Filip Jorissen:<br/>
Added view factor implementation.
</li>
</ul>
</html>", info="<html>
<p>
Partial model that defines the main variables and connectors of a zone model.
</p>
</html>"));
end PartialZone;
