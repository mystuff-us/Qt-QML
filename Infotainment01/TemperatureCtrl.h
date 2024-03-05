#ifndef TEMPERATURECTRL_H
#define TEMPERATURECTRL_H

#include <QObject>

// Used by QML temperature control to set car's interior temperature.
class TemperatureCtrl : public QObject
{
	Q_OBJECT
	Q_PROPERTY(int targetTemp READ targetTemp WRITE setTargetTemp NOTIFY targetTempChanged FINAL)

public:
	explicit TemperatureCtrl(QObject *parent = nullptr);

	int targetTemp() const;

	Q_INVOKABLE void incrementTargetTemp(const int &val);

public slots:
	void setTargetTemp(int newTargetTemp);

signals:
	void targetTempChanged();

private:
	int m_targetTemp;
};

#endif // TEMPERATURECTRL_H
