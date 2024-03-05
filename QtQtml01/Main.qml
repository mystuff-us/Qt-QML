import QtQuick
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Controls

// Another method is 'registering a type' (2)
import William 1.0

// QML has built in JavaScript engine to use all types,
// declaring functions in QML code,
Window {
  id: root

  width: 640
  height: 480
  visible: true
  color: "darkgray"
  title: qsTr("Qt/QML - Layouts, Signals/Slots")

  // A 2x2 layout
  GridLayout {
    anchors.fill: parent
    anchors.margins: 10 // space away from main window
    rows: 2
    columns: 2
    rowSpacing: 10 // space between the 2 rows
    columnSpacing: 10 // space between the 2 columns

    // Upper-left
    Item {
      id: item1

      Layout.fillWidth: true // sets the full width for use
      Layout.fillHeight: true // sets the full height for use

      // Simulate a button centered in the space
      Rectangle {
        id: button1

        // 'property' makes a type (color in this case) a global var
        property color baseColor: "steelblue" //"#FF5265"

        anchors {
          bottom: parent.verticalCenter
          horizontalCenter: parent.horizontalCenter
          bottomMargin: 20
        }
        // Dimensions of the button
        width: 150
        height: 40
        radius: 20 // rounds the rectangle's border

        // While capturing the mouse behavior on/off
        // this rectangle, set the Text id 'buttonText1'
        // to indicate what's happening.
        // Also, adjust the defined proprety 'baseColor'
        // of this rectangle based on the mouse behavior.
        color: if (buttonMouseArea1.containsPress) {
                 buttonText1.text = "Pressed"
                 return Qt.darker(baseColor)
               } else if (buttonMouseArea1.containsMouse) {
                 buttonText1.text = "Mouse over button"
                 //btn1_text.text = "Mouse over button"
                 return Qt.lighter(baseColor)
               } else {
                 buttonText1.text = "Click here to quit! (2)"
                 return baseColor
               }

        // The button's text, centered in the rounded rectangle.
        // Text changes with mouse changes.
        Text {
          id: buttonText1
          anchors.centerIn: parent
          text: "Click here to quit! (initial)"
        }

        // Capture mouse actions 'onClicked' and 'onHoverChanged'
        // for this button.
        MouseArea {
          id: buttonMouseArea1
          anchors.fill: parent
          hoverEnabled: true

          // Send message to Qt Creator's Application Output window,
          // and make button color change when clicked.
          onClicked: {
            console.log("Clicked in custom button...")
            button1.baseColor = "Orange"
          }
          onHoveredChanged: {
            console.log("Hover over custom button 2...")
            //button1.baseColor = "Yellow"
          }
        }
      }

      // Connect to above buttonMouseArea1 actions and note button
      // actions to Text below it (btn1_text).
      Connections {
        target: buttonMouseArea1

        function onClicked() {
          //Qt.quit()
          btn1_text.text
              = "OnClicked() Set btn1_text.text to this string. (Uncomment Qt.quit() to quit app.)"
        }
        function onHoveredChanged() {
          btn1_text.text = "On  H o v e r e d  C h a n g e d"
        }
        function onExited() {
          btn1_text.text = "On  E x i t e d"
        }
      }

      // A text message centered below the button that displays
      // messages from the above 'Connections'.
      Text {
        id: btn1_text
        text: "We'll put onClicked(), onHoveredChanged(), and onExited() button messages here."
        width: item1.width * 0.75
        //height: item1.height / 4
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WordWrap
        anchors {
          top: parent.verticalCenter
          horizontalCenter: parent.horizontalCenter
          topMargin: 0
        }
      }
    } // upper-left rectangular area

    // Upper-right rectangular area
    Item {
      id: upper_right

      Layout.fillWidth: true
      Layout.fillHeight: true

      RowLayout {
        id: btn_rect2

        anchors.fill: parent
        spacing: 0

        Rectangle {
          id: rectangle

          property bool iAmPretty: true
          property color greenish: "#a1a151"
          property color darkGreenish: Qt.darker("#a1a151")

          radius: 20

          Layout.fillWidth: true
          Layout.preferredHeight: 40
          //Layout.maximumWidth: 500
          //Layout.preferredWidth: 100
          color: mouseArea.containsPress ? darkGreenish : greenish

          Text {
            Layout.leftMargin: 20
            id: leftText
            anchors.verticalCenter: rectangle.verticalCenter
            color: Qt.lighter(rectangle.color)
            text: ""
            font.pixelSize: 20
          }

          //signal mySignal
          MouseArea {
            id: mouseArea
            anchors.fill: parent

            acceptedButtons: Qt.LeftButton | Qt.RightButton
            hoverEnabled: true

            // All slots are JavaScript functions
            onClicked: {
              console.log("Clicked 'mouseArea'...")
              // Change the main window's title
              btn_rect2.test_func1()
              leftText.text = "Clicked"
            }
            onPositionChanged: {
              console.log(
                    "PositionChanged 'mouseArea'..." + mouseArea.mouseX + "," + mouseArea.mouseY)
              //button1.baseColor = "Yellow"
              //root.title = "QtQtml - Layouts, Signals/Slots #2"
              leftText.text = mouseArea.mouseX + "," + mouseArea.mouseY
            }
            // onHoveredChanged: {
            //   console.log("HoveredChanged 'mouseArea'...")
            //   //button1.baseColor = "Yellow"
            //   //root.title = "QtQtml - Layouts, Signals/Slots #2"
            //   leftText.text = "Hovered"
            // }
            onEntered: {
              console.log("Entered 'mouseArea'...")
              //button1.baseColor = "Yellow"
              root.title = "QtQtml - Layouts, Signals/Slots #2"
              leftText.text = "Entered"
            }
            onExited: {
              console.log("Exited 'mouseArea'...")
              //button1.baseColor = "Yellow"
              //root.title = "QtQtml - Layouts, Signals/Slots #2"
              leftText.text = "Exited"
            }
          } // MouseArea
        } // Rectangle

        // Example function - call using 'btn_rect2.test_func1()'
        function test_func1() {
          // Set the main window's title
          root.title = "Message: Pressed btn_rect2 - mouseArea.onClicked()"
        }
      }

      // Another method is 'registering a type' (2)
      // SomeClass is created when this page is created HoverHandler
      // destroyed when this page is destroyed.
      SomeClass {
        id: myClass
      }

      // Another way to expose a variable / function of SomeClass to QML (4)
      // Need to add a Connections
      Connections {
        target: myClass

        // The following syntax is deprecated:
        //onSomeVarChanged: myLabel.text = myClass.getSomeVar()
        function onSomeVarChanged() {
          myLabel.text = myClass.getSomeVar()
        }
      }

      Button {
        id: myButton
        anchors.centerIn: parent
        text: "Click Me"

        // Most common way is through using context properties (1)
        //onClicked: classA.callMe()

        // Another method is 'registering a type' (2)
        //onClicked: myClass.callMe()
        // Uses function called from Q_INVOKEABLE in SomeClass
        //onClicked: myClass.anotherFunction();

        // (3)
        onClicked: myClass.setSomeVar(" e C I O s")
      }

      // (3)
      Text {
        id: myLabel
        Layout.fillWidth: true
        anchors {
          //horizontalCenter: parent
          horizontalCenter: parent.horizontalCenter
          top: parent.top
          topMargin: 20
        }
        font.pixelSize: 24
        // (3)
        //text: myClass.someVar

        // Another way to expose a variable / function of SomeClass to QML (4)
        text: myClass.getSomeVar()
      }
    } // upper-right cell

    // Bottom-left cell
    // Four rectangles
    Item {
      Layout.fillWidth: true
      Layout.fillHeight: true

      GridLayout {
        anchors.fill: parent
        rows: 2
        columns: 2
        rowSpacing: 5
        columnSpacing: 5

        Rectangle {
          Layout.fillWidth: true
          Layout.fillHeight: true
          width: 5
          height: 5
          x: 5
          y: 5
          radius: 2
          color: "lightblue"
        }
        Rectangle {
          Layout.fillWidth: true
          Layout.fillHeight: true
          color: Qt.darker("lightblue")
        }
        Rectangle {
          Layout.fillWidth: true
          Layout.fillHeight: true
          color: Qt.darker("lightblue")
        }
        Rectangle {
          Layout.fillWidth: true
          Layout.fillHeight: true
          color: "#a1a151"
        }
      }
    }

    // Bottom right quadrant of main window.
    // Contains as many as 25 rounded rectangles
    // based on the space of this rectangle in
    // relationship to the size of the main window.
    Item {
      // bottom-right cell
      id: btn_right
      Layout.fillWidth: true
      Layout.fillHeight: true

      // Places rectangles within the cell based
      // on the size of the main window.
      Flow {
        anchors.fill: parent
        anchors.margins: 5
        spacing: 10
        flow: Flow.TopToBottom // leftover is on right; default is bottom

        Repeater {
          //id: repeat
          model: 15 // repeat 15 rectangles/circles
          clip: true

          Rectangle {
            //Layout.fillWidth: true
            width: 80
            height: 80
            radius: 40
            color: "orange"
          }

          // Am considering how to remove Rectangles that
          // display beyond the right window boundary.
          property int remaining_width: 0
          onItemAdded: function (index, it) {
            remaining_width = (root.width / 2) - (it.width * (index - 1))
            console.log("Added: " + index + " w: " + remaining_width)
            //console.log("width: " + it.width)
            it.visible = remaining_width >= 0
            // if (remaining_width < 0)
            //   //index > 5)
            //   it.visible = false
            // else
            //   it.visible = true
          }
        }
      }
    }
  }
}
