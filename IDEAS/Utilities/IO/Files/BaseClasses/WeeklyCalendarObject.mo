within IDEAS.Utilities.IO.Files.BaseClasses;
class WeeklyCalendarObject "Class that loads a weekly calendar"
extends ExternalObject;
  function constructor
    "Verify whether a file writer with  the same path exists and cache variable keys"
    extends Modelica.Icons.Function;
    input String fileName "Name of the file, including extension";
    input Real t_offset "";
    output WeeklyCalendarObject weeklyCalendar "Pointer to the weekly calendar";
    external"C" weeklyCalendar = weeklyCalendarInit(fileName, t_offset)
    annotation (
      Include="#include <WeeklyCalendar.c>",
      IncludeDirectory="modelica://IDEAS/Resources/C-Sources");

    annotation(Documentation(info="<html>
<p>
</p>
</html>", revisions="<html>
c
</html>"));
  end constructor;

  function destructor "Release storage and close the external object, write data if needed"
    input WeeklyCalendarObject weeklyCalendar "Pointer to file writer object";
    external "C" weeklyCalendarFree(weeklyCalendar)
    annotation(Include=" #include <WeeklyCalendar.c>",
    IncludeDirectory="modelica://IDEAS/Resources/C-Sources");
  annotation(Documentation(info="<html>
</html>"));
  end destructor;

annotation(Documentation(info="<html>
</html>",
revisions="<html>
<ul>
<li>
March 7 2022, by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
end WeeklyCalendarObject;
