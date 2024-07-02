<?php
//---------------------------------------------------------------------------------
// Script name: phpcallparm1.php
// This example PHP script can be called from QShell or PASE and returns parameter
// values as part of the STOUT logging information.
// Note: We are not passing any arguments into this script, but passing
// input arguments works the same as always for PHP. Just pass them as you normally
// would via the php command line call.
//---------------------------------------------------------------------------------

   // Parameters
   $parm01="This is parm value 1";

   // https://www.php.net/manual/en/features.commandline.webserver.php
   echo("This is a parameter return sample\n");
   echo("Send return parm info to STDOUT prefix coded  RETURNPARM01 - RETURNPARM10.\n");
   echo("The return parmaeter data gets extracted by the QSHCALL CL command from STDOUT\n");

   // Format return parameter examples for QSHCALL to pick up from STDOUT log
   echo("RETURNPARM01:" . $parm01 . "\n");
   echo("RETURNPARM02:Return Value2\n");
   echo("RETURNPARM03:Return Value3\n");
   echo("RETURNPARM04:Return Value4\n");
   echo("RETURNPARM05:Return Value5\n");
   echo("RETURNPARM06:Return Value6\n");
   echo("RETURNPARM07:Return Value7\n");
   echo("RETURNPARM08:Return Value8\n");
   echo("RETURNPARM09:Return Value9\n");
   echo("RETURNPARM10:Return Value10\n");
?>
