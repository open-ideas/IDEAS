within IDEAS.Buildings.Data.Frames;
record AluminumInsulated "Low U value aluminum frame"
  extends IDEAS.Buildings.Data.Interfaces.Frame(
    U_value=1.5);

                                          annotation (Documentation(info="<html>
<p>
Well-insulated aluminum window frame.
</p>
<p>
U-value based on <a href=\"https://www.testeral.com/en_prozori.html\">manufacturer data</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
May 6, 2022, by Jelger Jansen:<br>Revised U-value and added reference. See <a href=\"https://github.com/open-ideas/IDEAS/issues/1190\">#1190</a>.
</li>
</ul>
</html>"));
end AluminumInsulated;
