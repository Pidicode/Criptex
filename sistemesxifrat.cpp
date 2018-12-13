#include "sistemesxifrat.h"
#include <QString>
#include <QDebug>

SistemesXifrat::SistemesXifrat(QObject *parent) : QObject(parent)
{
}

//Sistemes de transposició

//Mètode inversió

QString SistemesXifrat::cifradoInversion(QString frase){
    frase = frase.toLower().replace(" ","");
    QString auxFrase = frase;
    int j=0;
    int length = frase.length()-1;

    for(int i=0;i<frase.length();i++){
        frase[i]=auxFrase[length-j];
        j++;
    }

    return frase;
}

QString SistemesXifrat::descifradoInversion(QString frase){
    frase = frase.toLower().replace(" ","");
    QString auxFrase = frase;
    int j=0;
    int length = frase.length()-1;

    for(int i=0;i<frase.length();i++){
        frase[length-j]=auxFrase[i];
        j++;
    }

    return frase;
}

//Mètode transposició

QString SistemesXifrat::cifradoTransposicion2Claves(QString frase, QString palabraClave1, QString palabraClave2)
{

    frase = frase.toLower().replace(" ","");
    palabraClave1 = palabraClave1.toLower().replace(" ","");
    palabraClave2 = palabraClave2.toLower().replace(" ","");
    QString fraseClave1, fraseClave2;
    QString alfabeto = "abcdefghijklmnñopqrstuvwxyz";
    int numeros[palabraClave1.length()], contador = 0, min, aux, contadorExtra = 0, contadorExtra2 = 0;
    int cantidadFilasPalabra1 = ((frase.length()/palabraClave1.length())+1)*2;
    int cantidadPalabraClave1 = palabraClave1.length();
    QString matrizClave1[cantidadFilasPalabra1][cantidadPalabraClave1];


    //Introduciendo elementos Matriz Primera Palabra Clave

    for(int i = 0;i<cantidadPalabraClave1;i++){
        matrizClave1[0][i]=palabraClave1[i];
    }

    for(int i = 1;i<cantidadFilasPalabra1;i++){
        for(int j = 0;j<cantidadPalabraClave1;j++){
            if(contador!=frase.length()){
                matrizClave1[i][j]=frase[contador];
                contador++;
            }
        }
    }

    //Determinando numeros segun su posicion en el alfabeto de la palabra clave 1

    for(int i = 0;i<cantidadPalabraClave1;i++){
        for(int j = 0;j<alfabeto.length();j++){
            if(palabraClave1[i]==alfabeto[j]){
                numeros[i] = alfabeto.indexOf(alfabeto[j]);
                break;
            }
        }
    }

    //Ordenando numeros de menor a mayor

    for(int i=0;i<cantidadPalabraClave1;i++){
        min = i;
        for(int j=i+1;j<cantidadPalabraClave1;j++){
            if(numeros[j]<numeros[min]){
                min = j;
            }
        }
        aux=numeros[i];
        numeros[i]=numeros[min];
        numeros[min]=aux;
    }

    //Extrayendo primera frase segun el orden alfabetico en la matriz 1

    for(int ii = 0;ii<cantidadPalabraClave1;ii++){
        for(int i = 0;i<cantidadPalabraClave1;i++){
            if(alfabeto.indexOf(palabraClave1[i])==numeros[contadorExtra]){
                contadorExtra++;
                for(int j = 1;j<cantidadFilasPalabra1;j++){
                    fraseClave1.append(matrizClave1[j][i]);
                    contadorExtra2++;
                }
            }
        }
    }

    min = 0;
    aux = 0;
    contador = 0;
    contadorExtra = 0;

    int cantidadFilasPalabra2 = (fraseClave1.length()/palabraClave2.length()+1)*2;
    int cantidadPalabraClave2 = palabraClave2.length();
    int numeros2[cantidadPalabraClave2];
    int contadorPalabras=0;
    QString matrizClave2[cantidadFilasPalabra2][cantidadPalabraClave2];

    //Introduciendo elementos Matriz Segunda Palabra Clave

    for(int i = 0;i<cantidadPalabraClave2;i++){
        matrizClave2[0][i]=palabraClave2[i];
    }

    for(int i = 1;i<cantidadFilasPalabra2;i++){
        for(int j = 0;j<cantidadPalabraClave2;j++){
            if(contador!=fraseClave1.length()){
                matrizClave2[i][j]=fraseClave1[contador];
                contador++;
            }
        }
    }

    //Determinando numeros segun su posicion en el alfabeto de la palabra clave 2

    for(int i = 0;i<cantidadPalabraClave2;i++){
        for(int j = 0;j<alfabeto.length();j++){
            if(palabraClave2[i]==alfabeto[j]){
                numeros2[i] = alfabeto.indexOf(alfabeto[j]);
                break;
            }
        }
    }

    //Ordenando numeros de menor a mayor

    for(int i=0;i<cantidadPalabraClave2;i++){
        min = i;
        for(int j=i+1;j<cantidadPalabraClave2;j++){
            if(numeros2[j]<numeros2[min]){
                min = j;
            }
        }
        aux=numeros2[i];
        numeros2[i]=numeros2[min];
        numeros2[min]=aux;
    }

    for(int ii = 0;ii<cantidadPalabraClave2;ii++){
        for(int i = 0;i<cantidadPalabraClave2 && contadorPalabras<fraseClave1.length();i++){
            if(alfabeto.indexOf(palabraClave2[i])==numeros2[contadorExtra]){
                contadorExtra++;
                for(int j = 1;matrizClave2[j][i]!="";j++){
                    fraseClave2.append(matrizClave2[j][i]);
                    contadorPalabras++;
                    if(fraseClave1.length()<=cantidadPalabraClave2){
                        break;
                    }
                }
            }
        }
    }

    return fraseClave2;

}

