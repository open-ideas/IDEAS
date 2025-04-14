within IDEAS.Buildings.Data.WindPressureCoeff;
record Lowrise_Square_Exposed
  extends Interfaces.WindPressureCoeff(
    Cp_Wall=[0,0.4; 45,0.1; 90,-0.3; 135,-0.35; 180,-0.2; 225,
      -0.35; 270,-0.3; 315,0.1; 360,0.4],
    Cp_Roof_0_10=[0,-0.6; 45,-0.6; 90,-0.6; 135,-0.6],
    Cp_Roof_11_30=[0,-0.4; 45,-0.5; 90,-0.6; 135,-0.5; 180,-0.4; 225,-0.5; 270,
        -0.6; 315,-0.5; 360,-0.4],
    Cp_Roof_30_45=[0,0.3; 45,-0.4; 90,-0.6; 135,-0.4; 180,-0.5; 225,-0.4; 270,
        -0.6; 315,-0.4; 360,0.3],
    Cp_Floor=[0,0; 45,0; 90,0; 135,0; 180,0; 225,0; 270,0; 315,0; 360,0])
  annotation (Documentation(info="<html>
<p>
M. W. Liddament, <i>A guide to energy efficient ventilation</i>. Coventry: Annex V Air Infiltration and Ventilation Centre, 1996.<br>
<br>
Table A2.1 Wind Pressure Coefficient Data<br>
Low-rise buildings (up to 3 storeys)<br>
Length to width ratio: 1:1<br>
Shielding condition: Exposed<br>
Wind speed reference level: Building height<br>
</p>
</html>"));
annotation (Documentation(revisions="<html>
<ul>
<li>
October 30, 2024, by Klaas De Jonge:<br/>
First implementation.
</li>
</ul>
</html>"));
end Lowrise_Square_Exposed;
