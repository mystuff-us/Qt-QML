#include "someclass.h"
#include <QDebug>

SomeClass::SomeClass(QObject *parent)
    : QObject{parent}
    , m_someVar("default value")
{
    qDebug() << "Create class SomeClass()";
}

// void SomeClass::anotherFunction()
// {
//     qDebug() << "calling anotherFunction()";
// }

// Another way to expose a variable / function of SomeClass to QML (4)
QString SomeClass::getSomeVar()
{
	qDebug() << "SomeClass::getSomeVar(" << m_someVar << ")";
	return  m_someVar;
}

void SomeClass::callMe()
{
		qDebug() << "SomeClass::callMe()";
}

QString SomeClass::someVar()
{
	qDebug() << "SomeClass::someVar(" << m_someVar << ")";
	return  m_someVar;
}

void SomeClass::setSomeVar(QString var)
{
	qDebug() << "SomeClass::setSomeVar(" << var << ")";
	if (m_someVar != var)
	{
		m_someVar = var;
		emit someVarChanged();
	}
}

