/* 
  Author: Filip Jorissen, KU Leuven, Belgium

  This code implements a weekly calendar. Supported input format is ... 

*/


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "WeeklyCalendar.h"

#ifndef WEEKCAL_c
#define WEEKCAL_c


int cmpfun(const void ** tuple1, const void ** tuple2){
	// ModelicaFormatWarning("testin %i", );


	double time1 = (*(const TimeDataTuple **)tuple1)->time;
  double time2 = (*(const TimeDataTuple **)tuple2)->time;
  int res = (time1 > time2) - (time1 < time2);
	return  (time1-time2);
}

void* weeklyCalendarInit(const char* name, const double t_offset){
	WeeklyCalendar* calendarID = (WeeklyCalendar*)calloc(1, sizeof(WeeklyCalendar));

	FILE *fp;
	const int bufLen = 255;
	char token[bufLen];
	struct TimeDataTuple **rules;

	fp = fopen(name, "r");
	if (fp == NULL){
		ModelicaFormatError("Failed to open file");
	}


	int i = 0;    	
	int index = 0;    
	int line = 0; // number of parsed lines
	int rule_i = 0; // rule index
	int foundHeader = 0;
	int isHeaderLine = 0;
	int tokensInLine = 0;
	int comment = 0;
	int n_rules = 0;
	int n_rulesInRow = 0;
	while ( 1 ){
		int parseToken = 0;
		double timeStamp;
		

		char c = fgetc ( fp ) ; // reading the file
		if ( c == EOF ){
			if (feof(fp)){
				break; // exit the while loop
			}else{
				ModelicaFormatError("Error while reading file.");
			}
		}{
			if(index >= bufLen - 2){
				ModelicaFormatError("Buffer overflow");
			}

			// Check whether a token ends

			if (c == '\n'){
				parseToken = 1;
			}else if (comment == 1 || c == '#'){
				comment = 1;
				continue;
			}else if ( isHeaderLine == 0 && (c == ' ' || c == '\t' ) && index > 0){ // parse token when reaching a space or tab, unless buffer is empty
				parseToken = 1;
			}else if (c != ' ' && c != '\t' ){
				token[index]=c;
				index++;
			}


			// Parse a token if needed.
			if (parseToken == 1 && index > 0){
				

				token[index] = '\0';
				index++;
				const int tokenLen = strlen(token);
				index=0;
				ModelicaFormatWarning("Parsing token %s", token);
				char buff2[255];

				if (foundHeader == 0 && strcmp("double", token) == 0){
					isHeaderLine = 1;
				}
				else if ( isHeaderLine == 1 ){

					if (strncmp("tab1(", token, 4) != 0){
						ModelicaFormatError("Incorrect header. It should start with 'tab1('.");
					}
					
					char *source = token + 5;
					int ncharsRow = strcspn(source,",");
					
					if (tokenLen == ncharsRow + 5 ){
						ModelicaFormatError("Incorrect header. No comma was found in the header.");
					}
					strncpy(buff2, source, ncharsRow);
					buff2[ncharsRow]='\0';

					if (sscanf(buff2, "%i", &calendarID->n_rows_in) != 1){
						ModelicaFormatError("Error in intenger conversion in header while parsing %s.", buff2);
					}

					source = source + ncharsRow + 1;
					int ncharsCol = strcspn(source,")");
					if (tokenLen == ncharsCol + ncharsRow + 5 + 1){
						ModelicaFormatError("Incorrect header. No closing colon was found in the header.");
					}else if(tokenLen > ncharsCol + ncharsRow + 5 + 1 + 1){
						ModelicaFormatError("Incorrect header. It has trailing characters: '%s'.", token + ncharsRow + ncharsCol + 6);
					}
					strncpy(buff2, source, ncharsCol);
					buff2[ncharsCol]='\0';
					if (sscanf(buff2, "%i", &calendarID->n_cols_in) != 1){
						ModelicaFormatError("Error in integer conversion in header while parsing %s.", buff2);
					}
					if (calendarID->n_cols_in < 2){
						ModelicaFormatError("Illegal number of columns '%i'.", calendarID->n_cols_in);
					}
					if (calendarID->n_rows_in < 1){
						ModelicaFormatError("Illegal number of rows '%i'.", calendarID->n_rows_in);
					}
					ModelicaFormatWarning("Header sizes %i and %i", calendarID->n_cols_in, calendarID->n_rows_in);
					isHeaderLine = 0;
					foundHeader = 1;


					rules = calloc(sizeof(TimeDataTuple *), calendarID->n_rows_in);
					n_rules = calendarID->n_rows_in;
				}
				else if (tokensInLine == 0){

					timeStamp = 0;
					const int ncharsDays = strcspn(token,":");
					if (tokenLen  != ncharsDays){
						const int ncharsHour = strcspn(token + ncharsDays + 1,":");
						strncpy(buff2, token + ncharsDays + 1, ncharsHour);
						buff2[ncharsHour] = '\0';
						double val;
						if (sscanf(buff2, "%lf", &val) != 1){
							ModelicaFormatError("Error in float conversion in hours. Found token %s with length %i", buff2, ncharsHour);
						}
						if (val>24 || val < 0){
							ModelicaFormatError("Unexpected value for hour: '%lf', should be between 0 and 24.", val);
						}
						timeStamp += val*3600;

						if (tokenLen != ncharsHour + ncharsDays + 1){
							const int ncharsMinutes = strcspn(token + ncharsDays + ncharsHour + 2,":");
							strncpy(buff2, token + ncharsDays + ncharsHour + 2, ncharsMinutes);
							buff2[ncharsMinutes] = '\0';
							if (sscanf(buff2, "%lf", &val) != 1){
								ModelicaFormatError("Error in float conversion in minutes.");
							}
							if (val>60 || val < 0){
								ModelicaFormatError("Unexpected value for minute: '%lf', should be between 0 and 60.", val);
							}
							timeStamp += val*60;

							if (tokenLen != ncharsMinutes + ncharsHour + ncharsDays + 2){
								const int ncharsSeconds = tokenLen - ncharsMinutes - ncharsHour - ncharsDays - 2;
								strncpy(buff2, token + ncharsDays + ncharsHour + ncharsMinutes + 3, ncharsSeconds);
								buff2[ncharsSeconds] = '\0';
								if (sscanf(buff2, "%lf", &val) != 1){
									ModelicaFormatError("Error in float conversion in seconds.");
								}
								if (val>60 || val < 0){
									ModelicaFormatError("Unexpected value for seconds: '%lf', should be between 0 and 60.", val);
								}
								timeStamp += val;
							}
						}
					}
					strncpy(buff2, token, ncharsDays);
					buff2[ncharsDays]='\0';



					int offset = 0;
					while ( 1 ){
						char * startIndex = buff2 + offset;
						offset = offset + 4;
						int nchars = strcspn(startIndex,",");
						if (nchars != 3 ){
							ModelicaFormatError("Unexpected day formatting: %s.", startIndex);
						}
						

						double t_day;
						if (strncmp("mon", startIndex, 3) == 0){
							t_day = 0;
						}else if (strncmp("tue", startIndex, 3) == 0){
							t_day = 1*3600*24;
						}else if (strncmp("wed", startIndex, 3) == 0){
							t_day = 2*3600*24;
						}else if (strncmp("thu", startIndex, 3) == 0){
							t_day = 3*3600*24;
						}else if (strncmp("fri", startIndex, 3) == 0){
							t_day = 4*3600*24;
						}else if (strncmp("sat", startIndex, 3) == 0){
							t_day = 5*3600*24;
						}else if (strncmp("sun", startIndex, 3) == 0){
							t_day = 6*3600*24;
						}else{
							ModelicaFormatError("Unexpected day format: %s.", startIndex);
						}




						if (rule_i > n_rules){
							n_rules += calendarID->n_rows_in;
							rules = realloc(rules, sizeof(TimeDataTuple*) * n_rules);
							if(rules == NULL){
								ModelicaFormatError("Failed to reallocate memory.");
							}
						}

						double time_i = timeStamp +t_day;
						rules[rule_i] = calloc(sizeof(TimeDataTuple), 1);
						rules[rule_i]->time = time_i;
						rules[rule_i]->data = calloc(sizeof(double), (calendarID->n_cols_in-1));
						rule_i++;

						n_rulesInRow++;

						if (strlen(startIndex) == 3){ //reached the end of the substring
							break;
						}
					}
					
					tokensInLine++;
				}else if (tokensInLine > 0){
					if (tokensInLine >= calendarID->n_cols_in){
						ModelicaFormatError("Too many columns on row %i.", line);
					}

					double val;
					if (sscanf(token, "%f", &val) != 1){
						if (token[0]== '-'){
							val = NAN;
						}else{
							ModelicaFormatError("Invalid format for float %s.", token);
						}
						
					}
					// Set the data for all rules that result from this row.
					for (i = rule_i-n_rulesInRow; i < rule_i; ++i){
						rules[i]->data[tokensInLine-1] = val;
					}

					tokensInLine++;
				}else{
					ModelicaFormatError("Logic error");
				}
			}
			if (c == '\n'){
				if (tokensInLine>0 && tokensInLine != calendarID->n_cols_in){
					ModelicaFormatError("Incorrect number of columns on line %i.", line);
				}
				line++;
				tokensInLine = 0;
				comment = 0;
				n_rulesInRow = 0;
			}
		}
	}
	// ModelicaFormatError("test");
	fclose(fp);


	// TODO check number of rows
	// if (rul){
	// 	ModelicaFormatError("Incorrect number of columns on line %i.", line);
	// }

	qsort(rules, rule_i, sizeof(TimeDataTuple*), cmpfun);

	double lastData[calendarID->n_cols_in-1];
	memset(lastData, (char)(double)0, calendarID->n_cols_in-1); // set vector to zero initial guess

	ModelicaFormatError("test");
	int j,k;
	for (i = 0; i < 2; ++i){
		for (j = 0; j < rule_i; ++j){
			for (k = 0; k < calendarID->n_cols_in - 1; ++k){
				if (isnan(rules[j]->data[k])){
					rules[j]->data[k] = lastData[k];
				}else{
					lastData[k] = rules[j]->data[k];
				}
			}
		}
	}
	ModelicaFormatWarning("test");

	calendarID->t_offset = t_offset;
	calendarID->n_rules = rule_i;
	calendarID->previousIndex = 0;
	calendarID->calendar = rules;

	// weeklyCalendarFree(calendarID);

	return (void*) calendarID;
}

