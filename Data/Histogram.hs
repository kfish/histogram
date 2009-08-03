module Data.Histogram (
        Histogram,
        fromList,
	Data.Histogram.assocs
) where

import Data.Array.Unboxed as UA
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

assocs :: Histogram -> [(Int, Int)]
assocs (H arr) = UA.assocs arr
