/* 
  Author: Filip Jorissen, KU Leuven, Belgium

  This code implements a weekly calendar. Supported input format is ... 

*/

#ifndef WEEKCAL_h
#define WEEKCAL_h

typedef struct TimeDataTuple {
	double time;	/* Time relative to monday midnight. */
	double *data; /* Corresponding column data */ 
} TimeDataTuple;


typedef struct WeeklyCalendar {


	double t_offset;	/* Time offset for monday, midnight. */
	int n_rows_in;	/* Number of input rows */
	int n_cols_in; /* Number of input columns */
	int n_rules;	/* Number of rules: number of rows after unpacking the date */
	
	double previousTimestamp;	/* Time where the calendar was called the previous time */
	int previousIndex; 				/* Index where the calendar was called the previous time */

	struct TimeDataTuple ** calendar;


} WeeklyCalendar;



void *weeklyCalendarInit(const char* name, const double t_offset);

void weeklyCalendarFree(void * ID);

double getCalendarValue(void * ID, const int column, const double time);

#endif
