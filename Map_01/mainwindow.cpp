#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QDebug>
#include <QQmlApplicationEngine>
#include <QQuickItem>
#include <QLayout>
#include <algorithm>

MainWindow::MainWindow(QWidget *parent)
		: QMainWindow(parent)
		, ui(new Ui::MainWindow)
		, view_(nullptr)
		, m_win_width(0)
		, m_win_height(0)
		,	old_size()
		, old_map_size()
		,	old_label_size()
		, old_web_size()
{
	ui->setupUi(this);

	setMinimumSize(QSize(300,300));

	// <x>_size vars are used to resize qml map component
	// as this main window size changes.
	old_size = size();

	if (ui->the_map)
	{
		ui->the_map->show();
		old_map_size		= ui->the_map->size();
		old_label_size	= ui->the_map->size();
	}

	// Sample static city data.
	CityInfo	city;

	city.name				=	"San Francisco";
	city.latitude		= 37.755514;
	city.longitude	=	-122.497589;
	city.color			=	"SteelBlue";
	city_info_.push_back(city);

	city.name				=	"New York";
	city.latitude		=	40.7128;
	city.longitude	=	-74.0060;
	city.color			=	"BurlyWood";
	city_info_.push_back(city);

	city.name				= "London";
	city.latitude		= 51.5072;
	city.longitude	=	0.1276;
	city.color			=	"Olive";
	city_info_.push_back(city);

	city.name				= "Paris";
	city.latitude		= 48.8566;
	city.longitude	=	2.3522;
	city.color			=	"IndianRed";
	city_info_.push_back(city);

	// City dropdown
	if (ui->city_cb)
	{
		// Changes to the city name result in changes to the map
		//connect(ui->city_cb, SIGNAL(currentTextChanged(QString)), this, SLOT(cityChanged(QString)));
		connect(ui->city_cb, &QComboBox::currentTextChanged, this, &MainWindow::cityChanged);

		// Give this dropdown the initial focus - up/down key to change city.
		ui->city_cb->setFocus();
	}

	// Website button
	if (ui->webView_)
	{
		ui->webView_->setChecked(false);
		//connect(ui->webView_, SIGNAL(clicked()), this, SLOT(view_website()));
		connect(ui->webView_, &QPushButton::clicked, this, &MainWindow::view_website);
	}

	if (ui->webWidget_)
	{
		old_web_size	=	ui->webWidget_->size();
		view_					=	new QWebEngineView(ui->webWidget_);
		view_->hide();
		//ui->webWidget_->hide();
	}
}

MainWindow::~MainWindow()
{
	delete ui;
	delete view_;
}

