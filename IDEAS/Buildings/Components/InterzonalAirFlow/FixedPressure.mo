within IDEAS.Buildings.Components.InterzonalAirFlow;
model FixedPressure "FixedPressure: idealised, fixed pressure boundary"
  extends
    IDEAS.Buildings.Components.InterzonalAirFlow.BaseClasses.PartialInterzonalAirFlowBoundary(
      prescribesPressure=true,
      verifyBothPortsConnected=true,
      nPorts=1+nPortsExt,
      bou(nPorts=1));
equation
  assert(sim.interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None,
    "FixedPressure should not be used in combination with sim.interZonalAirFlowType == IDEAS.BoundaryConditions.Types.InterZonalAirFlow.None. Use AirTight instead.");
  connect(bou.ports[1], ports[1]) annotation (Line(points={{-6.66134e-16,0},{2,0},{2,-100}},
                     color={0,127,255}));
  annotation (Documentation(revisions="<html>
<ul>
<li>
June 13, 2025, Jelger Jansen:<br/>
Remove <code>visible=not allowFlowReversal</code> in annotation of icon elements.
Improve placement of icon elements.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1437\">#1437</a>.
</li>
<li>
March 17, 2020, Filip Jorissen:<br/>
Added support for vector fluidport.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1029\">#1029</a>.
</li>
<li>
January 25, 2019, Filip Jorissen:<br/>
Added constant <code>prescribesPressure</code> that indicates
whether this model prescribes the zone air pressure or not.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/971\">#971</a>.
</li>
<li>
April 27, 2018 by Filip Jorissen:<br/>
First version.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/796\">#796</a>.
</li>
</ul>
</html>", info="<html>
<p>
This model represents an non-air tight zone. 
I.e. the zone air volume is internally fixed to a constant pressure
and the sum of the air injected through the two fluid ports
is consequently injected in the environment (as if all windows are opened).
If a net mass flow rate leaves the zone, then air is extracted
from the environment with the ambient temperature and humidity.
</p>
</html>"), Icon(graphics={
        Polygon(
          points={{-11,10},{20,0},{-11,-10},{-11,10}},
          lineColor={0,128,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          origin={-115.5,20},
          rotation=180),
        Polygon(
          points={{-11,10},{20,0},{-11,-10},{-11,10}},
          lineColor={0,128,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          origin={-54.5,20},
          rotation=360),
        Line(
          points={{-120,20},{-50,20}},
          color={0,128,255})}));
end FixedPressure;
