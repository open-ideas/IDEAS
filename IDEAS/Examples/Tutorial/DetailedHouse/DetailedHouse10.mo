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
    pumEmi(
      energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      allowFlowReversal=false,
      use_riseTime=false),
    recZon1(
      redeclare IDEAS.Buildings.Components.InterzonalAirFlow.n50FixedPressure interzonalAirFlow,
      redeclare HeavyWallNoWood conTypA,
      redeclare HeavyWallNoWood conTypB,
      redeclare HeavyWallNoWood conTypC,
      redeclare HeavyWallNoWood conTypD),
    recZon(
      redeclare IDEAS.Buildings.Components.InterzonalAirFlow.n50FixedPressure interzonalAirFlow,
      redeclare HeavyWallNoWood conTypA,
      redeclare HeavyWallNoWood conTypB,
      redeclare HeavyWallNoWood conTypC,
      redeclare HeavyWallNoWood conTypD),
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
record HeavyWallNoWood "BESTEST heavy wall with idealized wood layer"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    final mats={
      IDEAS.Buildings.Validation.Data.Materials.WoodSiding(d=0),
      IDEAS.Buildings.Validation.Data.Insulation.FoamInsulation(d=0.0615),
      IDEAS.Buildings.Validation.Data.Materials.ConcreteBlock(d=0.10)});

end HeavyWallNoWood;
  annotation (
  __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Examples/Tutorial/DetailedHouse/DetailedHouse10.mos"
        "Simulate and plot"),
    experiment(
      StartTime=10000000,
      StopTime=11000000,
      __Dymola_NumberOfIntervals=5000,
      Tolerance=1e-06,
      __Dymola_fixedstepsize=20,
      __Dymola_Algorithm="Euler"),
  __Dymola_experimentFlags(
      Advanced(
        EvaluateAlsoTop=true,
        GenerateVariableDependencies=false,
        OutputModelicaCode=false),
      Evaluate=true,
      OutputCPUtime=true,
      OutputFlatModelica=false),
    Documentation(info="<html>
<p>
The previous examples present a rather good computational performance. However, the computation time 
can significantly increase for larger simulation time due to frequent on/off switching 
of the heat pump. This effect causes a lot of fast transients that force the solver
to take small steps, which takes a lot of time.
</p>
<p>
Fortunately, many tricks can be used to speed up the solver. The fundamental principle is to
remove small time constants from the problem.  
The example in <a href=\"modelica://IDEAS.Examples.Tutorial.DetailedHouse.DetailedHouse10\">
IDEAS.Examples.Tutorial.DetailedHouse.DetailedHouse10</a> implements changes
that cause the simulation to become almost 3 times faster. By systematically removing fast time constants, the solver can be 
switched to a simpler method, such as Euler integration, with a fixed time step of 20 seconds.
<p> 
It is important to note the trade-off between computation time and simulation 
accuracy when choosing an integration method. While the Euler method is generally 
much faster than implicit solvers such as Dassl, it is also less accurate, 
especially for stiff or highly dynamic systems. Using smaller Euler time steps 
increases simulation accuracy but also increases computation time, whereas larger
time steps decrease computation time at the expense of accuracy. Therefore, careful
consideration is needed when selecting the solver and time step size, balancing 
the need for speed and the desired level of accuracy in the simulation results. 
</p> 
<p> 
These are modest improvements since this small example model behaves rather well. 
However, for large models, the difference in computation time when using Euler integration
can become a factor 1000. The modifications however require a bit of knowledge about solvers and the models
that you are using, including some of the more advanced parameters. To learn more about this, we refer to
[1, 2, 3].
</p>
<h4>References</h4>
<ol>
[1]  F. Jorissen, M. Wetter, and L. Helsen. <i>Simulation Speed Analysis and Improvements of Modelica Models for Building Energy Simulation</i>. In 11th International Modelica Conference, Paris, 2015. doi: 10.3384/ecp1511859
</ol>
<ol>
[2]  F. Jorissen, M. Wetter, and L. Helsen. <i>Simplifications for hydronic system models in Modelica</i>. Journal of Building Performance Simulation, 11:6, 639-654, 2018. doi: 10.1080/19401493.2017.1421263
</ol>
<ol>
[3]  F. Jorissen. <i>Toolchain for Optimal Control and Design of Energy Systems in Buildings</i>. PhD Thesis, KU Leuven, 2018.
</ol>
</html>", revisions="<html>
<ul>
<li>
April 14, 2025, by Anna Dell'Isola and Lone Meertens:<br/>
Update and restructure IDEAS tutorial models.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1374\">#1374</a> 
and <a href=\"https://github.com/open-ideas/IDEAS/issues/1389\">#1389</a>.
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
