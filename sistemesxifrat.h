#ifndef SISTEMESXIFRAT_H
#define SISTEMESXIFRAT_H

#include <QObject>

class SistemesXifrat : public QObject
{
    Q_OBJECT
public:
    explicit SistemesXifrat(QObject *parent = nullptr);

    //Sistemes de transposició


    //Mètode de Inversió
    Q_INVOKABLE QString cifradoInversion(QString);
    Q_INVOKABLE QString descifradoInversion(QString);

    //Mètode de transposició amb 2 claus
    Q_INVOKABLE QString cifradoTransposicion2Claves(QString,QString,QString)__attribute__((optimize(0)));
    Q_INVOKABLE QString descifradoTransposicion2Claves(QString,QString,QString);

    //Mètode vertical paral·lel
    Q_INVOKABLE QString cifradoVerticalParalelo(QString);
    Q_INVOKABLE QString descifradoVerticalParalelo(QString);

    //Sistemes de substitució


    //Alfabet Desordenat
    Q_INVOKABLE QString cifradoAlfabetoDesordenado(QString,QString);
    Q_INVOKABLE QString descifradoAlfabetoDesordenado(QString,QString);

    //Codi Calendari
    Q_INVOKABLE QString cifradoCodigoCalendario(QString,int, int);
    // QString descifradoCodigoCalendario(QString,int, int);

    //Metode de sustitució numérica
    Q_INVOKABLE QString cifradoSustitucionNumerica(QString,QString);
    Q_INVOKABLE QString descifradoSustitucionNumerica(QString,QString);
signals:

public slots:
};

#endif // SISTEMESXIFRAT_H
