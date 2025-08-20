within IDEAS;
package UsersGuide "User's Guide"
extends Modelica.Icons.Information;

annotation (DocumentationClass=true, Documentation(info="<html>
<div align=\"center\">
<img height=\"100\" src=\"modelica://IDEAS/Resources/Images/IDEAS-logo-light.png\"/>
</div>
<p>
<span style=\"font-family: Courier New;\">IDEAS</span> is a Modelica library for 
<b>I</b>ntegrated <b>D</b>istrict <b>E</b>nergy <b>A</b>ssessment <b>S</b>imulations.
This free and open-source library enables simultaneous transient simulation of integrated thermal and electrical energy systems
including buildings at both individual (building) and collective (district) level. The IDEAS library extends from the
<a href=\"https://github.com/ibpsa/modelica-ibpsa\">Modelica IBPSA library</a> and has a particular focus on the development
of detailed building models. It is one of the four sister libraries that extend from the core Modelica IBPSA library, alongside
<a href=\"https://github.com/RWTH-EBC/AixLib\">AixLib</a>, <a href=\"https://github.com/lbl-srg/modelica-buildings\">Modelica Buildings</a>,
and <a href=\"https://github.com/UdK-VPT/BuildingSystems\">BuildingSystems</a>. IDEAS clearly differs from existing building energy system
simulation tools by integrating the dynamics of all hydronic, thermal, and electrical components at both the building and aggregated level within a single model and solver.</p>
<h4>Content</h4>
<p>
Main packages are listed below:
</p>
<ul>
<li>
<a href=\"modelica://IDEAS.Buildings\">Buildings</a> contains component models for modelling building envelopes.
</li>
<li>
<a href=\"modelica://IDEAS.Fluid\">Fluid</a> contains component models for modelling fluid systems.
</li>
<li>
<a href=\"modelica://IDEAS.Examples\">Examples</a> contains example models that demonstrate the use of
<a href=\"modelica://IDEAS.Buildings\">Buildings</a> and <a href=\"modelica://IDEAS.Fluid\">Fluid</a>.
</li>
</ul>
<p>
Package and model specific documentation can be found in the respective User&apos;s Guides and model documentation.
</p>
<h4>Feedback</h4>
<p>
IDEAS is developed at <a href=\"https://github.com/open-ideas/IDEAS\">GitHub</a>. 
Feel free to create an <a href=\"https://github.com/open-ideas/IDEAS/issues\">issue</a> in case you have a problem or a suggestion.
</p>
</html>", revisions="<html>
<ul>
<li>
July 30, 2025, by Lucas Verleyen:<br/>
Update for IDEAS v4.0.0.
</li>
<li>
January 12, 2017, by Filip Jorissen:<br/>
Updated for IDEAS 1.0
</li>
</ul>
</html>"));
end UsersGuide;
