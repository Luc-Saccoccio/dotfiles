module Main where

import           Data.Char                           (toUpper)
import qualified Data.Map                            as M
import           Graphics.X11.ExtraTypes.XF86
import           System.Exit
import           System.IO
import           System.Process
import           Text.Printf
import           XMonad
import           XMonad.Actions.GridSelect
import           XMonad.Actions.PhysicalScreens
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
import           XMonad.Layout.CircleEx              (circle)
import           XMonad.Layout.Grid
import           XMonad.Layout.IndependentScreens
import           XMonad.Layout.MultiToggle
import           XMonad.Layout.MultiToggle.Instances
import           XMonad.Layout.NoBorders
import           XMonad.Layout.Roledex
import           XMonad.Layout.Tabbed
import           XMonad.Operations
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


instance HasColorizer SearchEngine where
  defaultColorizer (SearchEngine n _) = defaultColorizer n

newtype WLState = WLState [FilePath]

instance ExtensionClass WLState where
  initialValue = WLState []

type WallpaperConf = FilePath

replaceFile :: (Int, FilePath) -> [FilePath] -> [FilePath]
replaceFile (_, file) []     = [file]
replaceFile (0, file) (x:xs) = file:xs
replaceFile (n, file) (x:xs) = x:replaceFile (n-1, file) xs

getCommandOutput :: String -> String -> IO String
getCommandOutput c cin = do
  (pin, pout, perr, _) <- runInteractiveCommand c
  hPutStr pin cin
  hClose pin
  output <- hGetContents pout
  hClose perr
  return output

getRandomWallpaper :: Int -> FilePath -> IO [FilePath]
getRandomWallpaper n wd = do
  (lpin, lpout, lperr, _) <- runInteractiveProcess "ls" [] (Just wd) Nothing
  hClose lpin
  walls <- hGetContents lpout
  (spin, spout, sperr, _) <- runInteractiveProcess "shuf" ["-n", show n] Nothing Nothing
  hPutStr spin walls
  hClose spin
  wallpapers <- hGetContents spout
  when (wallpapers == wallpapers) $ return ()
  hClose lpout
  hClose lperr
  hClose spout
  hClose sperr
  return $ words wallpapers

updateWallpapers :: WallpaperConf -> String -> X ()
updateWallpapers wd walls = do
  io (appendFile (wd ++ "/.wall-list") $ '\n':walls)
  spawn $ printf "cd %s; feh --bg-fill %s" wd walls

setWallpaperOnScreen :: WallpaperConf -> ScreenId -> ScreenId -> FilePath -> X ()
setWallpaperOnScreen wd (S nScreens) (S cScreen) wall = do
  WLState oldWalls <- XS.get
  let newWalls = take nScreens $ replaceFile (cScreen, wall) oldWalls
  XS.put $ WLState newWalls
  updateWallpapers wd $ unwords newWalls

