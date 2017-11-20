     H NoMain
       //*************************************************************************
       // Program . . . . . STRING
       //
       // Created on  . . . 06/27/2006
       //         by  . . . Mike Wills (http://mikewills.me)
       //
       // Description . . . Several string functions making it easier to work
       //                   with strings.
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
     D up              C                   'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
     D lo              C                   'abcdefghijklmnopqrstuvwxyz'

       // Prototypes
      /copy qsrvsrc,string_h

       // **********************************************************************
       // Global Definitions

     P*--------------------------------------------------
     P* Procedure name: CenterText
     P* Purpose:        Center the text in a given string to for a given length
     P* Returns:        The centered string
     P* Parameter:      stringIn => The String to center
     P* Parameter:      fieldLength => The length of the field that the str...
     P*                          ing will be centered in
     P*--------------------------------------------------
     P CenterText      B                   EXPORT
     D CenterText      PI         32767A
     D  stringIn                  32767A   CONST
     D*                                    OPTIONS(*VARSIZE)
     D  fieldLength                   5P 0 CONST

       // Local fields
     D retField        S          32767A
     D stringPosition  S              5P 0 inz(0)

      /free

       // Figure out
       stringPosition = (fieldLength - %len(%trim(stringIn))) / 2;

       if (stringPosition = 0);
         stringPosition = 1;
       endif;

       %subst(retField:stringPosition) = %trim(stringIn);

       return retField;

      /end-free
     P CenterText      E


     P*--------------------------------------------------
     P* Procedure name: ConvertToUpperCase
     P* Purpose:        Convert all characters to upper case
     P* Returns:
     P* Parameter:      stringIn
     P* Parameter:      lengthToConvert
     P*--------------------------------------------------
     P ConvertToUpperCase...
     P                 B                   EXPORT
     D ConvertToUpperCase...
     D                 PI         32767A   VARYING
     D  stringIn                  32767A   VARYING
     D                                     CONST
     D  lengthToConvert...
     D                                5P 0 CONST
     D                                     OPTIONS(*NOPASS)

     D* Local fields
     D retField        S          32767A   VARYING

      /free

       select;
         when (%parms() = 1);
           retField = %xlate(lo:up:stringIn);

         when (%parms() = 2);
           retField = %xlate(lo:up:stringIn:lengthToConvert);

       endsl;

       return retField;

      /end-free
     P ConvertToUpperCase...
     P                 E


     P*--------------------------------------------------
     P* Procedure name: ConvertToLowerCase
     P* Purpose:        Convert all characters to upper case
     P* Returns:
     P* Parameter:      stringIn
     P* Parameter:      lengthToConvert
     P*--------------------------------------------------
     P ConvertToLowerCase...
     P                 B                   EXPORT
     D ConvertToLowerCase...
     D                 PI         32767A   VARYING
     D  stringIn                  32767A   VARYING
     D                                     CONST
     D  lengthToConvert...
     D                                5P 0 CONST
     D                                     OPTIONS(*NOPASS)

     D* Local fields
     D retField        S          32767A   VARYING

      /free

       select;
         when (%parms() = 1);
           retField = %xlate(up:lo:stringIn);

         when (%parms() = 2);
           retField = %xlate(up:lo:stringIn:lengthToConvert);

       endsl;

       return retField;

      /end-free
     P ConvertToLowerCase...
     P                 E


     P*--------------------------------------------------
     P* Procedure name: WordWrap
     P* Purpose:        Wrap words so that they fit in the allowed space
     P* Returns:        Return the array with everything parsed
     P* Parameter:      stringIn
     P* Parameter:      trimLength
     P*--------------------------------------------------
     P WordWrap        B                   export
     D WordWrap        PI          4096A   dim(255)
     D  stringIn                  32767A   varying const options(*varsize)
     D  trimLength                    5P 0 const

     D* Local fields
     D i               S              5P 0                                      Current Position
     D start           S              5P 0                                      Start of String
     D space           S              5P 0                                      Last Space Found
     D end             S              5P 0                                      End Of Line
     D length          S              5P 0                                      Length
     D x               S              5P 0                                      Array Position
     D lengthCounter   S              5P 0
     D stringInLen     S              5P 0

      /free

       i = 1;
       start = 1;
       space = 0;
       end = 0;
       length = 0;
       x = 0;
       lengthCounter = 0;
       stringInLen = 0;

       dow (i < 255);
         retWordWrap(i) = ' ';
         i += 1;
       enddo;

       i = 1;
       StringInLen = %len(%trim(stringIn));

       dow i <= StringInLen and %subst(stringIn:i) <> ' ';

         // Check to see if it is a space
         if %subst(stringIn:i:1) = ' ';
           space = i;
         endif;

         if LengthCounter >= trimLength;
           end = space - 1;
           exsr AddString;
           start = space + 1;
           LengthCounter = (1 + (i - start + 1));
         endif;

         i += 1;
         LengthCounter += 1;
       enddo;

       end = i;
       exsr AddString;

       return retWordWrap;

       //-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
       // AddString - Add the line to the array
       begsr AddString;

         x += 1;
         length = end - start + 1;

         if length < 1;
           length = trimLength;
         endif;

         if ((start + length) < stringInLen);
           retWordWrap(x) = %subst(stringIn:start:length);
         else;
           retWordWrap(x) = %subst(stringIn:start);
         endif;

       endsr;    // AddString
      /end-free
     P WordWrap        E


     P*--------------------------------------------------
     P* Procedure name: SanitizeString
     P* Purpose:        Clean up any rouge characters in a string
     P* Returns:
     P* Parameter:      stringIn
     P*--------------------------------------------------
     P SanitizeString  B                   EXPORT
     D SanitizeString  PI         32767A   VARYING
     D  stringIn                  32767A   VARYING
     D                                     CONST

     D* Local fields
     D temp            S          32767A   VARYING
     D retField        S          32767A   VARYING
     D position        S              6P 0
     D start           S              6P 0

      /free

       retField = stringIn;

       // Replace a single quote with two single quotes
       position = %scan('''': stringIn);

       dow (position > 0);

         temp = %subst(retField:position+1);
         //retField = %replace('''''':retField:position:2);
         retField = %subst(retField:1:position-1) + '''''' + temp;
         start = position + 2;
         position = %scan('''': retField: start);

       enddo;

        return retField;

      /end-free
     P SanitizeString  E


     P*--------------------------------------------------
     P* Procedure name: FindReplace
     P* Purpose:
     P* Returns:
     P* Parameter:      string
     P* Parameter:      findString
     P*--------------------------------------------------
     P FindReplace     B                   EXPORT
     D FindReplace     PI         32767A   VARYING
     D  source                    32767A   VARYING
     D                                     CONST
     D  find                        255A   VARYING
     D                                     VALUE
     D  replace                     255A   VARYING
     D                                     VALUE

     D work            S                   like(source)

      /free
       work = source;

       dow (%scan(find:work) > 0);
         work = %replace(replace:work:%scan(find:work):%len(find));
       enddo;

       return work;

      /end-free
     P FindReplace     E


     P*--------------------------------------------------
     P* Procedure name: RtrimZeros
     P* Purpose:
     P* Returns:
     P* Parameter:      string
     P* Parameter:      number decimal places
     P*--------------------------------------------------
     P RtrimZeros      B                   EXPORT

     D RtrimZeros      PI            25
     D  cStringIn                    25    Value
     D  nDecPlaces                    2  0 Value

     D cStringOut      S             25
     D nStartPos       S              2  0

      /free
       // Determine the start position
       nStartPos = %scan('.':cStringIn)+nDecPlaces+1;
       if %CHECKR(' 0':cStringIn) > nStartPos;
         nStartPos = %CHECKR(' 0':cStringIn);
       endif;

       return %XLATE('0':' ':cStringIn:nStartPos);
      /end-free

     P                 E


     P*--------------------------------------------------
     P* Procedure name: RightAlign
     P* Purpose:
     P* Returns:
     P* Parameter:      textIn
     P*--------------------------------------------------
     P RightAlign      B                   EXPORT
     D RightAlign      PI         32767A   VARYING
     D  textIn                    32767A   VARYING
     D                                     CONST
     D  length                        5I 0 CONST

     D* Local fields
     D retField        S          32767A
     D startPosn       S              5I 0

      /free
       startPosn = length - %len(%trim(textIn));
       if (startPosn = 0);
         return textIn;
       endif;
       %subst(retField:startPosn) = %trim(textIn);
       return retField;
      /end-free
     P RightAlign      E
 