within IDEAS.Buildings.Data.Insulation;
record Ytong = IDEAS.Buildings.Data.Interfaces.Insulation (
    k=0.09,
    c=1000,
    rho=350,
    epsLw=0.8,
    epsSw=0.8) "Ytong" annotation (Documentation(info="<html>
<p>
Ytong (C2/350 weight class) insulating bricks thermal properties. 
The values are based on those in a <a href=\"https://storefrontapi.commerce.xella.com/medias/sys_master/root/hff/h5a/8796771647518/TD-Ytong-blokken_basis_nl/TD-Ytong-blokken-basis-nl.pdf\">technical sheet provided by the company Xella</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
May 3, 2022, by Jelger Jansen:<br/>
Updated thermal properties. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1245\">#1245</a>.
</li>
<li>
November 15, 2016, by Filip Jorissen:<br/>
Revised documentation for IDEAS 1.0.
</li>
</ul>
</html>"));
