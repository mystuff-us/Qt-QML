#include <QGuiApplication>
#include <QQmlApplicationEngine>

// Most common way is through using context properties (1)
// When using this method, SomeClass() must be created here
// and its context property defined.
#include <QQmlContext>
#include "someclass.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    // (1)
    // Defines 'testClass' for the lifetime of this app.
    //SomeClass   testClass;

		// A second method is 'registering a type' (2)
    // (2)
		qmlRegisterType<SomeClass>("William", 1, 0, "SomeClass");

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection
    );
    engine.loadFromModule("QtQtml01", "Main");

    // (1)
    //QQmlContext *rootContext = engine.rootContext();
    //rootContext->setContextProperty( "classA", &testClass);

    return app.exec();
}
