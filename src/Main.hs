--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
module Main (main) where


--------------------------------------------------------------------------------
import           Data.Monoid (mappend)
import           Hakyll


--------------------------------------------------------------------------------
main :: IO ()
main = hakyllWith config $ 
    match "index.html" $ do
        route idRoute
        compile copyFileCompiler


--------------------------------------------------------------------------------
config :: Configuration
config = defaultConfiguration
         { destinationDirectory = "docs" }


