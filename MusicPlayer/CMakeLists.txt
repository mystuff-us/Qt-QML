cmake_minimum_required(VERSION 3.21.1)

option(LINK_INSIGHT "Link Qt Insight Tracker library" ON)
option(BUILD_QDS_COMPONENTS "Build design studio components" ON)

project(MusicPlayerApp VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 REQUIRED COMPONENTS Core Gui Qml Quick Multimedia)

if (Qt6_VERSION VERSION_GREATER_EQUAL 6.3)
    qt_standard_project_setup()
endif()

qt_add_executable(
	MusicPlayerApp
	src/main.cpp
	#src/AudioInfo.h src/AudioInfo.cpp
	src/AudioSearchModel.h src/AudioSearchModel.cpp
	src/PlayerController.h src/PlayerController.cpp
	#assets/audio/air_on_the_g_string.mp3 assets/audio/eine_kleine_nachtmusik.mp3 assets/audio/reprezentuje_biede.mp3 assets/audio/symphony_no_5.mp3
	#assets/icons/add_icon.png assets/icons/app_icon.ico assets/icons/close_icon.png assets/icons/menu_icon.png assets/icons/next_icon.png assets/icons/pause_icon.png assets/icons/play_icon.png assets/icons/previous_icon.png assets/icons/search_icon.png assets/icons/trash_icon.png
	#assets/videos/video_1.avi
	#assets/Images/song_1.jpg assets/Images/song_2.jpg assets/Images/song_3.jpg
	AudioInfoBox.qml
	ImageButton.qml
	#main.qml
	PlaylistPanel.qml
	SearchField.qml
	SearchPanel.qml
)

qt_add_qml_module(
	MusicPlayerApp
		URI MusicPlayerApp
		VERSION 1.0

		QML_FILES
		main.qml AudioInfoBox.qml ImageButton.qml
		PlaylistPanel.qml
		SearchField.qml SearchPanel.qml

		SOURCES
		src/AudioInfo.cpp src/AudioInfo.h
		src/AudioSearchModel.cpp src/AudioSearchModel.h
		src/PlayerController.cpp src/PlayerController.h

		RESOURCES
		assets/audio/air_on_the_g_string.mp3
		assets/audio/eine_kleine_nachtmusik.mp3
		assets/audio/reprezentuje_biede.mp3
		assets/audio/symphony_no_5.mp3

		assets/icons/add_icon.png
		assets/icons/app_icon.ico
		assets/icons/close_icon.png
		assets/icons/menu_icon.png
		assets/icons/next_icon.png
		assets/icons/pause_icon.png
		assets/icons/play_icon.png
		assets/icons/previous_icon.png
		assets/icons/search_icon.png
		assets/icons/trash_icon.png

		assets/images/song_1.jpg
		assets/images/song_2.jpg
		assets/images/song_3.jpg

		assets/videos/video_1.avi
)

qt_add_resources(
	MusicPlayerApp "configuration"
    PREFIX "/"
    FILES
        qtquickcontrols2.conf
)

target_link_libraries(
	MusicPlayerApp PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
		Qt6::Multimedia
)

if (BUILD_QDS_COMPONENTS)
    include(${CMAKE_CURRENT_SOURCE_DIR}/qmlcomponents)
endif()

# Needed to comment this out to automatically
# add 'assets' folder to project.
#include(${CMAKE_CURRENT_SOURCE_DIR}/qmlmodules)

if (LINK_INSIGHT)
    include(${CMAKE_CURRENT_SOURCE_DIR}/insight)
endif ()

include(GNUInstallDirs)
install(TARGETS MusicPlayerApp
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

# make IDEs aware of the QML import path
set(QML_IMPORT_PATH ${PROJECT_BINARY_DIR}/qml CACHE PATH
    "Path to the custom QML components defined by the project")
