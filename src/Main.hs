--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
module Main (main) where


--------------------------------------------------------------------------------
--import           Data.Monoid (mappend)
import           Data.Monoid     ((<>))
import           Hakyll
import           Hakyll.Web.Sass (sassCompiler)


--------------------------------------------------------------------------------
main :: IO ()
main = hakyllWith config $ do

    match "styles/style.scss" $ do
        route $ setExtension "css"
        let compressCssItem = fmap compressCss
        compile (compressCssItem <$> sassCompiler)

    create ["index.html"] $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"
            let archiveCtx =
                    listField "posts" postCtx (return posts) <>
                    constField "title" "Home"                <>
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
    dateField "date" "%B %e, %Y" <>
    defaultContext

templateCtx :: Context String
templateCtx =
    constField "root" "localhost:8000/"