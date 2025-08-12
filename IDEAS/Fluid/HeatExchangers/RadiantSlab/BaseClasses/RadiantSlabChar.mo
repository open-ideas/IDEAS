within IDEAS.Fluid.HeatExchangers.RadiantSlab.BaseClasses;
record RadiantSlabChar
  "Record containing all parameters for a given a floor heating of concrete core activation"
  // The terminology from EN 15377 is followed, even if I find the development of the theory
  // by Koschenz and Lehmann better (see Thermoaktive Bauteilsysteme tabs, from Empa)
  // Important: this record ALSO contains the parameters that are specific to the building.
  extends Modelica.Icons.Record;

  parameter Boolean tabs = true
    "true if the model is used for TABS (assuming no insulation layer below the slab).";
  parameter Modelica.Units.SI.Length T(
    min=0.15,
    max=0.3) = 0.2 "Pipe spacing, limits imposed by prEN 15377-3 p22";
  parameter Modelica.Units.SI.Length d_a=0.02 "External diameter of the pipe";
  parameter Modelica.Units.SI.Length s_r=0.0025 "Thickness of the pipe wall";
  parameter Modelica.Units.SI.ThermalConductivity lambda_r=0.35
    "Thermal conductivity of the material of the pipe";
  parameter Modelica.Units.SI.Length S_1=0.1
    "Thickness of the concrete/screed ABOVE the pipe layer";
  parameter Modelica.Units.SI.Length S_2=0.1
    "Thickness of the concrete/screed UNDER the pipe layer";
  parameter Modelica.Units.SI.ThermalConductivity lambda_b=1.8
    "Thermal conductivity of the concrete or screed layer";
  parameter Modelica.Units.SI.SpecificHeatCapacity c_b=840
    "Thermal capacity of the concrete/screed material";
  parameter Modelica.Units.SI.Density rho_b=2100
    "Density of the concrete/screed layer";
  constant Integer n1=3 "Number of discrete capacities in upper layer";
  constant Integer n2=3 "Number of discrete capacities in lower layer";

  parameter Integer nParCir=1 "number of circuit in parallel";

  // Extra parameters for floor heating
  parameter Modelica.Units.SI.ThermalConductivity lambda_i=0.036
    "Heat conductivity of the insulation" annotation(Dialog(enable=not tabs));
  parameter Modelica.Units.SI.Length d_i=0.05
    "Thickness of the insulation" annotation(Dialog(enable=not tabs));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer alp1 = 3
    "Convective heat transfer coefficient between the floor layer and the room above" annotation(Dialog(enable=S_1<=0.3*T));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer alp2 = if tabs then 0.3 else lambda_i / d_i
    "Convective heat transfer coefficient between the floor layer and the room below.
     In case of a floor heating system, this variable is set equal to the ratio of the heat conductivity and thickness of the insulation" annotation(Dialog(enable=S_2<=0.3*T));

  annotation (Documentation(info="<html>
<p>
Record containing the properties of a thermally activated building system (TABS) or floor heating system.
The terminology from prEN15377 is followed, while the model itself is based on the model of Koschenz and Lehmann.
</p>
<p>
The default values of convective heat transfer coefficients <code>alp1</code> and <code>alp2</code> (in case of <code>tabs=true</code>)
are determined using the interior convection correlations as provided in the documentation of 
<a href=modelica://IDEAS.Buildings.Components.BaseClasses.ConvectiveHeatTransfer.InteriorConvection>
IDEAS.Buildings.Components.BaseClasses.ConvectiveHeatTransfer.InteriorConvection</a>,
for a room of <i>25 m<sup>2</sup></i> and a temperature difference between the slab and the room of <i>5°C</i>.
If <code>tabs=false</code>, <code>alp2</code> is set equal to <i>&lambda;<sub>i</sub> / d<sub>i</sub></i>, 
which is a valid assumption since the conductive thermal resistance of the floor heating's insulation is
significantly higher than the convective thermal resistance between the slab's surface and the room.
</p>
<h4>Model use</h4>
<ul>
<li>
It is important to set at least the floor surface to something different from 1.
</li>
<li>
The embeddedPipe model has a few assertions to check the validity of some parameters and their combinations.
</li>
</ul>
</html>", revisions="<html>
<ul>
<li>
August 12, 2025, by Jelger Jansen:<br/>
Add convective heat transfer coefficient <code>alp1</code>, update default value of <code>alp2</code>, and update documentation.<br/>
See <a href=https://github.com/open-ideas/IDEAS/issues/1381>#1381</a>.
</li>
<li>
May, 2013, by Roel De Coninck:<br/>
Add documentation.
</li>
<li>
June, 2011, by Roel De Coninck:<br/>
First implementation.
</li>
</ul>
</html>"));
end RadiantSlabChar;
