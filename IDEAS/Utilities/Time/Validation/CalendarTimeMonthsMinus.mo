within IDEAS.Utilities.Time.Validation;
model CalendarTimeMonthsMinus
  "Validation model for the calendar time model with start time slightly below the full hour"
  extends IDEAS.Utilities.Time.Validation.CalendarTimeMonths;

  annotation (
    __Dymola_Commands(file="modelica://IDEAS/Resources/Scripts/Dymola/Utilities/Time/Validation/CalendarTimeMonthsMinus.mos"
        "Simulate and plot"),
  Documentation(
    info="<html>
<p>
This model validates the use of the
<a href=\"modelica://IDEAS.Utilities.Time.CalendarTime\">
IDEAS.Utilities.Time.CalendarTime</a>.
It is identical to
<a href=\"modelica://IDEAS.Utilities.Time.Validation.CalendarTimeMonths\">
IDEAS.Utilities.Time.Validation.CalendarTimeMonths</a>
except that the start and end time are different.
</p>
</html>",
revisions="<html>
<ul>
<li>
September 14, 2016, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
    experiment(StartTime=172799, Tolerance=1e-6, StopTime=345599));
end CalendarTimeMonthsMinus;
