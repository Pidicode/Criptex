#include "xifratsantiga.h"
#include <QString>
#include <QDebug>

XifratsAntiga::XifratsAntiga(QObject *parent) : QObject(parent)
{

}

QString XifratsAntiga::cifradoCesar(QString frase, int n){
    frase = frase.toLower().replace(" ","");
    QString alfabeto = "abcdefghijklmnñopqrstuvwxyz";
    QString fraseModificada = frase.toLower().replace(" ","");

    if(n<0) n+=27;

    for(int i = 0;i<fraseModificada.length();i++){
        fraseModificada[i] = alfabeto[(alfabeto.indexOf(frase[i]) + n) % 27];
    }

    return fraseModificada;
}

QString XifratsAntiga::descifradoCesar(QString frase, int n){
    frase = frase.toLower().replace(" ","");
    QString alfabeto = "abcdefghijklmnñopqrstuvwxyz";
    QString fraseModificada = frase.toLower().replace(" ","");

    if(n>0) n-=27;

    for(int i = 0;i<fraseModificada.length();i++){
        fraseModificada[i] = alfabeto[(alfabeto.indexOf(frase[i]) - n) % 27];
    }

    return fraseModificada;
}


QString XifratsAntiga::cifradoDescifradoAtbash(QString frase)
{
    frase = frase.toLower().replace(" ","");
    QString alfabeto = "abcdefghijklmnñopqrstuvwxyz";
    QString alfabetoInvertido = "zyxwvutsrqpoñnmlkjihgfedcba";

    for (int i = 0; i < frase.length(); i++) {
        frase[i] = alfabetoInvertido.at(alfabeto.indexOf(frase[i]));
    }

    return frase;
}

QString XifratsAntiga::cifradoPolibio(QString frase)
{
    frase = frase.toLower().replace(" ","");
    QString alfabeto = "abcdefghiklmnopqrstuvwxyz";
    QString fraseFinal;

    for(int i = 0; i<frase.length(); i++){
        if(frase[i]=="j" || frase[i] == "ñ"){
            if(frase[i]=="j"){
                fraseFinal.append(QString::number(ceil((double)(alfabeto.indexOf("i")/5))+1)
                                  +QString::number(alfabeto.indexOf("i")%5+1)+" ");
            }
            else if(frase[i]=="ñ"){
                fraseFinal.append(QString::number(ceil((double)(alfabeto.indexOf("n")/5))+1)
                                  +QString::number(alfabeto.indexOf("n")%5+1)+" ");
            }
        }
        else{
            fraseFinal.append(QString::number(ceil((double)(alfabeto.indexOf(frase[i])/5))+1)
                              +QString::number(alfabeto.indexOf(frase[i])%5+1)+" ");
        }
    }

    return fraseFinal;
}

QString XifratsAntiga::descifradoPolibio(QString frase, QString fraseCifrada){
    if(frase.length()%2!=0)return fraseCifrada;
    frase = frase.replace(" ","");
    QString alfabeto = "abcdefghiklmnopqrstuvwxyz";
    QString fraseFinal;
    int test = frase.length(), test2 = 0;

    for(int i = 0; i<frase.length(); i+=2){
        fraseFinal.append(alfabeto.at((frase[i].digitValue()-1)*5+(frase[i+1].digitValue()-1)));
    }

    return fraseFinal;
}


QString XifratsAntiga::cifradoEscitala(QString frase, double columnas){
    frase = frase.toLower().replace(" ",""); //Traiem espais i tot minus
    QString nuevaFrase = ""; //Frase xifrada
    int filas = ceil((double)(frase.length()/columnas));

    //Algorisme escitala (C = k * (i mod n) + (i/n))

    for(int i = 0; i<frase.length()+(columnas*filas-frase.length()); i++){
        nuevaFrase.append(frase[(((int)columnas) * (i % filas)) + (i / filas)]);
    }

    nuevaFrase.replace('\0','*');
    nuevaFrase.replace("*","");
    return nuevaFrase;
}

QString XifratsAntiga::descifradoEscitala(QString frase, double filas){
    frase = frase.toLower().replace(" ","");
    int columnas = ceil((double)(frase.length()/filas));
    QString nuevaFrase = "";
    QString matriz[(int)filas][columnas];
    int contador = 0;

    //Introduint caràcters a la matriu on no hi haura lletres

    for(int i = filas-1; i>=0; i--){
        if(contador==filas*columnas-frase.length()) break;
        matriz[i][columnas-1]="¥";
        contador++;

    }

    contador = 0;

    //Rellenant matriu

    for(int i = 0; i<filas; i++){
        for(int j = 0; j<columnas; j++){
            if(matriz[i][j]!="¥"){
                matriz[i][j]=frase[contador];
                contador++;
            }
        }
    }

    //Extraient frase desxifrada

    for(int i = 0; i<columnas; i++){
        for(int j = 0; j<filas; j++){
            nuevaFrase.append(matriz[j][i]);
        }
    }

    nuevaFrase.replace("¥","");

    return nuevaFrase;
}





