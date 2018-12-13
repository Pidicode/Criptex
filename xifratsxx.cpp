#include "xifratsxx.h"
#include "math.h"
#include <vector>

XifratsXX::XifratsXX(QObject *parent) : QObject(parent)
{



}

QString XifratsXX::switchADFGVXcifrado(int n){
    switch (n) {
    case 0: return "A";
    case 1: return "D";
    case 2: return "F";
    case 3: return "G";
    case 4: return "V";
    case 5: return "X";
    }
}

int XifratsXX::switchADFGVXdescifrado(QChar letra){
    switch (letra.unicode()) {
    case 'A': return 0;
    case 'D': return 1;
    case 'F': return 2;
    case 'G': return 3;
    case 'V': return 4;
    case 'X': return 5;
    }
}

QString XifratsXX::cifradoADFGVX(QString frase, QString alfabeto, QString palabraClave){
    frase = frase.toLower().replace(" ","");
    palabraClave = palabraClave.toLower().replace(" ","");
    int contador = 0, numeros[palabraClave.length()], aux = 0, min = 0;
    double cantidadPalabraClave = palabraClave.length();
    int filasMatriz = ceil((double)((frase.length()*2)/cantidadPalabraClave));
    QString nuevaFrase = "", fraseFinal = "";
    QString matriz[filasMatriz][palabraClave.length()];
    QString alfabetoNormal = "abcdefghijklmnñopqrstuvwxyz";

    //Extraient parells de lletres a partir de les posicions de les lletres de la frase

    for(int i = 0; i<frase.length(); i++){
        nuevaFrase.append(switchADFGVXcifrado(ceil((double)(alfabeto.indexOf(frase[i])/6)))
                          +switchADFGVXcifrado((alfabeto.indexOf(frase[i])%6)));
    }

    //Omplint matriu amb tantes columnes com a lletres de la paraula clau amb la nuevaFrase

    for(int i = 0; i<filasMatriz*2; i++){
        for(int j = 0; j<palabraClave.length();j++){
            if(contador<nuevaFrase.length()){
                matriz[i][j] = nuevaFrase[contador];
                contador++;
            }
        }
    }

    //Extraient posició en l'alfabet de les lletres de la paraula clau

    for(int i = 0;i<palabraClave.length();i++){
        numeros[i] = alfabetoNormal.indexOf(palabraClave[i]);
    }

    //Ordenant nombres de menor a major

    for(int i=0;i<palabraClave.length();i++){
        min = i;
        for(int j=i+1;j<palabraClave.length();j++){
            if(numeros[j]<numeros[min]){
                min = j;
            }
        }
        aux=numeros[i];
        numeros[i]=numeros[min];
        numeros[min]=aux;
    }

    contador = 0;
    for(int i = 0; i<palabraClave.length(); i++){
        for(int j = 0; j<filasMatriz; j++){
            fraseFinal.append(matriz[j]
                              [palabraClave.indexOf(alfabetoNormal.at(numeros[contador]))]);
        }
        contador++;
    }

    return fraseFinal;

}



QString XifratsXX::descifradoADFGVX(QString frase, QString alfabeto, QString palabraClave){
    frase = frase.toUpper().replace(" ","");
    palabraClave = palabraClave.toLower().replace(" ","");
    int contador = 0, numeros[palabraClave.length()], aux = 0, min = 0, contadorFrase = 0;
    double cantidadPalabraClave = palabraClave.length();
    int filasMatriz = (double)(frase.length()/cantidadPalabraClave) == 0 ? (double)(frase.length()/cantidadPalabraClave) : ceil((double)(frase.length()/cantidadPalabraClave));
    QString nuevaFrase = "", fraseFinal = "";
    QString matriz[filasMatriz][palabraClave.length()], nuevaMatriz[6][6];
    QString alfabetoNormal = "abcdefghijklmnñopqrstuvwxyz";

    //Omplint matriu

    if(filasMatriz*palabraClave.length()!=frase.length()){
        for(int i = palabraClave.length()-1; i>=0 && contador<filasMatriz*palabraClave.length()-frase.length(); i--){
            matriz[filasMatriz-1][i]="¥";
            contador++;
        }
    }

    //Extraient posició en l'alfabet de les lletres de la paraula clau

    for(int i = 0;i<palabraClave.length();i++){
        numeros[i] = alfabetoNormal.indexOf(palabraClave[i]);
    }

    for(int i=0;i<palabraClave.length();i++){
        min = i;
        for(int j=i+1;j<palabraClave.length();j++){
            if(numeros[j]<numeros[min]){
                min = j;
            }
        }
        aux=numeros[i];
        numeros[i]=numeros[min];
        numeros[min]=aux;
    }

    contador = 0;

    for(int i = 0; i<palabraClave.length(); i++){
        for(int j = 0; j<filasMatriz; j++){
            if(matriz[j][palabraClave.indexOf(alfabetoNormal.at(numeros[contador]))]!="¥"){
                matriz[j][palabraClave.indexOf(alfabetoNormal.at(numeros[contador]))] = frase[contadorFrase];
                contadorFrase++;
            }
        }
        contador++;
    }

    for(int i = 0; i<filasMatriz; i++){
        for(int j = 0; j<palabraClave.length(); j++){
            nuevaFrase.append(matriz[i][j]);
        }
    }


    nuevaFrase.replace("¥","");

    for(int i = 0; i<nuevaFrase.length(); i+=2){
        fraseFinal.append(alfabeto.at(switchADFGVXdescifrado(nuevaFrase[i])*6
                                            +switchADFGVXdescifrado(nuevaFrase[i+1])));
    }


    return fraseFinal;
}

