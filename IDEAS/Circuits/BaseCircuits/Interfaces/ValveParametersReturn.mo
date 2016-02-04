within IDEAS.Circuits.BaseCircuits.Interfaces;
model ValveParametersReturn

  parameter Boolean useBalancingValve = false
    "Set to true to include a balancing valve"
    annotation(Dialog(group = "Settings"));

  parameter IDEAS.Fluid.Types.CvTypes CvDataReturn = IDEAS.Fluid.Types.CvTypes.Kv
    "Selection of flow coefficient"
   annotation(Dialog(group = "Flow Coefficient Return Valve",enable=useBalancingValve));
  parameter Real KvReturn(
    fixed= if CvDataReturn==IDEAS.Fluid.Types.CvTypes.Kv then true else false) if useBalancingValve
    "Kv (metric) flow coefficient [m3/h/(bar)^(1/2)]"
  annotation(Dialog(group = "Flow Coefficient Return Valve",
                    enable = (useBalancingValve and CvDataReturn==IDEAS.Fluid.Types.CvTypes.Kv)));

  parameter Real deltaMReturn = 0.02
    "Fraction of nominal flow rate where linearization starts, if y=1"
    annotation(Dialog(group="Pressure-flow linearization", enable=useBalancingValve));

end ValveParametersReturn;
