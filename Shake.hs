import Development.Shake

main = shakeArgs shakeOptions $ do
    phony "all" $ need ["25K.txt", "50K.txt", "100K.txt", "200K.txt", "400K.txt", "800K.txt", "1.6M.txt", "3.2M.txt"]

    "25K.txt" %> \_ -> need ["Main"] >> do
        cmd "./Main +RTS -s -RTS 25000" (FileStderr "25K.txt")

    "50K.txt" %> \_ -> need ["Main"] >> do
        cmd "./Main +RTS -s -RTS 50000" (FileStderr "50K.txt")

    "100K.txt" %> \_ -> need ["Main"] >> do
        cmd "./Main +RTS -s -RTS 100000" (FileStderr "100K.txt")

    "200K.txt" %> \_ -> need ["Main"] >> do
        cmd "./Main +RTS -s -RTS 200000" (FileStderr "200K.txt")

    "400K.txt" %> \_ -> need ["Main"] >> do
        cmd "./Main +RTS -s -RTS 400000" (FileStderr "400K.txt")

    "800K.txt" %> \_ -> need ["Main"] >> do
        cmd "./Main +RTS -s -RTS 800000" (FileStderr "800K.txt")

    "1.6M.txt" %> \_ -> need ["Main"] >> do
        cmd "./Main +RTS -s -RTS 1600000" (FileStderr "1.6M.txt")

    "3.2M.txt" %> \_ -> need ["Main"] >> do
        cmd "./Main +RTS -s -RTS 3200000" (FileStderr "3.2M.txt")

    "Main" %> \_ -> need ["Main.hs"] >> do
        cmd_ "ghc -O -optc-O3 Main.hs"

    phony "clean" $
        cmd_ "rm -f Main Main.o Main.hi 25K.txt 50K.txt 100K.txt 200K.txt 400K.txt 800K.txt 1.6M.txt 3.2M.txt"
