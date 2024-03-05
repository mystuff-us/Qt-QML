#include "TemperatureCtrl.h"

TemperatureCtrl::TemperatureCtrl(QObject *parent)
		: QObject{parent}
		, m_targetTemp(68)
{}

int TemperatureCtrl::targetTemp() const
{
	return m_targetTemp;
}

void TemperatureCtrl::incrementTargetTemp(const int &val)
{
	setTargetTemp(m_targetTemp + val);
}

void TemperatureCtrl::setTargetTemp(int newTargetTemp)
{
	if (m_targetTemp == newTargetTemp)
		return;
	m_targetTemp = newTargetTemp;
	emit targetTempChanged();
}

