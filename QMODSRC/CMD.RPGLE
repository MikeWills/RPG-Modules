     H NoMain
       //*************************************************************************
       // Program . . . . . CMD
       //
       // Created on  . . . 06/08/2006
       //         by  . . . Mike Wills (http://mikewills.me)
       //
       // Description . . . Execute Common Command via RPG
       //
       // To Compile:
       // *> CRTRPGMOD MODULE(MODULES/CMD) SRCFILE(MODULES/QMODSRC) SRCMBR(CMD)
       // *> CRTSRVPGM SRVPGM(MODULES/CMD) OPTION(*DUPPROC)
       // *> DLTSPLF FILE(CMD) SPLNBR(*LAST)
       //
       // CHANGE LOG:
       // Date       | Name            | Description
       // -----------------------------------------------------------------------
       //            |                 |
       //            |                 |
       //            |                 |
       //*************************************************************************

       // Prototypes
      /copy qsrvsrc,cmd_h

       // **********************************************************************
       // Global Definitions

     P*--------------------------------------------------
     P* Procedure name: ExecClCmd
     P* Purpose:        Execute a CL command
     P* Returns:
     P* Parameter:      cmd
     P*--------------------------------------------------
     P ExecClCmd       B                   EXPORT
     D ExecClCmd       PI
     D  cmdIn                     32767A   CONST

     D ClCommand       PR                  ExtPgm('QCMDEXC')
     D  clCmd                     32767A   CONST
     D  cmdLen                       15P 5 CONST

      /FREE

       monitor;
         ClCommand(cmdIn: %len(%trim(cmdIn)));
       on-error *all;
         // Doesn't handle any errors yet
       endmon;

      /END-FREE
     P ExecClCmd       E 