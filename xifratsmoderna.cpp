#include "xifratsmoderna.h"
#include "math.h"
#include "xifratsxx.h"
#include <QDebug>
#include <time.h>


XifratsModerna::XifratsModerna(QObject *parent) : QObject(parent)
{

}

QString XifratsModerna::cifradoBinario(QString frase){
    int digitoAscii;
    QString numeroBinario = "", digitoBinario;
    for(int i=0; i<frase.length();i++){
        digitoAscii = frase[i].toLatin1();
        for(int j = 7; j>=0; j--){
            if(digitoAscii>=pow(2,j)){
                numeroBinario.append("1");
                digitoAscii-=pow(2,j);
            }
            else{
                numeroBinario.append("0");
            }
        }
        numeroBinario.append(" ");
    }


    return numeroBinario;
}

QString XifratsModerna::descifradoBinario(QString frase){
    QString fraseFinal = "", fraseCortada = "";
    frase.replace(" ","");
    int contador = 7, numeroAscii = 0;

    for(int i=0; i<frase.length();i+=8){
        fraseCortada = frase.mid(i,8);
        for(int j = 0; j<8; j++){
            if(fraseCortada[j]=="1"){
                numeroAscii+=pow(2,contador);
                contador--;
            }
            else{
                contador--;
            }

        }
        contador=7;
        fraseFinal.append((char)numeroAscii);
        numeroAscii=0;
    }

    return fraseFinal;
}

int modulo(int a, int b, int n){
    long long x = 1, y = a;
    while (b>0){
        if (b%2 == 1) {
            x = (x*y) % n; // multiplicando la base
        }
        y = (y*y) % n; // elevando la base
        b /= 2;
    }
    return x % n;
}

QString XifratsModerna::cifradoRSA(QString frase, QString eString, QString nString){
    int e, n;
    QString fraseFinal = "";
    //Passem dString i nString (extrets dels TextFields, en QString), a int per poder operar amb ells.
    e = eString.toInt();
    n = nString.toInt();

    //C = (M^e) mod n
    for(int i = 0; i<frase.length(); i++){
        fraseFinal.append(QString::number(modulo(frase[i].toLatin1(),e,n),16)+" ");
    }

    return fraseFinal;
}


QString XifratsModerna::descifradoRSA(QString frase, QString dString, QString nString){
    int d, n;
    bool ok;
    QString fraseFinal = "", fraseCortada = "";
    //Passem dString i nString (extrets dels TextFields, en QString), a int per poder operar amb ells.
    d = dString.toInt();
    n = nString.toInt();

    for(int i = 0; i<frase.length(); i++){
        fraseCortada = frase.section(" ",i,i);
        fraseFinal.append((char)modulo(fraseCortada.toInt(&ok, 16),d,n));
    }

    return fraseFinal;
}

QString XifratsModerna::generarClaveRSA(QString qString, QString pString, QString eString, QString nString, QString dString ){
    int q, p, z, n, random, e = 0, i;
    XifratsXX funcionesXX;
    //Passem qString i pString(extret d'un TextField, en QString), a int per poder operar amb ells.
    q = qString.toInt();
    p = pString.toInt();
    n = q*p;
    z = (p-1)*(q-1);

    //Si el TextField de n no esta omplert al programa, el retorna.
    if(nString==""){
        return QString::number(n);
    }

    if(eString==""){
        srand(time(NULL));
        while(e==0){
            random = rand()%z+1;
            if(funcionesXX.mcd(random,z)==1){
                e = random;
            }
        }
        return QString::number(e);
    }

    if(dString==""){
        int d[3] = {0}, x[3] = {0}, y[3] = {0}, q[3]= {0}, c = 1;
        e = eString.toInt();

        d[0] = z; d[1] = e; x[0] = 1; x[1] = 0; y[0] = 0; y[1] = 1;

        while(d[c%3]!=0){
            q[(c+1)%3] = d[(c-1)%3]/d[c%3];
            d[(c+1)%3] = d[(c-1)%3]-q[(c+1)%3]*d[c%3];
            x[(c+1)%3] = x[(c-1)%3]-q[(c+1)%3]*x[c%3];
            y[(c+1)%3] = y[(c-1)%3]-q[(c+1)%3]*y[c%3];
            c++;
        }

        if(y[(c-1)%3]<0){
            y[(c-1)%3]+=z;
        }

        i = y[(c-1)%3];

        return QString::number(i);
    }
}