QString SistemesXifrat::descifradoTransposicion2Claves(QString frase, QString palabraClave1, QString palabraClave2)
{
    frase = frase.toLower().replace(" ","");
    palabraClave1 = palabraClave1.toLower().replace(" ","");
    palabraClave2 = palabraClave2.toLower().replace(" ","");
    QString fraseClave1, fraseClave2;
    QString alfabeto = "abcdefghijklmnñopqrstuvwxyz";
    int contador = 0, min, aux, contadorExtra = 0, contadorFrase = 0;
    int cantidadFilasPalabra2 = (frase.length()/palabraClave2.length()+1)*2;
    int cantidadPalabraClave2 = palabraClave2.length();
    int numeros2[cantidadPalabraClave2];
    QString matrizClave2[cantidadFilasPalabra2][cantidadPalabraClave2];

    //Introduciendo elementos Matriz Primera Palabra Clave

    for(int i = 0;i<cantidadPalabraClave2;i++){
        matrizClave2[0][i]=palabraClave2[i];
    }

    //Determinando numeros segun su posicion en el alfabeto de la palabra clave 2

    for(int i = 0;i<cantidadPalabraClave2;i++){
        for(int j = 0;j<alfabeto.length();j++){
            if(palabraClave2[i]==alfabeto[j]){
                numeros2[i] = alfabeto.indexOf(alfabeto[j]);
                break;
            }
        }
    }

    //Ordenando numeros de menor a mayor

    for(int i=0;i<cantidadPalabraClave2;i++){
        min = i;
        for(int j=i+1;j<cantidadPalabraClave2;j++){
            if(numeros2[j]<numeros2[min]){
                min = j;
            }
        }
        aux=numeros2[i];
        numeros2[i]=numeros2[min];
        numeros2[min]=aux;
    }


    //Rellenando matriz con x letra para que funcione el algoritmo siguiente

    for(int i = 1;i<cantidadFilasPalabra2;i++){
        for(int j = 0;j<cantidadPalabraClave2;j++){
            if(contador!=frase.length()){
                matrizClave2[i][j]="a";
                contador++;
            }
        }
    }

    //Ordenando matriz verticalmente segun su posicion en el alfabeto

    for(int ii = 0;ii<cantidadPalabraClave2;ii++){
        for(int i = 0;i<cantidadPalabraClave2;i++){
            if(alfabeto.indexOf(palabraClave2[i])==numeros2[contadorExtra]){
                contadorExtra++;
                for(int j = 1;matrizClave2[j][i]!="";j++){
                    matrizClave2[j][i]=frase[contadorFrase];
                    contadorFrase++;
                    if(frase.length()<palabraClave2.length()){
                        break;
                    }
                }
            }
        }
    }

    contadorExtra = 0;

    //Extrayendo matriz horizontalmente

    for(int i = 1;i<cantidadFilasPalabra2;i++){
        for(int j = 0;j<cantidadPalabraClave2;j++){
            fraseClave1.append(matrizClave2[i][j]);
        }
    }

    min = 0;
    aux = 0;
    contador = 0;
    contadorExtra = 0;
    contadorFrase = 0;

    int numeros[palabraClave1.length()];
    int cantidadFilasPalabra1 = ((fraseClave1.length()/palabraClave1.length())+1)*2;
    int cantidadPalabraClave1 = palabraClave1.length();

    QString matrizClave1[cantidadFilasPalabra1][cantidadPalabraClave1];


    //Introduciendo elementos Matriz Segunda Palabra Clave

    for(int i = 0;i<cantidadPalabraClave1;i++){
        matrizClave1[0][i]=palabraClave1[i];
    }

    //Determinando numeros segun su posicion en el alfabeto de la palabra clave 1

    for(int i = 0;i<cantidadPalabraClave1;i++){
        for(int j = 0;j<alfabeto.length();j++){
            if(palabraClave1[i]==alfabeto[j]){
                numeros[i] = alfabeto.indexOf(alfabeto[j]);
                break;
            }
        }
    }

    //Ordenando numeros de menor a mayor

    for(int i=0;i<cantidadPalabraClave1;i++){
        min = i;
        for(int j=i+1;j<cantidadPalabraClave1;j++){
            if(numeros[j]<numeros[min]){
                min = j;
            }
        }
        aux=numeros[i];
        numeros[i]=numeros[min];
        numeros[min]=aux;
    }


    for(int i = 1;i<cantidadFilasPalabra1;i++){
        for(int j = 0;j<cantidadPalabraClave1;j++){
            if(contador!=fraseClave1.length()){
                matrizClave1[i][j]="a";
                contador++;
            }
        }
    }

    for(int ii = 0;ii<cantidadPalabraClave1;ii++){
        for(int i = 0;i<cantidadPalabraClave1;i++){
            if(alfabeto.indexOf(palabraClave1[i])==numeros[contadorExtra]){
                contadorExtra++;
                for(int j = 1;matrizClave1[j][i]!="";j++){
                    if(contadorFrase<contador){
                        matrizClave1[j][i]=fraseClave1[contadorFrase];
                        contadorFrase++;
                        if(fraseClave1.length()<palabraClave1.length()){
                            break;
                        }
                    }
                }
            }
        }
    }

    for(int i = 1;i<cantidadFilasPalabra1;i++){
        for(int j = 0;j<cantidadPalabraClave1;j++){
            fraseClave2.append(matrizClave1[i][j]);
        }
    }

    return fraseClave2;
}

