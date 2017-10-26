-- | This module contains the data types
--   which represent the state of the game
module Model where

type Vec2 = (Float, Float)

(.-) , (.+) :: Vec2 -> Vec2 -> Vec2
(x , y) .+ (u , v) = (x + u , y + v)
(x , y) .- (u , v) = (x - u , y - v)


(.*) :: Float -> Vec2 -> Vec2
s .* (u , v) = (s * u , s * v)

data GameState = Menu
                | Game World Bool
                | GameOver Int

data World = Game { playerShip :: Ship,
                    asteroids  :: [Asteroid],
                    ufos       :: [Ufo],
                    bullets    :: [Bullet] }

data Object = Object { pos :: Vec2
                       vel :: Vec2 }

data Ship = Ship Object {
                   acc :: Vec2,
                   isAcc :: Bool}
          deriving (Eq,Show)

data Asteroid = Asteroid Object {size :: Int}

data Ufo = Ufo Object

data Bullet = Bullet

initialState :: GameState
initialState = GameState ShowNothing 0