QString XifratsModerna::cifradoRC4(QString frase, QString palabraClave){
    int vectorS[256], vectorK[256], keystream[frase.length()];
    int j = 0, i = 0, t = 0, aux = 0;
    QString fraseFinal = "";

    //Omplint els vector S i T amb els seus valors corresponents
    for(i = 0; i<256; i++){
        vectorS[i] = i;
        vectorK[i] = palabraClave[i%palabraClave.length()].toLatin1();
    }

    //Algorisme KSA
    i = 0;

    for(i = 0; i<256; i++){
        j = (j+vectorS[i] + vectorK[i]) % 256;
        aux = vectorS[i];
        vectorS[i] = vectorS[j];
        vectorS[j] = aux;
    }

    //Algorisme PRGA
    i = 0;
    j = 0;
    aux = 0;

    for(int k = 0; k<frase.length(); k++){
        i = (i + 1) % 256;
        j = (j + vectorS[i]) % 256;
        aux = vectorS[i];
        vectorS[i] = vectorS[j];
        vectorS[j] = aux;
        t = (vectorS[i] + vectorS[j]) % 256;
        keystream[k] = vectorS[t];
    }

    //XOR
    for(int i = 0; i<frase.length(); i++){
        fraseFinal.append(QString::number(frase[i].toLatin1() ^ keystream[i],16)+" ");
    }
    frase = frase.remove(0,frase.length()-1);

    return fraseFinal;
}


QString XifratsModerna::descifradoRC4(QString frase, QString palabraClave){
    int vectorS[256], vectorK[256], keystream[frase.length()], j = 0, i = 0, t = 0, aux = 0, XOR = 0;
    QString fraseFinal = "", fraseCortada = "";
    bool ok;

    //Rellenando vector S i T con sus valores correspondientes

    for(i = 0; i<256; i++){
        vectorS[i] = i;
        vectorK[i] = palabraClave[i%palabraClave.length()].toLatin1();
    }

    //Algoritmo KSA
    i = 0;

    for(i = 0; i<256; i++)
    {
        j = (j+vectorS[i] + vectorK[i]) % 256;
        aux = vectorS[i];
        vectorS[i] = vectorS[j];
        vectorS[j] = aux;
    }

    //Algoritmo PRGA

    i = 0;
    j = 0;
    aux = 0;


    for(int k = 0; k<frase.length(); k++){
        i = (i + 1) % 256;
        j = (j + vectorS[i]) % 256;
        aux = vectorS[i];
        vectorS[i] = vectorS[j];
        vectorS[j] = aux;
        t = (vectorS[i] + vectorS[j]) % 256;
        keystream[k] = vectorS[t];
    }

    //XOR


    for(int i = 0; i<frase.length(); i++){
        fraseCortada = frase.section(" ",i,i);
        if (fraseCortada == "") break;
        XOR =  keystream[i]^fraseCortada.toInt(&ok, 16);
        fraseFinal.append((char)XOR);
    }

    return fraseFinal;
}


QString** XifratsModerna::cifradoClaveDES(QString palabraClave){
    QString claveBinario, clavePermutada, claveBinarioL;
    QString claveBinarioR, claveLPermutada, claveRPermutada;
    int pc1[] = {57,49,41,33,25,17,9,1,58,50,42,34,26,18,
                 10,2,59,51,43,35,27,19,11,3,60,52,44,36,
                 63,55,47,39,31,23,15,7,62,54,46,38,30,22,
                 14,6,61,53,45,37,29,21,13,5,28,20,12,4};

    int pc2[] = {14,17,11,24,1,5,3,28,15,6,21,10,
                 23,19,12,4,26,8,16,7,27,20,13,2,
                 41,52,31,37,47,55,30,40,51,45,33,48,
                 44,49,39,56,34,53,46,42,50,36,29,32};

    int ls[] = {1,2,4,6,8,10,12,14,15,17,19,21,23,25,27,28};

    QString** Ki = new QString*[16];
    QString permutacionWord = "";


    //Passant la clau a binari
    for(int i = 0; i<palabraClave.length(); i++){
        claveBinario.append(QString("%1").arg(palabraClave[i].toLatin1(), 8, 2, QChar('0')));
    }

    //Permutant la clau en binari
    for(int i = 0; i<4*14; i++){
        clavePermutada.append(claveBinario[pc1[i]-1]);
    }

    //Separant les claus en L i R
    claveBinarioL = clavePermutada.mid(0,28);
    claveBinarioR = clavePermutada.mid(28,56);

    //Creant les 16 subclaus

    for(int i = 0; i<16; i++){
        permutacionWord = "";
        Ki[i] = new QString[48];

        //Desplaçant a l'esquerra (left shift) dues parts de les claus
        for(int j = 0; j<claveBinarioL.length(); j++){
            claveLPermutada[j] = claveBinarioL[(j+ls[i])%28];
            claveRPermutada[j] = claveBinarioR[(j+ls[i])%28];
        }

        //Ajuntem L i R en una sola variable
        clavePermutada = claveLPermutada+claveRPermutada;

        //Permutem aquesta variable amb la variable pc2
        for(int j = 0; j<48; j++){
            Ki[i][j] = clavePermutada[pc2[j]-1];
            permutacionWord.append(clavePermutada[pc2[j]-1]);
        }

    }

    return Ki;

}