//Metode vertical paralel

QString SistemesXifrat::cifradoVerticalParalelo(QString frase)
{
    frase = frase.toLower().replace(" ","");
    int contador = 0;
    int tamanoFilas = frase.length();
    if(tamanoFilas%2!=0){
        tamanoFilas++;
    }
    QString matriz[tamanoFilas/2][2];
    QString nuevaFrase = "";

    //Añadiendo informacion

    for(int j = 0;j<2;j++){
        for(int i = 0;i<tamanoFilas/2;i++){
            if(contador<frase.length()){
                matriz[i][j]=frase.at(contador);
                contador++;
            }
        }
    }

    //Mostrando informacion

    for(int i = 0;i<tamanoFilas/2;i++){
        for(int j = 0;j<2;j++){
            nuevaFrase.append(matriz[i][j]);
        }
    }

    return nuevaFrase;
}

QString SistemesXifrat::descifradoVerticalParalelo(QString frase)
{
    frase = frase.toLower().replace(" ","");
    int contador = 0;
    int tamanoFilas = frase.length();
    if(tamanoFilas%2!=0){
        tamanoFilas++;
    }
    QString matriz[tamanoFilas/2][2];
    QString nuevaFrase = "";


    //Añadiendo informacion

    for(int i = 0;i<tamanoFilas/2;i++){
        for(int j = 0;j<2;j++){
            if(contador!=frase.length()){
                matriz[i][j] = frase[contador];
                contador++;
            }
        }
    }

    for(int j = 0;j<2;j++){
        for(int i = 0;i<tamanoFilas/2;i++){
            nuevaFrase.append(matriz[i][j]);
        }
    }

    //Mostrando informacion

    return nuevaFrase;
}

