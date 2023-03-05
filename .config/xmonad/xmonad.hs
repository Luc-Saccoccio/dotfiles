import           Data.Char                           (toUpper)
import qualified Data.Map                            as M
import           Graphics.X11.ExtraTypes.XF86
import           System.Exit
import           System.IO
import           System.Process
import           XMonad
import           XMonad.Actions.GridSelect
import           XMonad.Actions.Search
import           XMonad.Actions.UpdatePointer
import           XMonad.Config.Desktop
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.Place
import           XMonad.Hooks.StatusBar
import           XMonad.Layout.Accordion
import           XMonad.Layout.BinarySpacePartition
import           XMonad.Layout.Circle
import           XMonad.Layout.Grid
import           XMonad.Layout.IndependentScreens
import           XMonad.Layout.MultiToggle
import           XMonad.Layout.MultiToggle.Instances
import           XMonad.Layout.NoBorders
import           XMonad.Layout.Roledex
import           XMonad.Layout.Tabbed
import           XMonad.Prelude
import           XMonad.Prompt
import           XMonad.Prompt.ConfirmPrompt
import           XMonad.Prompt.FuzzyMatch
import           XMonad.Prompt.Man
import           XMonad.Prompt.Shell
import           XMonad.Prompt.Ssh
import           XMonad.Prompt.Unicode
import           XMonad.Prompt.XMonad
import qualified XMonad.StackSet                     as W
import qualified XMonad.Util.ExtensibleState         as XS
import           XMonad.Util.EZConfig                (additionalKeys)
import           XMonad.Util.Loggers
import           XMonad.Util.Run                     (spawnPipe)
import           XMonad.Util.SpawnOnce
import           XMonad.Util.Ungrab

{-
   TODO: https://xmonad.github.io/xmonad-docs/xmonad-contrib/XMonad-Layout-Hidden.html
   https://xmonad.github.io/xmonad-docs/xmonad-contrib/XMonad-Layout-Fullscreen.html
   https://xmonad.github.io/xmonad-docs/xmonad-contrib/XMonad-Prompt-Man.html
   https://xmonad.github.io/xmonad-docs/xmonad-contrib/XMonad-Prompt-Unicode.html
-}


instance HasColorizer SearchEngine where
  defaultColorizer (SearchEngine n _) = defaultColorizer n

data WLState = WLState [FilePath]

instance ExtensionClass WLState where
  initialValue = WLState []

type WallpaperConf = FilePath

replaceFile :: (Int, FilePath) -> [FilePath] -> [FilePath]
replaceFile (_, file) []     = [file]
replaceFile (0, file) (x:xs) = file:xs
replaceFile (n, file) (x:xs) = x:replaceFile (n-1, file) xs

getRandomWallpaper :: FilePath -> IO FilePath
getRandomWallpaper wd = do
  (lpin, lpout, lperr, _) <- runInteractiveProcess "ls" [] (Just wd) Nothing
  hClose lpin
  walls <- hGetContents lpout
  (spin, spout, sperr, _) <- runInteractiveProcess "shuf" ["-n1"] Nothing Nothing
  hPutStr spin walls
  hClose spin
  wallpaper <- hGetContents spout
  when (wallpaper == wallpaper) $ return ()
  hClose lpout
  hClose lperr
  hClose spout
  hClose sperr
  return wallpaper

-- To run with withWindowSet !!!
setWallpaperOnScreen :: WallpaperConf -> ScreenId -> WindowSet -> X ()
setWallpaperOnScreen wd (S nScreens) ws = do
  WLState oldWalls <- XS.get
  randomWall <- liftIO $ getRandomWallpaper wd
  let (S n) = W.screen $ W.current ws
      newWalls = map (filter (/='\n')) . take nScreens $ replaceFile (n, randomWall) oldWalls
      command = unwords $ "cd":wd:";":"feh":"--bg-fill":newWalls
  XS.put $ WLState newWalls
  spawn command

myModMask :: KeyMask
myModMask = mod4Mask

myTerminal :: String
myTerminal = "st"

myTextEditor :: String
myTextEditor = "nvim"

myWorkspaces :: [String]
myWorkspaces = ["α", "β", "γ", "δ", "ε", "ζ", "η", "θ", "ι", "κ"]

myFont :: String
myFont = "xft:SpaceMono Nerd Font:style=Regular:size="

