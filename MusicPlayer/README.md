# Qt-QML
 Qt QML Examples


Application MusicPlayerApp is a simple audio playback application with an interface into Jamendo.com for searching for and playing online content. The application is inspired by Scythe Studio (https://www.youtube.com/@scythe-studio) and (https://github.com/scytheStudio).

MusicPlayer has a simple interface displaying a graphic associated with a composer, the composer's name and song (numerous other content information could be displayed), play controls, and a menu option to select / delete songs or to search for online content.

The application exercises QMediaPlayer, QAbstractListModel, QNetworkAccessManager, in addition to core qt classes. QML widgets get their data from c++ using qmlRegisterSingletonInstance() as shown in main.cpp. See AudioSearchModel.cpp for the Jamendo.com interface.


The initial application screen:

![MusicPlayer_01](https://github.com/mystuff-us/Qt-QML/assets/160074491/ceb7e5c7-398c-4164-86a8-46a1fa7c41aa)


Playing a song and switching to the next song:

![MusicPlayer_02](https://github.com/mystuff-us/Qt-QML/assets/160074491/982438cf-ffb0-4970-ba98-3906a9213c62)


The dropdown menu displaying available songs, and a "+" button to add online content:

![MusicPlayer_03](https://github.com/mystuff-us/Qt-QML/assets/160074491/b2e7e626-91de-444c-9b5f-ab4b0fd95299)


Entering "jazz" to search for online content from Jamendo.com:

![MusicPlayer_04](https://github.com/mystuff-us/Qt-QML/assets/160074491/6024ecf0-7444-47b1-9fd2-74bf33592424)


The selected song is added to the list of available songs, and can be played:

![MusicPlayer_05](https://github.com/mystuff-us/Qt-QML/assets/160074491/04174535-5fc7-4567-ad33-de47e4d32325)


The dropdown menu's playlist can be edited, removing songs by selecting the 'trash-can' icon:

![MusicPlayer_07](https://github.com/mystuff-us/Qt-QML/assets/160074491/6771d8dd-e350-44a7-8bb9-1b2d2824d36b)




---------------------------------------
