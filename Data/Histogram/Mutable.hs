module Data.Histogram.Mutable (
        MutHistogram,
        insert,
        new
) where

import Control.Monad (liftM)
import Control.Monad.ST (ST)
import Data.Array.MArray (newArray, readArray, writeArray)

import Data.Histogram.Internal (MutHistogram(..))

new :: Int -> ST s (MutHistogram s)
new len = MH `liftM` newArray (0,len-1) 0

insert :: MutHistogram s -> Int -> ST s ()
insert (MH arr) ix = do
        val <- readArray arr ix
	writeArray arr ix (val+1)
