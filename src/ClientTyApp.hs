{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}

module Main where

import qualified Data.Text as T
import Mu.GRpc.Client.TyApps
import Schema
import System.Environment

-- run:
-- stack run motriex-client sayHello  "fox"

main :: IO ()
main = do
  -- Setup the client
  let config = grpcClientConfigSimple "127.0.0.1" 8080 False
  Right client <- setupGrpcClient' config
  args <- getArgs
  case args of
    ["sayHello", sayName] -> hello client sayName
    _ -> putStrLn "Unknown to send message"

hello :: GrpcClient -> String -> IO ()
hello client sayName = do
  let hrm = HelloRequestMsg $ T.pack sayName
  putStrLn ("INPUT: Message to " <> sayName)

  rknown :: GRpcReply HelloReplyMsg <-
    gRpcCall @'MsgProtoBuf @HelloService @"Greeter" @"sayHello" client hrm

  putStrLn ("OUTPUT: " <> show rknown)
