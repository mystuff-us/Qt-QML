#ifndef SOMECLASS_H
#define SOMECLASS_H

#include <QObject>

class SomeClass : public QObject
{
    Q_OBJECT

    // How to use variables from a class in QML (3)
		//Q_PROPERTY(QString someVar READ someVar WRITE setSomeVar NOTIFY someVarChanged FINAL)

public:
    explicit SomeClass(QObject *parent = nullptr);

    // Another way to expose a function of SomeClass to QML:
		//Q_INVOKABLE void anotherFunction();

    // Another way to expose a variable / function of SomeClass to QML (4)
    Q_INVOKABLE QString getSomeVar();

    // (3)
    QString someVar();

signals:
    // (3)
    // NOTE: HAS to start with lower-case letter
    void someVarChanged();

//public slots:	// full access to slots
protected slots: // still accessible in qml
//private slots: // not accessible in qml
    void callMe();

    // (3)
    void setSomeVar(QString var);

private:
    // (3)
    QString m_someVar;
};

#endif // SOMECLASS_H
