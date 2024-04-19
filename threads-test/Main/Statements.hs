module Main.Statements where

import Hasql.Decoders qualified as D
import Hasql.Encoders qualified as E
import Hasql.Statement
import Prelude

selectSleep :: Statement Double ()
selectSleep =
  Statement sql encoder decoder True
  where
    sql =
      "select pg_sleep($1)"
    encoder =
      E.param (E.nonNullable E.float8)
    decoder =
      D.noResult
