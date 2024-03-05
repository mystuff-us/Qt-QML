import QtQuick

Rectangle {
  id: navSearchBox

  //property string url_text: ""
  color: "#f0f0f0"
  radius: 5

  // <a href="https://www.flaticon.com/free-icons/search" title="search icons">Search icons created by Taufik - Flaticon</a>
  Image {
    id: searchIcon
    anchors {
      left: parent.left
      leftMargin: 15
      verticalCenter: parent.verticalCenter
    }
    height: parent.height * 0.45
    fillMode: Image.PreserveAspectFit
    source: "qrc:/qt/qml/content/assets/search.png"
  }

  Text {
    id: navPlaceholderText
    visible: navTextInput.text === ""
    anchors {
      left: searchIcon.right
      leftMargin: 20
      verticalCenter: parent.verticalCenter
    }
    color: "gray"
    font.family: "OpenSans"
    font.pixelSize: 16
    opacity: 80
    text: "Web Navigation"
  }

  TextInput {
    id: navTextInput
    anchors {
      top: parent.top
      bottom: parent.bottom
      right: parent.right
      left: searchIcon.right
      leftMargin: 20
    }
    verticalAlignment: Text.AlignVCenter
    color: "slateblue"
    font.family: "OpenSans"
    font.pixelSize: 16
    clip: true
    onAccepted: {
      var url_text = text
      if (text.startsWith("https://") === false) {
        url_text = "https://" + text
      }
      //console.log("URL: text: >" + text + "< url_text: >" + url_text + "<")
      right_screen.show_web = true
      right_screen.show_map = false
      right_screen.web_url = url_text
    }
  }
}
