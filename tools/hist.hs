module Main where

import UI.Command

import Data.Default

import System.IO

import Data.Histogram

hist = def {
        appName = "hist",
        appVersion = "0.1",
        appAuthors = ["Conrad Parker"],
        appBugEmail = "conrad@metadecks.org",
        appShortDesc = "a commandline tool for generating histograms",
        appCategories = ["Reporting"],
        appCmds = histCommands
}

histCommands = [
        textCmd
        ]

------------------------------------------------------------
-- histFromFile
--

valsFromFile :: FilePath -> IO [Int]
valsFromFile filename = do
        handle <- openFile filename ReadMode
        contents <- hGetContents handle
        return $ map read (lines contents)

histFromFiles :: [String] -> IO Histogram
histFromFiles filenames = do
        allVals <- mapM valsFromFile filenames
        return $ fromList 100 (concat allVals)

------------------------------------------------------------
-- text
--

textCmd = def {
        cmdName = "text",
        cmdHandler = textHandler,
        cmdCategory = "Reporting",
        cmdShortDesc = "Text plot of histogram"
}

textHandler :: [String] -> IO ()
textHandler filenames = do
        h <- histFromFiles filenames
	let a = assocs h
	mapM_ (\(i, n) -> putStrLn $ show i ++ ": " ++ take n (repeat '+')) a

------------------------------------------------------------
-- Main
--

main = appMain hist

