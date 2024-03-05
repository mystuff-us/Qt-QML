// Copyright (C) 2024 William Myers
//

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtWebEngineQuick/QtWebEngineQuick>
#include <QtWebEngineQuick/qtwebenginequickglobal.h>

#include "app_environment.h"
#include "import_qml_components_plugins.h"
#include "import_qml_plugins.h"

#include <SystemBar.h>
#include <TemperatureCtrl.h>

int main(int argc, char *argv[])
{
	set_qt_environment();

	QCoreApplication::setOrganizationName("Infotainment01App");
	QtWebEngineQuick::initialize();

	QGuiApplication app(argc, argv);

	SystemBar				m_sys_bar;
	TemperatureCtrl	m_driverTemp, m_passengerTemp;

	QQmlApplicationEngine engine;

	const QUrl url(u"qrc:/qt/qml/Main/main.qml"_qs);

	QObject::connect(
			&engine,
			&QQmlApplicationEngine::objectCreated,
			&app,
			[url](QObject *obj, const QUrl &objUrl) {
				if (!obj && url == objUrl)
					QCoreApplication::exit(-1);
			},
			Qt::QueuedConnection);

	engine.addImportPath(QCoreApplication::applicationDirPath() + "/qml");
	engine.addImportPath(":/");

	// Define these *before* using 'engine.load(url)'
	QQmlContext *context = engine.rootContext();

	context->setContextProperty("sys_bar", &m_sys_bar);

	context->setContextProperty("driver_temp", &m_driverTemp);
	context->setContextProperty("passenger_temp", &m_passengerTemp);

	engine.load(url);

	if (engine.rootObjects().isEmpty()) {
		return -1;
	}

	return app.exec();
}
