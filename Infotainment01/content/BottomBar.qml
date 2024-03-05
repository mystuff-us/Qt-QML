import QtQuick
import QtQuick.Layouts

// Bottombar component
//  This widget sits on the bottom of the screen and represents
//  a control bar for driver/passenger side temperatures, and an
//  application console for browsing user desired websites.
//  The bottombar attempts to adjust its children based on
//  the width of the bar. (It's not fully implemented.)
//  The height of the bottombar is 6% of the height of the
//  main window - which isn't a good idea for a window
//  that can change size.
Rectangle {
  id: bottomBar

  property int btnRadius: 4
  property int rectMargin: 6

  anchors {
    left: parent.left
    right: parent.right
    bottom: parent.bottom
  }
  height: parent.height * 0.06
  color: "LightSlateGray"

  Flow {
    id: flow_root

    anchors.fill: parent
    anchors.margins: 2
    spacing: ((parent.width - (tile1.width + driverTempControl.width + appConsole.width
                               + passengerTempControl.width)) / 3) - 2
    layoutDirection: Qt.LeftToRight

    Rectangle {
      id: tile1

      color: bottomBar.color
      width: carSettingsIcon.width
      height: bottomBar.height * 0.9

      // Image attribution:
      // <a href="https://www.flaticon.com/free-icons/cars" title="cars icons">Cars icons created by Lizel Arina - Flaticon</a>
      Image {
        id: carSettingsIcon
        height: bottomBar.height * 0.9
        fillMode: Image.PreserveAspectFit
        source: "qrc:/qt/qml/content/assets/whitecar64x64_01.png"
      }
    }

    TempComponent {
      id: driverTempControl
      tempController: driver_temp
      implicitWidth: 96
      height: bottomBar.height * 0.9
      tool_tip_up: "Increase Driver side temperature"
      tool_tip_down: "Lower Driver side temperature"
    }

    UserAppsConsole {
      id: appConsole
      width: 390
      height: bottomBar.height * 0.9
    }

    TempComponent {
      id: passengerTempControl
      tempController: passenger_temp
      implicitWidth: 96
      height: bottomBar.height * 0.9
      tool_tip_up: "Increase Passenger side temperature"
      tool_tip_down: "Lower Passenger side temperature"
    }
  }
}
