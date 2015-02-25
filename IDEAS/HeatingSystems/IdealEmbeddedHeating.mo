within IDEAS.HeatingSystems;
model IdealEmbeddedHeating
  "Ideal heating, no DHW, with embedded system (eg. floor heating) "
  extends IDEAS.HeatingSystems.Interfaces.Partial_IdealHeating;
  extends IDEAS.Interfaces.BaseClasses.HeatingSystem(
    final isHea = true,
    final isCoo = false,
    nConvPorts = nZones,
    nRadPorts = nZones,
    nTemSen = nZones,
    nEmbPorts=nZones,
    nLoads=1);
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow prescribedHeatFlow1[
    nRadPorts](Q_flow=0)
    annotation (Placement(transformation(extent={{-142,-30},{-162,-10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow prescribedHeatFlow[
    nConvPorts](Q_flow=0)
    annotation (Placement(transformation(extent={{-144,10},{-164,30}})));
equation
  for i in 1:nZones loop
    if noEvent((TSet[i] - TSensor[i]) > 0) then
      QHeatZone[i] = IDEAS.Utilities.Math.Functions.smoothMin(x1=C[i]*(TSet[i] - TSensor[i])/t, x2=QNom[i],deltaX=1);
    else
      QHeatZone[i] = 0;
    end if;
    heatPortEmb[i].Q_flow = -QHeatZone[i];
  end for;
  QHeaSys = sum(QHeatZone);
  P[1] = QHeaSys/COP;
  Q[1] = 0;
  connect(prescribedHeatFlow1.port, heatPortRad) annotation (Line(
      points={{-162,-20},{-200,-20}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(prescribedHeatFlow.port, heatPortCon) annotation (Line(
      points={{-164,20},{-200,20}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Documentation(revisions="<html>
<p><ul>
<li>2013 June, Roel De Coninck: reworking interface and documentation</li>
<li>2011, Roel De Coninck: first version</li>
</ul></p>
</html>", info="<html>
<p><b>Description</b> </p>
<p>Ideal heating (no hydraulics) based on embedded heat emission, but with limited power <i>QNom</i> per zone. This model assumes a thermal inertia of each zone and computes the heat flux that would be required to heat up the zone to the set point within a time <i>t</i>. This heat flux is limited to <i>QNom</i> and imposed on the heatPort <i>heatPortEmb</i>. A COP can be passed in order to compute the electricity consumption of the heating.</p>
<p><u>Note</u>: the responsiveness of the system is influenced by the time constant <i>t </i>and of course by the inertia of the embedded system in which the heat is injected. </p>
<p><h4>Assumptions and limitations </h4></p>
<p><ol>
<li>No inertia in this model (but inertia supposed in the embedded system to which this model will be linked); responsiveness modelled by time constant <i>t</i> for reaching the temperature set point. </li>
<li>Limited output power according to <i>QNom[nZones]</i></li>
<li>Heat emitted through <i>heatPortEmb</i> </li>
</ol></p>
<p><h4>Model use</h4></p>
<p><ol>
<li>Connect the heating system to the corresponding heatPorts of a <a href=\"modelica://IDEAS.Interfaces.BaseClasses.Structure\">structure</a>. </li>
<li>Connect <i>TSet</i> and <i>TSensor</i> </li>
<li>Connect <i>plugLoad </i>to an inhome grid. A<a href=\"modelica://IDEAS.Interfaces.BaseClasses.CausalInhomeFeeder\"> dummy inhome grid like this</a> has to be used if no inhome grid is to be modelled. </li>
<li>Set all parameters that are required. </li>
</ol></p>
<p><h4>Validation </h4></p>
<p>No validation performed.</p>
<p><h4>Example </h4></p>
<p>An example of the use of this model can be found in<a href=\"modelica://IDEAS.Thermal.HeatingSystems.Examples.IdealEmbeddedHeating\"> IDEAS.Thermal.HeatingSystems.Examples.IdealEmbeddedHeating</a>.</p>
</html>"), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},
            {200,100}}),       graphics),
    Icon(coordinateSystem(extent={{-200,-100},{200,100}})));
end IdealEmbeddedHeating;
