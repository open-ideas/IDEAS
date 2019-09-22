within IDEAS.Buildings.Components.Validations;
model WindowUValidation "Verifies U value of a glazing record"
  extends Modelica.Icons.Example;

  Modelica.SIunits.CoefficientOfHeatTransfer U = window.layMul.port_a.Q_flow/(TZone-TOut)/window.A;

  Window window(
    redeclare Data.Glazing.EpcDouble glazing,
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S,
    A=1,
    nWin=1,
    frac=0,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    gainDif(k=0),
    gainDir(k=0),
    linIntCon_a=false,
    linExtCon=false,
    linExtRad=false)
    annotation (Placement(transformation(extent={{-16,-20},{-4,0}})));
  inner SimInfoManagerFixedBC sim(TDryBulFixed=TOut)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));

  model SimInfoManagerFixedBC
    extends IDEAS.BoundaryConditions.SimInfoManager(weaDat(
        TDryBulSou=IDEAS.BoundaryConditions.Types.DataSource.Parameter,
        TDryBul=TDryBulFixed,
        TBlaSkySou=IDEAS.BoundaryConditions.Types.DataSource.Parameter,
        TBlaSky=TDryBulFixed));


    parameter SI.Temperature TDryBulFixed=293.15
      "Dry bulb temperature (used if TDryBul=Parameter)";
  end SimInfoManagerFixedBC;


  Interfaces.DummyConnection                            dummyConnection(
    iSolDir=100,
    iSolDif=10,
    A=15,
    isZone=true,
    T=TZone)
    annotation (Placement(transformation(extent={{60,-20},{40,0}})));
  parameter SI.Temperature TZone=273.15 + 22
    "Fixed temperature for surfRad, or zone when isZone";
  parameter SI.Temperature TOut=263.15
    "Dry bulb temperature (used if TDryBul=Parameter)";
equation


  connect(window.propsBus_a, dummyConnection.zoneBus) annotation (Line(
      points={{-5,-8},{16,-8},{16,-10.2},{40,-10.2}},
      color={255,204,51},
      thickness=0.5));
  annotation (experiment(StopTime=100000));
end WindowUValidation;
