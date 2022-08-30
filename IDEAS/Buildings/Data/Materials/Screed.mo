within IDEAS.Buildings.Data.Materials;
record Screed = IDEAS.Buildings.Data.Interfaces.Material (
    k=1.3,
    c=1000,
    rho=2000,
    epsLw=0.88,
    epsSw=0.55) "Typical (Belgian) screed" annotation (Documentation(info="<html>
<p>Thermal properties of screed. The values are based on those provided in the following resources: </p>
<ul>
<li>
<a href=\"https://www.rsprojects.eu/images/Duremit/Warmtegeleiding%20van%20Duremitchape.pdf\">https://www.rsprojects.eu/images/Duremit/Warmtegeleiding&percnt;20van&percnt;20Duremitchape.pdf</a> (in Dutch)
<br/>
&rho;=2100, k=1.2
</li>
<li>
<a href=\"https://www.joostdevree.nl/shtmls/warmtegeleidingscoefficient.shtml\">https://www.joostdevree.nl/shtmls/warmtegeleidingscoefficient.shtml</a> (in Dutch)
<br/>
k=1.3
</li>
<li>
<a href=\"https://buildex.techinfus.com/en/uteplenie/teploprovodnost-uteplitelej.html\">https://buildex.techinfus.com/en/uteplenie/teploprovodnost-uteplitelej.html</a>
<br/>
&rho;=2000, k=1.4
</li>
<li>
<a href=\"https://www.researchgate.net/publication/345618041_FIRE_DESIGN_METHODS_FOR_TIMBER_FLOOR_ELEMENTS_THE_CONTRIBUTION_OF_SCREED_FLOOR_TOPPINGS_TO_THE_FIRE_RESISTANCE\">Rauch, Michael &amp; Werther, Norman &amp; Winter, Stefan. (2020). FIRE DESIGN METHODS FOR TIMBER FLOOR ELEMENTS THE CONTRIBUTION OF SCREED FLOOR TOPPINGS TO THE FIRE RESISTANCE. 10.13140/RG.2.2.16032.00004.</a>
<br/>
&rho;=2100, k=1.95, c=900
</li>
<li>
<a href=\"https://www.researchgate.net/publication/301220515_Dynamic_simulations_and_experimental_measurements_on_an_extensive_green_roof_in_Mediterranean_climate\">Gagliano, Antonio &amp; Nocera, Francesco &amp; Detommaso, Maurizio &amp; Agrifoglio, Antonio &amp; Patania, Francesco. (2016). Dynamic simulations and experimental measurements on an extensive green roof in Mediterranean climate.</a>
<br/>
&rho;=1800, k=1.35, c=1000
</li>
</ul>
</html>", revisions="<html>
<ul>
<li>
July 29, 2022, by Jelger Jansen:<br/>
Updated thermal properties. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1245\">#1245</a>.
</li>
</ul>
</html>"));
