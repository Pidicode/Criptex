#include "xifratsxix.h"
#include <math.h>

XifratsXIX::XifratsXIX(QObject *parent) : QObject(parent)
{

}

QString XifratsXIX::cifradoDelastelle(QString frase, QString palabraClave, int longitud){
    frase = frase.toLower().replace(" ","");
    palabraClave = palabraClave.toLower().replace(" ","");
    QString alfabetoModificado = "";
    QString alfabeto = "abcdefghiklmnopqrstuvwxyz";
    QString fraseFinal = "", fraseCortada = "";
    QString numF = "", numC = "", numFinal;

    //Ordenando alfabeto con la palabra clave

    alfabetoModificado.append(palabraClave);

    for(int i = 0;i<alfabeto.length();i++){
        if(!(alfabetoModificado.contains(alfabeto[i]))){
            alfabetoModificado.append(alfabeto[i]);
        }
    }

    //Separando la frase en bloques de 5, extrayendo numeros para el cifrado

    for(int i = 0; i<frase.length();i+=longitud){

        fraseCortada = frase.mid(i,longitud);
        for(int j = 0; j<fraseCortada.length(); j++){
            if(fraseCortada[j]=="j"){
                numF.append(QString::number(ceil((double)(alfabetoModificado.indexOf("i")/5))));
                numC.append(QString::number(alfabetoModificado.indexOf("i")%5));
            }
            else{
                numF.append(QString::number(ceil((double)(alfabetoModificado.indexOf(fraseCortada[j])/5))));
                numC.append(QString::number(alfabetoModificado.indexOf(fraseCortada[j])%5));
            }
        }
        numFinal.append(numF+numC);

        for(int j = 0; j<fraseCortada.length()*2; j+=2){
            fraseFinal.append(alfabetoModificado.at(numFinal[j].digitValue()*5+numFinal[j+1].digitValue()));
        }  
        fraseFinal.append(" "); numFinal = "", numF = "", numC ="";
    }

    return fraseFinal;
}




QString XifratsXIX::descifradoDelastelle(QString frase, QString palabraClave, int longitud){
    frase = frase.toLower().replace(" ","");
    frase = frase.replace("ij", "i");
    palabraClave = palabraClave.toLower().replace(" ","");
    QString alfabetoModificado = "", alfabeto = "abcdefghiklmnopqrstuvwxyz";
    QString fraseCortada = "", fraseFinal = "", numFC = "";

    //Ordenando alfabeto con la palabra clave

    alfabetoModificado.append(palabraClave);

    for(int i = 0;i<alfabeto.length();i++){
        if(!(alfabetoModificado.contains(alfabeto[i]))){
            alfabetoModificado.append(alfabeto[i]);
        }
    }

    //Separando la frase en bloques de 5, extrayendo numeros para el cifrado

    for(int i = 0; i<frase.length();i+=longitud){

        fraseCortada = frase.mid(i,longitud);

        for(int j = 0; j<fraseCortada.length(); j++){
            if(fraseCortada[j]=="j"){
                numFC.append(QString::number(ceil((double)(alfabetoModificado.indexOf("i")/5)))
                           +QString::number(alfabetoModificado.indexOf("i")%5));
            }
            else{
                numFC.append(QString::number(ceil((double)(alfabetoModificado.indexOf(fraseCortada[j])/5)))
                           +QString::number(alfabetoModificado.indexOf(fraseCortada[j])%5));
            }
        }

        for(int j = 0; j<fraseCortada.length(); j++){
            fraseFinal.append(alfabetoModificado.at(numFC[j].digitValue()*5+numFC[j+fraseCortada.length()].digitValue()));
        }

        numFC = "";
    }

    return fraseFinal;
}


