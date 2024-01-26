module Hasql.Commands
  ( Commands,
    asBytes,
    setEncodersToUTF8,
    setMinClientMessagesToWarning,
  )
where

import qualified Data.ByteString.Builder as BB
import qualified Data.ByteString.Lazy as BL
import Hasql.Prelude

newtype Commands
  = Commands (DList BB.Builder)
  deriving (Semigroup, Monoid)

asBytes :: Commands -> ByteString
asBytes (Commands list) =
  BL.toStrict $ BB.toLazyByteString $ foldMap (<> BB.char7 ';') $ list

setEncodersToUTF8 :: Commands
setEncodersToUTF8 =
  Commands (pure "SET client_encoding = 'UTF8'")

setMinClientMessagesToWarning :: Commands
setMinClientMessagesToWarning =
  Commands (pure "SET client_min_messages TO WARNING")
