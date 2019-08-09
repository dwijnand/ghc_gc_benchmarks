import Development.Shake
import Development.Shake.FilePath

main = shakeArgs shakeOptions $ do
    let targets = [f <.> "txt" | f <- ["25K", "50K", "100K", "200K", "400K", "800K", "1.6M", "3.2M"]]
    let values = ["250000","500000", "1000000", "2000000", "4000000", "8000000", "16000000", "32000000"]
    phony "all" $ need targets

    foldMap (\(t, v) -> t %> \out -> do
            need ["Main"]
            Stderr stderr <- cmd "./Main +RTS -s -RTS" v
            writeFile' out stderr
        ) (zip targets values)

    "Main" %> \out -> do
        need ["Main.hs"]
        cmd_ "ghc -O -optc-O3 Main.hs"

    phony "clean" $ do
        liftIO $ removeFiles "." $ ["Main", "Main.o", "Main.hi"] ++ targets
