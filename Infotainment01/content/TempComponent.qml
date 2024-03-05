import QtQuick
import QtQuick.Controls

// TBD:
//  - The increase/decrease buttons are similar and can be made components.
// Temperature Component
//  This is a temperature component made up of a left and right buttons with
//  the temperature value displayed between them.
Item {
  id: temp_root

  // Temperature component globals
  property string fontColor: "White"
  property string btnColor: "SlateGray"
  property int btnWidth: 20
  property int rectMargin: 6
  property int btnMargin: 6
  property int btnRadius: 4
  property string borderColor: Qt.lighter("SlateGray")
  property string grad2Color: "LightSteelBlue"
  property string tool_tip_up: "Increase Temperature"
  property string tool_tip_down: "Lower Temperature"

  //property int pixelSize: 24

  // One TempControls object, assigned when this QML type
  // is used, like this:
  // TempComponent {
  //   id: control01
  //   // Referenced in main.cpp using, for example:
  //   //  context->setContextProperty("driver_temp", &m_driverTemp);
  //   tempController: driver_temp
  //   ...
  // }
  property var tempController

  //width: 96
  //implicitWidth: 96
  width: (btnWidth * 2) + (decText.width + incText.wdith) + tempText.width + 30

  // Temperature control has a border around two buttons and the text.
  Rectangle {
    id: border1

    color: bottomBar.color
    border.color: borderColor
    border.width: 1
    width: temp_root.width
    height: parent.height - rectMargin
    radius: btnRadius
    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter

    Rectangle {
      id: decTempButton
      anchors {
        left: border1.left
        top: border1.top
        bottom: border1.bottom
        margins: btnMargin
      }
      radius: btnRadius
      width: btnWidth
      color: btnColor

      gradient: Gradient {
        GradientStop {
          id: gradient1
          position: 0.0
          color: grad2Color
        }
        GradientStop {
          id: gradient2
          position: 1.0
          color: btnColor
        }
      }

      Text {
        id: decText
        //anchors.centerIn: parent
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        color: fontColor
        text: "<"
        font.pixelSize: parent.height * 0.50
      }
      MouseArea {
        anchors.fill: parent
        hoverEnabled: true // required for tooltip display
        onHoveredChanged: {
          ToolTip.show(tool_tip_up, 1000)
        }
        onClicked: {
          tempController.incrementTargetTemp(-1)
        }
        onPressed: {
          gradient1.color = Qt.lighter(grad2Color)
          gradient2.color = Qt.lighter(btnColor)
        }
        onReleased: {
          gradient1.color = grad2Color
          gradient2.color = btnColor
        }
      }
    }

    Text {
      id: tempText
      anchors {
        left: decTempButton.right
        leftMargin: 10
        rightMargin: 10
        verticalCenter: parent.verticalCenter
      }
      font.pixelSize: parent.height * 0.8
      color: fontColor
      font.family: "OpenSans"
      text: tempController.targetTemp
    }

    Rectangle {
      id: incTempButton
      anchors {
        left: tempText.right
        top: border1.top
        bottom: border1.bottom
        margins: btnMargin
      }
      radius: btnRadius
      width: btnWidth
      color: btnColor

      gradient: Gradient {
        GradientStop {
          id: gradient3
          position: 0.0
          color: grad2Color
        }
        GradientStop {
          id: gradient4
          position: 1.0
          color: btnColor
        }
      }

      Text {
        id: incText
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        color: fontColor
        text: ">"
        font.pixelSize: parent.height * 0.50
      }
      MouseArea {
        anchors.fill: parent
        hoverEnabled: true // required for tooltip display
        onHoveredChanged: {
          ToolTip.show(tool_tip_down, 1000)
        }
        onClicked: {
          tempController.incrementTargetTemp(1)
        }
        onPressed: {
          gradient3.color = Qt.lighter(grad2Color)
          gradient4.color = Qt.lighter(btnColor)
        }
        onReleased: {
          gradient3.color = grad2Color
          gradient4.color = btnColor
        }
      }
    }
  }
}
