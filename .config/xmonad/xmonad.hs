import qualified Data.Map                           as M
import           Graphics.X11.ExtraTypes.XF86
import           System.Exit
import           System.IO
import           XMonad
import           XMonad.Actions.GridSelect
import           XMonad.Actions.Search
import           XMonad.Config.Desktop
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.Place
import           XMonad.Layout.Accordion
import           XMonad.Layout.BinarySpacePartition
import           XMonad.Layout.Circle
import           XMonad.Layout.Grid
import           XMonad.Layout.Roledex
import           XMonad.Layout.Tabbed
import           XMonad.Prompt
import           XMonad.Prompt.ConfirmPrompt
import           XMonad.Prompt.Man
import           XMonad.Prompt.Shell
import           XMonad.Prompt.Ssh
import           XMonad.Prompt.Unicode
import           XMonad.Prompt.XMonad
import qualified XMonad.StackSet                    as W
import           XMonad.Util.EZConfig               (additionalKeys)
import           XMonad.Util.Run                    (spawnPipe)
import           XMonad.Util.SpawnOnce
import           XMonad.Util.Ungrab

{-
   TODO: https://xmonad.github.io/xmonad-docs/xmonad-contrib/XMonad-Layout-Hidden.html
   https://xmonad.github.io/xmonad-docs/xmonad-contrib/XMonad-Layout-Fullscreen.html
   https://xmonad.github.io/xmonad-docs/xmonad-contrib/XMonad-Prompt-Man.html
   https://xmonad.github.io/xmonad-docs/xmonad-contrib/XMonad-Prompt-Unicode.html
   https://xmonad.github.io/xmonad-docs/xmonad-contrib/XMonad-Actions-Search.html myModMask xK_e
   https://xmonad.github.io/xmonad-docs/xmonad-contrib/XMonad-Actions-ShowText.html
-}

myModMask :: KeyMask
myModMask = mod4Mask

myTerminal :: String
myTerminal = "st"

myTextEditor :: String
myTextEditor = "nvim"

myWorkspaces :: [String]
myWorkspaces = ["α", "β", "γ", "δ", "ε", "ζ", "η", "θ", "ι", "κ"]

myXPConfig :: XPConfig
myXPConfig = def
  { font = "xft:SpaceMono Nerd Font:style=Regular:size=11",
  position = Top,
  bgColor = "#222222",
  fgColor = "#bbbbbb",
  bgHLight = "#005577",
  fgHLight = "#eeeeee",
  promptBorderWidth = 0,
  complCaseSensitivity = CaseInSensitive,
  changeModeKey = xK_twosuperior }

