pragma ComponentBehavior

import QtQuick
import QtLocation
import QtPositioning
import QtQuick.Controls

//import WinHelper 2.0
Rectangle {
  id: root
  visible: true

  // San Francisco
  property double prev_lat: 37.755514
  property double prev_lng: -122.497589
  property int the_width: 350
  property int the_height: 250

  //required property string msg
  property string msg: "Unassigned"

  // WindowHelper {
  //   id: main_win
  // }

  // // Another way to expose a variable / function of SomeClass to QML (4)
  // // Need to add a Connections
  // Connections {
  //   target: main_win

  //   function onWidthChanged() {
  //     root.width = main_win.get_width()
  //   }
  //   function onHeightChanged() {
  //     root.height = main_win.get_height()
  //   }
  // }
  width: /*main_win.win_width()*/ the_width
  height: /*main_win.win_height()*/ the_height
  color: "SteelBlue"

  Plugin {
    id: mapPlugin
    name: "osm"
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
    visible: true
    anchors.fill: parent
    anchors.centerIn: parent
    anchors.margins: 2
    width: 300
    height: 200
    plugin: mapPlugin
    // London
    //center: QtPositioning.coordinate(25.6585, 125.3658)
    // San Francisco
    //center: QtPositioning.coordinate(37.755514, -122.497589)
    center: QtPositioning.coordinate(prev_lat, prev_lng)
    zoomLevel: 15
    property geoCoordinate startCentroid

    PinchHandler {
      id: pinch
      target: null
      onActiveChanged: if (active) {
        map.startCentroid = map.toCoordinate(pinch.centroid.position, false)
        //console.log(">>> onActiveChanged()")
      }
      onScaleChanged: delta => {
        map.zoomLevel += Math.log2(delta)
        map.alignCoordinateToPoint(map.startCentroid, pinch.centroid.position)
        //console.log(">>> onScaleChanged()")
      }
      onRotationChanged: delta => {
        map.bearing -= delta
        map.alignCoordinateToPoint(map.startCentroid, pinch.centroid.position)
        //console.log(">>> onRotationChanged()")
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
      // onWheel: {
      //   console.log(">>> WheelHandler::onWheel()")
      // }
      //   onGrabChanged: {
      //     console.log("WheelHandler::onGrabChanged")
      //   }
    }
    DragHandler {
      id: drag
      target: null
      onTranslationChanged: delta => {
        map.pan(-delta.x, -delta.y)
        //console.log(">>> DragHandler::onTranslationChanged()")
      }
      // onGrabChanged: {
      //   console.log(">>> DragHandler::onGrabChanged()")
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
    // MouseArea {
    //   id: mouseBtn
    //   anchors.fill: parent
    //   hoverEnabled: true // required for tooltip display
    //   onHoveredChanged: {
    //     console.log(">>> MouseArea::onHoveredChanged()")
    //   }
    //   onPressed: {
    //     console.log(">>> MouseArea::onPressed()")
    //   }
    // }
  }

  Text {
    id: my_text
    anchors.centerIn: parent
    color: "LightSlateGray"

    font.pixelSize: 32
    font.family: "OpenSans"
    text: root.msg
  }

  // MouseArea {
  //   id: resize
  //   anchors {
  //     right: parent.right
  //     bottom: parent.bottom
  //   }
  // }
}
