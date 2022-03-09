within IDEAS.Utilities.IO.Files;
model WeeklyCalendar "Weekly calendar model"
  extends Modelica.Blocks.Icons.DiscreteBlock;

  IDEAS.Utilities.IO.Files.BaseClasses.WeeklyCalendarObject filWri=
      IDEAS.Utilities.IO.Files.BaseClasses.WeeklyCalendarObject("test.txt", 0)
    "File writer object";
end WeeklyCalendar;
