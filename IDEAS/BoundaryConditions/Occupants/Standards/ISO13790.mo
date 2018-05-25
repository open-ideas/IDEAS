within IDEAS.BoundaryConditions.Occupants.Standards;
model ISO13790 "Occupant model, based on ISO13790
  (if 1-zone model: internal gains are defined
  as the average between living area and others,
  if 2-zone model: internal gains of night zone are defined as
  the weighted average between weekdays and weekends)"
  extends IDEAS.Templates.Interfaces.BaseClasses.Occupant(nZones=1, nLoads=1);

  parameter Modelica.SIunits.Area[nZones] AFloor=ones(nZones)*100
    "Floor area of different zones";

protected
  final parameter Modelica.SIunits.Time interval=3600 "Time interval";
  final parameter Modelica.SIunits.Time period=86400/interval
    "Number of intervals per repetition";
  final parameter Real[3] QDay(unit="W/m2") = {4.5,10.5,4}
    "Specific power for dayzone";
  final parameter Real[3] TDay(unit="degC") = {16,21,18}
    "Temperature set-points for dayzone {day, evening, night}";
  final parameter Real[3] TNight(unit="degC") = {16,18,20}
    "Temperature set-points for nightzone {day, evening, night}";
  Integer t "Time interval";

algorithm
  when sample(0, interval) then
    t := if pre(t) + 1 <= period then pre(t) + 1 else 1;
  end when;

equation
  mDHW60C = 0;
  heatPortRad.Q_flow = heatPortCon.Q_flow;
  P = {heatPortCon[1].Q_flow + heatPortRad[1].Q_flow};
  Q = {0};

  if noEvent(t <= 7 or t >= 23) then
    heatPortCon.Q_flow = {-AFloor[1]*QDay[3]*0.5};
    TSet = {TDay[3] + 273.15};
  elseif noEvent(t > 7 and t <= 17) then
    heatPortCon.Q_flow = {-AFloor[1]*QDay[1]*0.5};
    TSet = {TDay[1] + 273.15};
  else
    heatPortCon.Q_flow = {-AFloor[1]*QDay[2]*0.5};
    TSet = {TDay[2] + 273.15};
  end if;

  annotation (Diagram(graphics));
end ISO13790;
