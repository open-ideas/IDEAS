within IDEAS.Buildings.Data.Frames;
record Aluminum "Aluminum frame"
  extends IDEAS.Buildings.Data.Interfaces.Frame(
    U_value=2.8);
       annotation (Documentation(info="<html>
<p>
Aluminum window frame. U-value may vary.
</p>
<p>
Reference U-value from: Van Den Bossche, N., Buffel, L., &amp; Janssens, A. (2015). Thermal Optimization of Window Frames. <i>Energy Procedia, 78, 2500-2505</i>. <a href=\"https://doi.org/10.1016/j.egypro.2015.11.251\">https://doi.org/10.1016/j.egypro.2015.11.251</a>
</p>
</html>", revisions="<html>
<ul>
<li>
May 6, 2022, by Jelger Jansen:<br>Revised U-value and added reference. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1190\">#1190</a>.
</li>
</ul>
</html>"));

end Aluminum;
