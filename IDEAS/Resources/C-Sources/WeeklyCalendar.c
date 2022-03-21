/*

  This code implements a weekly calendar. Header file.

	License: BSD3

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

 Changelog:
 		March 9, 2022 by Filip Jorissen, KU Leuven
 				Initial version.


*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "WeeklyCalendar.h"

#ifndef WEEKCAL_c
#define WEEKCAL_c


int cmpfun(const void * tuple1, const void * tuple2) {
	double time1 = (*(const TimeDataTuple **)tuple1)->time;
	double time2 = (*(const TimeDataTuple **)tuple2)->time;
	return  (time1 - time2);
}

void* weeklyCalendarInit(const char* name, const double t_offset) {
	WeeklyCalendar* calendarID = (WeeklyCalendar*)calloc(1, sizeof(WeeklyCalendar));

	FILE *fp;
	const int bufLen = 255;
	char *token = calloc(sizeof(char), bufLen);
	struct TimeDataTuple **rules;
	int i = 0;    			/* iterator*/
	int index = 0;  		/* index in the token buffer where we are currently writing*/
	int line = 0; 			/* number of parsed lines*/
	int rule_i = 0; 		/* rule index where we are currently writing*/
	int foundHeader = 0; /* indicates whether a header has been found*/
	int isHeaderLine = 0;/* indicates whether we are currently parsing the header line*/
	int tokensInLine = 0;/* keeps track of the number of tokens in the current line: column index and sanity check*/
	int comment = 0;		 /* we are parsing a comment*/
	int n_rulesInMem = 0;/* number of rules for which we have allocated memory*/
	int n_rulesInRow = 0;/* number of rules that exist in the current row*/
	int n_rowsUnpacked = 0;/* total number of unpacked ruules*/
	int n_rowsPacked = 0;/* number of rules*/

	fp = fopen(name, "r");
	if (fp == NULL) {
		ModelicaFormatError("Failed to open file");
	}

	/* Identify 'tokens' by splitting on (one ore more) whitespace characters.*/
	/* Each token is parsed and special behaviour is created for comments and the header.*/
	/* The first column is analysed and split in (one or more) days (which can be comma separated), and hours, minutes, seconds.*/
	/* The format is day1,day2,day3:23:59:59 where day* is one of mon, tue, wed, thu, fri, sat, sun.*/
	/* All later columns contain data, where '-' serves as a wildcard, where data from the previous rule is reused.*/
	/* Rules are sorted by timestamp and then expanded, where '-' is filled in.*/
	while ( 1 ) {
		int parseToken = 0;
		double timeStamp;


		char c = fgetc ( fp ) ; /* read a character from the file*/
		if ( c == EOF ) {
			if (feof(fp)) {
				break; /* exit the while loop*/
			} else {
				ModelicaFormatError("Error while reading file.");
			}
		}{
			if (index >= bufLen - 2) {
				ModelicaFormatError("Buffer overflow");
			}


			if (c == '\n') { /* Check whether a token ends*/
				parseToken = 1;
			} else if (comment == 1 || c == '#') {
				comment = 1;
				continue; /* ignore this character and the next characters until a newline is detected, then parse the token*/
			} else if ( isHeaderLine == 0 && (c == ' ' || c == '\t' ) && index > 0) { /* parse token when reaching a space or tab, unless buffer is empty*/
				parseToken = 1;
			} else if (c != ' ' && c != '\t' ) { /*build up the token by copying a character*/
				token[index] = c;
				index++;
			}


			/* Parse a token if needed.*/
			if (parseToken == 1 && index > 0) {
				/* shouldn't require an overflow check since token is already checked*/
				char *buff2 = calloc(sizeof(char), bufLen);
				int tokenLen;
				int offset = 0;

				token[index] = '\0';
				index++;
				tokenLen = strlen(token);
				index = 0;

				/* ModelicaFormatWarning("Parsing token %s", token);*/


				if (foundHeader == 0 && strcmp("double", token) == 0) { /* we found a header line, we expect a specific format after the whitespace*/
					isHeaderLine = 1;
					foundHeader = 1;
				} else if ( isHeaderLine == 1 ) {	/* parse the header columns and rows*/
					char *source;
					int ncharsRow;
					int ncharsCol;

					if (strncmp("tab1(", token, 4) != 0) {
						ModelicaFormatError("Incorrect header. It should start with 'tab1('.");
					}

					source = token + 5;
					ncharsRow = strcspn(source, ",");

					if (tokenLen == ncharsRow + 5 ) {
						ModelicaFormatError("Incorrect header. No comma was found in the header.");
					}
					strncpy(buff2, source, ncharsRow);
					buff2[ncharsRow] = '\0';

					if (sscanf(buff2, "%i", &calendarID->n_rows_in) != 1) {
						ModelicaFormatError("Error in intenger conversion in header while parsing %s.", buff2);
					}

					source = source + ncharsRow + 1;
					ncharsCol = strcspn(source, ")");
					if (tokenLen == ncharsCol + ncharsRow + 5 + 1) {
						ModelicaFormatError("Incorrect header. No closing colon was found in the header.");
					} else if (tokenLen > ncharsCol + ncharsRow + 5 + 1 + 1) {
						ModelicaFormatError("Incorrect header. It has trailing characters: '%s'.", token + ncharsRow + ncharsCol + 7);
					}
					strncpy(buff2, source, ncharsCol);
					buff2[ncharsCol] = '\0';
					if (sscanf(buff2, "%i", &calendarID->n_cols_in) != 1) {
						ModelicaFormatError("Error in integer conversion in header while parsing %s.", buff2);
					}
					if (calendarID->n_cols_in < 2) {
						ModelicaFormatError("Illegal number of columns '%i'.", calendarID->n_cols_in);
					}
					if (calendarID->n_rows_in < 1) {
						ModelicaFormatError("Illegal number of rows '%i'.", calendarID->n_rows_in);
					}
					isHeaderLine = 0;
					foundHeader = 1;
					rules = calloc(sizeof(TimeDataTuple *), calendarID->n_rows_in);
					n_rulesInMem = calendarID->n_rows_in;
				} else if (foundHeader == 0) {
					ModelicaFormatError("Illegal file format, no header was found.");
				} else if (tokensInLine == 0) {
					/* 0 tokens have been found on this line, so we're parsing a date/time*/
					const int ncharsDays = strcspn(token, ":");
					timeStamp = 0;
					if (tokenLen  != ncharsDays) {
						double val;
						const int ncharsHour = strcspn(token + ncharsDays + 1, ":");

						strncpy(buff2, token + ncharsDays + 1, ncharsHour);
						buff2[ncharsHour] = '\0';
						if (sscanf(buff2, "%lf", &val) != 1) {
							ModelicaFormatError("Error in float conversion in hours. Found token %s with length %i", buff2, ncharsHour);
						}
						if (val > 24 || val < 0) {
							ModelicaFormatError("Unexpected value for hour: '%lf', should be between 0 and 24.", val);
						}
						timeStamp += val * 3600;

						if (tokenLen != ncharsHour + ncharsDays + 1) {
							const int ncharsMinutes = strcspn(token + ncharsDays + ncharsHour + 2, ":");
							strncpy(buff2, token + ncharsDays + ncharsHour + 2, ncharsMinutes);
							buff2[ncharsMinutes] = '\0';
							if (sscanf(buff2, "%lf", &val) != 1) {
								ModelicaFormatError("Error in float conversion in minutes.");
							}
							if (val > 60 || val < 0) {
								ModelicaFormatError("Unexpected value for minute: '%lf', should be between 0 and 60.", val);
							}
							timeStamp += val * 60;

							if (tokenLen != ncharsMinutes + ncharsHour + ncharsDays + 2) {
								const int ncharsSeconds = tokenLen - ncharsMinutes - ncharsHour - ncharsDays - 2;
								strncpy(buff2, token + ncharsDays + ncharsHour + ncharsMinutes + 3, ncharsSeconds);
								buff2[ncharsSeconds] = '\0';
								if (sscanf(buff2, "%lf", &val) != 1) {
									ModelicaFormatError("Error in float conversion in seconds.");
								}
								if (val > 60 || val < 0) {
									ModelicaFormatError("Unexpected value for seconds: '%lf', should be between 0 and 60.", val);
								}
								timeStamp += val;
							}
						}
					}
					strncpy(buff2, token, ncharsDays);
					buff2[ncharsDays] = '\0';


					/* loop over all days (comma separated) and for each date, add a rule*/
					while ( 1 ) {
						char * startIndex = buff2 + offset;
						double t_day, time_i;
						int nchars = strcspn(startIndex, ",");

						if (nchars != 3 ) {
							ModelicaFormatError("Unexpected day formatting: %s.", startIndex);
						}

						if (strncmp("mon", startIndex, 3) == 0) {
							t_day = 0;
						} else if (strncmp("tue", startIndex, 3) == 0) {
							t_day = 1 * 3600 * 24;
						} else if (strncmp("wed", startIndex, 3) == 0) {
							t_day = 2 * 3600 * 24;
						} else if (strncmp("thu", startIndex, 3) == 0) {
							t_day = 3 * 3600 * 24;
						} else if (strncmp("fri", startIndex, 3) == 0) {
							t_day = 4 * 3600 * 24;
						} else if (strncmp("sat", startIndex, 3) == 0) {
							t_day = 5 * 3600 * 24;
						} else if (strncmp("sun", startIndex, 3) == 0) {
							t_day = 6 * 3600 * 24;
						} else {
							ModelicaFormatError("Unexpected day format: %s.", startIndex);
						}

						/* expand the memory if the initially assigned memory block does not suffice*/
						if (rule_i >= n_rulesInMem) {
							n_rulesInMem += calendarID->n_rows_in;
							rules = realloc(rules, sizeof(TimeDataTuple*) * n_rulesInMem);
							if (rules == NULL) {
								ModelicaFormatError("Failed to reallocate memory.");
							}
						}

						time_i = timeStamp + t_day;
						rules[rule_i] = calloc(sizeof(TimeDataTuple), 1);
						rules[rule_i]->time = time_i;
						rules[rule_i]->data = calloc(sizeof(double), (calendarID->n_cols_in - 1));
						rule_i++;

						n_rulesInRow++;
						n_rowsUnpacked++;
						if (offset == 0) /* only for the first rule in this row*/
							n_rowsPacked++;

						if (strlen(startIndex) == 3) { /*reached the end of the substring*/
							break;
						}
						offset = offset + 4; /* the length of a token and a comma*/
					}

					tokensInLine++;
				} else if (tokensInLine > 0) {
					double val;

					/* a token has been found on this line before, so we're parsing some numerical data*/
					if (tokensInLine >= calendarID->n_cols_in) {
						ModelicaFormatError("Too many columns on row %i.", line);
					}

					if (sscanf(token, "%lf", &val) != 1) {
						if (token[0] == '-') {
							val = HUGE_VAL; /*convert the wildcard in a double representation*/
						} else {
							ModelicaFormatError("Invalid format for float %s.", token);
						}

					}
					/* Set the data for all rules that result from this row.*/
					for (i = rule_i - n_rulesInRow; i < rule_i; ++i) {
						rules[i]->data[tokensInLine - 1] = val;
					}

					tokensInLine++;
				} else {
					ModelicaFormatError("Logic error"); /*should not be able to end up here*/
				}
				free(buff2);
			}
			if (c == '\n') { /*reset some internal variables*/
				if (tokensInLine > 0 && tokensInLine != calendarID->n_cols_in) {
					ModelicaFormatError("Incorrect number of columns on line %i.", line);
				}
				line++;
				tokensInLine = 0;
				comment = 0;
				n_rulesInRow = 0;
			}
		}
	}
	fclose(fp);

	if (n_rowsPacked != calendarID->n_rows_in) {
		ModelicaFormatError("Incorrect number of rows: %i instead of %i.", n_rowsPacked, calendarID->n_rows_in);
	}

	/* sort all data by time stamp*/
	qsort(rules, rule_i, sizeof(TimeDataTuple*), cmpfun);

	{
		/* working vector with zero initial value*/
		int j, k;
		double *lastData = calloc(sizeof(double), calendarID->n_cols_in - 1);
		memset(lastData, (char)(double)0, calendarID->n_cols_in - 1); /* set vector to zero initial guess*/

		/* Loop over all data and fill in wildcards using the last preceeding value.*/
		/* This may wrap back to the end of last week, therefore loop the data twice.*/
		/* If an entire column contains wildcards then use a default value of zero.*/

		for (i = 0; i < 2; ++i) {
			for (j = 0; j < rule_i; ++j) {
				for (k = 0; k < calendarID->n_cols_in - 1; ++k) {
					if ( rules[j]->data[k] != HUGE_VAL ) {
						lastData[k] = rules[j]->data[k];
					} else if (i > 0) { /* only on the second pass, since otherwise the default value is filled in permanently and information from the back of the domain can't be recycled*/
						rules[j]->data[k] = lastData[k];
					}
				}
			}
		}
		free(lastData);
	}

	/* store data for later use*/
	calendarID->t_offset = t_offset;
	calendarID->n_rowsUnpacked = n_rowsUnpacked;
	calendarID->previousIndex = 0;
	calendarID->calendar = rules;
	calendarID->previousTimestamp = HUGE_VAL;

	free(token);

	return (void*) calendarID;
}

