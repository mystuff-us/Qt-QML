import QtQuick
import QtQuick.Layouts
import Infotainment01

Item {
  id: root

  // Globals - better placed in Constants.qml?
  property int rectMargin: 3
  property int btnMargin: 3
  property int btnRadius: 4
  property string btnColor: "#6C7B89"
  property string borderColor: Qt.lighter("SlateGray")
  property string gradientColor: "LightSteelBlue"

  width: 390

  Rectangle {
    color: bottomBar.color
    border.color: borderColor
    border.width: 1
    width: root.width
    height: parent.height - rectMargin
    radius: btnRadius
    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter

    Flow {
      id: flow1
      anchors.fill: parent
      anchors.margins: btnMargin
      spacing: 40

      // Temporary rectangle used to determine the width of this component
      // Outputs:  qml: 299.200
      // Rectangle {
      //   anchors {
      //     left: app1.left
      //     right: app6.right
      //   }
      //   //Component.onCompleted: console.log("UserAppsConsole.width = " + width)
      //   //Component.onCompleted: console.log(parent.width)
      // }
      UserApp {
        id: app01
        width: parent.height // height
        height: parent.height
        tool_tip: "Browser"
        img_source: "qrc:/qt/qml/content/assets/Franksouza183-Fs-Apps-firefox.64.png"
        url: "https://www.mozilla.org/en-US/"
      }

      UserApp {
        id: app02
        width: parent.height
        height: parent.height
        tool_tip: "Lucid"
        img_source: "qrc:/qt/qml/content/assets/lucid-motors-logo.jpg"
        url: "https://www.lucidmotors.com/"
      }

      UserApp {
        id: app03
        width: parent.height // height
        height: parent.height
        tool_tip: "Apple TV"
        img_source: "qrc:/qt/qml/content/assets/apple-tv.png"
        url: "https://tv.apple.com/"
      }

      UserApp {
        id: app04
        width: parent.height // height
        height: parent.height
        tool_tip: "NPR"
        img_source: "qrc:/qt/qml/content/assets/NPR.png"
        url: "https://www.npr.org/"
      }

      UserApp {
        id: app05
        width: parent.height // height
        height: parent.height
        tool_tip: "Spotify"
        img_source: "qrc:/qt/qml/content/assets/spotify-2.png"
        url: "https://www.spotify.com/"
      }

      UserApp {
        id: app06
        width: parent.height // height
        height: parent.height
        tool_tip: "Qt"
        img_source: "qrc:/qt/qml/content/assets/qtlogo.png"
        url: "https://doc.qt.io/qt-6/"
      }
    }
  }
}
