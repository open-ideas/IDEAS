within IDEAS.Buildings.Data.WindPressureCoeff;
record Lowrise_Cubic
  extends Interfaces.WindPressureCoeff(
    Cp_Floor=[0,0; 45,0; 90,0; 135,0; 180,0; 225,0; 270,0; 315,0; 360,0],
    Cp_Roof=[0,-0.5; 45,-0.5; 90,-0.5; 135,-0.5; 180,-0.5; 225,-0.5; 270,-0.5; 315,
        -0.5; 360,-0.5],
    Cp_Wall=[0,0.4; 45,0.1; 90,-0.3; 135,-0.35; 180,-0.2; 225,
      -0.35; 270,-0.3; 315,0.1; 360,0.4]);







end Lowrise_Cubic;
