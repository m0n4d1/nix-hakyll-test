--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
module Main (main) where


--------------------------------------------------------------------------------
import           Data.Monoid (mappend)
import           Hakyll


--------------------------------------------------------------------------------
main :: IO ()
main = hakyllWith config $ do
--    match "index.html" $ do
--        route idRoute
--        compile copyFileCompiler

    create ["index.html"] $ do
        route idRoute
        compile $ do
            let archiveCtx =
                    constField "title" "Home"            `mappend`
                    defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/pages/home.html" archiveCtx
                >>= loadAndApplyTemplate "templates/layouts/default.html" archiveCtx
                >>= relativizeUrls

    match "templates/**" $ compile templateCompiler


--------------------------------------------------------------------------------
config :: Configuration
config = defaultConfiguration
         { destinationDirectory = "docs" 
         , providerDirectory    = "src"  }


