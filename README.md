# Qt-QML
 Qt QML Examples

Application QtQtml01 is a simple Qt QML app that exercises some basic qml components (GridLayout, Item, Rectangle, Text, MouseArea, Connections, RowLayout, Button, Flow, and Repeater) and exposes a c++ object to qml components that get/set the c++ object.

The app also uses one of three methods for exposing c++ objects to qml - registering a type. This is done by:

1) In SomeClass.h expose a variable or preferrably a function to QML by using Q_INVOKABLE, for example:
   Q_INVOKABLE QString getSomeVar();
2) In SomeClass.h define a public: or protected: slot to set the value of the SomeClass variable from qml, for example:
   protected slots:
   void setSomeVar(QString var);
3) #include "someclass.h" in main.cpp
4) add "qmlRegisterType<SomeClass>("William", 1, 0, "SomeClass");" after QtGuiApplication is defined and before QQmlApplicationEngine is QObject::connect(...). Now the class SomeClass can be referenced as module named "William 1.0"
5) Then "import William 1.0" in Main.qml
6) For the qml widgets in Main.qml that use class SomeClass, add "SomeClass{ id: myClass } so they can reference the class using the 'id'.
7) To use the Q_INVOKABLE function 'getSomeVar()' use:
   Text { ...
     text: myClass.getSomeVar()
   }
8) To use the slot 'setSomeVar(QString)' use:
   myClass.setSomeVar("Some string value")

![QtQml01_app_image](https://github.com/mystuff-us/Qt-QML/assets/160074491/8af6f150-4df3-42be-be23-cd782037902b)


---------------------------------------


Application Map 01 is c++ at its core but interfaces with a qml component. It uses standard qt widgets (QWidget, QComboBox, QLabel, QPushButton and one qml widget (QQuickWidget).
Map 01 displays a map using QWebEngineView in a QQuickWidget, and a web page in a QWidget.
The qml type Map uses qt's sample code to display a map, initially centered over San Francisco. The dropdown changes the map view according to the selected city (New York City, London, Paris).
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