QString XifratsXIX::cifradoPlayfair(QString frase, QString palabraClave){
    frase = frase.toLower().replace(" ","");
    palabraClave = palabraClave.toLower().replace(" ","");
    QString matriz[5][5];
    QString alfabetoModificado = "", alfabeto = "abcdefghiklmnopqrstuvwxyz";
    QString num1, num2, numIJ;
    QString fraseFinal;
    int contador = 0;

    //Introduint la paraula clau a l'alfabet

    alfabetoModificado.append(palabraClave);

    for(int i = 0;i<alfabeto.length();i++){
        if(!(alfabetoModificado.contains(alfabeto[i]))){
            alfabetoModificado.append(alfabeto[i]);
        }
    }

    //Omplint matriu

    for(int i = 0; i<5;i++){
        for(int j = 0; j<5 && contador<25;j++){
            matriz[i][j]=alfabetoModificado[contador];
            contador++;
        }
    }

    //Añadiendo elemento al final para que la frase sea par

    if(frase.length()%2!=0){
        frase.append("x");
    }

    //Algorisme de xifrat

    for(int i = 0; i<frase.length(); i+=2){

        if(frase[i]=="j"){
            numIJ.append(QString::number(ceil((double)(alfabetoModificado.indexOf("i")/5)))
                         +QString::number(alfabetoModificado.indexOf("i")%5)+" ");
        }
        else{
            num1.append(QString::number(ceil((double)(alfabetoModificado.indexOf(frase[i])/5)))
                        +QString::number(alfabetoModificado.indexOf(frase[i])%5));

            num2.append(QString::number(ceil((double)(alfabetoModificado.indexOf(frase[i+1])/5)))
                        +QString::number(alfabetoModificado.indexOf(frase[i+1])%5));
        }

        if(num1[0]==num2[0]){
            fraseFinal.append(matriz[num1[0].digitValue()][(num1[1].digitValue()+1)%5]);
            fraseFinal.append(matriz[num2[0].digitValue()][(num2[1].digitValue()+1)%5]);
        }
        else if(num1[1]==num2[1]){
            fraseFinal.append(matriz[(num1[0].digitValue()+1)%5][num1[1].digitValue()]);
            fraseFinal.append(matriz[(num2[0].digitValue()+1)%5][num2[1].digitValue()]);
        }
        else if(num1[1].digitValue()>num2[1].digitValue()){
            int resta = num1[1].digitValue()-num2[1].digitValue();
            fraseFinal.append(matriz[num1[0].digitValue()][num1[1].digitValue()-resta]);
            fraseFinal.append(matriz[num2[0].digitValue()][num2[1].digitValue()+resta]);
        }
        else if(num1[1].digitValue()<num2[1].digitValue()){
            int resta = num2[1].digitValue()-num1[1].digitValue();
            fraseFinal.append(matriz[num1[0].digitValue()][num1[1].digitValue()+resta]);
            fraseFinal.append(matriz[num2[0].digitValue()][num2[1].digitValue()-resta]);
        }


        num1 = ""; num2 = "";
    }

    return fraseFinal;
}



QString XifratsXIX::descifradoPlayfair(QString frase, QString palabraClave){
    frase = frase.toLower().replace(" ","");
    palabraClave = palabraClave.toLower().replace(" ","");
    QString matriz[5][5];
    QString alfabeto = "abcdefghiklmnopqrstuvwxyz", alfabetoModificado = "";
    QString num1, num2, numIJ;
    QString fraseFinal;
    int contador = 0;

    //Introduciendo palabra clave al alfabeto

    //alfabeto.prepend(palabraClave);
    alfabetoModificado.append(palabraClave);

    for(int i = 0;i<alfabeto.length();i++){
        if(!(alfabetoModificado.contains(alfabeto[i]))){
            alfabetoModificado.append(alfabeto[i]);
        }
    }

    //Rellenando matriz

    for(int i = 0; i<5;i++){
        for(int j = 0; j<5 && contador<25;j++){
            matriz[i][j]=alfabetoModificado[contador];
            contador++;
        }
    }

    //Añadiendo elemento al final para que la frase sea par

    if(frase.length()%2!=0){
        frase.append("x");
    }


    //Algoritmo del cifrado


    for(int i = 0; i<frase.length(); i+=2){

        if(frase[i]=="j"){
            numIJ.append(QString::number(ceil((double)(alfabetoModificado.indexOf("i")/5)))
                         +QString::number(alfabetoModificado.indexOf("i")%5)+" ");
        }
        else{
            num1.append(QString::number(ceil((double)(alfabetoModificado.indexOf(frase[i])/5)))
                        +QString::number(alfabetoModificado.indexOf(frase[i])%5));

            num2.append(QString::number(ceil((double)(alfabetoModificado.indexOf(frase[i+1])/5)))
                        +QString::number(alfabetoModificado.indexOf(frase[i+1])%5));
        }

        // Si m1 y m2 se encuentran en la misma fila, escoger c1 y c2 situados a su derecha (circularmente).

        if(num1[0]==num2[0]){
            fraseFinal.append(matriz[num1[0].digitValue()][(num1[1].digitValue()-1+5)%5]);
            fraseFinal.append(matriz[num2[0].digitValue()][(num2[1].digitValue()-1+5)%5]);
        }   
        else if(num1[1]==num2[1]){
            fraseFinal.append(matriz[(num1[0].digitValue()-1+5)%5][num1[1].digitValue()]);
            fraseFinal.append(matriz[(num2[0].digitValue()-1+5)%5][num2[1].digitValue()]);
        }


        else if(num1[1].digitValue()>num2[1].digitValue()){
            int resta = num1[1].digitValue()-num2[1].digitValue();
            fraseFinal.append(matriz[num1[0].digitValue()][num1[1].digitValue()-resta]);
            fraseFinal.append(matriz[num2[0].digitValue()][num2[1].digitValue()+resta]);
        }
        else if(num1[1].digitValue()<num2[1].digitValue()){
            int resta = num2[1].digitValue()-num1[1].digitValue();
            fraseFinal.append(matriz[num1[0].digitValue()][num1[1].digitValue()+resta]);
            fraseFinal.append(matriz[num2[0].digitValue()][num2[1].digitValue()-resta]);
        }

        num1 = ""; num2 = "";
    }

    return fraseFinal;
}

