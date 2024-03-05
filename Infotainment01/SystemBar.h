#ifndef SYSTEMBAR_H
#define SYSTEMBAR_H

#include <QObject>
#include <QTimer>

// Used by the overlaid widgets on the right screen:
//	car-lock, current temperature, username, and current time

class SystemBar : public QObject
{
	Q_OBJECT
	Q_PROPERTY(bool carLocked READ carLocked WRITE setCarLocked NOTIFY carLockedChanged FINAL)
	Q_PROPERTY(int temp READ temp WRITE settemp NOTIFY tempChanged FINAL)
	Q_PROPERTY(QString userName READ userName WRITE setuserName NOTIFY userNameChanged FINAL)
	Q_PROPERTY(QString curTime READ curTime WRITE setCurTime NOTIFY curTimeChanged FINAL)

public:
	explicit SystemBar(QObject *parent = nullptr);

	bool carLocked() const;
	int temp() const;
	QString userName() const;
	QString curTime() const;


public slots:
	void setCarLocked(bool newCarLocked);
	void settemp(int newTemp);
	void setuserName(const QString &newUserName);
	void setCurTime(const QString &newCurTime);
	void curTimeTimeout();

signals:
	void carLockedChanged(bool carLocked);
	void tempChanged();

	void userNameChanged();

	void curTimeChanged();

private:
	bool m_carLocked;
	int m_temp;
	QString m_userName;
	QString m_curTime;
	QTimer *m_curTimer;
};

#endif // SYSTEMBAR_H
