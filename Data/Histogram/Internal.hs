module Data.Histogram.Internal (
     Histogram(..),
     MutHistogram(..)
) where

import Data.Array.ST (STUArray)
import Data.Array.Unboxed (UArray)

data Histogram = H {
        histArray :: UArray Int Int
}

data MutHistogram s = MH {
        mutArray :: STUArray s Int Int
}

