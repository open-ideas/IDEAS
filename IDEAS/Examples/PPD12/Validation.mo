within IDEAS.Examples.PPD12;
model Validation
  extends Ventilation(the(THigh=273.15, TLow=273.15));
  Real TLivingCei[2]={sim.comTimTab.y[13], cei2.layMul.monLay[1].port_a.T};
  Real TLivingBackWall[2]={sim.comTimTab.y[14], cei2.layMul.monLay[1].port_a.T};
  Real TInAhu[2] = {sim.comTimTab.y[18],sim.comTimTab.y[19]};
  Real TWall1[2]= {sim.comTimTab.y[16],living.outC.layMul.monLay[1].monLayDyn.T[3]};
  Real TWall2[2]= {sim.comTimTab.y[29],living.outC.layMul.monLay[1].monLayDyn.T[2]};
  Real TWall3[2]= {sim.comTimTab.y[22],living.outC.layMul.monLay[1].monLayDyn.T[1]};
  Real TWall4[2]= {sim.comTimTab.y[25],living.outC.layMul.monLay[2].monLayDyn.T[1]};
  Real TRoom2[2]= {sim.comTimTab.y[17],living.outC.layMul.monLay[2].monLayDyn.T[1]};
  Real TRoom1[2]={sim.comTimTab.y[29], cei2.layMul.monLay[1].monLayDyn.T[1]};



  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow QRef(Q_flow=50)
    "Heat from refrigerator"
    annotation (Placement(transformation(extent={{80,-60},{60,-40}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow QElec(Q_flow=20)
    "Electronic equipment"
    annotation (Placement(transformation(extent={{4,108},{-16,128}})));
equation
  connect(QElec.port, living.gainCon)
    annotation (Line(points={{-16,118},{-46,118},{-46,49}}, color={191,0,0}));
  connect(QRef.port, Diner.gainCon) annotation (Line(points={{60,-50},{18,-50},{
          18,-25},{-26,-25}}, color={191,0,0}));
  annotation (experiment(
      StartTime=1528325717,
      StopTime=1531589845,
      __Dymola_NumberOfIntervals=5000,
      __Dymola_fixedstepsize=15,
      __Dymola_Algorithm="Euler"), Documentation(info="<html>
<p>Important note: this simulation uses epoch timestamps.</p>
<p>June 24th 2018 at 20:20 (1529864489s): sun edge 55cm below of top of large window top floor</p>
<p>1529864860: 25 cm</p>
</html>"));
end Validation;
