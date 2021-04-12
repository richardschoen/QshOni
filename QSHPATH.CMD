             CMD        PROMPT('Set Open Source Package Path')
             PARM       KWD(PKGPATH) TYPE(*CHAR) LEN(255) +
                          DFT(*DEFAULT) +
                          SPCVAL(('/QOpenSys/pkgs/bin' +
                          '/QOpenSys/pkgs/bin') (*DEFAULT +
                          '/QOpenSys/pkgs/bin')) CASE(*MIXED) +
                          PROMPT('Open source package path')
