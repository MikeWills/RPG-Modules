       // **********************************************************************
       // STRING FUNCTIONS - Copybook for string commands

     D*--------------------------------------------------
     D* Procedure name: CenterText
     D* Purpose:        Center the text in a given string to for a given length
     D* Returns:        The centered string
     D* Parameter:      stringIn => The String to center
     D* Parameter:      fieldLength => The length of the field that the str...
     D*                          ing will be centered in
     D*--------------------------------------------------
     D CenterText      PR         32767A
     D  stringIn                  32767A   CONST
     D*                                    OPTIONS(*VARSIZE)
     D  fieldLength                   5P 0 CONST

     D*--------------------------------------------------
     D* Procedure name: ConvertToUpperCase
     D* Purpose:        Convert all characters to upper case
     D* Returns:
     D* Parameter:      stringIn
     D* Parameter:      lengthToConvert
     D*--------------------------------------------------
     D ConvertToUpperCase...
     D                 PR         32767A   VARYING
     D  stringIn                  32767A   VARYING
     D                                     CONST
     D  lengthToConvert...
     D                                5P 0 CONST
     D                                     OPTIONS(*NOPASS)

     D*--------------------------------------------------
     D* Procedure name: ConvertToLowerCase
     D* Purpose:        Convert all characters to upper case
     D* Returns:
     D* Parameter:      stringIn
     D* Parameter:      lengthToConvert
     D*--------------------------------------------------
     D ConvertToLowerCase...
     D                 PR         32767A   VARYING
     D  stringIn                  32767A   VARYING
     D                                     CONST
     D  lengthToConvert...
     D                                5P 0 CONST
     D                                     OPTIONS(*NOPASS)

     D*--------------------------------------------------
     D* Procedure name: WordWrap
     D* Purpose:        Break the lines at the word so that you don't cut i...
     D*                          n the middle of a word
     D* Returns:
     D* Parameter:      lineIn
     D* Parameter:      breakAtLength
     D*--------------------------------------------------
     D WordWrap        PR          4096A   dim(255)
     D  stringIn                  32767A   varying const options(*varsize)
     D  trimLength                    5P 0 const

     D retWordWrap     S           4096A   dim(255)

     D*--------------------------------------------------
     D* Procedure name: SanitizeString
     D* Purpose:        Clean up any rouge characters in a string
     D* Returns:
     D* Parameter:      stringIn
     D*--------------------------------------------------
     D SanitizeString  PR         32767A   VARYING
     D  stringIn                  32767A   VARYING
     D                                     CONST

     D*--------------------------------------------------
     D* Procedure name: FindReplace
     D* Purpose:
     D* Returns:
     D* Parameter:      string
     D* Parameter:      findString
     D*--------------------------------------------------
     D FindReplace     PR         32767A   VARYING
     D  source                    32767A   VARYING
     D                                     CONST
     D  find                        255A   VARYING
     D                                     VALUE
     D  replace                     255A   VARYING
     D                                     VALUE

     D*--------------------------------------------------
     D* Procedure name: FindReplace
     D* Purpose:
     D* Returns:
     D* Parameter:      string
     D* Parameter:      number decimal places
     D*--------------------------------------------------
     D RtrimZeros      PR            25
     D  cStringIn                    25    Value
     D  nDecPlaces                    2  0 Value

     D*--------------------------------------------------
     D* Procedure name: RightAlign
     D* Purpose:
     D* Returns:
     D* Parameter:      textIn
     D*--------------------------------------------------
     D RightAlign      PR         32767A   VARYING
     D  textIn                    32767A   VARYING
     D                                     CONST
     D  length                        5I 0 CONST 