module Data.Histogram (
        Histogram,
        fromList
) where

import Data.Array.ST (runSTUArray)

import Data.Histogram.Internal
import Data.Histogram.Mutable (insert, new)

fromList :: Int -- max
         -> [Int] -- values to populate with
	 -> Histogram
fromList len values =
        H . runSTUArray $ do
	        mh <- new len
		mapM_ (insert mh) values
		return (mutArray mh)
