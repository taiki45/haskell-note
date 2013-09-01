import Data.Monoid
import Data.Foldable
import qualified Data.Map as Map


--
-- First and Last
-- First :: Maybe a -> First a
lastOne = (Last $ Just 4) `mappend` (Last $ Just 3)
-- Last {getLast = Just 3}

withIdElem = (Last $ Just 4) `mappend` (Last $ Just 3) `mappend` (mempty $ Just 5)
-- Last {getLast = Just 3}

withFoldable = fold [Last $ Just 3, Last $ Just 4, Last Nothing]
-- Just 4


-- combine with (a -> Maybe b) and First
--
robots = Map.fromList [("Lisa", "345")
                      ,("Bob", "234")]

nameList = ["John", "Bob", "Lisa"]

firstFoundRobot = getFirst . fold $ fmap (First . (flip Map.lookup robots)) nameList
-- Just "234"
firstFoundRobot' = getFirst . fold $ fmap (First . (flip Map.lookup robots)) ["L", "F"]
-- Nothing

-- use foldM
firstFoundRobot'' = getFirst $ foldMap (First . (flip Map.lookup robots)) nameList
