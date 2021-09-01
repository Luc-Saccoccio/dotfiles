import qualified Data.Map                    as M
import           System.Exit
import           System.IO
import           XMonad
import           XMonad.Actions.CopyWindow   (kill1)
import           XMonad.Config.Desktop
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.ManageDocks
import           XMonad.Prompt
import           XMonad.Prompt.ConfirmPrompt
import qualified XMonad.StackSet             as W
import           XMonad.Util.EZConfig        (additionalKeysP,
                                              additionalMouseBindings)
import           XMonad.Util.Run             (spawnPipe)
import           XMonad.Util.SpawnOnce

--- CONFIG
myModMask       = mod4Mask
myTerminal      = "st"
myTextEditor    = "nvim"
myBorderWidth   = 2
-- windowCount     = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

ws :: [String]
ws = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]

keyBindings :: [(String, X ())]
keyBindings =
    [ ("M-S-q", confirmPrompt greenXPConfig "exit" $ io exitSuccess)
    , ("M-C-r", spawn "xmonad --recompile")
    , ("M-S-r", spawn "xmonad --restart")
    , ("M-S-a", kill1)
    , ("M-<Return>", spawn myTerminal)
    , ("M-d", spawn "dmenu_run")
    , ("M-<Tab>", sendMessage NextLayout)
    ]

main :: IO ()
main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ ewmh desktopConfig
        { modMask = myModMask
        , terminal = myTerminal
        , borderWidth = 2
        , normalBorderColor = "#575976"
        , focusedBorderColor = "#007a01"
        , focusFollowsMouse = True
        , manageHook = manageDocks <+> manageHook def
        , layoutHook = avoidStruts $ layoutHook def
        , logHook = dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc }
        , workspaces = ws
        } `additionalKeysP` keyBindings

myStartupHook = do
    spawnOnce "$HOME/.fehbg"
