             CMD        PROMPT('Check for Active TCP/IP Port')
             PARM       KWD(LOCALPORT) TYPE(*DEC) LEN(5) RANGE(1 +
                          65535) MIN(1) EXPR(*YES) PROMPT('Local port')
             PARM       KWD(CONNTYPE) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(IPV4) VALUES(IPV4 IPV6) EXPR(*YES) +
                          CASE(*MIXED) PROMPT('Connection type')
             PARM       KWD(OUTFILE) TYPE(QUAL2) MIN(0) MAX(1) +
                          PROMPT('Temp file to receive results')
 QUAL2:      QUAL       TYPE(*NAME) LEN(10) DFT(TCPTMP001) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) EXPR(*YES) +
                          PROMPT('Library')
