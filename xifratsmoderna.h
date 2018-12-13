#ifndef XIFRATSMODERNA_H
#define XIFRATSMODERNA_H

#include <QObject>

class XifratsModerna : public QObject
{
    Q_OBJECT
public:
    explicit XifratsModerna(QObject *parent = nullptr);

signals:

    //Binari

    Q_INVOKABLE QString cifradoBinario(QString);
    Q_INVOKABLE QString descifradoBinario(QString);

    //RSA

    Q_INVOKABLE QString cifradoRSA(QString, QString, QString)__attribute__((optimize(0)));
    Q_INVOKABLE QString descifradoRSA(QString, QString, QString);
    Q_INVOKABLE QString generarClaveRSA(QString, QString, QString, QString, QString);

    //RC4

    Q_INVOKABLE QString cifradoRC4(QString, QString);
    Q_INVOKABLE QString descifradoRC4(QString, QString);

    //DES
    Q_INVOKABLE QString** cifradoClaveDES(QString);
    Q_INVOKABLE QString cifradoDES(QString, QString);
    Q_INVOKABLE QString descifradoDES(QString, QString);

public slots:
};

#endif // XIFRATSMODERNA_H
