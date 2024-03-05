#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QLabel>
#include <QtWebEngineWidgets/QWebEngineView>	// only works for MSVC
//#include <QQuickWindow>
#include <list>

QT_BEGIN_NAMESPACE
namespace Ui {
class MainWindow;
}
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
	Q_OBJECT

	Q_PROPERTY(int win_width READ win_width WRITE setWin_width NOTIFY win_widthChanged FINAL)
	Q_PROPERTY(int win_height READ win_height WRITE setWin_height NOTIFY win_heightChanged FINAL)

public:
	MainWindow(QWidget *parent = nullptr);
	~MainWindow();

	int win_width() const;
	void setWin_width(int newWin_width);

	int win_height() const;
	void setWin_height(int newWin_height);

private slots:
	void cityChanged(const QString &city_name);
	void view_website();

signals:
	void win_widthChanged();
	void win_heightChanged();
	void currentTextChanged(const QString &text);

protected:
	virtual void resizeEvent(QResizeEvent *);
	//void showEvent(QShowEvent *event);

private:
	// QWidget interface
	Ui::MainWindow *ui;

	// Web view
	QWebEngineView	*view_	= nullptr;

	int m_win_width = 0;
	int m_win_height = 0;

	QSize old_size,
			old_map_size,
			old_label_size,
			old_web_size;

	typedef struct city_info{
		QString name;
		double	latitude;
		double longitude;
		QString color;

		bool operator == (const struct city_info &city_name)
		{
			return 0 == name.compare(city_name.name);
		}
		bool is_same_city_name (const struct city_info &city_info)
		{
			return 0 == name.compare(city_info.name);
		}
		bool is_same_city_name (const QString &city_name)
		{
			return 0 == name.compare(city_name);
		}
	} CityInfo;

	std::list<CityInfo> city_info_;
};
#endif // MAINWINDOW_H