// Resize the qml widgets as this main window resizes.
void MainWindow::resizeEvent(QResizeEvent *)
{
	setWin_width(width());
	setWin_height(height());

	QSize main_win_size  = size();

	if (ui->the_map)
	{
		// Resize the map.qml when this main window resizes.
		QSize map_size = ui->the_map->size();
		ui->the_map->resize(old_map_size + (main_win_size - old_size));

		// Resize the text widget's width as the window resizes.
		QSize label_size = ui->label_->size();
		ui->label_->resize(
				(old_label_size + (main_win_size - old_size)).width()
				, label_size.height()
				);

		// Update the text widget with window sizing info
		QString	text;
		text	=
				QString("win: %1,%2  qml: %3,%4 label: %7,%8  diff: %5,%6")
						.arg(width()).arg(height())
						.arg(map_size.width())
						.arg(map_size.height())
						.arg((main_win_size - old_size).width())
						.arg((main_win_size - old_size).height())
						.arg(label_size.width())
						.arg(label_size.height());

		ui->label_->setText(text);

		// Send window size changes to Qt Creator's application output
		//qDebug() << text;

		// See https://doc.qt.io/qt-6/qquickitem.html
		// By setting 'property <type> <name>: <value>' in
		// 'map.qml' we can set their properties from here
		// by using the QQuickItem*->setProperty()

		QQuickItem *map_item = ui->the_map->rootObject();
		if (map_item)
		{
			//map_item->setVisible(true);//false);

			// Center the user message in the map.
			QString	qstr = QString("%3\nLatitude: %1\nLongitude: %2")
												 .arg(city_info_.front().latitude)
												 .arg(city_info_.front().longitude)
												 .arg(city_info_.front().name);
			map_item->setProperty("msg", QVariant(qstr));

			// Set the rectangle's color - map is overlayed over rectangle
			// so this looks like a thin border around the map.
			map_item->setProperty("the_color", QVariant(city_info_.front().color));

			// Test to set the lat/lng of map
			map_item->setProperty("prev_lat", QVariant(city_info_.front().latitude));
			map_item->setProperty("prev_lng", QVariant(city_info_.front().longitude));
		}	// update map properties


		//qt_metacast("my_text");

		//ui->the_map->setProperty("width", QVariant(width()));
		//ui->the_map->setProperty("height", QVariant(height()));
		//ui->the_map->setProperty("color", "Black");
		//ui->the_map->setContentsMargins(QMargins(50,50,50,50));
	}	// ui->the_map

	if (ui->webWidget_)
	{
		//QSize web_size = ui->webWidget_->size();

		ui->webWidget_->resize(
				old_map_size + (main_win_size - old_size)
				//old_web_size + (main_win_size - old_size)
				//(old_label_size + (my_size - old_size)).width()
				//	,	web_size.height()
				);
		if (view_)
		{
			view_->resize(ui->webWidget_->size());
		}
	}
}

// void MainWindow::showEvent(QShowEvent *event)
// {
// 	if (event->type() == QShowEvent::Show)
// 	{
// 		//old_size = size();
// 	}
// }

int MainWindow::win_width() const
{
	return width(); //m_win_width;
}

void MainWindow::setWin_width(int width)
{
	if (m_win_width == width)
		return;
	m_win_width = width;
	emit win_widthChanged();
}

int MainWindow::win_height() const
{
	return height();
}

void MainWindow::setWin_height(int newWin_height)
{
	if (m_win_height == newWin_height)
		return;
	m_win_height = newWin_height;
	emit win_heightChanged();
}

void MainWindow::cityChanged(const QString &city_name)
{
	//qDebug() << "MainWindow::cityChanged()";
	// When this is called, hide the website, show the map
	view_->hide();
	ui->webView_->setChecked(false);
	ui->the_map->show();

	CityInfo	info;
	info.name	=	city_name;

	// Simpliest call
	//auto
	//city_it = std::find(city_info_.begin(), city_info_.end(), info);

	// Using lambda ... but why use?
	auto
	matches_city_name = [&info](const CityInfo &city){ return info.is_same_city_name(city); };

	auto
	city_it = std::find_if(city_info_.begin(), city_info_.end(), matches_city_name);

	//qDebug() << "City name: " << (*city_it).name;
	//	<< "Lat: " << (*city_it).latitude << " Long: " << (*city_it).longitude;

	QQuickItem *map_item = ui->the_map->rootObject();
	if (map_item)
	{
		//map_item->setVisible(true);//false);

		// Set overlay message to city name, lat/lng
		QString	qstr = QString("%3\nLatitude: %1\nLongitude: %2")
											 .arg((*city_it).latitude)
											 .arg((*city_it).longitude)
											 .arg((*city_it).name);
		map_item->setProperty("msg", QVariant(qstr));

		// Reset map's center coordinates
		map_item->setProperty("prev_lat", QVariant((*city_it).latitude));
		map_item->setProperty("prev_lng", QVariant((*city_it).longitude));

		// Set border's color
		map_item->setProperty("the_color", QVariant((*city_it).color));
	}
}

void MainWindow::view_website()
{
	if (!ui->webView_->isChecked())
	{
		ui->the_map->show();
		view_->hide();
		return;
	}

	ui->the_map->hide();

	view_->load(QUrl("https://doc.qt.io/qt-6/qwebengineview.html"));
	//view_->load(QUrl("https://www.EnterpriseCIOs.com/"));
	view_->resize(ui->webWidget_->size());
	view_->show();
}
