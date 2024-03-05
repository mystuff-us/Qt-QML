import QtQuick
import QtQuick.Controls

Item {
  id: user_app

  property int btnRadius: 4
  property string btnColor: "#6C7B89"
  property string gradientColor: "LightSteelBlue"
  property string img_source: "qrc:/qt/qml/content/assets/search.png"
  property string tool_tip: "Browser"
  property string url: "https://www.google.com/"

  Rectangle {
    id: app1
    radius: btnRadius
    width: parent.height
    height: parent.height
    color: btnColor

    gradient: Gradient {
      GradientStop {
        id: gradStop1
        position: 0.0
        color: gradientColor
      }
      GradientStop {
        id: gradStop2
        position: 1.0
        color: btnColor
      }
    }

    Image {
      id: app1_img
      anchors.verticalCenter: parent.verticalCenter
      anchors.horizontalCenter: parent.horizontalCenter

      height: parent.height * 0.94
      width: parent.height * 0.94
      opacity: btnMouseArea.containsMouse ? 0.5 : 1.0
      fillMode: Image.PreserveAspectFit

      // TBD: provide image attribution ...
      // https://www.iconarchive.com/show/fs-icons-by-franksouza183/Apps-firefox-icon.html
      //source: "qrc:/qt/qml/content/assets/Franksouza183-Fs-Apps-firefox.64.png"
      source: img_source
    }

    MouseArea {
      id: btnMouseArea
      anchors.fill: parent
      hoverEnabled: true // required for tooltip display
      onHoveredChanged: {
        ToolTip.show(tool_tip, 1000)
      }
      // Pressing the button changes its look and toggles
      // between viewing the map and website url
      onPressed: {
        gradStop1.color = Qt.lighter(gradientColor)
        gradStop2.color = Qt.lighter(btnColor)

        right_screen.web_url = url
        right_screen.show_map = !right_screen.show_map
        right_screen.show_web = !right_screen.show_web
      }
      // Releasing the button changes the look slightly
      onReleased: {
        gradStop1.color = gradientColor
        gradStop2.color = btnColor
      }
    }
  }
}
