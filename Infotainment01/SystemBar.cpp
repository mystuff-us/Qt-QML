#include "SystemBar.h"
#include <QDateTime>

SystemBar::SystemBar(QObject *parent)
		: QObject{parent}
		, m_carLocked(true)
		, m_temp(60)
		, m_userName("William")
		, m_curTime()
		, m_curTimer(nullptr)
{
	m_curTimer = new QTimer(this);
	m_curTimer->setInterval(500);
	m_curTimer->setSingleShot(true);

	connect(m_curTimer, &QTimer::timeout, this, &SystemBar::curTimeTimeout);

	curTimeTimeout();
}

bool SystemBar::carLocked() const
{
	return m_carLocked;
}

void SystemBar::setCarLocked(bool newCarLocked)
{
	if (m_carLocked == newCarLocked)
		return;

	m_carLocked = newCarLocked;
	emit carLockedChanged(m_carLocked);
}

int SystemBar::temp() const
{
	return m_temp;
}

void SystemBar::settemp(int newTemp)
{
	if (m_temp == newTemp)
		return;
	m_temp = newTemp;
	emit tempChanged();
}

QString SystemBar::userName() const
{
	return m_userName;
}

void SystemBar::setuserName(const QString &newUserName)
{
	if (m_userName == newUserName)
		return;
	m_userName = newUserName;
	emit userNameChanged();
}

QString SystemBar::curTime() const
{
	return m_curTime;
}

void SystemBar::setCurTime(const QString &newCurTime)
{
	if (m_curTime == newCurTime)
		return;
	m_curTime = newCurTime;
	emit curTimeChanged();
}

void SystemBar::curTimeTimeout()
{
	QDateTime   date_time;
	QString cur_time = date_time.currentDateTime().toString("h:mm ap");

	setCurTime(cur_time);

	m_curTimer->start();
}
