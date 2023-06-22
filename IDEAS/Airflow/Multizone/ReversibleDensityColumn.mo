within IDEAS.Airflow.Multizone.BaseClasses;
model ReversibleDensityColumn
  "Vertical shaft with no friction and no storage of heat and mass, reversible because it can handle negative column heights"

  extends IDEAS.Airflow.Multizone.MediumColumn(
    h(min=-Modelica.Constants.inf), 
    densitySelection = IDEAS.Airflow.Multizone.Types.densitySelection.fromBottom);
  
  annotation (
Icon(graphics={
    Line(
      points={{0,100},{0,-100},{0,-98}}),
    Text(
      extent={{24,-78},{106,-100}},
      lineColor={0,0,127},
          textString="Zone/Amb"),
    Text(
      extent={{32,104},{98,70}},
      lineColor={0,0,127},
          textString="FlowElem"),
    Text(
      extent={{36,26},{88,-10}},
      lineColor={0,0,127},
      fillColor={255,0,0},
      fillPattern=FillPattern.Solid,
      textString="h=%h"),
    Rectangle(
      extent={{-16,80},{16,-80}},
      fillColor={255,0,0},
      fillPattern=FillPattern.Solid,
      pattern=LinePattern.None),
    Rectangle(
      visible=densitySelection == IDEAS.Airflow.Multizone.Types.densitySelection.fromTop,
      extent={{-16,80},{16,0}},
      fillColor={85,170,255},
      fillPattern=FillPattern.Solid,
      pattern=LinePattern.None,
      lineColor={0,0,0}),
    Rectangle(
      visible=densitySelection == IDEAS.Airflow.Multizone.Types.densitySelection.actual,
      extent={{-16,80},{16,54}},
      fillColor={85,170,255},
      fillPattern=FillPattern.Solid,
      pattern=LinePattern.None,
      lineColor={0,0,0}),
    Rectangle(
      visible=densitySelection == IDEAS.Airflow.Multizone.Types.densitySelection.fromBottom,
      extent={{-16,0},{16,-82}},
      fillColor={85,170,255},
      fillPattern=FillPattern.Solid,
      pattern=LinePattern.None,
      lineColor={0,0,0}),
    Rectangle(
      visible=densitySelection == IDEAS.Airflow.Multizone.Types.densitySelection.actual,
      extent={{-16,-55},{16,-80}},
      fillColor={85,170,255},
      fillPattern=FillPattern.Solid,
      pattern=LinePattern.None,
      lineColor={0,0,0})}),
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
Adapted IDEAS.Airflow.Multizone.MediumColumn to obtain the current model where input of h can be negative and cleaned out the model as the density should always be set by port_b. 
This makes port_a not nececarilly always the top port.

</li>
</ul>
</html>"));
end ReversibleDensityColumn;
