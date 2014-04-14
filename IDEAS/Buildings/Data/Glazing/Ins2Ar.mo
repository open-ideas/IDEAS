within IDEAS.Buildings.Data.Glazing;
record Ins2Ar = IDEAS.Buildings.Data.Interfaces.Glazing (
    nLay=3,
    mats={Materials.Glass(d=0.004),Materials.Argon(d=0.015, epsLw_a=0.04),
        Materials.Glass(d=0.004)},
    SwTrans=[0, 0.426; 10, 0.428; 20, 0.422; 30, 0.413; 40, 0.402; 50, 0.380;
        60, 0.333; 70, 0.244; 80, 0.113; 90, 0.000],
    SwAbs=[0, 0.118, 0.0, 0.190; 10, 0.118, 0.0, 0.192; 20, 0.120, 0.0, 0.198;
        30, 0.123, 0.0, 0.201; 40, 0.129, 0.0, 0.200; 50, 0.135, 0.0, 0.199; 60,
        0.142, 0.0, 0.199; 70, 0.149, 0.0, 0.185; 80, 0.149, 0.0, 0.117; 90,
        0.000, 0.0, 0.000],
    SwTransDif=0.333,
    SwAbsDif={0.142,0.0,0.199},
    U_value=1.1,
    g_value=0.589)
  "Saint Gobain Climaplus Futur AR 1.1 4/15/4 (U = 1.10 W/m2K, g = 0.589)";
