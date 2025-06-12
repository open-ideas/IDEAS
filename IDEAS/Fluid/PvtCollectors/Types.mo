within IDEAS.Fluid.PvtCollectors;
package Types "Package with type definitions used in solar collector data records"
  extends Modelica.Icons.TypesPackage;

  type HeatCapacity = enumeration(
      TotalCapacity
        "Total thermal capacity of the solar collector (i.e. including fluid)",
      DryCapacity
        "Dry thermal capacity and fluid volume of the solar collector",
      DryMass
        "Dry mass and fluid volume of the solar collector")
    "Enumeration to define how the heat capacity of the solar collector is calculated"
    annotation(Documentation(info="<html>
<p>
Enumeration used to define the different types of solar collector capacity specification.
</p>
</html>"));
  type NumberSelection = enumeration(
      Number "Number of panels",
      Area "Total panel area") "Enumeration of options for how users will specify
      the number of solar collectors in a system"
    annotation(Documentation(info="<html>
<p>
Enumeration used to define the different methods of declaring solar thermal
system size.
</p>
</html>"));
  type SystemConfiguration = enumeration(
      Parallel "Panels connected in parallel",
      Series "Panels connected in series",
      Array "Rectangular array of panels")
    "Enumeration of options for how the panels are connected"
    annotation(Documentation(info="<html>
<p>
Enumeration used to define the different configurations of
solar thermal systems.
</p>
</html>"));
annotation (preferredView="info", Documentation(info="<html>
  <p>
    This package contains type definitions used in solar thermal collector models.
  </p>
</html>"));
end Types;
