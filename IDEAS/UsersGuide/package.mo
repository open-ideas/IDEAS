within IDEAS;
package UsersGuide "User's Guide"
extends Modelica.Icons.Information;






annotation (DocumentationClass=true, Documentation(info="<html>
<p>
<i><b>Integrated District Energy Assessment by Simulation</b></i> 
(<code>IDEAS</code>) is a Modelica library that allows integrated transient simulation of 
thermal and electrical processes at neighborhood level. 
The <code>IDEAS</code> tool differs from existing building physics and 
systems based and electrical energy system based models by integrating 
the dynamics of the hydronic, thermal as well as electrical energy networks 
at both the building and aggregated level within a single model and solver.
</p>
<h4>Content</h4>
<p>
Main packages are listed below.
</p>
<ul>
<li>
<a href=modelica://IDEAS.Buildings>Buildings</a> contains component models for modelling building envelopes. 
</li>
<li>
<a href=modelica://IDEAS.Fluid>Fluid</a> contains component models for modelling fluid systems. 
</li>
<li>
<a href=modelica://IDEAS.Experimental.Electric>Experimental.Electric</a> contains component models for modelling electric distribution grids. 
These models are not unit tested and are not actively maintained.
</li>
<li>
<a href=modelica://IDEAS.Examples>Examples</a> contains example models that demonstrate 
the use of <a href=modelica://IDEAS.Buildings>Buildings</a> and <a href=modelica://IDEAS.Fluid>Fluid</a>. 
</li>
</ul>
<h4>Feedback</h4>
<p>
<code>IDEAS</code> is developed at <a href=https://github.com/open-ideas/IDEAS>GitHub</a>.
Feel free to create an <a href=https://github.com/open-ideas/IDEAS/issues>issue</a>
in case you have a problem or a suggestion.
</p>
<p>
Furthermore, a large part of the code was originally developed within
the <a href=http://www.iea-annex60.org>IEA EBC Annex 60 project</a>,
which is continued as <a href=https://ibpsa.github.io/project1/>IBPSA project 1</a>.
For models originating from this library,
bug reports are preferably submitted on the 
<a href=https://github.com/iea-annex60/modelica-annex60>Annex 60</a> or 
<a href=https://github.com/ibpsa/project1>IBPSA project 1</a>
GitHub pages.
</p>
</html>", revisions="<html>
<ul>
<li>June 20, 2025, by Lucas Verleyen:<br>
Update for IDEAS v4.0.0.
</li>
<li>
January 12, 2017, by Filip Jorissen:<br>
Updated for IDEAS 1.0
</li>
</ul>
</html>"));
end UsersGuide;
