within IDEAS.Buildings.Linearisation;
package Interfaces
  extends Modelica.Icons.InterfacesPackage;
  model LinearisationInterface
    "Extend this interface if you want to linearise a model"
  protected
    inner input IDEAS.Buildings.Linearisation.Interfaces.WindowBus[sim.nWindow]
      winBusIn(each nLay=sim.nLayWin) if sim.linearise;
  public
    output IDEAS.Buildings.Linearisation.Interfaces.WindowBus[sim.nWindow]
      windowBusOut(each nLay=sim.nLayWin) if sim.createOutputs
      "Dummy for getting outputs";
  protected
    inner input IDEAS.Buildings.Components.Interfaces.WeaBus weaBus(
      final outputAngles= not sim.linearise,
      final numSolBus=sim.numAzi + 1) if sim.linearise;
  public
    inner output IDEAS.Buildings.Components.Interfaces.WeaBus weaBusOut(
     final outputAngles= not sim.linearise,
     final numSolBus=sim.numAzi + 1) if sim.createOutputs;

  public
    inner SimInfoManager sim(linearise=true, createOutputs=false)
      annotation (Placement(transformation(extent={{-100,78},{-80,98}})));

  equation
    connect(sim.weaBus, weaBusOut);
    connect(sim.winBusOut,windowBusOut);
  end LinearisationInterface;

  partial model StateSpaceModelInterface
    parameter Modelica.SIunits.Temperature T_start=293.15;
    inner SimInfoManager sim(
      nWindow=ssm.nWin,
      final linearise=false,
      final createOutputs=true,
      final nLayWin=max(ssm.winNLay))
      annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  protected
    output IDEAS.Buildings.Linearisation.Interfaces.WindowBus[sim.nWindow]
      windowBusOut(each nLay=sim.nLayWin) "Dummy for getting outputs" annotation (
       Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={18,62})));
  protected
    inner input IDEAS.Buildings.Linearisation.Interfaces.WindowBus[sim.nWindow]
      winBusIn(each nLay=sim.nLayWin) if sim.linearise;
  public
    Components.StateSpace ssm(x_start=ones(ssm.states)*T_start)
      annotation (Placement(transformation(extent={{56,44},{76,64}})));

  equation
    connect(sim.winBusOut,windowBusOut);
    connect(windowBusOut, ssm.winBus) annotation (Line(
        points={{18,62},{56,62}},
        color={255,204,51},
        thickness=0.5));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}})));
  end StateSpaceModelInterface;

  expandable connector WindowBus
    "Bus containing inputs/outputs for linear window model"
    extends Modelica.Icons.SignalBus;
    parameter Integer nLay = 3 "Number of window layers";

    Real[nLay] AbsQFlow(start=fill(100,nLay)) annotation ();
    Real iSolDir(start=100) annotation ();
    Real iSolDif(start=100) annotation ();

    annotation (Documentation(revisions="<html>
<ul>
<li>
March, 2015 by Filip Jorissen:<br/>
First implementation
</li>
</ul>
</html>"));
  end WindowBus;
end Interfaces;