int XifratsXX::mcd(int n1, int n2){
    int mcd = 1;
    for(int i = 1; n1>n2 ? i<n1 : i<n2; i++){
        if(n1%i==0 && n2%i==0){
            mcd=i;
        }
    }
    return mcd;
}

int XifratsXX::rellenarMatrizUI(QString frase, int n){
    QString alfabeto = "abcdefghijklmnopqrstuvwxyz";
    return n>=frase.length() ? n-frase.length() : alfabeto.indexOf(frase[n]);
}

bool XifratsXX::comprobarMatriz(QString palabraClave, int orden){
    int matriz[25][25], contador = 0, determinante = 0;
    palabraClave.replace(" ","");
    QString alfabeto = "abcdefghijklmnopqrstuvwxyz";
    QString alfabetoModificado = "";

    alfabetoModificado.append(palabraClave+alfabeto);

    for(int i = 0;i<orden; i++){
        for(int j = 0; j<orden;j++){
            matriz[i][j]=alfabeto.indexOf(alfabetoModificado[contador]);
            contador++;
            if(contador==orden*orden) break;
        }
    }

    determinante = calcularDeterminante(orden,matriz)<0 ?
                  (calcularDeterminante(orden,matriz)%26)+26 : calcularDeterminante(orden,matriz)%26;

    return mcd(determinante,26) == 1 && determinante != 0 ? true : false;
}


QString XifratsXX::generarMatriz(int rango){
    QString palabraClave, alfabeto = "abcdefghijklmnopqrstuvwxyz";
    int matriz[25][25], determinante;
    bool matrizValida = false;

    for(int i = 0; !matrizValida; i++){
        for(int j = 0; j<rango; j++){
            for(int k = 0; k<rango; k++){
                matriz[j][k] = rand()%26;
            }
        }
        determinante = calcularDeterminante(rango,matriz);
        if(determinante!=0 && mcd(determinante,26)==1) matrizValida = true;
    }

    for(int i=0; i<rango; i++){
        for(int j=0; j<rango; j++){
            palabraClave.append(alfabeto.at(matriz[i][j]));
        }
    }

    return palabraClave;
}

int XifratsXX::calcularDeterminante(int orden, int matriz[25][25]){
    int nuevaMatriz[25][25], contador = 0, determinante = 0, contadorFila = 0;
    if(orden==1){
        return matriz[0][0];
    }
    if(orden==2){
        return (matriz[0][0]*matriz[1][1])-(matriz[0][1]*matriz[1][0]);
    }
    if(orden==3){
        return matriz[0][0]*matriz[1][1]*matriz[2][2]+
               matriz[1][0]*matriz[2][1]*matriz[0][2]+
               matriz[2][0]*matriz[0][1]*matriz[1][2]-
               matriz[0][2]*matriz[1][1]*matriz[2][0]-
               matriz[1][2]*matriz[2][1]*matriz[0][0]-
               matriz[2][2]*matriz[0][1]*matriz[1][0];
    }

    for(int i = 0; i<orden; i++){
        for(int j = 1;j<orden; j++){
            for(int k = 0; k<orden;k++){
                if(k!=i){
                    nuevaMatriz[contadorFila][contador]=matriz[j][k];
                    contador++;
                }
            }
            if (contador == orden-1) contadorFila++;
            contador = 0;
        }          
        determinante+=pow(-1,0+i)*calcularDeterminante(orden-1, nuevaMatriz)*matriz[0][i];
        contador=0;
        contadorFila = 0;
    }

    return determinante;
}




