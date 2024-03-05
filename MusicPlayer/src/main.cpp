// See:
//  QTcpSocket, QSslSocket

// How to connect to REST API
//  QNetworkAccessManager
//      void authenticationRequired
//      void sslErrors
//  QNetworkReply *get(const QNetworkRequest &request)
//  void finished()
//
//  QNetworkReply *reply_;
//  ... void MyClass:onFinished()
//      QByteArray results = reply_->readAll();
//      'results' is usually in JSON format
//      {"persons":[
//          {"id":1, "name": "Stanley", "surname": "Osinsky", "age":21}
//      ,   {"id":2, "name": "Rick", "surname": "Roll", "age":37}
//      ,   {"id":3, "name": "Kukasz", "surname": "Losinski", "age":14}
//      ]}
//      JSON creators/parsers:
//      QJsonDocument doc;
//          QString jsonString = doc.toJson();
//          QJsonObject obj = doc.toObject();
//          QJsonArray persons = obj["persons"].toArray();

// Using Jamendo for web access to media.
//  developer.jamendo.com/v3.0/tracks

// *** Compiling Issues ***
//  File:
//      C:\Documents\Qt\build-SongPlayer5-Desktop_Qt_6_6_1_MinGW_64_bit-Debug
//          \songplayer5_qmltyperegistrations.cpp
//  uses:
//      #include "AudioInfo.h"
//  instead of:
//      #include <src/AudioInfo.h>
//  and complains of not being able to find '#include "AudioInfo.h"
//  The fix is to edit the file (not recommended) and make the
//  path change as shown.

// *** WebAssembly Issues ***
//  ** Compiling Issue #1 **
//  File:
//      C:\Documents\Qt\build-SongPlayer5-WebAssembly_Qt_6_6_1_multi_threaded-Debug
//          \songplayer5_qmltyperegistrations.cpp
//  uses:
//      #include "AudioInfo.h"
//  instead of:
//      #include <src/AudioInfo.h>
//  and complains of not being able to find '#include "AudioInfo.h"
//  The fix is to edit the file (not recommended) and make the
//  path change as shown.
//
//  ** Compiling Issue #2 **
//  WebAssembly (wasm) complains that it runs out of memory when using the
//  default "INITIAL_MEMORY=50MB". Here's the message:
//
// 14:32:24: Running steps for project SongPlayer5...
// 14:32:24: Starting: "D:\Development\Qt\Tools\CMake_64\bin\cmake.exe" --build C:/Documents/Qt/build-SongPlayer5-WebAssembly_Qt_6_6_1_multi_threaded-Debug --target all
// [1/20 11.3/sec] Automatic MOC and UIC for target SongPlayer5
// [2/19 17.3/sec] Running AUTOMOC file extraction for target SongPlayer5
// [3/19 20.8/sec] Running moc --collect-json for target SongPlayer5
// [4/5 2.8/sec] Building CXX object CMakeFiles/SongPlayer5.dir/src/main.cpp.o
// [5/5 2.5/sec] Linking CXX executable SongPlayer5.js
// FAILED: SongPlayer5.js
// cmd.exe /C "cd . && D:\Development\emsdk\upstream\emscripten\em++.bat
//     -DQT_QML_DEBUG -g -s PTHREAD_POOL_SIZE=4
//     -s INITIAL_MEMORY=50MB -s EXPORTED_RUNTIME_METHODS=UTF16ToString,stringToUTF16,JSEvents,specialHTMLTargets,FS
//     -s MAX_WEBGL_VERSION=2 -s FETCH=1 -s WASM_BIGINT=1 -s STACK_SIZE=5MB -s MODULARIZE=1
//     -s EXPORT_NAME=createQtAppInstance -s DISABLE_EXCEPTION_CATCHING=1 -pthread
//     -s ALLOW_MEMORY_GROWTH -s DEMANGLE_SUPPORT=1 --profiling-funcs -sASYNCIFY_IMPORTS=qt_asyncify_suspend_js,qt_asyncify_resume_js
//     -s ERROR_ON_UNDEFINED_SYMBOLS=1 @CMakeFiles\SongPlayer5.rsp -o SongPlayer5.js  && cd ."
// em++: warning: -pthread + ALLOW_MEMORY_GROWTH may run non-wasm code slowly, see https://github.com/WebAssembly/design/issues/1271 [-Wpthreads-mem-growth]

// ====> here's where it complains <====
// wasm-ld: error: initial memory too small, 58711440 bytes needed
// em++: error: 'D:/Development/emsdk/upstream/bin\wasm-ld.exe @C:\Users\eCIOs\AppData\Local\Temp\emscripten_p7okojtt.rsp.utf-8' failed (returned 1)
// ninja: build stopped: subcommand failed.
// 14:32:26: The process "D:\Development\Qt\Tools\CMake_64\bin\cmake.exe" exited with code 1.
// Error while building/deploying project SongPlayer5 (kit: WebAssembly Qt 6.6.1 (multi-threaded))
// When executing step "Build"
// 14:32:26: Elapsed time: 00:02.
//
//  The *fix* is to edit 'build.ninja' in the root build folder, and change:
//      -s INITIAL_MEMORY=50MB
//  to some value larger than '58711440 bytes needed'. For example, use 128 instead of 50:
//      -s INITIAL_MEMORY=128MB

// For 'release' deployment use:
//	D:\Development\Qt\6.6.1\mingw_64\bin>windeployqt --release --qmldir C:\Documents\Qt\Qt-QML\MusicPlayer .\MusicPlayerApp\MusicPlayerApp.exe

// Notes:
//	Access to "https://api.jamendo.com/v3.0/tracks/" doesn't seem to work for:
//		- MSVC compiler
//		- release version for MinGW
//	Debug version of MinGW works.

#include <QGuiApplication>
#include <QIcon>
#include <QQmlApplicationEngine>
#include "PlayerController.h"
#include "AudioSearchModel.h"
//#include "AudioInfo.h"

// #include "app_environment.h"
// #include "import_qml_components_plugins.h"
// #include "import_qml_plugins.h"

int main(int argc, char *argv[])
{
	//set_qt_environment();

	QGuiApplication app(argc, argv);

	app.setWindowIcon(QIcon(":/MusicPlayer/assets/icons/app_icon.ico"));

	QQmlApplicationEngine engine;
	const QUrl url(u"qrc:/MusicPlayerApp/main.qml"_qs);
	QObject::connect(
			&engine,
			&QQmlApplicationEngine::objectCreated,
			&app,
			[url](QObject *obj, const QUrl &objUrl) {
				if (!obj && url == objUrl)
					QCoreApplication::exit(-1);
			},
			Qt::QueuedConnection);

	engine.addImportPath("C:\\Documents\\Qt\\Qt-QML\\MusicPlayer");
	engine.addImportPath(QCoreApplication::applicationDirPath() + "/qml");
	engine.addImportPath(":/");

	PlayerController *playerController = new PlayerController(&app);
	qmlRegisterSingletonInstance("com.company.PlayerController", 1, 0, "PlayerController", playerController);

	AudioSearchModel *audioSearchModel = new AudioSearchModel(&app);
	qmlRegisterSingletonInstance("com.company.AudioSearchModel", 1, 0, "AudioSearchModel", audioSearchModel);

	engine.load(url);

	if (engine.rootObjects().isEmpty()) {
		return -1;
	}

	return app.exec();
}
