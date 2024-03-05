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
The qml type Map uses qt's sample code to display a map, initially centered over San Francisco. The dropdown changes the map view according to the selected city (New York City, London, Paris). The map can be panned and zoomed.
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

Application Infotainment01App is mostly qml with a c++ backend for populating various qml components. It was inspired by MontyTheSoftwareEngineer on YouTube (https://www.youtube.com/watch?v=Tq-E6lqO6tM&t=177s).

The main screen is separted into three areas, left, right, and bottom screens.

The bottom bar's temperature controls are controlled by class TemperatureCtrl.

BottomBar.qml references TempComponent.qml and UserAppsConsole.qml. UserAppsConsole.qml references UserApp.qml, functionally a button, which displays a specific app (browser, lucid-motors, apple-tv, npr, spotify) assigned to it. UserApp.qml shows how to create one qml component with desired behaviors and then how to reuse it by a parent component, thereby eliminating redundant code and easing code maintenance. Selecting any button with the browser displayed toggles the browser off and brings forward the map.

The right screen's upper controls (locking, outside temperature, current time, and user's name) are controlled by class SystemBar.

The c++ data is passed via QQmlContext::setContextProperty() as shown in main.cpp

Initial Infotainment screen:

![Vehicle_Infotainment_01](https://github.com/mystuff-us/Qt-QML/assets/160074491/1e0e92fa-b9a3-49d0-8b7c-8cc5a530275f)

Exercising the driver side temperature control:

![Vehicle_Infotainment_02](https://github.com/mystuff-us/Qt-QML/assets/160074491/652b1060-6de5-46cd-ae54-1caa623b1bb6)

Selecting the NPR button on the bottom-bar changes the right screen to display the npr website:

![Vehicle_Infotainment_03](https://github.com/mystuff-us/Qt-QML/assets/160074491/62b172bf-5b56-4bc5-b169-fff0b17099e7)

Typing a URL into the search box opens the URL in the browser window:

![Vehicle_Infotainment_04](https://github.com/mystuff-us/Qt-QML/assets/160074491/1ce9144c-6085-4226-94b9-f2bf11882744)


---------------------------------------


Application MusicPlayerApp is a simple audio playback application with an interface into Jamendo.com for playing online content. The application is inspired by Scythe Studio (https://www.youtube.com/@scythe-studio) and (https://github.com/scytheStudio).

MusicPlayer has a simple interface displaying a graphic associated with a composer, the composer's name and song, play controls, and a menu option to select songs or to search for online content.

The application exercises QMediaPlayer, QAbstractListModel, QNetworkAccessManager, in addition to core qt classes. QML widgets get their data from c++ using qmlRegisterSingletonInstance() as shown in main.cpp. See AudioSearchModel.cpp for the Jamendo.com interface.


The initial application screen:

![MusicPlayer_01](https://github.com/mystuff-us/Qt-QML/assets/160074491/f85fcd53-a4ff-403a-8cac-adec4290f99c)

Playing a song and switching to the next song:

![MusicPlayer_02](https://github.com/mystuff-us/Qt-QML/assets/160074491/a18bd9a2-d79a-4d49-91be-4ef7b55c5b5b)

The dropdown menu displaying available songs, and a "+" button to add online content:

![MusicPlayer_03](https://github.com/mystuff-us/Qt-QML/assets/160074491/451579ae-bdec-4238-b411-7db259755b41)

Entering "jazz" to search for online content from Jamendo.com:

![MusicPlayer_04](https://github.com/mystuff-us/Qt-QML/assets/160074491/64f5a145-a511-475a-b1db-870c85faf897)

The selected song is added to the list of available songs, and can be played:

![MusicPlayer_06](https://github.com/mystuff-us/Qt-QML/assets/160074491/0ad05d1d-8df7-459a-ab3b-dcf27a03f6e9)

The dropdown menu's playlist can be edited, removing songs by selecting the 'trash-can' icon:

![MusicPlayer_07](https://github.com/mystuff-us/Qt-QML/assets/160074491/4eebe602-82f7-4c37-bd4b-f8f6c95dcf8e)






---------------------------------------