QString XifratsXX::cifradoHill(QString frase, QString palabraClave, int ordre){
    int matriz[ordre][ordre], contador = 0, numerosFinal[ordre];
    memset(numerosFinal, 0, sizeof(numerosFinal));
    QString alfabeto = "abcdefghijklmnopqrstuvwxyz";
    QString alfabetoModificado = "";
    QString fraseFinal = "";
    palabraClave = palabraClave.toLower().replace(" ","");
    frase = frase.toLower().replace(" ","");

    alfabetoModificado.append(palabraClave+alfabeto);

    for(int i = 0;i<ordre; i++){
        for(int j = 0; j<ordre;j++){
            matriz[i][j]=alfabeto.indexOf(alfabetoModificado[contador]);
            contador++;
            if(contador==ordre*ordre) break;
        }
    }

    contador = 0;

    for(int i=0;i<frase.length();i+=ordre){
        QString fraseCortada = frase.mid(i,ordre);
        if(fraseCortada.length()!=ordre) return fraseFinal;
        contador = 0;
        for(int j = 0;j<ordre; j++){
            for(int k = 0; k<ordre;k++){
                numerosFinal[contador]+=matriz[j][k]*alfabeto.indexOf(fraseCortada[k]);
            }
            contador++;
        }
        for(int j = 0;j<ordre;j++){
            fraseFinal.append(alfabeto[numerosFinal[j]%26]);
        }
        for(int j = 0; j<ordre;j++){
            numerosFinal[j]=0;
        }
    }

    return fraseFinal;
}



QString XifratsXX::descifradoHill(QString frase, QString palabraClave, int ordre){
    int matriz[25][25], contador = 0, numerosFinal[ordre], matrizTraspuesta[ordre][ordre], determinante = 0;
    int nuevaMatriz[25][25], matrizInversa[ordre][ordre], inversoModular = 0, contadorInversa = 0;
    int comprobarColumnas = 0, comprobarFilas = 0, contadorColumnas = 0, contadorFilas = 0;
    bool comprobarInverso = false;
    memset(nuevaMatriz, 0, sizeof(nuevaMatriz));
    memset(matriz, 0, sizeof(matriz));
    memset(numerosFinal, 0, sizeof(numerosFinal));
    QString alfabeto = "abcdefghijklmnopqrstuvwxyz";
    QString alfabetoModificado = "";
    QString fraseFinal = "";
    palabraClave = palabraClave.toLower().replace(" ","");
    frase = frase.toLower().replace(" ","");

    alfabetoModificado.append(palabraClave+alfabeto);
    for(int i = 0;i<ordre; i++){
        for(int j = 0; j<ordre;j++){
            matriz[i][j]=alfabeto.indexOf(alfabetoModificado[contador]);
            contador++;
            if(contador==ordre*ordre) break;
        }
    }
    determinante = calcularDeterminante(ordre,matriz)<0 ?
                (calcularDeterminante(ordre,matriz)%26)+26 : calcularDeterminante(ordre,matriz)%26;

    //Creant matriu inversa

    contador = 0;
    //Transposada
    for(int i = 0;i<ordre; i++){
        for(int j = 0; j<ordre;j++){
            matrizTraspuesta[i][j]=matriz[j][i];
        }
    }

    //Adjunta

    for(int i = 0; i<ordre*ordre; i++){
        for(int j = 0;j<ordre; j++){
            for(int k = 0; k<ordre;k++){
                if(k!=comprobarColumnas%ordre && j!=comprobarFilas){
                    nuevaMatriz[contadorFilas][contadorColumnas]=matrizTraspuesta[j][k];
                    contadorColumnas++;
                }
            }
            if (contadorColumnas == ordre-1) contadorFilas++;
            contadorColumnas = 0;
        }
        contadorFilas = 0;
        comprobarColumnas++;
        if(comprobarColumnas%ordre==0) comprobarFilas++;
        if(i%ordre==0 && i!=0) contadorInversa++;
        matrizInversa[contadorInversa][i%ordre]=calcularDeterminante(ordre-1,nuevaMatriz);


    }
    contador = 0;

    //Canviant el signes

    for(int i = 0; i<ordre; i++){
        for(int j = 0;j<ordre; j++){
            matrizInversa[i][j]*=pow(-1,i+j);
        }
    }


    //Trobant l'invers modular

    for(int i = 0;!comprobarInverso;i++){
        if((i*determinante)%26==1){
            inversoModular = i;
            comprobarInverso = true;
        }
    }



    //Multiplicant la nova matriu per l'invers del determinant per obtenir la inversa

    for(int i = 0;i<ordre; i++){
        for(int j = 0; j<ordre;j++){
            matrizInversa[i][j]=(((matrizInversa[i][j]*inversoModular)%26)+26)%26;
        }
    }


    contador = 0;


    //Omplint matriu amb la array extreta

    for(int i=0;i<frase.length();i+=ordre){
        QString fraseCortada = frase.mid(i,ordre);
        if(fraseCortada.length()!=ordre) return fraseFinal;
        contador = 0;
        for(int j = 0;j<ordre; j++){
            for(int k = 0; k<ordre;k++){
                numerosFinal[contador]+=matrizInversa[j][k]*alfabeto.indexOf(fraseCortada[k]);
            }
            contador++;
        }
        for(int j = 0;j<ordre;j++){
            fraseFinal.append(alfabeto[numerosFinal[j]%26]);
        }
        for(int j = 0; j<ordre;j++){
            numerosFinal[j]=0;
        }

    }

    return fraseFinal;
}


