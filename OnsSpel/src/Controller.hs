-- | This module defines how the state changes
--   in response to time and user input
module Controller where

import Model

import Graphics.Gloss
import Graphics.Gloss.Interface.IO.Game
import System.Random

-- | Handle one iteration of the game
step :: Float -> GameState -> IO GameState
step secs gstate
  | elapsedTime gstate + secs > nO_SECS_BETWEEN_CYCLES
  = -- We show a new random number
    do randomNumber <- randomIO
       let newNumber = abs randomNumber `mod` 10
       return $ GameState (ShowANumber newNumber) 0
  | otherwise
  = -- Just update the elapsed time
    return $ gstate { elapsedTime = elapsedTime gstate + secs }

-- | Handle user input
input :: Event -> GameState -> IO GameState
input e gstate = return (inputKey e gstate)

inputKey :: Event -> GameState -> GameState
inputKey (EventKey (Char c) _ _ _) gstate
  = -- If the user presses a character key, show that one
    gstate { infoToShow = ShowAChar c }
inputKey _ gstate = gstate -- Otherwise keep the same

test :: Ship -> Vec2 -> Vec2
test (Ship _ vel acc _) u = acc .+ u


handleEvents :: Event -> World -> IO World
--handleEvents (EventKey (Char 'w') Down _ _) (Game s) = return (Game(s { vel = (test s (0, 10)) } ))
handleEvents (EventKey (Char 'w') Up _ _) (Game s)   = return (Game(s { acc = (test s (0, -10)) } ))
handleEvents (EventKey (Char 'w') Down _ _) (Game s) = return (Game(s { acc = (test s (0, 10)) } ))
handleEvents (EventKey (Char 's') Up _ _) (Game s)   = return (Game(s { acc = (test s (0, 10)) } ))
handleEvents (EventKey (Char 's') Down _ _) (Game s) = return (Game(s { acc = (test s (0, -10)) } ))
handleEvents (EventKey (Char 'a') Up _ _) (Game s)   = return (Game(s { acc = (test s (10, 0)) } ))
handleEvents (EventKey (Char 'a') Down _ _) (Game s) = return (Game(s { acc = (test s (-10, 0)) } ))
handleEvents (EventKey (Char 'd') Up _ _) (Game s)   = return (Game(s { acc = (test s (-10, 0)) } ))
handleEvents (EventKey (Char 'd') Down _ _) (Game s) = return (Game(s { acc = (test s (10, 0)) } ))
