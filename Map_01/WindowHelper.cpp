#include "WindowHelper.h"

WindowHelper::WindowHelper(
    QMainWindow *widget,
    QObject *parent)
    : QObject{parent}
    , w(widget)
{}

int WindowHelper::width() const
{
		return w ? w->width() : 300;
}

int WindowHelper::height() const
{
		return w ? w->height() : 300;
}
