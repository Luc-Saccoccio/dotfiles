import Xmobar

config :: Config
config =
  defaultConfig
    { font = "SpaceMono Nerd Font Regular 11",
      additionalFonts = ["monospace 11"],
      bgColor = "#000000",
      fgColor = "#afd75f",
      position = Top,
      lowerOnStart = True,
      hideOnStart = False,
      allDesktops = True,
      persistent = True,
      iconRoot = "/home/luc/Images/xpm/",
      commands =
        [ Run $ Date "%a %d %b %H:%M" "date" 10,
          Run $ Wireless "wlp3s0" ["-t", "net <quality>", "-S", "True"] 10,
          Run $ Cpu ["-t", "cpu <total>%", "-H", "50", "--high", "red"] 10,
          Run $ Memory ["-t", "mem <usedratio>%"] 10,
          Run $ DiskU [("/", "root <usedbar> (<free>)")] [] 360,
          Run $ Volume "default" "Master" ["-t", "vol <volume>% <status>"] 10,
          Run $ BatteryP ["BAT0"] ["-t", "bat <left>%"] 10,
          Run StdinReader
        ],
      -- , sepChar = "%"
      alignSep = "}{",
      template = "<icon=haskell.xpm/> %StdinReader% }{ <fc=#FF4143>%wlp3s0wi%</fc> <fc=#ffff5f>%cpu%</fc> <fc=#ff5f87>%memory%</fc> <fc=#87afd7>%disku%</fc> <fc=#6FD599>%default:Master%</fc> %battery% <fc=#afd75f>%date%</fc> "
    }

main :: IO ()
main = configFromArgs config >>= xmobar