//Sistemes de substitució

//Alfabet Desordenat

QString SistemesXifrat::cifradoAlfabetoDesordenado(QString frase, QString palabraClave){
    frase = frase.toLower().replace(" ","");
    palabraClave = palabraClave.toLower().replace(" ","");
    QString alfabetoNormal = "abcdefghijklmnñopqrstuvwxyz";
    QString alfabeto = "abcdefghijklmnnñopqrstuvwxyz";

    //Ordenando alfabeto con la palabra clave

    alfabeto.prepend(palabraClave);

    for(int i = 0;i<alfabeto.length();i++){
        if(alfabeto.length()==alfabetoNormal.length()){
            break;
        }
        if(alfabeto.count(alfabeto.at(i))>=2){
            int contador=0;
            for(int j = 0;j<alfabeto.length();j++){
                if(alfabeto.at(i)==alfabeto.at(j)){
                    contador++;
                }
                if(contador>=2){
                    alfabeto.remove(j,1);
                    contador--;
                }
                if(alfabeto.count(alfabeto.at(i))==1){
                    break;
                }
            }
        }
    }

    //Rellenando matriz
    for(int i = 0;i<frase.length();i++){
        frase[i] = alfabeto[alfabetoNormal.indexOf(frase[i])];
    }

    return frase;
}

QString SistemesXifrat::descifradoAlfabetoDesordenado(QString frase, QString palabraClave){
    frase = frase.toLower().replace(" ","");
    palabraClave = palabraClave.toLower().replace(" ","");
    QString alfabetoNormal = "abcdefghijklmnñopqrstuvwxyz";
    QString alfabeto = "abcdefghijklmnñopqrstuvwxyz";

    //Ordenando alfabeto con la palabra clave

    alfabeto.prepend(palabraClave);

    for(int i = 0;i<alfabeto.length();i++){
        if(alfabeto.length()==alfabetoNormal.length()){
            break;
        }
        if(alfabeto.count(alfabeto.at(i))>=2){
            int contador=0;
            for(int j = 0;j<alfabeto.length();j++){
                if(alfabeto.at(i)==alfabeto.at(j)){
                    contador++;
                }
                if(contador>=2){
                    alfabeto.remove(j,1);
                    contador--;
                }
                if(alfabeto.count(alfabeto.at(i))==1){
                    break;
                }
            }
        }
    }

    //Rellenando matriz
    for(int i = 0;i<frase.length();i++){
        frase[i] = alfabetoNormal[alfabeto.indexOf(frase[i])];
    }

    return frase;
}

//El codi calendari

