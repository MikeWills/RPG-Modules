     H nomain option(*srcstmt:*nodebugio)
       //*************************************************************************
       // Program . . . . . BANK
       //
       // Created on  . . . 10/09/2012
       //         by  . . . Mike Wills
       //
       // Description . . . Methods for validating bank information
       //
       // To Compile:
       // *> CRTRPGMOD MODULE(&O/&ON) SRCFILE(&L/&F) SRCMBR(&N) DBGVIEW(*SOURCE)
       // *> CRTSRVPGM SRVPGM(&O/&ON) OPTION(*DUPPROC)
       //
       // CHANGE LOG:
       // Date       | Name            | Description
       // -----------------------------------------------------------------------
       //            |                 |
       //            |                 |
       //            |                 |
       //*************************************************************************

       // Prototypes
      /copy QSRVSRC,BANK_H

       // **********************************************************************
       // Global Definitions

     P*--------------------------------------------------
     P* Procedure name: IsValidRoutingNumber
     P* Purpose:        Validate the routing number is a valid number (not ...
     P*                          necessarily the right number)
     P* Returns:        Returns true/false
     P* Parameter:      routingNumber
     P*--------------------------------------------------
     P IsValidRoutingNumber...
     P                 B                   EXPORT
     D IsValidRoutingNumber...
     D                 PI              N
     D  routingNumber                10I 0 CONST

     D* Local fields
     D str             S              9A
     D checkDigit      S             18P 5
     D retField        S               N

      /free

       evalr str = %editc(routingNumber:'X');

       checkDigit = %rem((3 * (%int(%subst(str:1:1)) + %int(%subst(str:4:1)) +
                            %int(%subst(str:7:1)))) +
                         (7 * (%int(%subst(str:2:1)) + %int(%subst(str:5:1)) +
                            %int(%subst(str:8:1)))) +
                         (%int(%subst(str:3:1)) + %int(%subst(str:6:1)) +
                            %int(%subst(str:9:1))):10);

       if (checkDigit = 0);
         return *on;
       else;
         return *off;
       endif;

      /end-free
     P IsValidRoutingNumber...
     P                 E
 