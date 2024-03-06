# Qt-QML
 Qt QML Examples

Contained within are Qt QML examples, Map_01 is a C++ application that interfaces with a QML widget, and Infotainment01, MusicPlayer, and QtQtml01 are QML applications that interface with C++ objects.

See each application's README.md for more details.

The applications were created using Qt Creator 12.02 on Windows 11, Qt version 6.6.1, and either MinGW or MSVC2019 compilers.

---------------------------------------

Application QtQtml01 is a simple Qt QML application that exercises some basic QML components and exposes a c++ object to those QML components.

The application also uses one of three methods for exposing c++ objects to QML - registering a type.


![QtQml01_app_image](https://github.com/mystuff-us/Qt-QML/assets/160074491/8af6f150-4df3-42be-be23-cd782037902b)


---------------------------------------


Application Map 01 is a c++ application that interfaces with a qml component - a map. It uses standard qt widgets and one qml widget.

The dropdown changes the map view according to the selected city (New York City, London, Paris). The map can be panned and zoomed.

The map and web page viewer are placed on top of one another in the dialog and toggled on/off, depending on which should be displayed.

Initial Screen:

![Initial_Map_screen](https://github.com/mystuff-us/Qt-QML/assets/160074491/91a01038-c85f-446a-812f-469435b0c428)



---------------------------------------

Application Infotainment01App is a qml application with a c++ backend for populating various qml components. It was inspired by MontyTheSoftwareEngineer on YouTube (https://www.youtube.com/watch?v=Tq-E6lqO6tM&t=177s) who attempted to partially replicate the Tesla interface.

The main screen is separated into three areas, left, right, and bottom screens.

The right screen displays a map that can be panned and zoomed, and is used to display an URL provided in the search box or by picking one of the buttons on the bottom bar.

The bottom bar's temperature controls function to increase/decrease the driver/passenger side interior temperature.

The right screen's upper control's values (locking, outside temperature, current time, and user's name) are taken from a c++ object.


Initial Infotainment screen:

![Vehicle_Infotainment_01](https://github.com/mystuff-us/Qt-QML/assets/160074491/1e0e92fa-b9a3-49d0-8b7c-8cc5a530275f)


---------------------------------------


Application MusicPlayerApp is a simple audio playback application with an interface into Jamendo.com for playing online content. The application is inspired by Scythe Studio (https://www.youtube.com/@scythe-studio) and (https://github.com/scytheStudio).

MusicPlayer has a simple interface displaying a graphic associated with a composer, the composer's name and song, play controls, and a menu option to select/delete songs or to search for online content from Jamendo.


The initial application screen:

![MusicPlayer_01](https://github.com/mystuff-us/Qt-QML/assets/160074491/f85fcd53-a4ff-403a-8cac-adec4290f99c)


---------------------------------------
