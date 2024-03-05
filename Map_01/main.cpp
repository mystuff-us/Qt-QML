#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
//#include <QtWebEngineWidgets/QWebEngineView>
//#include <QtWebEngineQuick/QtWebEngineQuick>
#include <mainwindow.h>
#include <WindowHelper.h>

int main(int argc, char *argv[])
{
	//QCoreApplication::setOrganizationName("Map_01");

	// //QtWebEngineQuick::initialize(); // MSVC: unresolved external
	QApplication app(argc, argv);

	MainWindow main_win;

	//qmlRegisterType<WindowHelper>("WinHelper", 2, 0, "WindowHelper");

	QQmlApplicationEngine engine;

	// const QUrl url(u"qrc:/map.qml"_qs);
	// QObject::connect(
	// 		&engine,
	// 		&QQmlApplicationEngine::objectCreated,
	// 		&app,
	// 		[url](QObject *obj, const QUrl &objUrl) {
	// 				if (!obj && url == objUrl)
	// 						QCoreApplication::exit(-1);
	// 		},
	// 		Qt::QueuedConnection
	// 		);
	//engine.loadFromModule("Map_01", "map");

	// QQmlContext *context = engine.rootContext();
	// context->setContextProperty("main_window", &w);

	//WindowHelper    helper(&w);

	//qmlRegisterType<WindowHelper>("WinHelper", 1, 0, "WindowHelper");

	QObject::connect(
			&engine,
			&QQmlApplicationEngine::objectCreationFailed,
			&app,
			[]() { QCoreApplication::exit(-1); },
			Qt::QueuedConnection
			);

	main_win.show();

	return app.exec();
}