QString XifratsModerna::cifradoDES(QString frase, QString palabraClave){
    int ip[] = {58,	50,	42,	34,	26,	18,	10,	2,
                60,	52,	44,	36,	28,	20,	12,	4,
                62,	54,	46,	38,	30,	22,	14,	6,
                64,	56,	48,	40,	32,	24,	16,	8,
                57,	49,	41,	33,	25,	17,	9,	1,
                59,	51,	43,	35,	27,	19,	11,	3,
                61,	53,	45,	37,	29,	21,	13,	5,
                63,	55,	47,	39,	31,	23,	15,	7};

    int E[] = {32,1,2,3,4,5,
               4,5,6,7,8,9,
               8,9,10,11,12,13,
               12,13,14,15,16,17,
               16,17,18,19,20,21,
               20,21,22,23,24,25,
               24,25,26,27,28,29,
               28,29,30,31,32,1};

    int S[]=    {14,4,13,1,2,15,11,8,3,10,6,12,5,9,0,7,
                0,15,7,4,14,2,13,1,10,6,12,11,9,5,3,8,
                4,1,14,8,13,6,2,11,15,12,9,7,3,10,5,0,
                15,12,8,2,4,9,1,7,5,11,3,14,10,0,6,13,
                15,1,8,14,6,11,3,4,9,7,2,13,12,0,5,10,
                3,13,4,7,15,2,8,14,12,0,1,10,6,9,11,5,
                0,14,7,11,10,4,13,1,5,8,12,6,9,3,2,15,
                13,8,10,1,3,15,4,2,11,6,7,12,0,5,14,9,
                10,0,9,14,6,3,15,5,1,13,12,7,11,4,2,8,
                13,7,0,9,3,4,6,10,2,8,5,14,12,11,15,1,
                13,6,4,9,8,15,3,0,11,1,2,12,5,10,14,7,
                1,10,13,0,6,9,8,7,4,15,14,3,11,5,2,12,
                7,13,14,3,0,6,9,10,1,2,8,5,11,12,4,15,
                13,8,11,5,6,15,0,3,4,7,2,12,1,10,14,9,
                10,6,9,0,12,11,7,13,15,1,3,14,5,2,8,4,
                3,15,0,6,10,1,13,8,9,4,5,11,12,7,2,14,
                2,12,4,1,7,10,11,6,8,5,3,15,13,0,14,9,
                14,11,2,12,4,7,13,1,5,0,15,10,3,9,8,6,
                4,2,1,11,10,13,7,8,15,9,12,5,6,3,0,14,
                11,8,12,7,1,14,2,13,6,15,0,9,10,4,5,3,
                12,1,10,15,9,2,6,8,0,13,3,4,14,7,5,11,
                10,15,4,2,7,12,9,5,6,1,13,14,0,11,3,8,
                9,14,15,5,2,8,12,3,7,0,4,10,1,13,11,6,
                4,3,2,12,9,5,15,10,11,14,1,7,6,0,8,13,
                4,11,2,14,15,0,8,13,3,12,9,7,5,10,6,1,
                13,0,11,7,4,9,1,10,14,3,5,12,2,15,8,6,
                1,4,11,13,12,3,7,14,10,15,6,8,0,5,9,2,
                6,11,13,8,1,4,10,7,9,5,0,15,14,2,3,12,
                13,2,8,4,6,15,11,1,10,9,3,14,5,0,12,7,
                1,15,13,8,10,3,7,4,12,5,6,11,0,14,9,2,
                7,11,4,1,9,12,14,2,0,6,10,13,15,3,5,8,
                2,1,14,7,4,10,8,13,15,12,9,0,3,5,6,11};

    int P[] = {16,7,20,21,29,12,28,17,
                1,15,23,26,5,18,31,10,
                2,8,24,14,32,27,3,9,
                19,13,30,6,22,11,4,25};

    int IPInversa[] = {40,8,48,16,56,24,64,32,
                     39,7,47,15,55,23,63,31,
                     38,6,46,14,54,22,62,30,
                     37,5,45,13,53,21,61,29,
                     36,4,44,12,52,20,60,28,
                     35,3,43,11,51,19,59,27,
                     34,2,42,10,50,18,58,26,
                     33,1,41,9,49,17,57,25};


    QString** Ki_puntero = cifradoClaveDES(palabraClave);
    QString Ki[16][48], fraseBinario, bloqueFrase, sFila, sColumna;
    QString bloquePermutado, bloqueL, bloqueR, bloqueRPermutado, bloqueS, bloqueXOR, bloqueRL, fraseFinal;

    int contador = 0;
    for(int i = 0; i<16; i++){
        for(int j = 0; j<48;j++){
            Ki[i][j]=Ki_puntero[i][j];
        }
    }

    //Convertint frase a binari
    for(int i = 0; i<frase.length(); i++){
        fraseBinario.append(QString("%1").arg(frase[i].toLatin1(), 8, 2, QChar('0')));
    }

    //Omplint la frase amb bits extres per poder extraure blocs de 64 bits
    if(fraseBinario.length()%64!=0){
        while(fraseBinario.length()%64!=0){
            fraseBinario.append("0");
        }
    }


    for(int i = 0; i<fraseBinario.length();i+=64){
        //Agafant de 64 en 64 bits la frase
        bloqueFrase = fraseBinario.mid(i,64);

        //Permutacion Inicial (IP)
        for(int j = 0; j<64; j++){
            bloquePermutado.append(bloqueFrase[ip[j]-1]);
        }

        /*Dividint la seqüència resultant tras la permutació en
        dos blocs, bloc L i bloc R.*/
        bloqueL = bloquePermutado.mid(0,32);
        bloqueR = bloquePermutado.mid(32,64);

        for(int j = 0; j<16; j++){

            //Permutant el bloc R (Expansió)
            for(int k = 0; k<48; k++){
                bloqueRPermutado.append(bloqueR[E[k]-1]);
            }

            //Operació XOR amb el bloc permutat i subclau_i
            for(int k = 0; k<bloqueRPermutado.length(); k++){
                bloqueXOR.append(QString::number(bloqueRPermutado[k].digitValue()^Ki[j][k].toInt()));
            }

            //Operant amb les taules
            bloqueFrase = "";
            for(int k = 0; k<bloqueRPermutado.length();k+=6){
                bloqueS=bloqueXOR.mid(k,6); sFila = ""; sColumna = "";
                sFila.append(bloqueS[0]).append(bloqueS[5]);
                sColumna.append(bloqueS[1]).append(bloqueS[2]).append(bloqueS[3]).append(bloqueS[4]);
                bloqueFrase.append(QString("%1").arg(S[sFila.toInt(nullptr,2)*16+(64*(contador))+sColumna.toInt(nullptr,2)], 4, 2, QChar('0')));
                contador++;
            }

            bloqueRPermutado = "";

            //Permutació P
            for(int k = 0; k<32; k++){
                bloqueRPermutado.append(bloqueFrase[P[k]-1]);
            }

            //XOR amb el bloc L
            bloqueXOR = "";
            for(int k = 0; k<bloqueRPermutado.length(); k++){
                bloqueXOR.append(QString::number(bloqueRPermutado[k].digitValue()^bloqueL[k].digitValue()));
            }

            bloqueL = bloqueR;
            bloqueR = bloqueXOR;

            bloqueRPermutado = ""; bloquePermutado = ""; bloqueFrase = "", bloqueXOR = ""; contador = 0;
        }

        //Ajuntant R+L
        bloqueRL = bloqueR + bloqueL;

        //Permutació IP inversa
        for(int j = 0; j<64; j++){
            bloquePermutado.append(bloqueRL[IPInversa[j]-1]);
        }

        //Passant blocs de 8 bits a hexadecimal
        for(int j = 0; j<bloquePermutado.length();j+=8){
            fraseFinal.append(QString::number(bloquePermutado.mid(j,8).toInt(nullptr,2),16)+" ");
        }
        bloqueRPermutado = ""; bloquePermutado = ""; bloqueFrase = "", bloqueXOR = ""; contador = 0;
    }

    return fraseFinal;

}

