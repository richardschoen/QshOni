             CMD        PROMPT('Set Open Source Package Path')
             PARM       KWD(PKGPATH) TYPE(*CHAR) LEN(255) +
                          DFT(*DEFAULT) +
                          SPCVAL(('/QOpenSys/pkgs/bin' +
                          '/QOpenSys/pkgs/bin') (*DEFAULT +
                          '/QOpenSys/pkgs/bin')) CASE(*MIXED) +
                          PROMPT('Open source package path')
             PARM       KWD(PATHLOC) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*DTAARA) VALUES(*DTAARA *BEGIN *END) +
                          CASE(*MONO) PROMPT('Open source path +
                          location')