QString SistemesXifrat::cifradoCodigoCalendario(QString frase, int mes, int ano){
    frase = frase.toLower().replace(" ","");
    QString alfabeto = "abcdefghijklmnopqrstuvwxyz";
    QString contadorString = "";
    QString diaSemana;
    QString fraseTotal;
    int numeros[frase.length()], intAno, calculoAno, calculoAnoBisiesto, calculoMes, calculoDia, contador, suma;

    //Determinando numeros segun la posicion en el alfabeto de los caracteres de la frase
    for(int i = 0;i<frase.length();i++){
        for(int j = 0;j<alfabeto.length();j++){
            if(frase[i]==alfabeto[j]){
                numeros[i] = alfabeto.indexOf(alfabeto[j]);
                break;
            }
        }
    }

    for(int i = 0;i<frase.length();i++){
        intAno = (ano%100/4), calculoAno = ano%100 + intAno, calculoAnoBisiesto = ano%4==0 ? -1 : 0, calculoMes = mes, calculoDia = numeros[i]+1, contador = 1, suma = 0;

        switch (mes) {
            case 0: case 9: calculoMes = 6; break;
            case 1: case 2: case 10: calculoMes = 2; break;
            case 3: case 6: calculoMes = 5; break;
            case 4: calculoMes = 0; break;
            case 5: calculoMes = 3; break;
            case 7: calculoMes = 1; break;
            case 8: case 11: calculoMes = 4;
            default: break;
        }

        suma = (calculoAno + calculoAnoBisiesto + calculoMes + calculoDia)%7;

        for(int i = 0; calculoDia>7 ;i++){
            calculoDia-=7;
            contador++;
        }

        contadorString = QString::number(contador);

        switch (suma){
            case 1: diaSemana = "L";
                diaSemana.append(contadorString+" ");
                break;
            case 2: diaSemana = "N";
                diaSemana.append(contadorString+" ");
                break;
            case 3: diaSemana = "M";
                diaSemana.append(contadorString+" ");
                break;
            case 4: diaSemana = "J";
                diaSemana.append(contadorString+" ");
                break;
            case 5: diaSemana = "V";
                diaSemana.append(contadorString+" ");
                break;
            case 6: diaSemana = "S";
                diaSemana.append(contadorString+" ");
                break;
            case 0: diaSemana = "D";
                diaSemana.append(contadorString+" ");
                break;
            default: break;
        }

        fraseTotal = fraseTotal.append(diaSemana);
    }

    return fraseTotal;
}

//QString SistemesXifrat::descifradoCodigoCalendario(QString frase, int mes, int ano){

//    frase = frase.replace(" ","");

//    QString alfabeto = "abcdefghijklmnopqrstuvwxyz";
//    QString fraseFinal;
//    int numeroSemana;
//    int numeros[frase.length()], intAno, calculoAno, calculoAnoBisiesto, calculoMes, calculoDia, contador, suma;

//    if(frase.length()%2==0){
//        intAno = (ano%100/4), calculoAno = ano%100 + intAno, calculoAnoBisiesto = ano%4==0 ? -1 : 0, calculoMes = mes, contador = 1, suma = 0;
//        frase.remove(0,frase.length()-2);
//        switch(frase){
//            case frase.contains("L"): numeroSemana=1;break;
//            case frase.contains("N"): numeroSemana=2;break;
//            case frase.contains("M"): numeroSemana=3;break;
//            case frase.contains("J"): numeroSemana=4;break;
//            case frase.contains("V"): numeroSemana=5;break;
//            case frase.contains("S"): numeroSemana=6;break;
//            case frase.contains("D"): numeroSemana=0;break;
//        }

//    }
//    else{
//        return fraseCifrada;
//    }
//}

//QString SistemesXifrat::descifradoCodigoCalendario(QString frase, int mes, int ano){

//}

//Metode de sustitució numérica

