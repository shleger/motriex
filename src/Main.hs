{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE PartialTypeSignatures #-}
{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -fno-warn-partial-type-signatures #-}

module Main where

import Mu.GRpc.Server
import Mu.Server
import Schema

main :: IO ()
main = do
  putStrLn "Start HelloService"
  runGRpcApp msgProtoBuf 8080 server

server :: MonadServer m => SingleServerT i Greeter m _
server = singleService (method @"sayHello" $ sayHello)

sayHello :: (MonadServer m) => HelloRequestMsg -> m HelloReplyMsg
sayHello (HelloRequestMsg nm) = alwaysOk $ do
  putStr "HelloRequestMsg.name: " >> print nm
  pure $ HelloReplyMsg nm
