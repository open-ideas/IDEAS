within IDEAS.UsersGuide.ReleaseNotes;
class Version_0_2_0 "Version_0_2_0"
  extends Modelica.Icons.ReleaseNotes;
  annotation (Documentation(info="<html>
<p>Major changes compared to v0.1.0 are:</p>
<ul>
<li>
The *.TMY3 file is used as the default climate file, and its reader is adopted from the LBNL Buildings library.
</li>
<li>
The IDEAS/Buildings/. package is updated so that the building components require only a single connector to be connected with the zone.
</li>
<li>
All hydronic components in IDEAS/Fluid are defined and updated based on the IEA EBC Annex60 models.
</li>
</ul>
</html>"));
end Version_0_2_0;
