import Development.Shake

main = shakeArgs shakeOptions $ do
    phony "all" $ need ["25K.txt", "50K.txt", "100K.txt", "200K.txt", "400K.txt", "800K.txt", "1.6M.txt", "3.2M.txt"]

    "25K.txt" %> \out -> do
        need ["Main"]
        Stderr stderr <- cmd "./Main +RTS -s -RTS 25000"
        writeFile' out stderr

    "50K.txt" %> \out -> do
        need ["Main"]
        Stderr stderr <- cmd "./Main +RTS -s -RTS 50000"
        writeFile' out stderr

    "100K.txt" %> \out -> do
        need ["Main"]
        Stderr stderr <- cmd "./Main +RTS -s -RTS 100000"
        writeFile' out stderr

    "200K.txt" %> \out -> do
        need ["Main"]
        Stderr stderr <- cmd "./Main +RTS -s -RTS 200000"
        writeFile' out stderr

    "400K.txt" %> \out -> do
        need ["Main"]
        Stderr stderr <- cmd "./Main +RTS -s -RTS 400000"
        writeFile' out stderr

    "800K.txt" %> \out -> do
        need ["Main"]
        Stderr stderr <- cmd "./Main +RTS -s -RTS 800000"
        writeFile' out stderr

    "1.6M.txt" %> \out -> do
        need ["Main"]
        Stderr stderr <- cmd "./Main +RTS -s -RTS 1600000"
        writeFile' out stderr

    "3.2M.txt" %> \out -> do
        need ["Main"]
        Stderr stderr <- cmd "./Main +RTS -s -RTS 3200000"
        writeFile' out stderr

    "Main" %> \out -> do
        need ["Main.hs"]
        cmd_ "ghc -O -optc-O3 Main.hs"

    phony "clean" $ do
        liftIO $ removeFiles "."
            ["Main", "Main.o", "Main.hi", "25K.txt", "50K.txt", "100K.txt", "200K.txt", "400K.txt", "800K.txt", "1.6M.txt", "3.2M.txt"]
