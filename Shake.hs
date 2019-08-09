import Development.Shake
import Development.Shake.FilePath

targets = [x <> "0000.txt" | x <- ["25", "50", "100", "200", "400", "800", "1600", "3200"]]
main = shakeArgs shakeOptions $ do
    phony "all" $ need targets

    "*0000.txt" %> \out -> do
        need ["Main"]
        cmd_ "./Main +RTS -s -RTS" (takeBaseName out) (FileStderr out)

    "Main" %> \_ -> do
        need ["Main.hs"]
        cmd_ "ghc -O -optc-O3 Main.hs"

    phony "clean" $ do
        liftIO $ removeFiles "." $ ["Main", "Main.o", "Main.hi"] ++ targets
