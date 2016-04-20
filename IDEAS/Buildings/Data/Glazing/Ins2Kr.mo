within IDEAS.Buildings.Data.Glazing;
record Ins2Kr = IDEAS.Buildings.Data.Interfaces.Glazing (
    final nLay=3,
    final mats={Materials.Glass(d=0.004, epsLw_a=0.04),
                Materials.Krypton(d=0.015),
                Materials.Glass(d=0.004)},
    final SwTrans=[0, 0.426;
                   10, 0.428;
                   20, 0.422;
                   30, 0.413;
                   40, 0.402;
                   50, 0.380;
                   60, 0.333;
                   70, 0.244;
                   80, 0.113;
                   90, 0.000],
    final SwAbs=[0, 0.118, 0.0, 0.190;
                 10, 0.118, 0.0, 0.192;
                 20, 0.120, 0.0, 0.198;
                 30, 0.123, 0.0, 0.201;
                 40, 0.129, 0.0, 0.200;
                 50, 0.135, 0.0, 0.199;
                 60, 0.142, 0.0, 0.199;
                 70, 0.149, 0.0, 0.185;
                 80, 0.149, 0.0, 0.117;
                 90, 0.000, 0.0, 0.000],
    final SwTransDif=0.142,
    final SwAbsDif={0.142,0.0,0.199},
    final U_value=1.0,
    final g_value=0.598)
  "Saint Gobain Climaplus Futur KR 1.0 4/15/4 (U = 1.0 W/m2K, g = 0.598)"
  annotation (Documentation(revisions="<html>
<ul>
<li>
September 2, 2015, by Filip Jorissen:<br/>
Moved epsLw definition to solid layer to be consistent 
with changed implementation of MultiLayerLucent.
</li>
</ul>
</html>"));
