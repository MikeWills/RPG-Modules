     H NoMain
       //*************************************************************************
       // Program . . . . . DATE
       //
       // Created on  . . . 06/08/2006
       //         by  . . . Mike Wills (http://mikewills.me)
       //
       // Description . . . Several date functions to make working with dates
       //                   easier.
       //
       // To Compile:
       // *> CRTRPGMOD MODULE(&O/&ON) SRCFILE(&L/&F) SRCMBR(&N)
       // *> CRTSRVPGM SRVPGM(&O/&ON) OPTION(*DUPPROC)
       // *> DLTSPLF FILE(&ON) SPLNBR(*LAST)
       //
       // CHANGE LOG:
       // Date       | Name            | Description
       // -----------------------------------------------------------------------
       //            |                 |
       //            |                 |
       //            |                 |
       //*************************************************************************
     FHOLIDAYP  IF   E           K DISK    usropn

       // Prototypes
      /copy qsrvsrc,date_h

       // **********************************************************************
       // Global Definitions

     P*--------------------------------------------------
     P* Procedure name: IsValidDate
     P* Purpose:        Validate a date in numeric format
     P* Returns:
     P* Parameter:      DateIn YYYYMMDD format only
     P*--------------------------------------------------
     P IsValidDate     B                   EXPORT
     D IsValidDate     PI              N
     D  DateIn                        8P 0 CONST

       // Work fields
     D workDate        S               D
     D retField        S               N   inz(*ON)

      /free


       // Check for valid YYYYMMDD
       monitor;
         retField = *ON; // Assume is valid
         workDate = %date(DateIn:*ISO);
       on-error *ALL;
         retField = *OFF;  // It is not valid
       endmon;

       if (not retField);

         // Maybe the date is in MMDDYYYY format
         monitor;
           retField = *ON; // Assume is valid
           workDate = %date(DateIn:*USA);
         on-error;
           retField = *OFF;
         endmon;

       endif;

       return retField;    // It is valid

      /end-free
     P IsValidDate     E

     P*--------------------------------------------------
     P* Procedure name: ConvertDecimalDateToUsa
     P* Purpose:
     P* Returns:
     P* Parameter:      dateIn
     P*--------------------------------------------------
     P ConvertDecimalDateToUsa...
     P                 B                   EXPORT
     D ConvertDecimalDateToUsa...
     D                 PI             8P 0
     D  dateIn                        8P 0 CONST

     D* Local fields
     D retField        S              8P 0

      /free

       monitor;
         retField = %int(%char(%date(dateIn):*usa0));
       on-error *all;
         retField = 0;
       endmon;

       return retField;

      /end-free
     P ConvertDecimalDateToUsa...
     P                 E

     P*--------------------------------------------------
     P* Procedure name: ConvertDecimalDateToIso
     P* Purpose:
     P* Returns:
     P* Parameter:      dateIn
     P*--------------------------------------------------
     P ConvertDecimalDateToIso...
     P                 B                   EXPORT
     D ConvertDecimalDateToIso...
     D                 PI             8P 0
     D  dateIn                        8P 0 CONST

     D* Local fields
     D retField        S              8P 0

      /free

       monitor;
         retField = %int(%char(%date(dateIn:*usa):*iso0));
       on-error *all;
         retField = 0;
       endmon;

       return retField;

      /end-free
     P ConvertDecimalDateToIso...
     P                 E


     P*--------------------------------------------------
     P* Procedure name: ZeroDateToBlank
     P* Purpose:
     P* Returns:
     P*--------------------------------------------------
     P ZeroDateToBlank...
     P                 B                   EXPORT
     D ZeroDateToBlank...
     D                 PI            10A
     D  dateIn                         D

      /free

       if (dateIn = %date('0001-01-01'));
         return ' ';
       else;
         return %char(dateIn:*usa);
       endif;

       return ' ';

      /end-free
     P ZeroDateToBlank...
     P                 E


     P*--------------------------------------------------
     P* Procedure name: BlankToZeroDate
     P* Purpose:
     P* Returns:
     P*--------------------------------------------------
     P BlankToZeroDate...
     P                 B                   EXPORT
     D BlankToZeroDate...
     D                 PI              D
     D  dateIn                       10A

      /free

       if (dateIn = ' ');
         return %date('0001-01-01');
       else;
         return %date(dateIn:*usa);
       endif;

       return %date('0001-01-01');

      /end-free
     P BlankToZeroDate...
     P                 E


     P*--------------------------------------------------
     P* Procedure name: DayOfWeek
     P* Purpose: Calculates the day of the week
     P* Returns:
     P*--------------------------------------------------
     P DayOfWeek       B                   EXPORT
     D DayOfWeek       PI            10A
     D   dt                            D   value datfmt(*iso)

     D returnDay       S             10P 0

      /free

       returnDay = %rem (%diff (dt: d'1800-01-05': *days): 7);

       select;
         when (returnDay = 0);
           return 'Sunday';

         when (returnDay = 1);
           return 'Monday';

         when (returnDay = 2);
           return 'Tuesday';

         when (returnDay = 3);
           return 'Wednesday';

         when (returnDay = 4);
           return 'Thursday';

         when (returnDay = 5);
           return 'Friday';

         when (returnDay = 6);
           return 'Saturday';

       endsl;

      /end-free
     P DayOfWeek       E


     P*--------------------------------------------------
     P* Procedure name: IsHoliday
     P* Purpose:
     P* Returns:
     P* Parameter:      dateIn
     P*--------------------------------------------------
     P IsHoliday       B                   EXPORT
     D IsHoliday       PI              N
     D  dateIn                         D   DATFMT(*ISO)
     D                                     CONST

     D* Local fields
     D retField        S               N

      /free

       open HOLIDAYP;

       chain (dateIn) HOLIDAYR;

       if (%found());
         retField = *on;
       else;
         retField = *off;
       endif;

       close HOLIDAYP;

       return retField;

      /end-free
     P IsHoliday       E


     P*--------------------------------------------------
     P* Procedure name: DecimalDateToDate
     P* Purpose:        Convert a decimal date to a date field
     P* Returns:
     P* Parameter:      decimalDate
     P*--------------------------------------------------
     P DecimalDateToDate...
     P                 B                   EXPORT
     D DecimalDateToDate...
     D                 PI              D   DATFMT(*USA)
     D  decimalDate                   8P 0 CONST

     D* Local fields
     D retField        S               D   DATFMT(*USA)

      /free

       monitor;
         retField = %date(%char(decimalDate):*iso0);
       on-error;
         retField = %date('0001-01-01':*iso);
       endmon;

       return retField;

      /end-free
     P DecimalDateToDate...
     P                 E
 