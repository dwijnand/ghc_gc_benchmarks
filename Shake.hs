import Development.Shake
import Development.Shake.FilePath

main = shakeArgs shakeOptions $ do
    let values = [x <> "0000" | x <- ["25", "50", "100", "200", "400", "800", "1600", "3200"]]
    let targets = [f <.> "txt" | f <- values]
    phony "all" $ need targets

    "*0000.txt" %> \out -> do
        need ["Main"]
        Stderr stderr <- cmd "./Main +RTS -s -RTS" (takeBaseName out)
        writeFile' out stderr

    "Main" %> \out -> do
        need ["Main.hs"]
        cmd_ "ghc -O -optc-O3 Main.hs"

    phony "clean" $ do
        liftIO $ removeFiles "." $ ["Main", "Main.o", "Main.hi"] ++ targets
