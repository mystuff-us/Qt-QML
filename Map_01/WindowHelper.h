#ifndef WINDOWHELPER_H
#define WINDOWHELPER_H

#include <QObject>
#include <QMainWindow>

class WindowHelper : public QObject
{
	Q_OBJECT
public:
	explicit WindowHelper(QMainWindow *widget, QObject *parent = nullptr);

	int width() const;
	int height() const;

	Q_INVOKABLE int get_width()
	{
		return  w ? w->width() : 300;
	}
	Q_INVOKABLE int get_height()
	{
		return w ? w->height() : 300;
	}

signals:
	//void onWidthChanged();
	//void onHeightChanged();

private:
	QMainWindow *w = nullptr;
};

#endif // WINDOWHELPER_H
