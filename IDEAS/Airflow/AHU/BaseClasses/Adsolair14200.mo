within IDEAS.Airflow.AHU.BaseClasses;
record Adsolair14200
  "Adsolair type 58 parameters for a unit with a nominal volumetric flow rate of 14200 m3/h"
  extends IDEAS.Airflow.AHU.BaseClasses.AdsolairData(
    pressure(V_flow={5423,7537,9958,12256,14857,17121,19042,20649}/3600, dp={
          1385,1350,1290,1195,1021,838,653,470}),
    efficiency(V_flow={5341,6743,9230,11651,14412,17383,20235}/3600,
        eta={0.45,0.51,0.6,0.72,0.7,0.72,0.6}),
    motorEfficiency(V_flow={5341,20235}/3600, eta={0.887,0.887}),
    powerOrEfficiencyIsHydraulic = true,
    etaHydMet=IDEAS.Fluid.Movers.BaseClasses.Types.HydraulicEfficiencyMethod.Efficiency_VolumeFlowRate,
    etaMotMet=IDEAS.Fluid.Movers.BaseClasses.Types.MotorEfficiencyMethod.Efficiency_VolumeFlowRate,
    m1_flow_nominal=4.69,
    m2_flow_nominal=4.69,
    dT_compressor=37.1 - 10.8,
    G_condensor=46700/(37.1 - 35.2),
    G_evaporator=40400/(16.7 - 10.8),
    fraPmin=0.1,
    N_top=1726,
    N_bottom=1774,
    Kv_3wayValveHeater=6.3,
    m_flow_3way_nominal=1660/3600,
    epsHeating=0.53,
    m1_flow_nominal_heater=13775/3600*(101300/287/(273.15 + 15.6)),
    m2_flow_nominal_heater=2150/3600,
    dp1_nominal_heater=33,
    dp2_nominal_heater=4200,
    epsCooling=0.497,
    m1_flow_nominal_cooler=13507/3600*(101300/287/(273.15 + 8)),
    m2_flow_nominal_cooler=3520/3600,
    dp1_nominal_cooler=55,
    dp2_nominal_cooler=4700,
    dp_nominal_top=dp_filter_dumped,
    dp_nominal_bottom=dp_filter_fresh + dp_filter_pulsion + dp1_nominal_heater
         + dp1_nominal_cooler,
    dp_nominal_top_recup=(211 + dp_condenser),
    dp_nominal_bottom_recup=197 + dp_evaporator,
    dp_adiabatic=60,
    eps_adia_on=0.9,
    eps_adia_off=0.79,
    A_dam_byp_top=w_unit*w_blade*2,
    A_dam_rec_top=w_unit*w_blade*8,
    A_dam_byp_bot=w_unit*w_blade*4,
    A_dam_rec_bot=w_unit*w_blade*7,
    A_byp_top_min=A_dam_byp_top,
    A_byp_bot_min=0.15*w_unit,
    UA_adia_on=14000,
    UA_adia_off=23000);
  constant Modelica.Units.SI.Pressure dp_filter_fresh=33;
  constant Modelica.Units.SI.Pressure dp_filter_pulsion=70;
  constant Modelica.Units.SI.Pressure dp_filter_dumped=46;
  constant Modelica.Units.SI.Pressure dp_evaporator=63;
  constant Modelica.Units.SI.Pressure dp_condenser=76;
  constant Modelica.Units.SI.Length w_unit=1.7 "Unit width";
  constant Modelica.Units.SI.Length w_blade=1.2/10 "Width single damper blade";
  annotation (Documentation(revisions="<html>
<ul>
<li>
October 30, 2024, by Lucas Verleyen and Jelger Jansen:<br/>
Updates according to <a href=\"https://github.com/ibpsa/modelica-ibpsa/tree/8ed71caee72b911a1d9b5a76e6cb7ed809875e1e\">IBPSA</a>.<br/>
See <a href=\"https://github.com/open-ideas/IDEAS/pull/1383\">#1383</a> 
(and <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1704\">IBPSA, #1704</a>,
<a href=\"https://github.com/lbl-srg/modelica-buildings/pull/3845\">Buildings, #3845</a>, and
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2668\">Buildings, #2668</a>).
</li>
<li>
October 11, 2016, by Filip Jorissen:<br/>
Added first implementation.
</li>
</ul>
</html>"));
end Adsolair14200;
