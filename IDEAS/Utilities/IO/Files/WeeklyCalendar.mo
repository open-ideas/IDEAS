within IDEAS.Utilities.IO.Files;
model WeeklyCalendar "Weekly calendar model"
  extends Modelica.Blocks.Icons.DiscreteBlock;
  parameter Integer[:] columns = {1,2,3,4}
    "Columns that should be loaded from file";
  parameter Modelica.SIunits.Time t_offset = 0
    "Timestamp that corresponds to Monday midnight";
  parameter String fileName = Modelica.Utilities.Files.loadResource("modelica://IDEAS/Resources/Data/schedule.txt")
    "Filename";

  IDEAS.Utilities.IO.Files.BaseClasses.WeeklyCalendarObject cal=
      IDEAS.Utilities.IO.Files.BaseClasses.WeeklyCalendarObject(fileName, t_offset)
    "Calendar object";
protected
  parameter Integer n_columns = size(columns,1);
  function getCalendarValue
    "Returns the interpolated (zero order hold) value"
    extends Modelica.Icons.Function;
    input IDEAS.Utilities.IO.Files.BaseClasses.WeeklyCalendarObject ID "Pointer to file writer object";
    input Integer iCol;
    input Real timeIn;
    output Real y;
    external "C" y=getCalendarValue(ID, iCol, timeIn)
    annotation(Include=" #include <WeeklyCalendar.c>",
    IncludeDirectory="modelica://IDEAS/Resources/C-Sources");
  end getCalendarValue;
public
  Modelica.Blocks.Interfaces.RealOutput[n_columns] y = {getCalendarValue(cal, iCol-1, time) for iCol in columns} " Outputs"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  annotation (experiment(
      StartTime=-10000,
      StopTime=1000000,
      Interval=100),                                     Documentation(
        revisions="<html>
<ul>
<li>
March 9 2022, by Filp Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
end WeeklyCalendar;