void weeklyCalendarFree(void * ID){
	WeeklyCalendar* calendarID = (WeeklyCalendar*)ID;
	

	int i;
	for (i = 0; i < calendarID->n_rules; ++i){
		ModelicaFormatWarning("Time: %f for %i", calendarID->calendar[i]->time, i );
		free(calendarID->calendar[i]->data);
		free(calendarID->calendar[i]);// TODO FIX
	}
	
	free(calendarID->calendar);

	free(ID);
	ID=NULL;
}

double getCalendarValue(void * ID, const int column, const double time){
	WeeklyCalendar* calendarID = (WeeklyCalendar*)ID;

	if (column < 0 || column > calendarID->n_cols_in-1){
		ModelicaFormatError("The requested column index '%i' is outside of the table range.", column + 1);
	}

	int i;
	if (time == calendarID->previousTimestamp)
		i=calendarID->previousIndex;
	else if (time > calendarID->calendar[calendarID->previousIndex]->time){
		for(i=calendarID->previousIndex; i<calendarID->n_rules -1; i ++){
			if (calendarID->calendar[i]->time > time);
				break;
		}
	}else{
		for(i=calendarID->previousIndex; i>0; i --){
			if (calendarID->calendar[i]->time < time);
				break;
		}
	}
	calendarID->previousIndex = i;
	calendarID->previousTimestamp = time;
	

	return calendarID->calendar[i]->data[column];
}


#endif