QString SistemesXifrat::cifradoSustitucionNumerica(QString frase, QString palabraClave){
    frase = frase.toLower().replace(" ","");
    palabraClave = palabraClave.toLower().replace(" ","");
    QString alfabeto = "abcdefghijklmnopqrstuvxyz";
    QString matriz[alfabeto.length()][4];
    QString nuevaFrase;
    int numeros[palabraClave.length()], numerosFrase[frase.length()], contador = 0, contadorExtra = 0;
    bool comprobarContador = false;

    for(int i = 0;i<palabraClave.length();i++){
        for(int j = 0;j<alfabeto.length();j++){
            if(palabraClave[i]==alfabeto[j]){
                numeros[i] = alfabeto.indexOf(alfabeto[j]);
                break;
            }
        }
    }

    for(int i = 0;i<frase.length();i++){
        for(int j = 0;j<alfabeto.length();j++){
            if(frase[i]==alfabeto[j]){
                numerosFrase[i] = alfabeto.indexOf(alfabeto[j]);
                break;
            }
        }
    }

    for(int i = 0; i<4; i++){
        for(int j = 0; j<alfabeto.length(); j++){
            if(j<(alfabeto.length()-numeros[i])){
                matriz[numeros[i]+contador][i] = QString::number(contadorExtra);
                contador++;
                contadorExtra++;
            }
            else{
                contador = comprobarContador ? contador : 0;
                comprobarContador = true;
                matriz[contador][i] = QString::number(contadorExtra);
                contador++;
                contadorExtra++;
            }
        }
        contador = 0;
        comprobarContador = false;
    }

    contador = 0;

    for(int i = 0; i<frase.length(); i++){

        switch (matriz[numerosFrase[i]][contador%4].toInt()) {
            case 0:
            case 1:
            case 3:
            case 4:
            case 5:
            case 6:
            case 7:
            case 8:
            case 9: nuevaFrase.append("0"); break;
        }

       nuevaFrase.append(matriz[numerosFrase[i]][contador%4]+" ");
       contador++;

    }

    return nuevaFrase;
}

QString SistemesXifrat::descifradoSustitucionNumerica(QString frase, QString palabraClave)
{
    palabraClave = palabraClave.toLower().replace(" ","");
    frase = frase.toLower().replace(" ","");
    QString alfabeto = "abcdefghijklmnopqrstuvxyz";
    QString matriz[alfabeto.length()][4];
    QString nuevaFrase, fraseCortada = "";
    int numeros[palabraClave.length()], numerosFrase[frase.length()], contador = 0, contadorExtra = 0;
    bool comprobarContador = false;

    for(int i = 0;i<palabraClave.length();i++){
        for(int j = 0;j<alfabeto.length();j++){
            if(palabraClave[i]==alfabeto[j]){
                numeros[i] = alfabeto.indexOf(alfabeto[j]);
                break;
            }
        }
    }

    for(int i = 0;i<frase.length();i++){
        for(int j = 0;j<alfabeto.length();j++){
            if(frase[i]==alfabeto[j]){
                numerosFrase[i] = alfabeto.indexOf(alfabeto[j]);
                break;
            }
        }
    }

    for(int i = 0; i<4; i++){
        for(int j = 0; j<alfabeto.length(); j++){
            if(j<(alfabeto.length()-numeros[i])){
                if(contadorExtra<10){
                    matriz[numeros[i]+contador][i] = "0"+QString::number(contadorExtra);
                    contador++;
                    contadorExtra++;
                }
                else{
                    matriz[numeros[i]+contador][i] = QString::number(contadorExtra);
                    contador++;
                    contadorExtra++;
                }
            }
            else{
                if(contadorExtra<10){
                    matriz[numeros[i]+contador][i] = "0"+QString::number(contadorExtra);
                    contador = comprobarContador ? contador : 0;
                    comprobarContador = true;
                    contador++;
                    contadorExtra++;
                }
                else{
                    contador = comprobarContador ? contador : 0;
                    comprobarContador = true;
                    matriz[contador][i] = QString::number(contadorExtra);
                    contador++;
                    contadorExtra++;
                }
            }
        }
        contador = 0;
        comprobarContador = false;
    }

    contador = 0;
    comprobarContador = true;

    while(nuevaFrase.length()!=frase.length()/2){
        fraseCortada = frase.mid(contador,2);

        for(int i = 0; i<alfabeto.length() && comprobarContador; i++){
            for(int j = 0; j<4 && comprobarContador; j++){
                if(fraseCortada==matriz[i][j]){
                    nuevaFrase.append(alfabeto.at(i));
                    comprobarContador = false;
                }
            }
        }
        contador+=2;
        comprobarContador = true;
    }


    return nuevaFrase;
}



