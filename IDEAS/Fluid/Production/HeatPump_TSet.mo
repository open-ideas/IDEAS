within IDEAS.Fluid.Production;
model HeatPump_TSet
  extends IDEAS.Fluid.Production.BaseClasses.HeatPumpModulating;

  parameter Real k=5 "Gain of PI controller";
  parameter SI.Time Ti=120 "Time constant of PI control integrator";

  IDEAS.Controls.Continuous.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=k,
    Ti=Ti,
    yMax=1,
    yMin=0) annotation (Placement(transformation(extent={{40,20},{60,40}})));

  Modelica.Blocks.Interfaces.RealInput TSet "Temperature set point" annotation (
     Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,108})));
equation
  modInt=PID.y;

  connect(TSet, PID.u_s) annotation (Line(points={{0,108},{0,82},{26,82},{26,30},
          {38,30}}, color={0,0,127}));
  connect(PID.u_m, senTemEvaOut.T) annotation (Line(points={{50,18},{50,16},{-32,
          16},{-32,40}}, color={0,0,127}));
end HeatPump_TSet;