QString XifratsXIX::cifradoPrimos(QString frase){
    frase = frase.toLower().replace(" ","");
    QString alfabeto = "abcdefghijklmnñopqrstuvxyz";
    bool comprobarPrimo = true;
    int numerosPrimos[26], contador = 0;
    double multiplicacion = 1;

    for(int i = 1; i<100; i++){
        for(int j = 1; j<i;j++){
            if(i%j==0 && j!=1){
                comprobarPrimo = false;
            }
        }
        if(comprobarPrimo){
            numerosPrimos[contador] = i;
            contador++;
        }
        else{
            comprobarPrimo = true;
        }
    }

    for(int i = 0; i<frase.length(); i++){
        multiplicacion*=numerosPrimos[alfabeto.indexOf(frase[i])];
    }

    return QString::number(multiplicacion);

}

QString XifratsXIX::descifradoPrimos(QString frase){
    QString fraseFinal = "";
    QString alfabeto = "abcdefghijklmnñopqrstuvxyz";
    double numero = frase.toDouble(), multiplicacion = 1;
    int divisores[26], contador = 0, numerosPrimos[26];
    bool comprobarPrimo;

    for(int i = 1; multiplicacion!=numero;i++){
        if(fmod(numero,(double)i)==0){
            numero/=i;
            divisores[contador]=i;
            multiplicacion*=i;
            contador++;
        }
    }

    for(int i = 1; i<100; i++){
        for(int j = 1; j<i;j++){
            if(i%j==0 && j!=1){
                comprobarPrimo = false;
            }
        }
        if(comprobarPrimo){
            numerosPrimos[contador] = i;
            contador++;
        }
        else{
            comprobarPrimo = true;
        }
    }

    for(int i = 0; i<26; i++){
        for(int j = 0; j<26; j++){
            if(divisores[i]==numerosPrimos[i]){
                fraseFinal.append(alfabeto.at(i));
                break;
            }
        }
    }

    return fraseFinal;
}

QString XifratsXIX::cifradoMorse(QString frase){
    QString nuevaFrase = "";
    QString alfabeto = "abcdefghijklmnopqrstuvwxyz0123456789.,?:;-/<! ";
    QString alfabetoMorse[] = {".- ","-... ","-.-. ","-.. ",". ",
                               "..-. ","--. ",".... ",".. ",".--- ",
                               "-.- ",".-.. ","-- ","-. ","--- ",
                               ".--. ","--.- ",".-. ","... ","- ","..- ",
                               "...- ",".-- ","-..- ","-.-- ","--.. ",
                               "----- ",".---- ","..--- ", "...-- ","....- ",
                               "..... ","-.... ","--... ","---.. ","----. ",
                               ".-.-.- ","-.-.-- ","..--.. ","---... ","-.-.-. ",
                               "-....- ","-..-. ",".-..-. ","--..-- ","/ "};
    for(int i = 0; i<frase.length(); i++ ){
        nuevaFrase.append(alfabetoMorse[alfabeto.indexOf(frase[i])]);
    }
    return nuevaFrase;
}


