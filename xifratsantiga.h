#ifndef XIFRATSANTIGA_H
#define XIFRATSANTIGA_H

#include <QObject>

class XifratsAntiga : public QObject
{
    Q_OBJECT
public:
    explicit XifratsAntiga(QObject *parent = nullptr);

    //Cesar

    Q_INVOKABLE QString cifradoCesar(QString, int);
    Q_INVOKABLE QString descifradoCesar(QString, int);

    //Atbash

    Q_INVOKABLE QString cifradoDescifradoAtbash(QString);

    //Polibio

    Q_INVOKABLE QString cifradoPolibio(QString);
    Q_INVOKABLE QString descifradoPolibio(QString, QString);

    //Escitala

    Q_INVOKABLE QString cifradoEscitala(QString, double);
    Q_INVOKABLE QString descifradoEscitala(QString, double);


signals:

public slots:
};

#endif // XIFRATSANTIGA_H
