       // **********************************************************************
       // DATE FUNCTIONS - Copybook for date functions

     D*--------------------------------------------------
     D* Procedure name: IsValidDate
     D* Purpose:        Validate a date in numeric format
     D* Returns:
     D* Parameter:      DateIn
     D*--------------------------------------------------
     D IsValidDate     PR              N
     D  DateIn                        8P 0 CONST

     D*--------------------------------------------------
     D* Procedure name: ConvertDecimalDateToUsa
     D* Purpose:
     D* Returns:
     D* Parameter:      dateIn
     D*--------------------------------------------------
     D ConvertDecimalDateToUsa...
     D                 PR             8P 0
     D  dateIn                        8P 0 CONST

     D*--------------------------------------------------
     D* Procedure name: ConvertDecimalDateToIso
     D* Purpose:
     D* Returns:
     D* Parameter:      dateIn
     D*--------------------------------------------------
     D ConvertDecimalDateToIso...
     D                 PR             8P 0
     D  dateIn                        8P 0 CONST

     D*--------------------------------------------------
     D* Procedure name: ZeroDateToBlank
     D* Purpose:
     D* Returns:
     D*--------------------------------------------------
     D ZeroDateToBlank...
     D                 PR            10A
     D  dateIn                         D

     D*--------------------------------------------------
     D* Procedure name: BlankToZeroDate
     D* Purpose:
     D* Returns:
     D*--------------------------------------------------
     D BlankToZeroDate...
     D                 PR              D
     D  dateIn                       10A

     P*--------------------------------------------------
     P* Procedure name: DayOfWeek
     P* Purpose: Calculates the day of the week
     P* Returns:
     P*--------------------------------------------------
     D DayOfWeek       PR            10A
     D   dt                            D   value datfmt(*iso)

     D*--------------------------------------------------
     D* Procedure name: IsHoliday
     D* Purpose:
     D* Returns:
     D* Parameter:      dateIn
     D*--------------------------------------------------
     D IsHoliday       PR              N
     D  dateIn                         D   DATFMT(*ISO)
     D                                     CONST

     D*--------------------------------------------------
     D* Procedure name: DecimalDateToDate
     D* Purpose:        Convert a decimal date to a date field
     D* Returns:
     D* Parameter:      decimalDate
     D*--------------------------------------------------
     D DecimalDateToDate...
     D                 PR              D   DATFMT(*USA)
     D  decimalDate                   8P 0 CONST
 