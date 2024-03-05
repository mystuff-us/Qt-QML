QT       += core gui quickwidgets webenginewidgets location positioning

# Added 'quickwidgets' to enable QML form
greaterThan(QT_MAJOR_VERSION, 4): QT += widgets quickwidgets webenginewidgets location positioning

CONFIG += c++17

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    WindowHelper.cpp \
    main.cpp \
    mainwindow.cpp

HEADERS += \
    WindowHelper.h \
    mainwindow.h

FORMS += \
    mainwindow.ui

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

RESOURCES += \
	Qml.qrc
#	WindowHelper.cpp
#	WindowHelper.h
