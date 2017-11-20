     H NoMain
     H BNDDIR('MODULES')
       //*************************************************************************
       // Program . . . . . ADVERROR
       //
       // Created on  . . . 01/18/2008
       //         by  . . . Mike Wills
       //
       // Description . . . Methods to make it easy to display errors in a
       //                   program.
       //
       // To Compile:
       // *> CRTRPGMOD MODULE(MODULES/ADVERROR) SRCFILE(MODULES/QMODSRC) -
       // *>   SRCMBR(ADVERROR) DBGVIEW(*SOURCE)
       // *> CRTSRVPGM SRVPGM(MODULES/ADVERROR) OPTION(*DUPPROC)
       // *> DLTSPLF FILE(ADVERROR) SPLNBR(*LAST)
       //
       // CHANGE LOG:
       // Date       | Name            | Description
       // -----------------------------------------------------------------------
       //            |                 |
       //            |                 |
       //            |                 |
       //*************************************************************************
     FADVERRORFMCF   E             WORKSTN USROPN

       // Prototypes
      /copy qsrvsrc,adverror_h
      /copy modules/qsrvsrc,string_h

       // **********************************************************************
       // Global Definitions

     P*--------------------------------------------------
     P* Procedure name: ErrorMsg
     P* Purpose:        Pop-up a screen with a longer error message
     P* Returns:
     P* Parameter:      errorText
     P*--------------------------------------------------
     P ErrorMsg        B                   EXPORT
     D ErrorMsg        PI
     D  errorText                   150A   VARYING
     D                                     CONST

     D len             S              3P 0

      /free

       if (not %open(ADVERRORFM));
         open ADVERRORFM;
       endif;

       retWordWrap = WordWrap(errorText:50);

       wError1 = %subst(retWordWrap(1):1:50);
       wError2 = %subst(retWordWrap(2):1:50);
       wError3 = %subst(retWordWrap(3):1:50);

       exfmt ERRORSCRN;

       close ADVERRORFM;

       return;

      /end-free
     P ErrorMsg        E


     P*--------------------------------------------------
     P* Procedure name: PromptMsg
     P* Purpose:        Pop-up a screen with a longer error message
     P* Returns:
     P* Parameter:      errorText
     P*--------------------------------------------------
     P PromptMsg       B                   EXPORT
     D PromptMsg       PI              N
     D  errorText                   150A   VARYING
     D                                     CONST

     D len             S              3P 0

      /free

       if (not %open(ADVERRORFM));
         open ADVERRORFM;
       endif;

       retWordWrap = WordWrap(errorText:50);

       wError1 = %subst(retWordWrap(1):1:50);
       wError2 = %subst(retWordWrap(2):1:50);
       wError3 = %subst(retWordWrap(3):1:50);

       exfmt PROMPTSCRN;

       if (not *in12);
         if (wPrompt = 'Y');
           return *on;
         else;
           return *off;
         endif;
       endif;

       close ADVERRORFM;

       return *off;

      /end-free
     P PromptMsg       E
 