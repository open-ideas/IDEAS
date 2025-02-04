within IDEAS.Buildings.Data.Interfaces;
record WindPressureCoeff
  "Record for storing tables for wind pressure coeff"
  extends Modelica.Icons.Record;

  parameter Real Cp_Wall [:,:] "Face 1";
  parameter Real Cp_Roof_0_10[:,:] "Roof (<10° pitch, Average)";
  parameter Real Cp_Roof_11_30[:,:] "Roof (11-30° pitch, Front)";
  parameter Real Cp_Roof_30_45[:,:] "Roof (>30° pitch, Front)";

  parameter Real Cp_Floor[:,:];

  annotation (Documentation(info="<html>
<p>

M. W. Liddament, <i>A guide to energy efficient ventilation</i>. Coventry: Annex V Air Infiltration and Ventilation Centre, 1996.<br>
<br>
Appendix 2 - Wind Pressure Coefficient Data


</p>
</html>", revisions="<html>
<ul>
<li>
October 30, 2024, by Klaas De Jonge:<br/>
First implementation.
</li>
</ul>
</html>"));
end WindPressureCoeff;
