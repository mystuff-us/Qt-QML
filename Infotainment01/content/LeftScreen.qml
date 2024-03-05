import QtQuick
import QtQuick.Controls

Rectangle {
  id: leftScreen

  property bool old_show_web: right_screen.show_web
  property bool old_show_map: right_screen.show_map
  property string old_url: "https://www.lucidmotors.com/"

  anchors {
    top: parent.top
    bottom: bottomBar.top
    left: parent.left
    right: right_screen.left
  }
  //width: parent.width * 1 / 3
  color: "white"

  Button {
    id: attribBtn
    anchors {
      bottom: leftScreen.bottom
      margins: 20
      horizontalCenter: parent.horizontalCenter
    }
    opacity: 0.3
    onClicked: popup.open()
    text: "Image Attribution ..."
  }

  Popup {
    id: popup
    // place popup centered above button
    anchors.centerIn: parent
    topMargin: leftScreen.height * 0.65
    width: 270
    height: 150
    modal: true
    focus: true
    onOpened: {
      old_show_web = right_screen.show_web
      old_show_map = right_screen.show_map
      old_url = right_screen.web_url
    }
    onClosed: {
      right_screen.show_web = old_show_web
      right_screen.show_map = old_show_map
      right_screen.web_url = old_url
    }
    enter: Transition {
      NumberAnimation {
        property: "opacity"
        from: 0.0
        to: 0.7
      }
    }
    exit: Transition {
      NumberAnimation {
        property: "opacity"
        from: 0.7
        to: 0.0
      }
    }
    // redundant
    //closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent | Popup.CloseOnPressOutside
    Text {
      anchors.centerIn: parent
      textFormat: Text.RichText
      //wrapMode: Text.WrapAnywhere
      text: "<h2>Car image attributed to:</h2> <a href= https://www.istockphoto.com/portfolio/Vladimiroquai?mediatype=photography><h4>Vladimiroquai</h4></a> <i>https://www.istockphoto.com/portfolio/</i><br><i>Vladimiroquai?mediatype=photography</i>"
      // mouse pressed within text is required for url to display
      MouseArea {
        anchors.fill: parent
        onPressed: {
          right_screen.web_url
              = "https://www.istockphoto.com/portfolio/Vladimiroquai?mediatype=photography"
          right_screen.show_map = !right_screen.show_map
          right_screen.show_web = !right_screen.show_web
        }
      }
    }
  }

  Image {
    id: carRender
    anchors.centerIn: parent
    width: parent.width * 0.9
    fillMode: Image.PreserveAspectFit
    source: "qrc:/qt/qml/content/assets/CarWhiteBackground.png"
    MouseArea {
      anchors.fill: parent
      hoverEnabled: true // required for tooltip display
      onHoveredChanged: {
        ToolTip.show("TBD: Add dashboard controls", 2000)
      }
    }
  }
}
