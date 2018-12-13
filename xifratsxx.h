#ifndef XIFRATSXX_H
#define XIFRATSXX_H

#include <QObject>

class XifratsXX : public QObject
{
    Q_OBJECT
public:
    explicit XifratsXX(QObject *parent = nullptr);

    //ADFGVX

    int switchADFGVXdescifrado(QChar);
    QString switchADFGVXcifrado(int);
    Q_INVOKABLE QString cifradoADFGVX(QString, QString, QString);
    Q_INVOKABLE QString descifradoADFGVX(QString, QString, QString)__attribute__((optimize(0)));

    //Hill

    int calcularDeterminante (int, int[25][25]);
    int mcd (int,int);
    Q_INVOKABLE QString generarMatriz(int);
    Q_INVOKABLE bool comprobarMatriz(QString, int);
    Q_INVOKABLE QString cifradoHill(QString, QString, int);
    Q_INVOKABLE QString descifradoHill(QString, QString, int);
    Q_INVOKABLE int rellenarMatrizUI(QString, int);

    //Enigma

    Q_INVOKABLE QString cifradoEnigma(QString, QString, QString, int, int, int);

signals:

public slots:
};

#endif // XIFRATSXX_H
