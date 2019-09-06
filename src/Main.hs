--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
module Main (main) where


--------------------------------------------------------------------------------
import           Data.Monoid (mappend)
import           Hakyll


--------------------------------------------------------------------------------
main :: IO ()
main = hakyllWith config $ 
    match "test/*" $ do
        route $ setExtension "html"
        compile copyFileCompiler


--------------------------------------------------------------------------------
config :: Configuration
config = defaultConfiguration
         { destinationDirectory = "docs" }


