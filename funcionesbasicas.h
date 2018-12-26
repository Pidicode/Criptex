#ifndef FUNCIONESBASICAS_H
#define FUNCIONESBASICAS_H

#include <QObject>

class FuncionesBasicas : public QObject
{
    Q_OBJECT
public:
    explicit FuncionesBasicas(QObject *parent = nullptr);
    Q_INVOKABLE QString quitarNamespaces(QString);
    Q_INVOKABLE QString anadirNamespaces(QString, int);
    Q_INVOKABLE QString ultimaLetra(QString);
    Q_INVOKABLE int contarLetrasFrecuencias(QString, QString);
    Q_INVOKABLE int contarLetras(QString);
    Q_INVOKABLE int stringANum(QString);
    Q_INVOKABLE QString quitarEspacioUltimaLetra(QString);
    Q_INVOKABLE bool comprobarPrimo(QString);

    //Hill


signals:

public slots:
};

#endif // FUNCIONESBASICAS_H
