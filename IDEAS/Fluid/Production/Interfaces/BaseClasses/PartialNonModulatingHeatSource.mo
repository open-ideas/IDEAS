within IDEAS.Fluid.Production.Interfaces.BaseClasses;
partial model PartialNonModulatingHeatSource
  //Extensions
  extends PartialHeatSource(
    final QNomRef=data.QNomRef,
    final useTinPrimary=data.useTinPrimary,
    final useToutPrimary=data.useToutPrimary,
    final useTinSecondary=data.useTinSecondary,
    final useToutSecondary=data.useToutSecondary,
    final useMassFlowPrimary=data.useMassFlowPrimary);

  //Components
  Modelica.Blocks.Tables.CombiTable2D heat(table=data.heat)
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  Modelica.Blocks.Tables.CombiTable2D power(table=data.power) if calculatePower
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  replaceable PartialNonModulatingRecord data
    constrainedby
    IDEAS.Fluid.Production.Interfaces.BaseClasses.PartialNonModulatingRecord
    annotation (choicesAllMatching=true, Placement(transformation(extent={{70,-94},{90,-74}})));
end PartialNonModulatingHeatSource;
