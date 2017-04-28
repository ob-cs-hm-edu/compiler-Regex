module Main where

import           Control.Monad   (when)
import           System.IO       (BufferMode (NoBuffering), hSetBuffering,
                                  stdout)
import           Text.Regex.PCRE

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering
    putStrLn $ "Geben Sie am string-Prompt eine Zeichenkette und am regex-Prompt\n"
              ++ "einen regex oder \":q\" zum Beenden ein."
    main'

main' :: IO ()
main' = do
    putStr "string> "
    string <- getLine
    when (string /= ":q") $ do
      putStr "regex> "
      regex <- getLine
      when (regex /= ":q") $ do
        putStrLn $ replicate 80 '-'
        let matchSuccess = string =~regex
        if not matchSuccess
          then putStrLn $ "match nicht erfolgreich\n" ++ replicate 80 '-'
          else do
            putStrLn $ "match erfolgreich\n" ++ replicate 80 '-'
            putStrLn $ "Matching: " ++ show string ++ " =~ " ++ show regex
                     ++ " :: MatchResult String"
            let match = string =~ regex :: MatchResult String
            putStr $ "mrBefore: " ++ mrBefore match ++ "\n"
                  ++ "mrMatch:  " ++ mrMatch match ++ "\n"
                  ++ "mrAfter:  " ++ mrAfter match ++ "\n"
            putStrLn $ replicate 80 '-'
            putStrLn $ "Matching: " ++ show string ++ " =~ " ++ show regex
                     ++ " :: AllTextMatches [] String"
            let match = string =~ regex :: AllTextMatches [] String
            putStrLn $ "getAllTextMatches: " ++ show (getAllTextMatches match)
            putStrLn $ replicate 80 '-'
        main'