//Descifrado
QString XifratsXIX::descifradoMorse(QString frase){
    QString nuevaFrase = "";
    QString alfabeto = "abcdefghijklmnopqrstuvwxyz0123456789.,?:;-/<! ";
    QStringList opcionesMorse;

    opcionesMorse<<".-"<<"-..."<<"-.-."<<"-.."<<"."
                 <<"..-."<<"--."<<"...."<<".."<<".---"
                 <<"-.-"<<".-.."<<"--"<<"-."<<"---"
                 <<".--."<<"--.-"<<".-."<<"..."<<"-"
                 <<"..-"<<"...-"<<".--"<<"-..-"<<"-.--"
                 <<"--.."<<"-----"<<".----"<<"..---"<<"...--"
                 <<"....-"<<"....."<<"-...."<<"--..."<<"---.."
                 <<"----."<<".-.-.-"<<"-.-.--"<<"..--.."<<"---..."
                 <<"-.-.-."<<"-....-"<<"-..-."<<".-..-."<<"--..--"<<"/";

    frase.prepend(" "); frase.append(" ");
    frase.replace("./", ". /");frase.replace("-/", "- /");
    frase.replace("/.", "/ .");frase.replace("/-", "/ -");

    for(int i = 1; i<frase.length(); i++ ){
        QString fraseCortada = frase.section(' ',i,i);
        if(fraseCortada=="")break;
        nuevaFrase.append(alfabeto.at(opcionesMorse.indexOf(fraseCortada)));
    }
    return nuevaFrase;
}



QString XifratsXIX::cifradoNihilista(QString frase, QString palabraClave, QString palabraClave2){
    QString alfabeto = "abcdefghiklmnopqrstuvwxyz";
    QString alfabetoModificado = "";
    QString numerosPalabra = "", numerosFrase = "", numerosTotal = "";
    QString fraseCortada2 = "";
    QString fraseCortada1 = "";
    frase = frase.replace(" ","").toLower();
    palabraClave.replace(" ","");
    palabraClave2.replace(" ","");

    //Ordenando nuevo alfabeto

    alfabetoModificado.append(palabraClave);

    for(int i = 0;i<alfabeto.length();i++){
        if(!(alfabetoModificado.contains(alfabeto[i]))){
            alfabetoModificado.append(alfabeto[i]);
        }
    }

    //Extrayendo numeros segun la matriz de la palabra clave 2

    for(int i = 0; i<palabraClave2.length(); i++){
        if(palabraClave2[i]=="j"){
            numerosPalabra.append(QString::number(ceil((double)(alfabetoModificado.indexOf("i")/5)))
                         +QString::number(alfabetoModificado.indexOf("i")%5));
        }
        else{
            numerosPalabra.append(QString::number(ceil((double)(alfabetoModificado.indexOf(palabraClave2[i])/5)))
                        +QString::number(alfabetoModificado.indexOf(palabraClave2[i])%5));
        }
    }

    //Extrayendo numeros segun la matriz de la frase

    for(int i = 0; i<frase.length(); i++){
        if(frase[i]=="j"){
            numerosFrase.append(QString::number(ceil((double)(alfabetoModificado.indexOf("i")/5)))
                         +QString::number(alfabetoModificado.indexOf("i")%5));
        }
        else{
            numerosFrase.append(QString::number(ceil((double)(alfabetoModificado.indexOf(frase[i])/5)))
                        +QString::number(alfabetoModificado.indexOf(frase[i])%5));
        }
    }

    //Sumando numeros palabra frase

    for(int i = 0; i<frase.length()*2; i+=2){
        fraseCortada1 = numerosFrase.mid(i%numerosFrase.length(),2);
        fraseCortada2 = numerosPalabra.mid(i%numerosPalabra.length(),2);
        if(fraseCortada2.toInt()+fraseCortada1.toInt()>100){
            numerosTotal.append("0"+QString::number(fraseCortada2.toInt()+fraseCortada1.toInt()-100));
        }
        else if(fraseCortada2.toInt()+fraseCortada1.toInt()<10){
            numerosTotal.append("0"+QString::number(fraseCortada2.toInt()+fraseCortada1.toInt()));
        }
        else{
            numerosTotal.append(QString::number(fraseCortada2.toInt()+fraseCortada1.toInt()));
        }
    }

    //Separando en grupos de 5
    for(int i = 5; i<numerosTotal.length(); i+=6){
        numerosTotal.insert(i, " ");
    }

    return numerosTotal;
}

