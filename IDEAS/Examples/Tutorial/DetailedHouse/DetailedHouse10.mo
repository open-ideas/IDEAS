within IDEAS.Examples.Tutorial.DetailedHouse;
model DetailedHouse10 "Speeding up the code"
  extends DetailedHouse9(
    pumSec(
      energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      allowFlowReversal=false,
      use_riseTime=false),
    pumPri(
      energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      allowFlowReversal=false,
      use_riseTime=false),
    recZon1(
      redeclare Buildings.Components.InterzonalAirFlow.n50FixedPressure interzonalAirFlow,
      redeclare HeavyWall conTypA,
      redeclare HeavyWall conTypB,
      redeclare HeavyWall conTypC,
      redeclare HeavyWall conTypD),
    recZon(
      redeclare Buildings.Components.InterzonalAirFlow.n50FixedPressure interzonalAirFlow,
      redeclare HeavyWall conTypA,
      redeclare HeavyWall conTypB,
      redeclare HeavyWall conTypC,
      redeclare HeavyWall conTypD),
    fanRet(
      allowFlowReversal=false,
      energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      use_riseTime=false),
    fanSup(
      allowFlowReversal=false,
      energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      use_riseTime=false),
    val(allowFlowReversal=false, from_dp=true),
    val1(allowFlowReversal=false, from_dp=true),
    rad(allowFlowReversal=false, nEle=2),
    rad1(allowFlowReversal=false, nEle=2),
    heaPum(
      allowFlowReversal1=false,
      allowFlowReversal2=false,
      from_dp1=true,
      from_dp2=true),
    senTemSup(tau=0),
    tan(allowFlowReversal=false, tau=60),
    vavSup(allowFlowReversal=false, use_strokeTime=false),
    vavRet(allowFlowReversal=false, use_strokeTime=false),
    vavSup1(allowFlowReversal=false, use_strokeTime=false),
    vavRet1(allowFlowReversal=false, use_strokeTime=false),
    hex(allowFlowReversal1=false, allowFlowReversal2=false));
protected
record HeavyWall "BESTEST heavy wall with idealized wood layer"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    final mats={
      IDEAS.Buildings.Validation.Data.Materials.WoodSiding(d=0),
      IDEAS.Buildings.Validation.Data.Insulation.FoamInsulation(d=0.0615),
      IDEAS.Buildings.Validation.Data.Materials.ConcreteBlock(d=0.10)});

end HeavyWall;
  annotation (
 __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Examples/Tutorial/DetailedHouse/DetailedHouse10.mos"
        "Simulate and plot"),
 experiment(
      StartTime=10000000,
      StopTime=11000000,
      __Dymola_NumberOfIntervals=5000,
      __Dymola_fixedstepsize=20,
      __Dymola_Algorithm="Euler"), __Dymola_experimentFlags(
      Advanced(
        EvaluateAlsoTop=true,
        GenerateVariableDependencies=false,
        OutputModelicaCode=false),
      Evaluate=true,
      OutputCPUtime=true,
      OutputFlatModelica=false),
    Documentation(info="<html>
<p>
The created models tend to exhibit slow performance, with computation time significantly increasing due to 
controller oscillations or frequent on/off switching of the heat pump. These effects cause a lot of fast
transients that force the solver to take small steps, which takes a lot of time.
<p>
Fortunately, there are many tricks that can be used to speed up the solver. The fundamental principle is to
remove small time constants from the problem.  
The example in <a href=\"modelica://IDEAS.Examples.Tutorial.DetailedHouse.DetailedHouse10\">
IDEAS.Examples.Tutorial.DetailedHouse.DetailedHouse10</a> implements changes
that cause the simulation to become 2 times faster. By systematically removing fast time constants, the solver can be 
switched to a simpler method, such as Euler integration, the simulation time also becomes 2 times smaller
when using a fixed time step of 20 seconds.  These are modest improvements since this small example model
behaves rather well. However, for large models, the difference in computation time when using Euler integration
can become a factor 1000. The modifications however require a bit of knowledge about solvers and the models
that you are using, including some of the more advanced parameters. To learn more about this, we refer to
[1, 2, 3].
</p>
<h4>References</h4>
<p>
[1]  F. Jorissen, M. Wetter, and L. Helsen. <i>Simulation Speed Analysis and Improvements of Modelica Models for Building Energy Simulation</i>. In 11th International Modelica Conference, Paris, 2015. doi: 10.3384/ecp1511859
</p>
<p>
[2]  F. Jorissen, M. Wetter, and L. Helsen. <i>Simplifications for hydronic system models in Modelica</i>. Journal of Building Performance Simulation, 11:6, 639-654, 2018. doi: 10.1080/19401493.2017.1421263
</p>
<p>
[3]  F. Jorissen. <i>Toolchain for Optimal Control and Design of Energy Systems in Buildings</i>. PhD Thesis, KU Leuven, 2018.
</p>
</html>", revisions="<html>
<ul>
<li>
January 14, 2025, by Lone Meertens:<br/>
Updates detailed in <a href=\"https://github.com/open-ideas/IDEAS/issues/1404\">
#1404</a>
</li>
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
</html>"));
end DetailedHouse10;