keyBindings :: [((KeyMask, KeySym), X ())]
keyBindings =
  [ ((shiftMask .|. myModMask, xK_a), kill),
    ((myModMask, xK_Left), windows W.focusDown),
    ((myModMask, xK_Right), windows W.focusUp),
    ((shiftMask .|. myModMask, xK_Left), windows W.swapDown),
    ((shiftMask .|. myModMask, xK_Right), windows W.swapUp),
    ((myModMask, xK_space), sendMessage NextLayout),
    ((shiftMask .|. myModMask, xK_space), withFocused $ windows . W.sink),

    -- Prompts
    ((myModMask, xK_Tab), goToSelected def),
    ((myModMask, xK_l), choseLayout),
    ((myModMask, xK_e), choseSearch),
    ((myModMask, xK_F1), manPrompt myXPConfig),
    ((myModMask, xK_F2), xmonadPrompt myXPConfig),
    ((myModMask, xK_F3), sshPrompt myXPConfig),
    ((myModMask, xK_d), shellPrompt myXPConfig),
    ((shiftMask .|. myModMask, xK_BackSpace), confirmPrompt greenXPConfig "exit" $ io exitSuccess),
    ((shiftMask .|. myModMask, xK_q), confirmPrompt greenXPConfig "recompile" $ spawn "xmonad --recompile && xmonad --restart"),

    -- Apps
    ((shiftMask .|. myModMask, xK_m), spawn "clipmenu"),
    ((shiftMask .|. myModMask, xK_p), spawn "dmenuunicode"),
    ((myModMask, xK_t), spawn "firefox"),
    ((myModMask, xK_p), spawn "thunar"),
    ((myModMask, xK_i), spawn "random-wall"),
    ((shiftMask .|. myModMask, xK_u), spawn "walw"),
    ((myModMask, xK_w), spawn "walc -s"),
    ((shiftMask .|. myModMask, xK_s), spawn "walc -d"),
    ((myModMask, xK_Return), spawn myTerminal),
    ((shiftMask .|. myModMask, xK_Return), spawn $ myTerminal ++ " -c floating"),

    -- Others
    ((noModMask, xF86XK_MonBrightnessDown), spawn "backlight-control dec"),
    ((noModMask, xF86XK_MonBrightnessUp), spawn "backlight-control inc"),
    ((myModMask, xK_b), spawn "toggle-screenkey")
  ]
    ++ wsKeys
  where
    wsKeys :: [((KeyMask, KeySym), X ())]
    wsKeys =
      [ ((m .|. myModMask, k), windows $ f i)
        | (i, k) <- zip myWorkspaces [0x26, 0xe9, 0x22, 0x27, 0x28, 0x2d, 0xe8, 0x5f, 0xe7, 0xe0],
          (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
      ]

myLayout =
  tiled
    ||| Mirror tiled
    ||| Full
    ||| Roledex
    ||| Accordion
    ||| emptyBSP
    ||| Circle
    ||| Grid
    ||| simpleTabbed
    where tiled = Tall nmaster delta ratio
          nmaster = 1
          ratio = 1 / 2
          delta = 3 / 100

layoutGrid :: X (Maybe String)
layoutGrid = gridselect def . map (\x -> (x, x)) $! layouts
  where
    layouts = ["Tall", "Mirror Tall", "Full", "Roledex", "Accordion", "BSP", "Circle", "Grid", "Tabbed Simplest"]

choseLayout :: X ()
choseLayout = layoutGrid >>= flip whenJust (sendMessage . JumpToLayout)

searchGrid :: X (Maybe SearchEngine)
searchGrid = gridselect def . map f $! engines
  where
    f :: SearchEngine -> (String, SearchEngine)
    f s@(SearchEngine name _) = (name, s)
    engines :: [SearchEngine]
    engines = [duckduckgo, hoogle, github, hackage, imdb, alpha, mathworld, wikipedia, youtube]

choseSearch :: X ()
choseSearch = searchGrid >>= flip whenJust (promptSearch def)

myStartupHook :: X ()
myStartupHook =
  -- spawnOnce "$HOME/.fehbg"
  spawnOnce "random-wall"
    >> spawnOnce "xsetroot -cursor_name left_ptr"
    >> spawnOnce "setxkbmap -layout fr -variant azerty"
    >> spawnOnce "picom -b &"

myXmobarPP :: PP
myXmobarPP =
  def
    { ppCurrent = xmobarColor "yellow" "",
      ppVisible = xmobarColor "green" "",
      ppUrgent = xmobarColor "red" "yellow",
      ppHidden = xmobarColor "green" "",
      ppHiddenNoWindows = xmobarColor "gray" "",
      ppVisibleNoWindows = Just $ xmobarColor "yellow" "",
      ppSep = " ",
      ppTitle = xmobarColor "pink" "" . shorten 36
    }

myManageHook :: ManageHook
myManageHook = manageDocks <+> composeAll [ className =? "floating" --> doFloat'
                                          , className =? "mpv"      --> doFloat'
                                          , className =? "discord"  --> doShift "κ"]
  where
    doFloat' :: ManageHook
    doFloat' = placeHook (smart (0.5, 0.5)) <+> doFloat

main :: IO ()
main = do
  xmproc <- spawnPipe "xmobar"
  xmonad $
    ewmh
      desktopConfig
        { modMask = mod4Mask,
          terminal = myTerminal,
          borderWidth = 2,
          normalBorderColor = "#575976",
          focusedBorderColor = "#007a01",
          focusFollowsMouse = True,
          workspaces = myWorkspaces,
          manageHook = myManageHook,
          layoutHook = avoidStruts myLayout,
          logHook =
            dynamicLogWithPP $
              myXmobarPP
                { ppOutput = hPutStrLn xmproc
                },
          startupHook = myStartupHook
        }
      `additionalKeys` keyBindings