chooseWallpaperOnScreen :: WallpaperConf -> ScreenId -> WindowSet -> X ()
chooseWallpaperOnScreen wd nScreens ws = do
  (_, Just hout, _, handle) <- io $ createProcess ((shell "ls | sort | dmenu -p 'Wallpaper: ' -l 7") { std_out = CreatePipe, cwd = Just wd })
  wall <- words <$> io (hGetContents' hout)
  if wall /= [] then
    setWallpaperOnScreen wd nScreens (W.screen $ W.current ws) $ head wall
  else return ()

randomWallpaper :: WallpaperConf -> ScreenId -> WindowSet -> X ()
randomWallpaper wd nScreens ws = do
  randomWall <- io (getRandomWallpaper 1 wd)
  setWallpaperOnScreen wd nScreens (W.screen $ W.current ws) (head randomWall)

randomWallpapers :: WallpaperConf -> ScreenId -> X ()
randomWallpapers wd (S nScreens) = do
  randomWalls <- io (getRandomWallpaper nScreens wd)
  XS.put $ WLState randomWalls
  updateWallpapers wd $ unwords randomWalls

myModMask :: KeyMask
myModMask = mod4Mask

altMask :: KeyMask
altMask = mod1Mask

ctrlMask :: KeyMask
ctrlMask = controlMask

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
    ||| circle
    ||| Grid
    ||| simpleTabbed
    where
      nmaster = 1
      ratio = 1 / 2
      delta = 3 / 100
      tiled = Tall nmaster delta ratio

myWallpaperConf :: WallpaperConf
myWallpaperConf = "/home/luc/images/wallpapers"

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
    ((myModMask, xK_r), sendMessage Rotate),
    ((myModMask .|. altMask, xK_l), sendMessage $ ExpandTowards R),
    ((myModMask .|. altMask, xK_h), sendMessage $ ExpandTowards L),
    ((myModMask .|. altMask, xK_j), sendMessage $ ExpandTowards D),
    ((myModMask .|. altMask, xK_k), sendMessage $ ExpandTowards U),
    ((myModMask .|. altMask .|. ctrlMask, xK_l), sendMessage $ ShrinkFrom R),
    ((myModMask .|. altMask .|. ctrlMask, xK_h), sendMessage $ ShrinkFrom L),
    ((myModMask .|. altMask .|. ctrlMask, xK_j), sendMessage $ ShrinkFrom D),
    ((myModMask .|. altMask .|. ctrlMask, xK_k), sendMessage $ ShrinkFrom U),
    ((myModMask, xK_s), windows focusNextScreen >> updatePointer (0.5, 0.5) (0, 0)),
    ((shiftMask .|. myModMask, xK_s), withWindowSet sendNextScreen),-- >> updatePointer (0.5, 0.5) (0, 0)),

    -- Prompts
    ((myModMask, xK_Tab), goToSelected myGSConfig),
    ((myModMask, xK_space), choseLayout),
    ((myModMask, xK_e), choseSearch),
    ((myModMask, xK_F1), manPrompt myXPConfig),
    ((myModMask, xK_F2), xmonadPrompt myXPConfig),
    ((myModMask, xK_F3), sshPrompt myXPConfig),
    ((myModMask, xK_d), shellPrompt myXPConfig),
    ((shiftMask .|. myModMask, xK_BackSpace), confirmPrompt greenXPConfig "exit" $ io exitSuccess),
    ((shiftMask .|. myModMask, xK_e), confirmPrompt greenXPConfig "shutdown" $ spawn "doas shutdown -P now"),
    ((shiftMask .|. myModMask, xK_q), confirmPrompt greenXPConfig "recompile" $ spawn "xmonad --recompile && xmonad --restart && notify-send \"XMonad\" \"Restarted\""),
    ((shiftMask .|. myModMask, xK_r), confirmPrompt greenXPConfig "restart" $ spawn "xmonad --restart"),

    -- Apps
    ((shiftMask .|. myModMask, xK_m), spawn "clipmenu"),
    ((shiftMask .|. myModMask, xK_p), spawn "dmenuunicode"),
    ((myModMask, xK_t), spawn "firefox"),
    ((myModMask, xK_p), spawn "thunar"),
    ((myModMask, xK_i), withWindowSet $ randomWallpaper myWallpaperConf nScreens),
    ((shiftMask .|. myModMask, xK_i), randomWallpapers myWallpaperConf nScreens),
    ((shiftMask .|. myModMask, xK_u), spawn "walw"),
    ((myModMask, xK_w), spawn "walc -s"),
    ((shiftMask .|. myModMask, xK_w), withWindowSet $ chooseWallpaperOnScreen myWallpaperConf nScreens),
    ((myModMask, xK_Return), spawn myTerminal),
    ((shiftMask .|. myModMask, xK_Return), spawn $ myTerminal ++ " -c floating"),

    -- Others
    ((noModMask, xF86XK_MonBrightnessDown), spawn "backlight-control dec"),
    ((noModMask, xF86XK_MonBrightnessUp), spawn "backlight-control inc"),
    ((noModMask, xF86XK_ScreenSaver), spawn "xscreensaver-command --lock"),
    ((noModMask, xF86XK_AudioMute), spawn "pulsemixer --toggle-mute"),
    ((noModMask, xF86XK_AudioMicMute), spawn "thinkpad-mutemic"),
    ((noModMask, xF86XK_AudioRaiseVolume), spawn "pulsemixer --change-volume +5"),
    ((noModMask, xF86XK_AudioLowerVolume), spawn "pulsemixer --change-volume -5")
  ]
    ++ wsKeys
  where
    focusNextScreen :: WindowSet -> WindowSet
    focusNextScreen ws =
      let currentScreenId = W.screen $ W.current ws
       in focusScreen ((currentScreenId + 1) `mod` nScreens) ws
    sendNextScreen :: WindowSet -> X ()
    sendNextScreen ws =
      let nextScreenId = (W.screen (W.current ws) + 1) `mod` nScreens
       in screenWorkspace nextScreenId >>= flip whenJust (windows . W.shift)
    wsKeys :: [((KeyMask, KeySym), X ())]
    wsKeys =
      [ ((mask .|. myModMask, k), windows $ onCurrentScreen f i)
        | (i, k) <- zip myWorkspaces [0x26, 0xe9, 0x22, 0x27, 0x28, 0x2d, 0xe8, 0x5f, 0xe7, 0xe0],
          (f, mask) <- [(W.greedyView, 0), (W.shift, shiftMask)]
      ]

myStartupHook :: X ()
myStartupHook =
  spawnOnce "$HOME/.fehbg" -- TODO: Load wallpapers on start too
    >> spawnOnce "xsetroot -cursor_name left_ptr"
    >> spawnOnce "setxkbmap -layout fr -variant azerty"
    >> spawnOnce "picom -fb"
    >> spawnOnce "xscreensaver &"
    >> spawnOnce "echo > Images/wallpapers/.wall-list"
    >> spawnOnce "xrdb ~/.config/X11/xresources"
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
                                          , className =? "discord"  --> doShift "κ"]
  where
    doFloat' :: ManageHook
    doFloat' = placeHook (smart (0.5, 0.5)) <+> doFloat

main :: IO ()
main = do
  nScreens <- countScreens
  xmobars <- sequence [statusBarPipe ("xmobar -x " ++ show i) . pure $ marshallPP si (myXmobarPP { ppExtras = [logLayoutOnScreen si, (xmobarColor "pink" "" . shorten 36) `onLogger` logTitleOnScreen si] }) | si@(S i) <- [0..nScreens-1]]
  xmonad . ewmh . ewmhFullscreen . docks . withSB (mconcat xmobars) $
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