QString XifratsModerna::descifradoDES(QString frase, QString palabraClave){
    int ip[] = {58,	50,	42,	34,	26,	18,	10,	2,
                60,	52,	44,	36,	28,	20,	12,	4,
                62,	54,	46,	38,	30,	22,	14,	6,
                64,	56,	48,	40,	32,	24,	16,	8,
                57,	49,	41,	33,	25,	17,	9,	1,
                59,	51,	43,	35,	27,	19,	11,	3,
                61,	53,	45,	37,	29,	21,	13,	5,
                63,	55,	47,	39,	31,	23,	15,	7};

    int E[] = {32,1,2,3,4,5,
               4,5,6,7,8,9,
               8,9,10,11,12,13,
               12,13,14,15,16,17,
               16,17,18,19,20,21,
               20,21,22,23,24,25,
               24,25,26,27,28,29,
               28,29,30,31,32,1};

    int S[]=    {14,4,13,1,2,15,11,8,3,10,6,12,5,9,0,7,
                 0,15,7,4,14,2,13,1,10,6,12,11,9,5,3,8,
                 4,1,14,8,13,6,2,11,15,12,9,7,3,10,5,0,
                 15,12,8,2,4,9,1,7,5,11,3,14,10,0,6,13,
                 15,1,8,14,6,11,3,4,9,7,2,13,12,0,5,10,
                 3,13,4,7,15,2,8,14,12,0,1,10,6,9,11,5,
                 0,14,7,11,10,4,13,1,5,8,12,6,9,3,2,15,
                 13,8,10,1,3,15,4,2,11,6,7,12,0,5,14,9,
                 10,0,9,14,6,3,15,5,1,13,12,7,11,4,2,8,
                 13,7,0,9,3,4,6,10,2,8,5,14,12,11,15,1,
                 13,6,4,9,8,15,3,0,11,1,2,12,5,10,14,7,
                 1,10,13,0,6,9,8,7,4,15,14,3,11,5,2,12,
                 7,13,14,3,0,6,9,10,1,2,8,5,11,12,4,15,
                 13,8,11,5,6,15,0,3,4,7,2,12,1,10,14,9,
                 10,6,9,0,12,11,7,13,15,1,3,14,5,2,8,4,
                 3,15,0,6,10,1,13,8,9,4,5,11,12,7,2,14,
                 2,12,4,1,7,10,11,6,8,5,3,15,13,0,14,9,
                 14,11,2,12,4,7,13,1,5,0,15,10,3,9,8,6,
                 4,2,1,11,10,13,7,8,15,9,12,5,6,3,0,14,
                 11,8,12,7,1,14,2,13,6,15,0,9,10,4,5,3,
                 12,1,10,15,9,2,6,8,0,13,3,4,14,7,5,11,
                 10,15,4,2,7,12,9,5,6,1,13,14,0,11,3,8,
                 9,14,15,5,2,8,12,3,7,0,4,10,1,13,11,6,
                 4,3,2,12,9,5,15,10,11,14,1,7,6,0,8,13,
                 4,11,2,14,15,0,8,13,3,12,9,7,5,10,6,1,
                 13,0,11,7,4,9,1,10,14,3,5,12,2,15,8,6,
                 1,4,11,13,12,3,7,14,10,15,6,8,0,5,9,2,
                 6,11,13,8,1,4,10,7,9,5,0,15,14,2,3,12,
                 13,2,8,4,6,15,11,1,10,9,3,14,5,0,12,7,
                 1,15,13,8,10,3,7,4,12,5,6,11,0,14,9,2,
                 7,11,4,1,9,12,14,2,0,6,10,13,15,3,5,8,
                 2,1,14,7,4,10,8,13,15,12,9,0,3,5,6,11};


    int P[] = {16,7,20,21,29,12,28,17,
                1,15,23,26,5,18,31,10,
                2,8,24,14,32,27,3,9,
                19,13,30,6,22,11,4,25};

    int IPInversa[] = {40,8,48,16,56,24,64,32,
                     39,7,47,15,55,23,63,31,
                     38,6,46,14,54,22,62,30,
                     37,5,45,13,53,21,61,29,
                     36,4,44,12,52,20,60,28,
                     35,3,43,11,51,19,59,27,
                     34,2,42,10,50,18,58,26,
                     33,1,41,9,49,17,57,25};


    QString** Ki_puntero = cifradoClaveDES(palabraClave);
    QString Ki[16][48], fraseBinario, bloqueFrase, sFila, sColumna, fraseCortada;
    QString bloquePermutado, bloqueL, bloqueR, bloqueRPermutado, bloqueS, bloqueXOR, bloqueRL, fraseFinal;
    int contador = 0, contadorClaves = 15;


    for(int i = 0; i<16; i++){
        for(int j = 0; j<48;j++){
            Ki[i][j]=Ki_puntero[i][j];
        }
    }

    //Pasant frase a binari

    for(int i = 0; i<frase.length(); i++){
        fraseCortada = frase.section(' ',i,i);
        if(fraseCortada=="") break;
        fraseBinario.append(QString("%1").arg(fraseCortada.toInt(nullptr,16), 8, 2, QChar('0')));
    }

    //Rellenando la frase con bits extras para poder extraer bloques de 64 bits
    if(fraseBinario.length()%64!=0){
        while(fraseBinario.length()%64!=0){
            fraseBinario.append("0");
        }
    }

    for(int i = 0; i<fraseBinario.length();i+=64){
        bloqueFrase = fraseBinario.mid(i,64);

        //Permutacion Inicial (IP)
        for(int j = 0; j<64; j++){
            bloquePermutado.append(bloqueFrase[ip[j]-1]);
        }

        bloqueL = bloquePermutado.mid(0,32);
        bloqueR = bloquePermutado.mid(32,64);

        for(int j = 0; j<16; j++){

            //Permutando bloque R (Expansion)

            for(int k = 0; k<48; k++){
                bloqueRPermutado.append(bloqueR[E[k]-1]);
            }

            //Operando amb XOR
            for(int k = 0; k<bloqueRPermutado.length(); k++){
                bloqueXOR.append(QString::number(bloqueRPermutado[k].digitValue()^Ki[contadorClaves][k].toInt()));
            }
            contadorClaves--;

            //Operando con las tablas

            bloqueFrase = "";

            for(int k = 0; k<bloqueRPermutado.length();k+=6){
                bloqueS=bloqueXOR.mid(k,6); sFila = ""; sColumna = "";
                sFila.append(bloqueS[0]).append(bloqueS[5]);
                sColumna.append(bloqueS[1]).append(bloqueS[2]).append(bloqueS[3]).append(bloqueS[4]);
                bloqueFrase.append(QString("%1").arg(S[sFila.toInt(nullptr,2)*16+(64*(contador))+sColumna.toInt(nullptr,2)], 4, 2, QChar('0')));
                contador++;
            }

            bloqueRPermutado = "";

            //Permutacion P

            for(int k = 0; k<32; k++){
                bloqueRPermutado.append(bloqueFrase[P[k]-1]);
            }

            //Xor con el bloque L

            bloqueXOR = "";

            for(int k = 0; k<bloqueRPermutado.length(); k++){
                bloqueXOR.append(QString::number(bloqueRPermutado[k].digitValue()^bloqueL[k].digitValue()));
            }

            bloqueL = bloqueR;
            bloqueR = bloqueXOR;

            bloqueRPermutado = ""; bloquePermutado = ""; bloqueFrase = "", bloqueXOR = ""; contador = 0;
        }

        bloqueRL = bloqueR + bloqueL;

        for(int j = 0; j<64; j++){
            bloquePermutado.append(bloqueRL[IPInversa[j]-1]);
        }

        for(int j = 0; j<bloquePermutado.length();j+=8){
            fraseFinal.append((char)bloquePermutado.mid(j,8).toInt(nullptr,2));
        }
        bloqueRPermutado = ""; bloquePermutado = ""; bloqueFrase = "", bloqueXOR = ""; contador = 0; contadorClaves = 15;
    }

    return fraseFinal;
}




