#include "funcionesbasicas.h"
#include <QString>

FuncionesBasicas::FuncionesBasicas(QObject *parent) : QObject(parent)
{
}

QString FuncionesBasicas::quitarNamespaces(QString frase){
    frase.replace(" ","");
    return frase;
}

QString FuncionesBasicas::anadirNamespaces(QString frase, int n){
    int contadorEspacios = 0;
    frase.replace(" ","");
    for(int i=0;i<frase.length();i++){
        if(contadorEspacios==n){
            frase.insert(i, " ");
            contadorEspacios=-1;
        }
        contadorEspacios++;
    }
    return frase;
}

QString FuncionesBasicas::ultimaLetra(QString frase){

    return frase.remove(0,frase.length()-1);
}

int FuncionesBasicas::contarLetrasFrecuencias(QString frase, QString letra){
    return (frase.count(letra)*10)+15;
}

int FuncionesBasicas::stringANum(QString n){
    return n.toInt();
}

int FuncionesBasicas::contarLetras(QString frase){
    return frase.count();
}

QString FuncionesBasicas::quitarEspacioUltimaLetra(QString frase){
    frase.replace(frase.remove(0,frase.length()-1),"");
    return frase;
}

bool FuncionesBasicas::comprobarPrimo(QString nString){
    int n = nString.toInt();
    for(int i = 2; i<n; i++){
        if(n%i==0) return false;
    }
    return true;
}
