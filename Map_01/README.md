# Qt-QML
 Qt QML Examples


Application Map 01 is a c++ application but interfaces with a qml component to display the map. It uses standard qt widgets (QWidget, QComboBox, QLabel, QPushButton and one qml widget, QQuickWidget.

Map 01 displays a map using QWebEngineView in a QQuickWidget, and a web page in a QWidget tied to the QML component map.qml.

The map uses qt's sample code to display a map, initially centered over San Francisco. The dropdown changes the map view according to the selected city (New York City, London, Paris). The map can be panned and zoomed.

As the dialog resizes the qml component displaying the map is resized via Q_PROPERTY() of MainWindow.h and MainWindow::resizeEvent().

The map's position, and an overlaid qml Text type displaying the latitude and longitude of the map center and the city name, are updated within MainWindow.cpp using QQuickItem::setProperty().

The map and web page viewer are placed on top of one another in the dialog and toggled on/off (show(), hide()) depending on which should be displayed.

Initial Screen:

![Initial_Map_screen](https://github.com/mystuff-us/Qt-QML/assets/160074491/91a01038-c85f-446a-812f-469435b0c428)

Dropdown changed to NYC and dialog resized:

![DropdownChange_to_NYC](https://github.com/mystuff-us/Qt-QML/assets/160074491/5c30f0ee-aab5-4b6d-a09d-b3fce591b840)

Website button pressed:

![ViewWebsite_button_press](https://github.com/mystuff-us/Qt-QML/assets/160074491/a555184a-9645-4b46-a619-5db520130c39)


---------------------------------------
