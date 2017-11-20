       // **********************************************************************
       // Copybook for ADVERROR

     D*--------------------------------------------------
     D* Procedure name: ErrorMsg
     D* Purpose:        Pop-up a screen with a longer error message
     D* Returns:
     D* Parameter:      errorText
     D*--------------------------------------------------
     D ErrorMsg        PR
     D  errorText                   150A   VARYING
     D                                     CONST

     D*--------------------------------------------------
     D* Procedure name: PromptMsg
     D* Purpose:        Pop-up a screen with a longer error message
     D* Returns:
     D* Parameter:      errorText
     D*--------------------------------------------------
     D PromptMsg       PR              N
     D  errorText                   150A   VARYING
     D                                     CONST 