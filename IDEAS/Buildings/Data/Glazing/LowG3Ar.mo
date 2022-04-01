within IDEAS.Buildings.Data.Glazing;
record LowG3Ar =IDEAS.Buildings.Data.Interfaces.Glazing (
    mats={IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_a=0.026),
        IDEAS.Buildings.Data.Materials.Argon(d=0.018),
        IDEAS.Buildings.Data.Materials.Glass(d=0.004),
        IDEAS.Buildings.Data.Materials.Argon(d=0.018),
        IDEAS.Buildings.Data.Materials.Glass(
        d=0.004,
        epsLw_b=0.038,epsLw_a=0.84)},
    nLay=5,
    U_value=0.576,
    g_value=0.307,
    SwTransDif=0.184,
    SwTrans=[0,0.236;
            10,0.239;
            20,0.233;
            30,0.225;
            40,0.216;
            50,0.199;
            60,0.163;
            70,0.104;
            80,0.039;
            90,0.000],
    SwAbs=[0,0.303,0.0,0.011,0.0,0.027;
          10,0.306,0.0,0.011,0.0,0.028;
          20,0.311,0.0,0.011,0.0,0.031;
          30,0.314,0.0,0.011,0.0,0.033;
          40,0.314,0.0,0.011,0.0,0.034;
          50,0.315,0.0,0.011,0.0,0.035;
          60,0.320,0.0,0.011,0.0,0.038;
          70,0.319,0.0,0.011,0.0,0.037;
          80,0.252,0.0,0.009,0.0,0.022;
          90,0.001,0.0,0.000,0.0,0.000],
    SwAbsDif={0.308,0.0,0.011,0.0,0.033})
    "Triple glazing with g = 0.3" annotation (Documentation(info="<html>
<p>Triple glazing system with low g value.</p>
</html>", revisions="<html>
<ul>
<li>
December 13, 2021, by Filip Jorissen:<br/>
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1241\">
#1241</a>
</li>
</ul>
</html>"));
