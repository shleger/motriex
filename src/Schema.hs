{-# LANGUAGE CPP #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}

module Schema where

import qualified Data.Aeson as J
import Data.Text as T
import GHC.Generics
import Mu.Adapter.Json ()
import Mu.Quasi.GRpc
import Mu.Schema

grpc "GreeterSchema" id "motriex.proto"

type HelloService = Greeter

newtype HelloRequestMsg = HelloRequestMsg {name :: T.Text}
  deriving
    ( Eq,
      Show,
      Ord,
      Generic,
      ToSchema GreeterSchema "HelloRequest",
      FromSchema GreeterSchema "HelloRequest"
    )
  deriving
    (J.ToJSON, J.FromJSON)
    via (WithSchema GreeterSchema "HelloRequest" HelloRequestMsg)

newtype HelloReplyMsg = HelloReplyMsg {message :: T.Text}
  deriving
    ( Eq,
      Show,
      Ord,
      Generic,
      ToSchema GreeterSchema "HelloReply",
      FromSchema GreeterSchema "HelloReply"
    )
  deriving
    (J.ToJSON, J.FromJSON)
    via (WithSchema GreeterSchema "HelloReply" HelloReplyMsg)
