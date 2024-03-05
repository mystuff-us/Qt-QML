import QtQuick
import QtQuick.Controls
import QtLocation
import QtPositioning
import QtWebEngine

// The right-screen displays either a map or a browser url.
// It also overlays:
//  - a console lock, time, temperature, and username
//  - a map navigation input widget
// Below this screen are buttons that set the browser url.
// If the browser is displayed, picking a button toggles
// the map into view - and visa versa.
// The map can be panned and zoomed. As of yet there is no
// navigation or location entry enabled.
Rectangle {
  id: rightScreen

  // Globals
  property string textColor: "White"
  property int text_size: 18
  property string font_family: "OpenSans"
  // San Francisco
  property double prev_lat: 37.755514
  property double prev_lng: -122.497589

  property bool show_web: false
  property bool show_map: true
  property string web_url: "https://www.lucidmotors.com/"

  anchors {
    top: parent.top
    bottom: bottomBar.top
    right: parent.right
  }
  width: parent.width * 2 / 3

  WebEngineView {
    id: web_view
    visible: show_web
    anchors.fill: parent
    url: web_url

    //onNewWindowRequested: function (request) {}

    // Check if entered web page can't load.
    // On failure, displays ERR_NAME_NOT_RESOLVED screen
    onLoadingChanged: function (load_info) {
      if (load_info.status === WebEngineView.LoadFailedStatus) {
        console.log("... onLoadingChanged()\nError: " + load_info.errorString)
        console.log(">>> Web page load failed for: " + load_info.url + "\n")
        // We could provide an error msg and then display search screen.
        //web_url = "https://www.google.com/"
      }
    }
    //onRenderProcessTerminated: {}
  }

  Plugin {
    id: mapPlugin
    name: "osm" // "osm" or "mapboxgl" or "esri"

    // These plugin parameters eliminate the following console runtime messages:
    //  QGeoTileProviderOsm: Tileserver disabled at  QUrl("http://maps-redirect.qt.io/osm/5.8/satellite")
    //  QGeoTileFetcherOsm: all providers resolved
    PluginParameter {
      name: "osm.mapping.providersrepository.disabled"
      value: "true"
    }
    // PluginParameter {
    //   name: "osm.mapping.providersrepository.address"
    //   value: "http://maps-redirect.qt.io/osm/5.6/"
    // }
  }

  Map {
    id: map
    visible: show_map
    anchors.fill: parent
    plugin: mapPlugin
    center: QtPositioning.coordinate(prev_lat, prev_lng)
    zoomLevel: 13
    property geoCoordinate startCentroid

    PinchHandler {
      id: pinch
      target: null
      onActiveChanged: if (active) {
                         map.startCentroid = map.toCoordinate(
                               pinch.centroid.position, false)
                       }
      onScaleChanged: delta => {
                        map.zoomLevel += Math.log2(delta)
                        map.alignCoordinateToPoint(map.startCentroid,
                                                   pinch.centroid.position)
                      }
      onRotationChanged: delta => {
                           map.bearing -= delta
                           map.alignCoordinateToPoint(map.startCentroid,
                                                      pinch.centroid.position)
                         }
      grabPermissions: PointerHandler.TakeOverForbidden
    }

    WheelHandler {
      id: wheel
      // workaround for QTBUG-87646 / QTBUG-112394 / QTBUG-112432:
      // Magic Mouse pretends to be a trackpad but doesn't work with PinchHandler
      // and we don't yet distinguish mice and trackpads on Wayland either
      acceptedDevices: Qt.platform.pluginName === "cocoa"
                       || Qt.platform.pluginName
                       === "wayland" ? PointerDevice.Mouse
                                       | PointerDevice.TouchPad : PointerDevice.Mouse
      rotationScale: 1 / 120
      property: "zoomLevel"
    }

    DragHandler {
      id: drag
      target: null
      onTranslationChanged: delta => map.pan(-delta.x, -delta.y)
      //console.log("onTranslationChanged")
      // onGrabChanged: {
      //   console.log("onGrabChanged")
      // }
    }
    Shortcut {
      enabled: map.zoomLevel < map.maximumZoomLevel
      sequence: StandardKey.ZoomIn
      onActivated: map.zoomLevel = Math.round(map.zoomLevel + 1)
    }
    Shortcut {
      enabled: map.zoomLevel > map.minimumZoomLevel
      sequence: StandardKey.ZoomOut
      onActivated: map.zoomLevel = Math.round(map.zoomLevel - 1)
    }
  }

  // function setCenter(lat, lng) {
  //   map.pan()
  // }

  // PositionSource {
  //   id: positionSource
  //   //name: root.simulation ? "nmea" : ""
  //   onPositionChanged: {
  //     let posData = position.coordinate.toString().split(", ")
  //     //positionBox.latitudeString = posData[0]
  //     //positionBox.longitudeString = posData[1]
  //     map: QtPositioning.coordinate(37.755514 + posData[0],
  //                                       -122.497589 + posData[1])
  //   }
  // }

  // <a href="https://www.flaticon.com/free-icons/padlock" title="padlock icons">Padlock icons created by DinosoftLabs - Flaticon</a>
  Image {
    id: lockIcon
    anchors {
      left: parent.left
      top: parent.top
      margins: 5
    }
    width: parent.width / 30
    fillMode: Image.PreserveAspectFit
    source: (sys_bar.carLocked ? "qrc:/qt/qml/content/assets/lock64x64.png" : "qrc:/qt/qml/content/assets/unlock64x64.png")

    MouseArea {
      anchors.fill: parent
      hoverEnabled: true // required for tooltip display
      onHoveredChanged: {
        ToolTip.show("Lock/Unlock Screen\nNeeds better image", 1000)
      }
      onClicked: sys_bar.setCarLocked(!sys_bar.carLocked)
    }
  }

  Text {
    id: dateTimeDisplay
    anchors {
      left: lockIcon.right
      leftMargin: 40
      bottom: lockIcon.bottom
    }
    font.pixelSize: text_size
    color: textColor
    font.family: font_family
    text: sys_bar.curTime
  }

  Text {
    id: tempDisplay
    anchors {
      left: dateTimeDisplay.right
      leftMargin: 40
      bottom: lockIcon.bottom
    }
    font.pixelSize: text_size
    font.family: font_family
    color: textColor

    text: sys_bar.temp + "°F"
  }

  Text {
    id: nameDisplay
    anchors {
      left: tempDisplay.right
      leftMargin: 40
      bottom: lockIcon.bottom
    }
    font.pixelSize: text_size
    font.family: font_family
    color: textColor

    text: sys_bar.userName
  }

  NavigationSearchBox {
    id: navSearchBox
    anchors {
      left: lockIcon.left
      top: lockIcon.bottom
      topMargin: 15
    }
    width: parent.width * 0.4
    height: parent.height * 1 / 14
  }
}
