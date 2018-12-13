#ifndef XIFRATSRENAIXEMENT_H
#define XIFRATSRENAIXEMENT_H

#include <QObject>

class XifratsRenaixement : public QObject
{
    Q_OBJECT
public:
    explicit XifratsRenaixement(QObject *parent = nullptr);

    //Tabla Tritemio

    Q_INVOKABLE QString cifradoTritemio(QString);
    Q_INVOKABLE QString descifradoTritemio(QString);

    //Vigenere

    Q_INVOKABLE QString cifradoVigenere(QString, QString);
    Q_INVOKABLE QString descifradoVigenere(QString, QString);

    //Francis Bacon

    Q_INVOKABLE QString cifradoBacon(QString);
    Q_INVOKABLE QString descifradoBacon(QString, QString);

signals:

public slots:
};

#endif // XIFRATSRENAIXEMENT_H
