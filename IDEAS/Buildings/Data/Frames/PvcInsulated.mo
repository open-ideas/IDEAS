within IDEAS.Buildings.Data.Frames;
record PvcInsulated "Low U value PVC frame"
    extends IDEAS.Buildings.Data.Interfaces.Frame(
    U_value=0.75);
      annotation (Documentation(info="<html>
<p>
Well-insulated PVC window frame.
</p>
<p>
U-value from: Gustavsen, A., Jelle, B. P., Arasteh, D., &amp; Kholer, C. (2007). State-of-the-art highly insulating window frames - Research and market review. (<a href=\"https://eta-publications.lbl.gov/sites/default/files/1133.pdf\">https://eta-publications.lbl.gov/sites/default/files/1133.pdf</a>)
</p>
</html>", revisions="<html>
<ul>
<li>
May 6, 2022, by Jelger Jansen:<br/>
Revised U-value and added reference. 
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1190\">#1190</a>.
</li>
</ul>
</html>"));
end PvcInsulated;
