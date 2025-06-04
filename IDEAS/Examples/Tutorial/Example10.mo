within IDEAS.Examples.Tutorial;
model Example10 "Speeding up the code"
  extends Example9(
    fanRet(
      energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState, use_riseTime=
          false),
    fanSup(
      energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState, use_riseTime=
          false),
    val(allowFlowReversal=false, from_dp=true),
    val1(allowFlowReversal=false, from_dp=true),
    pumpSec(
      energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      allowFlowReversal=false,
      use_riseTime=false),
    pumpPrim(
      energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      allowFlowReversal=false,
      use_riseTime=false),
    rectangularZoneTemplate1(
      redeclare Buildings.Components.InterzonalAirFlow.n50FixedPressure interzonalAirFlow,
      redeclare HeavyWall conTypA,
      redeclare HeavyWall conTypB,
      redeclare HeavyWall conTypC,
      redeclare HeavyWall conTypD,
      redeclare HeavyWall conTypFlo),
    rectangularZoneTemplate(
      redeclare Buildings.Components.InterzonalAirFlow.n50FixedPressure interzonalAirFlow,
      redeclare HeavyWall conTypA,
      redeclare HeavyWall conTypB,
      redeclare HeavyWall conTypC,
      redeclare HeavyWall conTypD,
      redeclare HeavyWall conTypFlo),
    rad(nEle=2),
    rad1(nEle=2),
    heaPum(from_dp1=true, from_dp2=true),
    senTemSup(tau=0),
    tan(tau=60),
    vavSup(use_strokeTime=false),
    vavRet(use_strokeTime=false),
    vavSup1(use_strokeTime=false),
    vavRet1(use_strokeTime=false));
protected
record HeavyWall "BESTEST heavy wall with idealized wood layer"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    final mats={
      IDEAS.Buildings.Validation.Data.Materials.WoodSiding(d=0),
      IDEAS.Buildings.Validation.Data.Insulation.FoamInsulation(d=0.0615),
      IDEAS.Buildings.Validation.Data.Materials.ConcreteBlock(d=0.10)});

end HeavyWall;
  annotation (experiment(
      StartTime=10000000,
      StopTime=11000000,
      __Dymola_NumberOfIntervals=5000,
      Tolerance=0.00011,
      __Dymola_fixedstepsize=20,
      __Dymola_Algorithm="Euler"), __Dymola_experimentFlags(
      Advanced(
        EvaluateAlsoTop=true,
        GenerateVariableDependencies=false,
        OutputModelicaCode=false),
      Evaluate=true,
      OutputCPUtime=true,
      OutputFlatModelica=false),
    Documentation(revisions="<html>
<ul>
<li>
October 30, 2024, by Lucas Verleyen:<br/>
Updates according to <a href=\"https://github.com/ibpsa/modelica-ibpsa/tree/8ed71caee72b911a1d9b5a76e6cb7ed809875e1e\">IBPSA</a>.<br/>
See <a href=\"https://github.com/open-ideas/IDEAS/pull/1383\">#1383</a> 
(and <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1926\">IBPSA, #1926</a>).
</li>
<li>
September 18, 2019 by Filip Jorissen:<br/>
First implementation for the IDEAS crash course.
</li>
</ul>
</html>", info="<html>
<p>
Tuning model and solver for computation time
</p>
</html>"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Examples/Tutorial/Example10.mos"
        "Simulate and plot"));
end Example10;