myXPConfig :: XPConfig
myXPConfig = def
  { font = myFont ++ "11",
  position = Top,
  bgColor = "#222222",
  fgColor = "#bbbbbb",
  bgHLight = "#005577",
  fgHLight = "#eeeeee",
  promptBorderWidth = 0,
  complCaseSensitivity = CaseInSensitive,
  searchPredicate = fuzzyMatch,
  sorter = fuzzySort,
  changeModeKey = xK_twosuperior }

buildGSConfig :: (a -> Bool -> X (String, String)) -> GSConfig a
buildGSConfig col = GSConfig 60 130 10 col (myFont++"9") defaultNavigation noRearranger (1/2) (1/2) "white"

myGSConfig :: HasColorizer a => GSConfig a
myGSConfig = buildGSConfig defaultColorizer

myLayout = smartBorders . mkToggle (NOBORDERS ?? FULL ?? EOT) $
  tiled
    ||| Mirror tiled
    ||| Full
    ||| Roledex
    ||| Accordion
    ||| emptyBSP
    ||| Circle
    ||| Grid
    ||| simpleTabbed
    where
      nmaster = 1
      ratio = 1 / 2
      delta = 3 / 100
      tiled = Tall nmaster delta ratio

myWallpaperConf :: WallpaperConf
myWallpaperConf = "/home/luc/Images/wallpapers"

layoutGrid :: X (Maybe String)
layoutGrid = gridselect myGSConfig . map (\x -> (x, x)) $! layouts
  where
    layouts = ["Tall", "Mirror Tall", "Full", "Roledex", "Accordion", "BSP", "Circle", "Grid", "Tabbed Simplest"]

choseLayout :: X ()
choseLayout = layoutGrid >>= flip whenJust (sendMessage . JumpToLayout)

searchGrid :: X (Maybe SearchEngine)
searchGrid = gridselect myGSConfig . map f $! engines
  where
    maj :: String -> String
    maj (x:xs) = toUpper x : xs
    maj []     = []
    f :: SearchEngine -> (String, SearchEngine)
    f s@(SearchEngine name _) = (maj name, s)
    engines :: [SearchEngine]
    engines = [duckduckgo, hoogle, github, hackage, imdb, alpha, mathworld, wikipedia, youtube, aur, cratesIo, flora, ncatlab, protondb, rosettacode, rustStd, sourcehut, steam, voidpgks_x86_64]

choseSearch :: X ()
choseSearch = searchGrid >>= flip whenJust (promptSearch myXPConfig)

