import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Cifrados 1.0
import FuncionesBasicas 1.0
import "qrc:/Items"

PageClassica {
    id: pageADFGVX

    XifratsModerna{
        id:xifrats
    }

    ColumnCifrados{
        id: columnaCifrados
        tCifrado.text: (tNoCifrado.text === "" || tPalabraClave.text === "") ? "" : (comprobacionCifrado) ? xifrats.cifradoRC4(tNoCifrado.text, tPalabraClave.text) : xifrats.descifradoRC4(tNoCifrado.text, tPalabraClave.text)
        tTitulo.text: "RC4"
        tDescripccion.text: "El sistema RC4 és un dels sistemes més utilitzats e importants dels xifrats en flux, sinó el més utilitzat. Va ser dissenyat pel criptògraf Ron Rivest l’any 1897, sent inicialment un secret comercial però filtrat l’any 1994 a través d’una llista de correu. És utilitzat en protocols de xifrat populars com ara el TLS (Transport Layer Security) o el WEP (Wired Equivalent Privacy), protocol totalment insegur avui en dia.  Per conèixer més sobre el funcionament fes click <a href='http://www.kde.org'>aquí</a>"

        tDescripccion.onLinkActivated: {
            pInformacion.state = (pInformacion.state === "visible") ? "invisible" : "visible"
            pInformacion.visible = (pInformacion.visible === true) ? false : true
        }

        tNoCifrado.onTextChanged: {
            if(tPalabraClave.text === ""){
                error.textoDialogo = "Clau no introduïda."
                error.open()
                tNoCifrado.clear()
            }
        }

        DialogoError{
            id: error
        }

        TextField {
            id: tPalabraClave
            hoverEnabled: true
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.maximumWidth: 225
            Layout.maximumHeight: 50
            placeholderText: "Introdueixi la paraula clau"
            selectByMouse: true
        }

        PageInformacion{
            id: pInformacion
            Layout.minimumHeight: window.height/3
            FlickableInformacion{
                ColumnLayoutInformacion{
                    id: columnaLayout
                    TextoInformacion{
                        text: "El sistema RC4 és un dels sistemes més utilitzats e importants dels xifrats en flux, sinó el més utilitzat. Va ser dissenyat pel criptògraf Ron Rivest l’any 1897, sent inicialment un secret comercial però filtrat l’any 1994 a través d’una llista de correu. És utilitzat en protocols de xifrat populars com ara el TLS (Transport Layer Security) o el WEP (Wired Equivalent Privacy), protocol totalment insegur avui en dia.

RC4 és remarcable per la seva simplicitat i velocitat, però també cal dir que és molt vulnerable i, per tant, insegur, sobretot si fem ús de claus no aleatòries, com vam mencionar en el punt anterior, no sent recomanat el seu ús en nous sistemes.

El xifrat consisteix bàsicament en 2 algorismes, el KSA (Key Scheduling Algorithm) i el PRGA (Pseudo-Random Generation Algorithm). Es fa ús d’un vector S de 256 números que conté els nombres del 0 al 256. El KSA, a partir d’un vector clau o vector K, desordena els nombres del vector S. Aquest vector desordenat serà el que utilitzarà l’algorisme PRGA per xifrar finalment el missatge. Primer, hem de crear dos vectors de 256 nombres, el vector S i el vector K. Pel que fa al vector S, s’omplirà amb els nombres del 0 al 256, en ordre:
"
                    }
                    Image{
                        Layout.preferredHeight: 100
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaRC4_1.png"
                    }

                    TextoInformacion{
                        text: "Pel que fa al vector K, també anomenat la “llavor” del sistema, consistirà en un vector de 256 nombres omplert amb la paraula clau. Per exemple, si la nostra paraula clau és <<SALA>>, omplirem el vector repetint la clau tantes vegades com calgui. Realment, introduïm una paraula clau que després passem a ASCII, per operar amb nombres, tenint <<SALA>> en ASCII com <<83 65 76 65>>. Per tant, el vector K resultaria en:"
                    }

                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 650
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaRC4_2.png"
                    }

                    TextoInformacion{
                        text: "Amb el vector S i el vector K ja creat, barregem el vector S a partir del següent algorisme o codi:"
                    }

                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 250
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaRC4_3.png"
                    }

                    TextoInformacion{
                        text: "On, a partir d’un bucle, anem recorrent i barrejant el vector S, calculant un valor de j que després s’utilitzarà per intercanviar les posicions dels nombres del mateix vector. Per als tres primers valors de i l’algorisme funcionaria com:"
                    }

                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 200
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaRC4_4.png"
                    }

                    TextoInformacion{
                        text: "El vector S resultaria en:"
                    }

                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 600
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaRC4_5.png"
                    }

                    TextoInformacion{
                        text: "Una vegada hem aplicat l’algorisme KSA i tenim un nou vector S, apliquem l’algorisme PRGA, el qual generarà la seqüència de clau o keystream. Aquesta seqüència s’utilitzarà per xifrar el missatge a partir de l’operador XOR. Aquesta seqüència de clau tindrà la mateixa longitud que la frase a xifrar. L’algorisme PRGA és el següent:"
                    }

                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 250
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaRC4_6.png"
                    }

                    TextoInformacion{
                        text: "Aquest procés es repetirà tantes vegades com lletres tingui la frase a xifrar, per tant ho podem expressar així:"
                    }

                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 250
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaRC4_7.png"
                    }

                    TextoInformacion{
                        text: "Sent k el comptador del bucle i L la longitud de la frase a xifrar. Bàsicament, comença calculant un valor per i, i altre per j, que utilitza per intercanviar els valors al vector de S[i] i S[j], i per calcular el valor de t, el qual serà l’índex al vector S d’un dels valors que tindrà el keystream. Diguem-ne que volem xifrar <<HOLA>>, utilitzant el vector S ja prèviament barrejat amb la clau <<SALA>>. L’algorisme transcorreria així:"
                    }

                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 200
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaRC4_8.png"
                    }

                    TextoInformacion{
                        text: "Resultant el keystream en: <<226 163 138 140>>. Ara, passaríem la frase i el keystream a binari, resultant el keystream <<11100010 10100011 10001010 10001100>>, i la frase <<01001000 01001111 01001100 01000001>>. A continuació aplicarem l’operació XOR entre les dues expressions. Resultant el xifrat: <<10101010 11101100 11000110 11001101>>. En comptes de deixar-ho en binari també ho podem expressar en qualsevol altre sistema, per exemple en hexadecimal resultant en: <<AA EC C6 CD>>. A continuació, tenim un vídeo explicatiu del xifrat. El vídeo no és propi, link original al creador: "
                    }

                    TextoInformacion{
                        text: "A continuació, tenim un vídeo explicatiu del xifrat. El vídeo no és propi, link original al creador: <a href='https://www.youtube.com/watch?v=G3HajuqYH2U&t'>https://www.youtube.com/watch?v=G3HajuqYH2U&t=</a>"
                        onLinkActivated: Qt.openUrlExternally("https://www.youtube.com/watch?v=G3HajuqYH2U&t=")
                    }

                    VideoInformacion{
                        source: "qrc:/videos/videoRC4.mp4"
                        onVideoBoolChanged: {
                            if(!videoBool){
                                pInformacion.Layout.minimumHeight = window.height/2
                            }
                            else{
                                pInformacion.Layout.minimumHeight = window.height/3.5
                            }
                        }
                    }

                }
            }
        }
        Component.onCompleted: {
            pInformacion.Layout.row = 2
            tNoCifrado.Layout.row = 3
            layoutBotones.Layout.row = 6
            tPalabraClave.Layout.row = 5
        }
    }
}
