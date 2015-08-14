within IDEAS.Buildings.Linearisation;
package Interfaces
  extends Modelica.Icons.InterfacesPackage;
  model LinearisationInterface
    "Extend this interface if you want to linearise a model"
    import IDEAS;
  protected
    inner input IDEAS.Buildings.Linearisation.Interfaces.WindowBus[sim.nWindow]
      winBusIn(each nLay=sim.nLayWin) if sim.linearise;
  public
    inner IDEAS.Buildings.Linearisation.Interfaces.WindowBus[sim.nWindow]
      winBusOut(each nLay=sim.nLayWin) if sim.createOutputs;
  protected
    output IDEAS.Buildings.Linearisation.Interfaces.WindowBus[sim.nWindow]
      windowBusOut(each nLay=sim.nLayWin) if sim.createOutputs
      "Dummy for getting outputs";
  protected
    inner input IDEAS.Buildings.Components.Interfaces.WeaBus weaBus(
      final numSolBus=sim.numAzi + 1) if sim.linearise;
  public
    inner output IDEAS.Buildings.Components.Interfaces.WeaBus weaBusOut(
     final numSolBus=sim.numAzi + 1) if sim.createOutputs;

  public
    inner SimInfoManager sim(linearise=true, createOutputs=false)
      annotation (Placement(transformation(extent={{-100,78},{-80,98}})));

  equation
    connect(sim.weaBus, weaBusOut);
    connect(winBusOut,windowBusOut);
  end LinearisationInterface;

  expandable connector WindowBus "Linearized window bus"
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
