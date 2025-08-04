within IDEAS.Fluid.Sources;
model OutsideAir
  "Outside boundary that takes temperature, pressure, humidity and CO2 from the SimInfoManager"
  extends IDEAS.Fluid.Sources.BaseClasses.PartialSource(final verifyInputs=true);

  outer IDEAS.BoundaryConditions.SimInfoManager sim "SimInfoManager";
  parameter Boolean use_TDryBul_in = false "= true, to overwrite the dry bulb temperature";
  parameter Real table[:,:]=[0,0.4; 45,0.1; 90,-0.3; 135,-0.35; 180,-0.2; 225,-0.35; 270,-0.3; 315,0.1; 360,0.4] "Cp at different angles of attack";
  parameter Modelica.Units.SI.Angle azi "Surface azimuth (South:0, West:pi/2)"
    annotation (choicesAllMatching=true);

  parameter Real Cs = (A0*A0)*((Habs/sim.Hwind)^(2*a)) "Wind speed modifier" annotation(Dialog(group="Wind"));
  parameter Modelica.Units.SI.Length Habs=10
    "Absolute height of boundary for correcting the wind speed"
    annotation (Dialog(group="Wind"));
  parameter Real A0=sim.A0 "Local terrain coefficient." 
    annotation(Dialog(tab="Overwrite",group="Effect of surroundings on wind"));
  parameter Real a=sim.a "Velocity profile exponent."
    annotation(Dialog(tab="Overwrite",group="Effect of surroundings on wind"));
  Modelica.Units.SI.Density rho = IDEAS.Utilities.Psychrometrics.Functions.density_pTX(
        p=Medium.p_default,
        T= sim.Te,
        X_w=sim.XiEnv.X[1]);
  
  Modelica.Units.SI.Angle alpha "Wind incidence angle (0: normal to wall)";
  Real CpAct(final unit="1") = windPressureProfile(u=alpha, table=table[:, :]) "Actual wind pressure coefficient";


  Modelica.Units.SI.Pressure pWin(displayUnit="Pa")
    "Change in pressure due to wind force";

  Modelica.Blocks.Interfaces.RealOutput pTot(min=0, nominal=1E5, final unit="Pa")
    "Sum of atmospheric pressure and wind pressure";

  Modelica.Blocks.Interfaces.RealInput TDryBul_in if use_TDryBul_in 
    "Optional override input for the dry bulb temperature" annotation(
    Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput m_flow = sum(ports.m_flow) "Total mass flow rate" annotation(
    Placement(visible = true, transformation(origin = {-110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 180), iconTransformation(origin = {-110, -60}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
protected
  constant Integer s[:]= {
    if ( Modelica.Utilities.Strings.isEqual(string1=Medium.extraPropertiesNames[i],
                                            string2="CO2",
                                            caseSensitive=false))
    then 1 else 0 for i in 1:Medium.nC}
    "Vector with zero everywhere except where species is";

  Modelica.Blocks.Interfaces.RealInput T_in_internal(final unit="K",
                                                     displayUnit="degC")
    "Needed to connect to conditional connector";
  Modelica.Blocks.Interfaces.RealInput h_internal = Medium.specificEnthalpy(
    Medium.setState_pTX(p_in_internal, T_in_internal, X_in_internal));

  IDEAS.BoundaryConditions.WeatherData.Bus bus;

  Modelica.Blocks.Interfaces.RealInput X_wEnv
    "Connector for X_wEnv";
  Modelica.Blocks.Routing.RealPassThrough p_link;

function windPressureProfile
  "Function for the cubic spline interpolation of table input of a windpressureprofile"

    input Modelica.Units.SI.Angle u
      "independent variable, wind incidence angle";
  input Real table[:,:];

  output Real z "Dependent variable without monotone interpolation, CpAct";

  //extend table with 1 point at the beginning and end for correct derivative at 0 and 360

  protected
  Real Radtable[:,:] = [Modelica.Constants.D2R*table[:,1],table[:,2]];

  Real prevPoint[1,2] = [Radtable[size(table, 1)-1, 1] - (2*Modelica.Constants.pi), Radtable[size(table, 1)-1, 2]];
  Real nextPoint[1,2] = [Radtable[2, 1] + (2*Modelica.Constants.pi), Radtable[2, 2]];
  Real exTable[:,:] = [prevPoint;Radtable;nextPoint]; //Extended table

  Real[:] xd=exTable[:,1] "Support points x-value";
  Real[size(xd, 1)] yd=exTable[:,2] "Support points y-value";
  Real[size(xd, 1)] d=IDEAS.Utilities.Math.Functions.splineDerivatives(
    x=xd,
    y=yd,
    ensureMonotonicity=false); // Get the derivative values at the support points

  Integer i "Integer to select data interval";
  Real aR "u, restricted to 0...2*pi";


algorithm

  // Change sign to positive
  aR := if u < 0 then -u else u;

  // Constrain to [0...2*pi]
  if aR > 2*Modelica.Constants.pi then
  aR := aR - integer(aR/(2*Modelica.Constants.pi))*(2*Modelica.Constants.pi);
  end if;

  i := 1;
  for j in 1:size(xd, 1) - 1 loop
    if aR > xd[j] then
      i := j;
    end if;
  end for;

  // Interpolate the data

  z :=IDEAS.Utilities.Math.Functions.cubicHermiteLinearExtrapolation(
        x=aR,
        x1=xd[i],
        x2=xd[i + 1],
        y1=yd[i],
        y2=yd[i + 1],
        y1d=d[i],
        y2d=d[i + 1]);
   annotation(Inline=false);
end windPressureProfile;
  Modelica.Units.SI.Angle surOut=azi - Modelica.Constants.pi
    "Angle of surface that is used to compute angle of attack of wind";
  Modelica.Blocks.Interfaces.RealInput vWin(final unit="m/s") = sim.Va   "Wind speed from weather bus";
  Modelica.Blocks.Interfaces.RealInput winDir( final unit="rad",displayUnit="deg") = sim.Vdir "Wind direction from weather bus";
  Modelica.Blocks.Math.Add adder;
  Modelica.Blocks.Sources.RealExpression dpStack(y=-(Habs-sim.HPres)*Modelica.Constants.g_n*rho);
equation

  alpha = winDir-surOut;


  pWin = Cs*0.5*CpAct*rho*vWin*vWin;
  pTot = p_in_internal + (if sim.interZonalAirFlowType <> IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None then pWin else 0);

  connect(bus,sim.weaDatBus);

  connect(p_link.u, bus.pAtm);
  connect(p_link.y,adder.u1);
  connect(adder.u2, dpStack.y);
  connect(p_in_internal, adder.y);

  // must use sim.weaBus.Te for linearisation
  if (use_TDryBul_in) then
    connect(TDryBul_in, T_in_internal);
  else
   T_in_internal = sim.weaBus.Te;
  end if;

  C_in_internal = {if i==1 then sim.CEnv.y  else 0 for i in s};

  // Check medium properties
  if Medium.nX>1 then
    Modelica.Fluid.Utilities.checkBoundary(Medium.mediumName, Medium.substanceNames,
      Medium.singleState, true, X_in_internal, "Boundary_pT");
  end if;
  if Medium.nX == 1 then
    X_in_internal = ones(Medium.nX);
  else
    X_in_internal = {X_wEnv, 1-X_wEnv};
  end if;

  connect(X_wEnv, bus.X_wEnv);
  connect(X_in_internal[1:Medium.nXi], Xi_in_internal);

  ports.C_outflow = fill(C_in_internal, nPorts);

  if not verifyInputs then
    h_internal    = Medium.h_default;
    p_in_internal = Medium.p_default;
    X_in_internal = Medium.X_default;
    T_in_internal = Medium.T_default;
  end if;

  // Assign medium properties
  connect(medium.h, h_internal);
  connect(medium.Xi, Xi_in_internal);

  for i in 1:nPorts loop
    ports[i].p          = pTot;
    ports[i].h_outflow  = h_internal;
    ports[i].Xi_outflow = Xi_in_internal;
  end for;

  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(
          extent={{-98,100},{102,-100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={0,127,255}),
        Text(
          extent={{-150,110},{150,150}},
          textString="%name",
          lineColor={0,0,255}),
        Text(
          extent={{-60,-66},{78,72}},
          lineColor={238,46,47},
          textString="Sim.")}),
    Documentation(info="<html>
<p>
This model describes boundary conditions for
pressure, enthalpy, and CO2 that can be obtained
from weather data.
These data are obtained from the SimInfoManager,
which should be included in the model.
</p>
<p>
Note that boundary temperature,
mass fractions and trace substances have only an effect if the mass flow
is from the boundary into the port. If mass is flowing from
the port into the boundary, the boundary definitions,
with exception of boundary pressure, do not have an effect.
</p>
</html>",
revisions="<html>
<ul>
<li>
July 9, 2025, by Jelger Jansen:<br/>
Update documentation of A0 and a.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1340\">#1340</a>.
</li>
<li>
October 30, 2024, by Klaas De Jonge:<br/>
Modifications for wind pressure,ambient pressure and wind speed modifiers used in interzonal airflow.
</li>
<li>
November 13, 2023 by Filip Jorissen:<br/>
Computing stack height.
</li>
<li>
July 21, 2022 by Filip Jorissen:<br/>
Added optional dry bulb temperature input for #1270.
</li>
<li>
September 21, 2019 by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
end OutsideAir;
