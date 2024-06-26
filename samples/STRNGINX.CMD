/* Text: Start NGINX Web Server */
             CMD        PROMPT('Start NGINX Web Server')
             PARM       KWD(NGINXBIN) TYPE(*CHAR) LEN(255) +
                          DFT('/QopenSys/pkgs/bin/nginx') +
                          CASE(*MIXED) PROMPT('NGINX runtime binary')
             PARM       KWD(NGINXCONF) TYPE(*CHAR) LEN(255) +
                          DFT('/QOpenSys/etc/nginx/nginx.conf') +
                          CASE(*MIXED) PROMPT('NGINX config file')
             PARM       KWD(DSPSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) PROMPT('Display +
                          standard output result')
             PARM       KWD(LOGSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*YES) VALUES(*NO *YES) PROMPT('Log +
                          standard output to job log')
             PARM       KWD(PRTSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) PROMPT('Print +
                          standard output result')
             PARM       KWD(DLTSTDOUT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*YES) VALUES(*NO *YES) PROMPT('Delete +
                          standard output result')
 QUAL2:      QUAL       TYPE(*NAME) LEN(10) DFT(MONOSTDOUT) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(QTEMP) EXPR(*YES) +
                          PROMPT('Library')