QString XifratsXX::cifradoEnigma(QString frase, QString palabraClave, QString plugboard, int pos1, int pos2, int pos3){
    QString alfabeto  = "abcdefghijklmnopqrstuvwxyz"; 
    QString reflector = "yruhqsldpxngokmiebfzcwvjat";
    QString rotores[3] = {"ekmflgdqvzntowyhxuspaibrcj", "ajdksiruxblhwtmcqgznpyfvoe", "bdfhjlcprtxvznyeiwgakmusqo"};
    int contadorRotor[3];

    frase = frase.toLower().replace(" ","");
    palabraClave = palabraClave.toLower().replace(" ","");
    plugboard.append(" ");

    //Obteniendo la posicion de los rotores segun la palabraClave introducida

    for(int i = 0; i<3; i++){
        contadorRotor[i] = alfabeto.indexOf(palabraClave[i]);
    }

    //Algoritmo enigma

    for(int i = 0; i<frase.length(); i++){

        //Intercambiando letras segun el plugboard si es necesario

        if(plugboard.contains(frase[i])){
            frase[i] = plugboard[plugboard.indexOf(frase[i])+1] == " " ?
                       plugboard[plugboard.indexOf(frase[i])-1] : plugboard[plugboard.indexOf(frase[i])+1];
        }

        contadorRotor[2]++;

        if(contadorRotor[2]%26==0) contadorRotor[2]=0;
        if(contadorRotor[1]%26==0 && contadorRotor[1]!=0) contadorRotor[1]=0;
        if(contadorRotor[0]%26==0 && contadorRotor[0]!=0) contadorRotor[0]=0;
        if(alfabeto.at(contadorRotor[2])=='w') contadorRotor[1]++;
        if(alfabeto.at(contadorRotor[1])=='f') contadorRotor[0]++;

        frase[i]=alfabeto.at(((alfabeto.indexOf(rotores[pos3].at((alfabeto.indexOf(frase[i])
                                                                  +contadorRotor[2])%26))-contadorRotor[2])+26)%26);
        frase[i]=alfabeto.at(((alfabeto.indexOf(rotores[pos2].at((alfabeto.indexOf(frase[i])
                                                                  +contadorRotor[1])%26))-contadorRotor[1])+26)%26);
        frase[i]=alfabeto.at(((alfabeto.indexOf(rotores[pos1].at((alfabeto.indexOf(frase[i])
                                                                  +contadorRotor[0])%26))-contadorRotor[0])+26)%26);

        frase[i]=reflector.at(alfabeto.indexOf(frase[i]));

        frase[i]=alfabeto.at(((rotores[pos1].indexOf(alfabeto.at((alfabeto.indexOf(frase[i])
                                                                  +contadorRotor[0])%26))-contadorRotor[0])+26)%26);
        frase[i]=alfabeto.at(((rotores[pos2].indexOf(alfabeto.at((alfabeto.indexOf(frase[i])
                                                                  +contadorRotor[1])%26))-contadorRotor[1])+26)%26);
        frase[i]=alfabeto.at(((rotores[pos3].indexOf(alfabeto.at((alfabeto.indexOf(frase[i])
                                                                  +contadorRotor[2])%26))-contadorRotor[2])+26)%26);

        if(plugboard.contains(frase[i])){
            frase[i] = plugboard[plugboard.indexOf(frase[i])+1] == " " ?
                       plugboard[plugboard.indexOf(frase[i])-1] : plugboard[plugboard.indexOf(frase[i])+1];
        }

    }

    return frase.toUpper();

}







