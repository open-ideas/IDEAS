within IDEAS.Examples.TwinHouses.BaseClasses.Data;
model ValidationDataO5Exp1_Airflow
  "Model that reads mass flow results from similar CONTAM simulation"

final parameter String filNam = "CONTAMTwinHouseO5.txt";
final parameter String dirPath = Modelica.Utilities.Files.loadResource("modelica://IDEAS/Resources/measurements/")    annotation(Evaluate=true);
Modelica.Blocks.Sources.CombiTimeTable CONTAMdata(
    tableOnFile=true,
    columns=2:45,
    smoothness=Modelica.Blocks.Types.Smoothness.MonotoneContinuousDerivative2,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    final fileName=dirPath + filNam,
    tableName="CONTAMdata",
    startTime(displayUnit="s") = 14946900)
    "input for validation data from CONTAM model of Holzkirchen"
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
    //When comparing to Modelica the sign might be inverse because of other conventions

  Modelica.Units.SI.MassFlowRate W1_FlowRate=CONTAMdata.y[1];
  Modelica.Units.SI.MassFlowRate W2_FlowRate=CONTAMdata.y[2];
  Modelica.Units.SI.MassFlowRate W3_FlowRate=CONTAMdata.y[3];
  Modelica.Units.SI.MassFlowRate W4_FlowRate=CONTAMdata.y[4];
  Modelica.Units.SI.MassFlowRate W5_FlowRate=CONTAMdata.y[5];
  Modelica.Units.SI.MassFlowRate W6_FlowRate=CONTAMdata.y[6];
  Modelica.Units.SI.MassFlowRate W7_FlowRate=CONTAMdata.y[7];
  Modelica.Units.SI.MassFlowRate W8_FlowRate=CONTAMdata.y[8];
  Modelica.Units.SI.MassFlowRate W9_FlowRate=CONTAMdata.y[9];
  Modelica.Units.SI.MassFlowRate W10_FlowRate=CONTAMdata.y[10];
  Modelica.Units.SI.MassFlowRate W11_FlowRate=CONTAMdata.y[11];
  Modelica.Units.SI.PressureDifference W1_dP=CONTAMdata.y[12];
  Modelica.Units.SI.PressureDifference W2_dP=CONTAMdata.y[13];
  Modelica.Units.SI.PressureDifference W3_dP=CONTAMdata.y[14];
  Modelica.Units.SI.MassFlowRate W27_FlowRate=CONTAMdata.y[15];
  Modelica.Units.SI.MassFlowRate W28_FlowRate=CONTAMdata.y[16];
  Modelica.Units.SI.MassFlowRate W29_FlowRate=CONTAMdata.y[17];
  Modelica.Units.SI.MassFlowRate W30_FlowRate=CONTAMdata.y[18];
  Modelica.Units.SI.MassFlowRate W31_FlowRate=CONTAMdata.y[19];
  Modelica.Units.SI.MassFlowRate W32_FlowRate=CONTAMdata.y[20];
  Modelica.Units.SI.MassFlowRate W33_FlowRate=CONTAMdata.y[21];
  Modelica.Units.SI.MassFlowRate W34_FlowRate=CONTAMdata.y[22];
  Modelica.Units.SI.MassFlowRate W35_FlowRate=CONTAMdata.y[23];
  Modelica.Units.SI.MassFlowRate W36_FlowRate=CONTAMdata.y[24];
  Modelica.Units.SI.MassFlowRate W37_FlowRate=CONTAMdata.y[25];
  Modelica.Units.SI.MassFlowRate W38_FlowRate=CONTAMdata.y[26];
  Modelica.Units.SI.MassFlowRate W39_FlowRate=CONTAMdata.y[27];
  Modelica.Units.SI.MassFlowRate W40_FlowRate=CONTAMdata.y[28];
  Modelica.Units.SI.MassFlowRate W41_FlowRate=CONTAMdata.y[29];
  Modelica.Units.SI.MassFlowRate W42_FlowRate=CONTAMdata.y[30];
  Modelica.Units.SI.MassFlowRate W43_FlowRate=CONTAMdata.y[31];
  Modelica.Units.SI.MassFlowRate W44_FlowRate=CONTAMdata.y[32];
  Modelica.Units.SI.MassFlowRate W45_FlowRate=CONTAMdata.y[33];
  Modelica.Units.SI.MassFlowRate W46_FlowRate=CONTAMdata.y[34];
  Modelica.Units.SI.MassFlowRate W47_FlowRate=CONTAMdata.y[35];
  Modelica.Units.SI.MassFlowRate W40_resDoor=CONTAMdata.y[36];
  Modelica.Units.SI.MassFlowRate W41_resDoor=CONTAMdata.y[37];
  Modelica.Units.SI.MassFlowRate W42_resDoor=CONTAMdata.y[38];
  Modelica.Units.SI.MassFlowRate Supply_FlowRate=CONTAMdata.y[42];
  Modelica.Units.SI.MassFlowRate Exhaust_Bath=CONTAMdata.y[43];
  Modelica.Units.SI.MassFlowRate Exhaust_bedr=CONTAMdata.y[44];






  annotation (experiment(
      StartTime=15000000,
      StopTime=31536000,
      Interval=900,
      __Dymola_Algorithm="Dassl"));
end ValidationDataO5Exp1_Airflow;
