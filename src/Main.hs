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

    match "posts/*" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/pages/post.html"    postCtx
            >>= loadAndApplyTemplate "templates/layouts/default.html" postCtx
            >>= relativizeUrls
    
    match "templates/**" $ compile templateCompiler


--------------------------------------------------------------------------------
config :: Configuration
config = defaultConfiguration
    { destinationDirectory = "docs" 
    , providerDirectory    = "src"  }

postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" `mappend`
    constField "post" "test"     `mappend`
    defaultContext