void weeklyCalendarFree(void * ID) {
	WeeklyCalendar* calendarID = (WeeklyCalendar*)ID;

	int i;
	for (i = 0; i < calendarID->n_rowsUnpacked; ++i) {
		free(calendarID->calendar[i]->data);
		free(calendarID->calendar[i]);
	}

	free(calendarID->calendar);
	free(ID);
	ID = NULL;
}

/* Get a column value. Cache the last used row internally to speed up lookup.*/
double getCalendarValue(void * ID, const int column, const double modelicaTime) {
	WeeklyCalendar* calendarID = (WeeklyCalendar*)ID;
	/*extrapolation for weeks that are outside of the user-defined range*/
	double t = modelicaTime - calendarID->t_offset;
	const double weekLen = 7 * 24 * 3600;
	double time = fmod(t - weekLen * floor(t / weekLen), weekLen);
	int i;
	const int columnIndex = column - 1; /* Since we do not store the time indices in the data table*/

	if (column < 0 || column > calendarID->n_cols_in - 1) {
		ModelicaFormatError("The requested column index '%i' is outside of the table range.", column + 1);
	}
	if (column == 0 ) {
		ModelicaFormatError("The column index 1 is not a data column and is reserved for 'time'. It should not be read.");
	}


	if (time == calendarID->previousTimestamp) {
		i = calendarID->previousIndex;
	} else if (time > calendarID->calendar[calendarID->previousIndex]->time) {
		for (i = calendarID->previousIndex; i < calendarID->n_rowsUnpacked - 1; i ++) {
			if (calendarID->calendar[i + 1]->time > time) {
				break;
			}
		}
	} else {
		for (i = calendarID->previousIndex; i > 0; i--) {
			if (calendarID->calendar[i - 1]->time < time) {
				i = i - 1;
				break;
			}
		}
		/* if time is smaller than the first row, wrap back to the end of the week*/
		if (i == 0 && calendarID->calendar[0]->time > time) {
			i = calendarID->n_rowsUnpacked - 1;
		}
	}
	calendarID->previousIndex = i;
	calendarID->previousTimestamp = time;

	return calendarID->calendar[i]->data[columnIndex];
}


#endif
