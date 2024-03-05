# Qt-QML
 Qt QML Examples

QtQtml01 is a simple Qt QML app that exercises some basic qml components (GridLayout, Item, Rectangle, Text, MouseArea, Connections, RowLayout, Button, Flow, and Repeater) and exposes a c++ object to qml components that get/set the c++ object.

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

![image](https://github.com/mystuff-us/Qt-QML/assets/160074491/bcce7127-ae42-4202-bfb4-034b7effe1fe)
