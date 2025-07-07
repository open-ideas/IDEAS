within IDEAS.Fluid.PVTCollectors.Validation.PVT2.BaseClasses;
model MySimInfoManager
  "Simulation information manager for handling time and climate data required in each for simulation."
  extends IDEAS.Fluid.PVTCollectors.Validation.PVT2.BaseClasses.MyPartialSimInfoManager
                                                         (
    Te=TDryBul.y,
    TeAv=Te,
    Tground=TdesGround,
    relHum=phiEnv.y,
    TDewPoi=TDewPoiData.y,
    Tsky=TBlaSkyData.y,
    Va=winSpeData.y,
    Vdir=winDirData.y);

  inner Modelica.Blocks.Sources.CombiTimeTable meaDat(
    tableOnFile=true,
    tableName="data",
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://IDEAS/Resources/Data/Fluid/PvtCollectors/Validation/PVT2/PVT2_measurements.txt"),
    columns=1:26) annotation (Placement(transformation(extent={{-90,-96},{-70,
            -76}})));
protected
  Modelica.Blocks.Routing.RealPassThrough HDirNorData;
  Modelica.Blocks.Routing.RealPassThrough HGloHorData;
  Modelica.Blocks.Routing.RealPassThrough HDiffHorData;
  Modelica.Blocks.Routing.RealPassThrough TDryBulData;
  Modelica.Blocks.Routing.RealPassThrough relHumData;
  Modelica.Blocks.Routing.RealPassThrough TDewPoiData;
  Modelica.Blocks.Routing.RealPassThrough nOpaData;
  Modelica.Blocks.Routing.RealPassThrough winSpeData;
  Modelica.Blocks.Routing.RealPassThrough winDirData;
  Modelica.Blocks.Routing.RealPassThrough TBlaSkyData;
  Modelica.Blocks.Sources.RealExpression HDirNor_mea(y=meaDat.y[20])
    annotation (Placement(transformation(extent={{-142,-66},{-122,-46}})));
  Modelica.Blocks.Sources.RealExpression H_GloHor_mea(y=meaDat.y[22])
    annotation (Placement(transformation(extent={{-142,-80},{-122,-60}})));
equation

  connect(HDirNorData.u, weaDatBus.HDirNor);
  connect(HGloHorData.u, weaDatBus.HGloHor);
  connect(HDiffHorData.u, weaDatBus.HDifHor);
  connect(TDryBulData.u, weaDatBus.TDryBul);
  connect(relHumData.u, weaDatBus.relHum);
  connect(TDewPoiData.u, weaDatBus.TDewPoi);
  connect(nOpaData.u, weaDatBus.nOpa);
  connect(winSpeData.u, weaDatBus.winSpe);
  connect(winDirData.u, weaDatBus.winDir);
  connect(TBlaSkyData.u, weaDatBus.TBlaSky);
  connect(weaDat.HDirNor_in, HDirNor_mea.y) annotation (Line(points={{-101,-61},
          {-116,-61},{-116,-56},{-121,-56}}, color={0,0,127}));
  connect(H_GloHor_mea.y, weaDat.HGloHor_in) annotation (Line(points={{-121,-70},
          {-101,-70},{-101,-63}}, color={0,0,127}));
annotation (
  defaultComponentName = "sim",
  defaultComponentPrefixes = "inner",
  missingInnerMessage =
    "Your model is using an outer \"sim\" component. An inner \"sim\" component is not defined. For simulation, drag IDEAS.BoundaryConditions.SimInfoManager into your model.",
  Icon(coordinateSystem(extent = {{-100,-100},{100,100}}),
       graphics = {
         Bitmap(extent = {{22,-8},{20,-8}}, fileName = "")}),
  Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,160}})),
  Documentation(info = "<html>
<p>
This component is a modified version of 
<a href=\"modelica://IDEAS.BoundaryConditions.SimInfoManager\">
IDEAS.BoundaryConditions.SimInfoManager</a>,
adapted for validation purposes.
</p>

<p>
The key modification is support for weather files with 
<b>higher time resolution</b> than the standard 1-hour format.
Specifically, this version is intended for use with 
<b>5-second resolution weather data</b>.
</p>

<p>
All original functionalities are preserved, including:
<ul>
  <li>TMY3 weather data reading,</li>
  <li>precomputation of solar angles for default orientations,</li>
  <li>and energy conservation diagnostics.</li>
</ul>
</p>

<p>
Refer to the original model’s documentation for full details:
<a href=\"modelica://IDEAS.BoundaryConditions.SimInfoManager\">
IDEAS.BoundaryConditions.SimInfoManager</a>.
</p>
</html>",
  revisions = "<html>
  <ul>
    <li>
      July 7, 2025, by Lone Meertens:<br/>
      Modified from IDEAS.BoundaryConditions.SimInfoManager for validation with 5-second resolution weather file.<br/>
      Tracked in 
      <a href=\"https://github.com/open-ideas/IDEAS/issues/1436\">
        IDEAS #1436
      </a>.
    </li>
  </ul>
</html>"));


end MySimInfoManager;
