# Qt-QML
 Qt QML Examples

---------------------------------------

Application Infotainment01App is a QML app with a c++ backend for populating various qml components. It was inspired by MontyTheSoftwareEngineer (https://www.youtube.com/watch?v=Tq-E6lqO6tM&t=177s).

The main screen is separted into three areas, left, right, and bottom screens.

The bottom bar's temperature controls are controlled via class TemperatureCtrl.

BottomBar.qml references TempComponent.qml and UserAppsConsole.qml. UserAppsConsole.qml references UserApp.qml, functionally a button that displays a specific app (browser, lucid-motors, apple-tv, npr, spotify) assigned to it. UserApp.qml shows how to create one qml component with desired behaviors and then how to reuse it by a parent component, thereby eliminating redundant code and easing code maintenance. Selecting any button with the browser displayed toggles the browser off and brings forward the map.

The right screen's upper controls (locking, outside temperature, current time, and user's name) are controlled by class SystemBar. The contols should change or hide when the browser is active, but they don't.

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
