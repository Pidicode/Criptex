#include "xifratsrenaixement.h"
#include "math.h"

XifratsRenaixement::XifratsRenaixement(QObject *parent) : QObject(parent)
{

}

//Tabla Tritemio

QString XifratsRenaixement::cifradoTritemio(QString frase){
    frase = frase.toLower().replace(" ","");
    QString alfabeto = "abcdefghijklmnñopqrstuvwxyz"; //n = 27
    QString fraseModificada = frase.toLower().replace(" ","");

    for(int i = 0;i<frase.length();i++){
        fraseModificada[i] = alfabeto[(alfabeto.indexOf(frase[i]) + i) % 27]; //C(x) = x + k % (mod n)
    }

    return fraseModificada;
}

QString XifratsRenaixement::descifradoTritemio(QString frase){
    frase = frase.toLower().replace(" ","");
    QString alfabeto = "abcdefghijklmnñopqrstuvwxyz";
    QString fraseModificada = frase.toLower().replace(" ","");

    for(int i = 0;i<frase.length();i++){
        fraseModificada[i] = alfabeto[(alfabeto.indexOf(frase[i]) - i + 27) % 27]; //M(x) = x - k (mod n)
    }

    return fraseModificada;
}


//Vigenere

QString XifratsRenaixement::cifradoVigenere(QString frase, QString palabraClave){
    frase = frase.toLower().replace(" ","");
    QString fraseModificada = "";
    QString alfabeto = "abcdefghijklmnopqrstuvwxyz";

    for(int i = 0; i<frase.length();i++){
        fraseModificada.append(alfabeto[(alfabeto.indexOf(frase[i])+alfabeto.indexOf
                                         (palabraClave[i%palabraClave.length()])+26)%26]);
    }

    return fraseModificada;
}




QString XifratsRenaixement::descifradoVigenere(QString frase, QString palabraClave){
    frase = frase.toLower().replace(" ","");
    QString fraseModificada = "";
    QString alfabeto = "abcdefghijklmnopqrstuvwxyz";

    for(int i = 0; i<frase.length();i++){
        fraseModificada.append(alfabeto[(alfabeto.indexOf(frase[i])-alfabeto.indexOf
                                         (palabraClave[i%palabraClave.length()])+26)%26]);
    }



    return fraseModificada;
}



//Bacon

QString XifratsRenaixement::cifradoBacon(QString frase){
    frase = frase.toLower().replace(" ","");
    QString nuevaFrase = "";

    for(int i = 0; i<frase.length(); i++){
        switch(frase[i].toLatin1()){
        case 'a': nuevaFrase.append("AAAAA"); break;
        case 'b': nuevaFrase.append("AAAAB"); break;
        case 'c': nuevaFrase.append("AAABA"); break;
        case 'd': nuevaFrase.append("AAABB"); break;
        case 'e': nuevaFrase.append("AABAA"); break;
        case 'f': nuevaFrase.append("AABAB"); break;
        case 'g': nuevaFrase.append("AABBA"); break;
        case 'h': nuevaFrase.append("AABBB"); break;
        case 'i': nuevaFrase.append("ABAAA"); break;
        case 'j': nuevaFrase.append("ABAAA"); break;
        case 'k': nuevaFrase.append("ABAAB"); break;
        case 'l': nuevaFrase.append("ABABA"); break;
        case 'm': nuevaFrase.append("ABABB"); break;
        case 'n': nuevaFrase.append("ABBAA"); break;
        case 'o': nuevaFrase.append("ABBAB"); break;
        case 'p': nuevaFrase.append("ABBBA"); break;
        case 'q': nuevaFrase.append("ABBBB"); break;
        case 'r': nuevaFrase.append("BAAAA"); break;
        case 's': nuevaFrase.append("BAAAB"); break;
        case 't': nuevaFrase.append("BAABA"); break;
        case 'u': nuevaFrase.append("BAABB"); break;
        case 'v': nuevaFrase.append("BAABB"); break;
        case 'w': nuevaFrase.append("BABAA"); break;
        case 'x': nuevaFrase.append("BABAB"); break;
        case 'y': nuevaFrase.append("BABBA"); break;
        case 'z': nuevaFrase.append("BABBB"); break;
        }
        nuevaFrase.append(" ");
    }

    return nuevaFrase;
}

QString XifratsRenaixement::descifradoBacon(QString frase, QString fraseAntigua){
    frase.replace(" ","");
    if(frase.count()%5==0){
        frase.replace(" ", "").toLower();
        frase.replace("A", "0");
        frase.replace("B", "1");
        int numeros[5], suma = 0, contador = 4;
        QString nuevaFrase = "", alfabeto = "abcdefghiklmnopqrstuwxyz";

        for(int i = 0; i<frase.length();i+=5){
            QStringRef fraseCortada(&frase,i,5);
            for(int j = 0; j<5; j++){
                numeros[j] = fraseCortada[j].digitValue();
            }
            for(int j = 0; j<5; j++){
                numeros[j]*=pow(2,contador);
                suma+=numeros[j];
                contador--;
            }
            nuevaFrase.append(alfabeto[suma]);
            contador = 4;
            suma = 0;
        }
        return nuevaFrase;
    }
    else{
        return fraseAntigua;
    }
}
