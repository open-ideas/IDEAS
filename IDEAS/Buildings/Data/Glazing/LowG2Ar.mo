within IDEAS.Buildings.Data.Glazing;
record LowG2Ar =IDEAS.Buildings.Data.Interfaces.Glazing (
    mats={IDEAS.Buildings.Data.Materials.Glass(d=0.006, epsLw_a=0.028),
        IDEAS.Buildings.Data.Materials.Argon(d=0.015),
        IDEAS.Buildings.Data.Materials.Glass(d=0.006)},
    nLay=3,
    U_value=1.0,
    g_value=0.28,
    SwTransDif=0.189,
    SwTrans=[0,0.226;
            10,0.228;
            20,0.225;
            30,0.220;
            40,0.215;
            50,0.204;
            60,0.179;
            70,0.164;
            80,0.062;
            90,0.000],
    SwAbs=[0,0.290,0.0,0.007;
          10,0.293,0.0,0.007;
          20,0.298,0.0,0.007;
          30,0.300,0.0,0.007;
          40,0.299,0.0,0.007;
          50,0.298,0.0,0.007;
          60,0.300,0.0,0.007;
          70,0.293,0.0,0.007;
          80,0.228,0.0,0.007;
          90,0.001,0.0,0.000],
    SwAbsDif={0.291,0.0,0.007})
  "Double glazing with g = 0.3, SGG Cool-lite XTREME 60/28 (2) and planiclear"
                                  annotation (Documentation(info="<html>
<p>Double glazing system with low g value.</p>
</html>", revisions="<html>
<ul>
<li>
December 13, 2021, by Filip Jorissen:<br/>
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1241\">
#1241</a>
</li>
</ul>
</html>"));
