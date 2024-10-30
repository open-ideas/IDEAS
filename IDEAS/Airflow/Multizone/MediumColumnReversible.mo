within IDEAS.Airflow.Multizone;
model MediumColumnReversible
  "Vertical shaft with no friction and no storage of heat and mass, reversible because it can handle negative column heights"

  extends IDEAS.Airflow.Multizone.MediumColumn(
    h(min=-Modelica.Constants.inf),
    final densitySelection = IDEAS.Airflow.Multizone.Types.densitySelection.fromBottom);
    // by convention, port_b must be connected to a zone instead of a flow element
    // h is allowed to be negative to accomodate for this convention

  annotation (
Icon(graphics={
    Line(
      points={{0,100},{0,-100},{0,-98}}),
    Text(origin = {-126, 2},lineColor = {0, 0, 127}, extent = {{24, -78}, {106, -100}}, textString = "Zone/Amb"),
    Text(origin = {-130, 4}, lineColor = {0, 0, 127}, extent = {{32, 104}, {98, 70}}, textString = "FlowElem"),
    Text(lineColor = {0, 0, 127}, extent = {{36, 26}, {88, -10}}, textString = "h=%h"),
    Rectangle(fillColor = {255, 0, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-16, 80}, {16, -80}}),
    Rectangle(visible = false, fillColor = {85, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-16, 80}, {16, 0}}),
    Rectangle(visible = false, fillColor = {85, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-16, 80}, {16, 54}}),
    Rectangle(fillColor = {85, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-16, 0}, {16, -82}}),
    Rectangle(visible = false, fillColor = {85, 170, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-16, -55}, {16, -80}})}),
  defaultComponentName="col",
  Documentation(info="<html>
<p>
This model describes the pressure difference of a vertical medium
column. It can be used to model the pressure difference caused by
stack effect.
It is a variation on IDEAS.Airflow.Multizone.MediumColumn.
</p>
</html>",
      revisions="<html>
<ul>
<li>
January 19, 2022, by Klaas De Jonge:<br/>
Adapted IDEAS.Airflow.Multizone.MediumColumn to obtain the current model where input of
 h can be negative and cleaned out the model as the density should always be set by port_b. 
This makes port_a not nececarilly always the top port.
</li>
</ul>
</html>"));
end MediumColumnReversible;
