-- | This module defines how to turn
--   the game state into a picture
module View where

import Graphics.Gloss
import Model

view :: GameState -> IO Picture
view = return . viewPure

viewPure :: GameState -> Picture
viewPure gstate = case infoToShow gstate of
  ShowNothing   -> blank
  ShowANumber n -> color green (text (show n))
  ShowAChar   c -> color green (text [c])

  draw :: World -> IO Picture
  draw (Game(Ship (x, y) _ _ _)) = return (pictures [ship])
    where
      ship = color white (pictures [translate x y (circle 10)])
