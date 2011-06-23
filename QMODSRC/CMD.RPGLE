000100060608     H NoMain
000200060608       //*************************************************************************
000300110622       // Program . . . . . CMD
000400060608       //
000500060608       // Created on  . . . 06/08/2006
000600110622       //         by  . . . Mike Wills (http://mikewills.me)
000700060608       //
000800060608       // Description . . . Execute Common Command via RPG
000900110512       //
001000110512       // To Compile:
001100110622       // *> CRTRPGMOD MODULE(MODULES/CMD) SRCFILE(MODULES/QMODSRC) SRCMBR(CMD)
001200110622       // *> CRTSRVPGM SRVPGM(MODULES/CMD) OPTION(*DUPPROC)
001300110622       // *> DLTSPLF FILE(CMD) SPLNBR(*LAST)
001400060608       //
001500060608       // CHANGE LOG:
001600060608       // Date       | Name            | Description
001700060608       // -----------------------------------------------------------------------
001800060608       //            |                 |
001900060608       //            |                 |
002000060608       //            |                 |
002100060608       //*************************************************************************
002200060608
002300060608       // Prototypes
002400110512      /copy qsrvsrc,cmd_h
002500060608
002600060608       // **********************************************************************
002700060608       // Global Definitions
002800060608
002900060608     P*--------------------------------------------------
003000060608     P* Procedure name: ExecClCmd
003100060608     P* Purpose:        Execute a CL command
003200060608     P* Returns:
003300060608     P* Parameter:      cmd
003400060608     P*--------------------------------------------------
003500060608     P ExecClCmd       B                   EXPORT
003600060608     D ExecClCmd       PI
003700061013     D  cmdIn                     32767A   CONST
003800060608
003900060608     D ClCommand       PR                  ExtPgm('QCMDEXC')
004000061013     D  clCmd                     32767A   CONST
004100060608     D  cmdLen                       15P 5 CONST
004200060608
004300060608      /FREE
004400060608
004500060608       monitor;
004600060608         ClCommand(cmdIn: %len(%trim(cmdIn)));
004700060608       on-error *all;
004800110622         // Doesn't handle any errors yet
004900060608       endmon;
005000060608
005100060608      /END-FREE
005200060608     P ExecClCmd       E
