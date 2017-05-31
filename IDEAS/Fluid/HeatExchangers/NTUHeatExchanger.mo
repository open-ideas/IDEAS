within IDEAS.Fluid.HeatExchangers;
model NTUHeatExchanger "Heat exchanger with effectiveness calculated by NTU method, counter-flow"
  extends IDEAS.Fluid.HeatExchangers.BaseClasses.PartialEffectiveness(
    sensibleOnly1 = true,
    sensibleOnly2 = true,
    final prescribedHeatFlowRate1=true,
    final prescribedHeatFlowRate2=true,
    Q1_flow = eps * QMax_flow,
    Q2_flow = -Q1_flow,
    mWat1_flow = 0,
    mWat2_flow = 0);

  parameter Modelica.SIunits.CoefficientOfHeatTransfer U
    "heat transfer coefficient";
  parameter Modelica.SIunits.Area A
    "area of heat transfer";
  Modelica.SIunits.Efficiency eps(max=1)
    "Heat exchanger effectiveness";
  Real NTU
    "Number of Transfer Units";

equation
  if (1-Cr*exp(-NTU*(1-Cr))) == 0 then
    eps = 1;
  else
    eps = (1-exp(-NTU*(1-Cr)))/(1-Cr*exp(-NTU*(1-Cr)));
  end if;

  if CMax_flow == 0 then
    NTU = 0;
  else
    NTU = U*A/CMin_flow;
  end if;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={Rectangle(
          extent={{-70,78},{70,-82}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid), Text(
          extent={{-56,-12},{54,-72}},
          lineColor={255,255,255},
          textString="NTU")}),
          preferredView="info",
defaultComponentName="hex",
Documentation(info="<html>
<p>Model for a heat exchanger based on the Number of Transfer Units (NTU) Method. Only applicable to counter-flow heat-exchangers</p>
<p>This model transfers heat in the amount of </p>
<p align=\"center\"><i>Q = Q<sub>max</sub> &epsilon;, </i></p>
<p>where <i>Q<sub>max</i></sub> is the maximum heat that can be transferred and &epsilon; is the effectiveness calculated by the NTU method (see below)</p>
<p align=\"center\"> <img src=\"modelica://IDEAS/Resources/Images/equations/equation-ZA2CQUtf.png\" alt=\"eps = (1-exp(-NTU*(1-Cr)))/(1-Cr*exp(-NTU*(1-Cr)))\"/></p>
<p>Where Cr is the ratio between the lower and the higher heat capacity and NTU is defined as:</p>
<p align=\"center\"><img src=\"modelica://IDEAS/Resources/Images/equations/equation-cvhqkKJg.png\" alt=\"NTU = U*A/Cmin\"/></p>
</html>",
revisions="<html>
<ul>
<li>May 29, 2017, by Iago Cupeiro:<br>First implementation. </li>
</ul>
</html>"));
end NTUHeatExchanger;