keyBindings :: ScreenId -> [((KeyMask, KeySym), X ())]
keyBindings nScreens =
  [ ((shiftMask .|. myModMask, xK_a), kill),
    ((myModMask, xK_Left), windows W.focusDown),
    ((myModMask, xK_Right), windows W.focusUp),
    ((shiftMask .|. myModMask, xK_Left), windows W.swapDown),
    ((shiftMask .|. myModMask, xK_Right), windows W.swapUp),
    ((myModMask, xK_a), sendMessage NextLayout),
    ((myModMask, xK_m), sendMessage $ Toggle FULL),
    ((shiftMask .|. myModMask, xK_space), withFocused $ windows . W.sink),
    ((myModMask, xK_q), sendMessage ToggleStruts),
    ((myModMask, xK_s), windows nextScreen >> updatePointer (0.5, 0.5) (0, 0)),

    -- Prompts
    ((myModMask, xK_Tab), goToSelected myGSConfig),
    ((myModMask, xK_space), choseLayout),
    ((myModMask, xK_e), choseSearch),
    ((myModMask, xK_F1), manPrompt myXPConfig),
    ((myModMask, xK_F2), xmonadPrompt myXPConfig),
    ((myModMask, xK_F3), sshPrompt myXPConfig),
    ((myModMask, xK_d), shellPrompt myXPConfig),
    ((shiftMask .|. myModMask, xK_BackSpace), confirmPrompt greenXPConfig "exit" $ io exitSuccess),
    ((shiftMask .|. myModMask, xK_q), confirmPrompt greenXPConfig "recompile" $ spawn "xmonad --recompile && xmonad --restart && notify-send \"XMonad\" \"Restarted\""),
    ((shiftMask .|. myModMask, xK_r), confirmPrompt greenXPConfig "restart" $ spawn "xmonad --restart"),

    -- Apps
    ((shiftMask .|. myModMask, xK_m), spawn "clipmenu"),
    ((shiftMask .|. myModMask, xK_p), spawn "dmenuunicode"),
    ((myModMask, xK_t), spawn "firefox"),
    ((myModMask, xK_p), spawn "thunar"),
    ((myModMask, xK_i), withWindowSet $ setWallpaperOnScreen myWallpaperConf nScreens),
    ((shiftMask .|. myModMask, xK_u), spawn "walw"),
    ((myModMask, xK_w), spawn "walc -s"),
    ((shiftMask .|. myModMask, xK_s), spawn "walc -d"),
    ((myModMask, xK_Return), spawn myTerminal),
    ((shiftMask .|. myModMask, xK_Return), spawn $ myTerminal ++ " -c floating"),

    -- Others
    ((noModMask, xF86XK_MonBrightnessDown), spawn "backlight-control dec"),
    ((noModMask, xF86XK_MonBrightnessUp), spawn "backlight-control inc"),
    ((myModMask, xK_b), spawn "toggle-screenkey"),
    ((noModMask, xF86XK_ScreenSaver), spawn "xscreensaver-command --lock"),
    ((noModMask, xF86XK_AudioMute), spawn "pulsemixer --toggle-mute"),
    ((noModMask, xF86XK_AudioMicMute), spawn "thinkpad-mutemic"),
    ((noModMask, xF86XK_AudioRaiseVolume), spawn "pulsemixer --change-volume +5"),
    ((noModMask, xF86XK_AudioLowerVolume), spawn "pulsemixer --change-volume -5")
  ]
    ++ wsKeys
  where
    nextScreen :: WindowSet -> WindowSet
    nextScreen ws =
      let currentScreenId = W.screen $ W.current ws
       in focusScreen ((currentScreenId + 1) `mod` nScreens) ws
    wsKeys :: [((KeyMask, KeySym), X ())]
    wsKeys =
      [ ((m .|. myModMask, k), windows $ onCurrentScreen f i)
        | (i, k) <- zip myWorkspaces [0x26, 0xe9, 0x22, 0x27, 0x28, 0x2d, 0xe8, 0x5f, 0xe7, 0xe0],
          (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
      ]

myStartupHook :: X ()
myStartupHook =
  -- spawnOnce "$HOME/.fehbg"
  spawnOnce "random-wall"
    >> spawnOnce "xsetroot -cursor_name left_ptr"
    >> spawnOnce "setxkbmap -layout fr -variant azerty"
    >> spawnOnce "picom -fb"
    >> spawnOnce "xscreensaver &"
    >> spawnOnce "echo > Images/wallpapers/.wall-list"
    >> spawnOnce "xrdb ~/.Xresources"
    >> spawnOnce "pgrep clipmenud || clipmenud &"

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
      -- Following are controlled by custom loggers
      ppTitle = const "",
      ppLayout = const ""
    }

myManageHook :: ManageHook
myManageHook = manageDocks <+> composeAll [ className =? "floating" --> doFloat'
                                          , className =? "mpv"      --> doFloat'
                                          -- , className =? "tabbed"   --> doIgnore
                                          , className =? "discord"  --> doShift "κ"]
  where
    doFloat' :: ManageHook
    doFloat' = placeHook (smart (0.5, 0.5)) <+> doFloat

main :: IO ()
main = do
  nScreens <- countScreens
  xmobars <- sequence [statusBarPipe ("xmobar -x " ++ show i) . pure $ marshallPP si (myXmobarPP { ppExtras = [logLayoutOnScreen si, (xmobarColor "pink" "" . shorten 36) `onLogger` logTitleOnScreen si] }) | si@(S i) <- [0..nScreens-1]]
  xmonad . ewmh . docks . withSB (mconcat xmobars) $
      desktopConfig
        { modMask = mod4Mask,
          terminal = myTerminal,
          borderWidth = 2,
          normalBorderColor = "#575976",
          focusedBorderColor = "#007a01",
          focusFollowsMouse = True,
          workspaces = withScreens nScreens myWorkspaces,
          manageHook = myManageHook,
          layoutHook = avoidStruts myLayout,
          startupHook = myStartupHook
        }
      `additionalKeys` keyBindings nScreens
