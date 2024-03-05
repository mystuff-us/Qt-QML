import QtQuick
import QtQuick.Controls
import Infotainment01

// This defines the main window, made up of:
//  - a left screen that displays the vehicle
//  - a right screen that displays a map or browser url
//  - a bottom bar that displays temperature controls and
//    user apps that set the browser url.
ApplicationWindow {
  id: main_win

  width: mainScreen.width
  height: mainScreen.height

  visible: true
  title: "Vehicle Infotainment Center"

  Screen01 {
    id: mainScreen
  }

  LeftScreen {
    id: leftScreen
  }

  RightScreen {
    id: right_screen
  }

  BottomBar {
    id: bottomBar
  }
}
