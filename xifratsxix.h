#ifndef XIFRATSXIX_H
#define XIFRATSXIX_H

#include <QObject>

class XifratsXIX : public QObject
{
    Q_OBJECT
public:
    explicit XifratsXIX(QObject *parent = nullptr);

    //Delastelle

    Q_INVOKABLE QString cifradoDelastelle(QString, QString, int);
    Q_INVOKABLE QString descifradoDelastelle(QString, QString, int);

    //Playfair

    Q_INVOKABLE QString cifradoPlayfair(QString, QString);
    Q_INVOKABLE QString descifradoPlayfair(QString, QString);

    //Nombres prims

    Q_INVOKABLE QString cifradoPrimos(QString);
    Q_INVOKABLE QString descifradoPrimos(QString);

    //Morse

    Q_INVOKABLE QString cifradoMorse(QString)__attribute__((optimize(0)));
    Q_INVOKABLE QString descifradoMorse(QString)__attribute__((optimize(0)));


    //Nihilista

    Q_INVOKABLE QString cifradoNihilista(QString, QString, QString);
    Q_INVOKABLE QString descifradoNihilista(QString, QString, QString);

    //Rail Fence

    Q_INVOKABLE QString cifradoRailFence(QString, int);
    Q_INVOKABLE QString descifradoRailFence(QString, int);

signals:

public slots:
};

#endif // XIFRATSXIX_H
