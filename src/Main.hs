--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
module Main (main) where


--------------------------------------------------------------------------------
import           Data.Monoid (mappend)
import           Hakyll
import           Hakyll.Web.Sass (sassCompiler)


--------------------------------------------------------------------------------
main :: IO ()
main = hakyllWith config $ do
--    match "index.html" $ do
--        route idRoute
--        compile copyFileCompilerscss
--    match "styles/main.scss" $ do
--        route   $ constRoute "style.css"
--        compile compressScssCompiler

    match "styles/main.scss" $ do
        route $ constRoute "styles/style.css"
        let compressCssItem = fmap compressCss
        compile (compressCssItem <$> sassCompiler)

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


-- compressScssCompiler :: Compiler (Item String)
-- compressScssCompiler = 
--   fmap (fmap compressCss) $
--     getResourceString
--     >>= withItemBody (unixFilter "sass" [ "-s"
--                                         , "--scss"
--                                         , "--style", "compressed"
--                                         , "--load-path", "styles"
--                                         ])