QString XifratsXIX::descifradoNihilista(QString frase, QString palabraClave, QString palabraClave2){
    QString alfabeto = "abcdefghiklmnopqrstuvwxyz";
    QString alfabetoModificado= "";
    QString numerosPalabra = "", numerosTotal = "", fraseFinal = "";
    QString fraseCortada2 = "";
    QString fraseCortada1 = "";
    frase = frase.replace(" ","");
    palabraClave.replace(" ","");
    palabraClave2.replace(" ","");

    //Ordenando nuevo alfabeto

    alfabetoModificado.append(palabraClave);

    for(int i = 0;i<alfabeto.length();i++){
        if(!(alfabetoModificado.contains(alfabeto[i]))){
            alfabetoModificado.append(alfabeto[i]);
        }
    }

    //Extrayendo numeros segun la matriz de la palabra clave 2

    for(int i = 0; i<palabraClave2.length(); i++){
        if(palabraClave2[i]=="j"){
            numerosPalabra.append(QString::number(ceil((double)(alfabetoModificado.indexOf("i")/5)))
                         +QString::number(alfabetoModificado.indexOf("i")%5));
        }
        else{
            numerosPalabra.append(QString::number(ceil((double)(alfabetoModificado.indexOf(palabraClave2[i])/5)))
                        +QString::number(alfabetoModificado.indexOf(palabraClave2[i])%5));
        }
    }

    //Sumando numeros palabra frase

    for(int i = 0; i<frase.length(); i+=2){
        fraseCortada1 = frase.mid(i%frase.length(),2);
        fraseCortada2 = numerosPalabra.mid(i%numerosPalabra.length(),2);
        if(fraseCortada1.toInt()-fraseCortada2.toInt()<0){
            numerosTotal.append(QString::number(fraseCortada1.toInt()-fraseCortada2.toInt()+100));
        }
        else if(fraseCortada1.toInt()-fraseCortada2.toInt()<10){
            numerosTotal.append("0"+QString::number(fraseCortada1.toInt()-fraseCortada2.toInt()));
        }
        else{
            numerosTotal.append(QString::number(fraseCortada1.toInt()-fraseCortada2.toInt()));
        }
    }

    for(int i = 0; i<frase.length(); i+=2){
        fraseFinal.append(alfabetoModificado.at((numerosTotal[i].digitValue())*5
                                                +(numerosTotal[i+1].digitValue())));
    }

    return fraseFinal;
}

QString XifratsXIX::cifradoRailFence(QString frase, int railes){
    if(railes == 0 || railes == 1) return frase;
    frase = frase.toLower().replace(" ","");
    QString matriz[railes][frase.length()];
    QString nuevaFrase = "";
    bool comprobar = false;
    int contador = 0;

    //Introduint elements en la matriu diagonalment
    for(int i = 0; i<frase.length(); i++){
        matriz[comprobar ? contador-- : contador++][i]=frase[i];
        if(contador == railes-1) comprobar = true;
        if(contador == 0) comprobar = false;
    }

    //Extraient els elements de la matriu horitzontalment
    for(int i = 0; i<railes;i++){
        for(int j = 0; j<frase.length();j++){
            if(matriz[i][j]!=""){
                nuevaFrase.append(matriz[i][j]);
            }
        }
    }

    return nuevaFrase;
}



QString XifratsXIX::descifradoRailFence(QString frase, int railes){
    if(railes == 0 || railes == 1) return frase;
    frase = frase.toLower().replace(" ","");
    QString matriz[railes][frase.length()];
    QString nuevaFrase = "";
    bool comprobar = false;
    int contador = 0;

    //Introduint "." per col·locar les lletres posteriorment
    for(int i = 0; i<frase.length(); i++){
        matriz[comprobar ? contador-- : contador++][i]=".";
        if(contador == railes-1) comprobar = true;
        if(contador == 0) comprobar = false;
    }


    contador = 0;

    //Introduint caràcters on no hi hagi " ", o sigui, en els punts
    for(int i = 0; i<railes;i++){
        for(int j = 0; j<frase.length();j++){
            if(matriz[i][j]!=""){
                matriz[i][j]=frase[contador];
                contador++;
            }
        }
    }

    contador = 0;
    comprobar = false;

    //Llegint matriu horitzontalment
    for(int i = 0; i<frase.length(); i++){
        nuevaFrase.append(matriz[comprobar ? contador-- : contador++][i]);
        if(contador == railes-1) comprobar = true;
        if(contador == 0) comprobar = false;
    }



    return nuevaFrase;
}









