import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Cifrados 1.0
import FuncionesBasicas 1.0
import "qrc:/Items"

PageClassica {
    id: pageDES

    XifratsModerna{
        id:xifrats
    }

    FB{
        id:fb
    }

    ColumnCifrados{
        id: columnaCifrados
        tCifrado.text: (tNoCifrado.text === "" || tPalabraClave.text === "") ? "" : (comprobacionCifrado) ? xifrats.cifradoDES(tNoCifrado.text, tPalabraClave.text) : xifrats.descifradoDES(tNoCifrado.text, tPalabraClave.text)
        tTitulo.text: "DES"
        tDescripccion.text: "A principi de la dècada dels 70, el Comitè d’Estàndards Estatunidenc (NBS), després de veure la necessitat d’un estàndard per a xifrar informació confidencial i després de consultar amb la National Security Agency (NSA), va sol·licitar propostes d’algorismes que complissin aquests requisits. Una de les propostes va ser un sistema basat en l’algorisme Lucifer, presentat per IBM, i anomenat DES.  Per conèixer més sobre el funcionament fes click <a href='http://www.kde.org'>aquí</a>"

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
            else if(fb.contarLetras(tPalabraClave.text)!==8){
                error.textoDialogo = "La clau no es de 64 bits (8 lletres)."
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
                        id: linkVideo
                        onLinkActivated: Qt.openUrlExternally("https://www.youtube.com/watch?v=Sy0sXa73PZA&t")
                        text:"Abans de començar l'explicació del xifrat, cal dir que aquesta serà força extensa i per tant, recomanem veure el següent vídeo. Aquest vídeo no és propi i està en angles, el link del video original és el següent: <a href='https://www.youtube.com/watch?v=Sy0sXa73PZA&t'>link</a> "
                    }

                    VideoInformacion{
                        source: "qrc:/videos/videoDES.mp4"
                        onVideoBoolChanged: {
                            if(!videoBool){
                                pInformacion.Layout.minimumHeight = window.height/2
                            }
                            else{
                                pInformacion.Layout.minimumHeight = window.height/3.5
                            }
                        }
                    }

                    TextoInformacion{
                        text: "Aquest xifrat, des del principi presentava queixes per la seva curta longitud de la clau (56 bits), entre altres, evidenciant interferències per part de la NSA. El fet és que la NSA va pressionar perquè es reduís la mida de la clau del sistema a un nombre suficientment gran perquè cap ordinador pogués atacar el sistema DES a excepció dels de la pròpia NSA. Malgrat tot, el DES va ser aprovat com a estàndard governamental l’any 1976.

DES consisteix en un sistema simètric per blocs, agafant, operant i xifrant el text clar en grups de 64 bits (8 lletres), a partir d’una paraula clau també de 64 bits.

Abans de començar pròpiament el xifrat, hem de crear setze subclaus generades a partir de la clau del sistema. Diguem-ne que com a paraula clau de 64 bits tenim <<TRCRIPTO>>. Primer passarem aquesta paraula clau a sistema binari obtenint: <<01010100 01010010 01000011 01010010 01001001 01010000 01010100 01001111>>.
Aquesta seqüència binaria, ara, l’hem de permutar, reordenar, seguint la taula següent:
"
                    }
                    Image{
                        Layout.preferredHeight: 400
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaDes1.png"
                    }

                    TextoInformacion{
                        text: "On, ara la seqüència binaria correspondria a la seqüència anterior en l’ordre dels nombres de la taula. Així, el primer nombre seria el 57 de la seqüència anterior, el segon el 49, el tercer el 41, així amb tota la taula, resultant: <<00000000 11111111 00000000 01101000 11101100 00011001 00001011>>.

Com veiem, la seqüència s’ha reduït de 64 bits a 56. Ara, la dividim en dos parts, Li (esquerra) i Ri (dreta), sent L1 <<00000000 11111111 0000000 00110>> i R1 <<10001110 11000001 10010000 1011>>. Una vegada tenim la seqüència separada, desplacem les dues parts una posició a l’esquerra, resultant: L1 <<00000001 11111110 00000000 1100>> i R1 <<00011101 10000011 00100001 0111>>. Aquestes dues seqüències desplaçades es tornen a agrupar <<00000001 11111110 00000000 11000001 11011000 00110010 00010111>>, permutant l’agrupació a partir de la següent taula:
"
                    }

                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 350
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaDes2.png"
                    }

                    TextoInformacion{
                        text: "Resultant finalment: <<10100000 10010010 11000010 01011100 00101001 10000101>>. Això seria la subclau número 1, o subclau1. Pel que fa la subclau2, agafaríem les seqüències prèvies Li i Ri ja desplaçades i les desplaçaríem una altra posició a l’esquerra, sent L2 <<00000011 11111100 00000001 1000 >> i R2 <<00111011 00000110 01000010 1110>>. Ajuntant-les i permutant-les a partir de la taula PC-2, obtenint finalment la subclau2. Aquest mateix procés el repetiríem fins aconseguir les setze subclaus.

Cal mencionar que els desplaçaments a l’esquerra que es realitzen a partir de Li i Ri varien segons la subclau que estem creant, a partir la següent taula:
"
                    }

                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 100
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaDes3.png"
                    }

                    TextoInformacion{
                        text: "Les 16 subclaus generades a partir de la paraula clau <<TRCRIPTO>> són les següents:"
                    }

                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 650
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaDes4.png"
                    }

                    TextoInformacion{
                        text: "Una vegada tenim les 16 claus, podem començar a xifrar el missatge. Diguem-ne que volem xifrar <<CRIPTOGRAFIA MODERNA>>. Primer dividim el missatge en blocs de 64 bits, o 8 lletres, resultant els blocs, si passem el missatge a binari, en: <<01000011 01010010 01001001 01010000 01010100 01001111 01000111 01010010>>,  <<01000001 01000110 01001001 01000001 00100000 01001101 01001111 01000100>> i <<01000101 01010010 01001110 01000001>>. Si ens hi fixem, l’últim bloc no arriba a tenir 64 bits, en aquest cas, podríem omplir el bloc amb zeros fins que arribés a 64 bits, resultant: <<01000101 01010010 01001110 01000001 00000000 00000000>>.

Comencem amb el primer bloc <<01000011 01010010 01001001 01010000 01010100 01001111 01000111 01010010>>. Primer, permutaríem els valors a partir de la següent taula, IP (Initial Permutation):
"
                    }

                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 350
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaDes5.png"
                    }

                    TextoInformacion{
                        text: "Resultant la seqüència binaria després de la permutació en <<11111111 10011010 01110000 01100101 00000000 00000000 00100100 11100011>>. Ara, igual que hem fet amb la creació de les subclaus, dividim el missatge en esquerra i dreta, o L i R, resultant: L <<11111111 10011010 01110000 01100101>> i R <<00000000 00000000 00100100 11100011>>.

A partir d’aquí, realitzarem un procés que s’haurà de repetir setze vegades per totes les subclaus. Primer, agafem R i l’expandirem a partir d’una permutació, basada la següent taula E (Expansió):
"
                    }

                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 300
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaDes6.png"
                    }

                    TextoInformacion{
                        text: "Resultant R després d’aplicar la permutació E en <<10000000  00000000 00000000 00010000 10010111 00000110>>. Si ens hi fixem, la seqüència binaria ha augmentat de 32 bits a 48 bits.

Una vegada tenim la seqüència expandida, realitzem una operació XOR entre aquesta seqüència i la subclau1. Ara, dividim aquesta seqüència en blocs de 6 bits, tenint <<001000 001001 001011 000010 0100 11 001011 111010 000011>>. A continuació, agafem bloc a bloc els bits, i extraiem el nombre decimal dels bits dels extrems del bloc i de l’interior. Per exemple, amb el primer bloc <<001000>>, agafem els bits extrems <<00>> (<<001000>>), i els canviem a sistema decimal, 0, igual amb els bits interiors <<0100>> (<<001000>), que correspon al 4. Aquests dos nombres, el 0 i el 4, correspondran a la fila i la columna respectivament de la següent taula:
"
                    }

                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 275
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaDes7.png"
                    }

                    TextoInformacion{
                        text: "Si observem la taula, veiem com el nombre decimal corresponent a la fila 0 columna 4 és el 2. Si passem el 2 a binari tindrem <<00000010>>, agafant tan sols 4 bits <<0010>>.

Realitzarem aquest mètode amb cada bloc, de 6 bits pertocant-li a cada un una taula diferent, que són les següents:  al primer bloc S1, segon bloc S2, tercer S3, etc.
"
                    }

                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 600
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaDes8.png"
                    }

                    TextoInformacion{
                        text: "Per exemple, si agafem el segon bloc <<001001>> el xifrarem amb la taula S2. Agafem els bits exteriors i els passem a decimal, donant 1 (<<01>>), així com els bits interiors, donant una altra vegada 4 (<<0100>>). El decimal corresponent a la fila 1 columna 4 és el 15, que si el passem a binari correspon a <<00001111>>.

Una vegada hem realitzat aquest procés amb tots els blocs, obtenim la següent seqüència <<00101111 01001101 00001100 01011111>>. Aquesta seqüència haurà de ser permutada a partir de la taula següent:
"
                    }

                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 275
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaDes9.png"
                    }

                    TextoInformacion{
                        text: "Resultant finalment en <<11011010 00011011 01011010 01111000>>. Ara, haurem de fer una operació XOR amb aquesta seqüència i la seqüència L (que encara no hem utilitzat). Aquest és el procés que hem de repetir setze vegades, amb les setze subclaus que tenim. Aquesta darrera seqüència serà la seqüència R de la següent iteració, mentre que L serà l’antiga seqüència R (a la tercera iteració, si ens hi fixem, L serà aquesta darrera seqüència, ja que com hem vist, correspon a R al principi de la segona).

Una vegada hem realitzat les setze voltes pel mateix procés, tindrem com a R <<11111001 00001001 10100010 01110001>> i com a L <<01010101 01101110 10011000 01111110>>. A continuació, agruparíem aquestes dos seqüències en R+L: <<11111001 00001001 10100010 01110001 01010101 01101110 10011000 01111110>> i realitzaríem una permutació final a partir de la taula següent (permutació inicial inversa):
"
                    }

                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 450
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaDes10.png"
                    }

                    TextoInformacion{
                        text: "Obtenim finalment <<01001100 11101111 10100100 01111001 11101101 01101001 01011111 01111111>>, seqüència que seria el bloc de 64 bits xifrat. Aquest bloc el podem expressar en qualsevol altre sistema, per exemple, en hexadecimal, resultant en <<d1 26 a2 7a cb 67 e3 4c>>. Si realitzem el mateix procés amb els altres blocs del missatge que volíem xifrar, obtindrem finalment com a xifrat <<d1 26 a2 7a cb 67 e3 4c 4c ef a4 79 ed 69 5f 7f 27 df 12 c3 24 1e d2 4c>>.

Pel que fa el desxifrat, el procés és exactament el mateix, a excepció que en la repetició del procés del xifrat, on utilitzem les setze subclaus realitzant una operació XOR a la part L de la seqüència binaria, en comptes d’aplicar les subclaus en ordre (subclau1 a la primera iteració, subclau2 a la segona iteració, etc.), les apliquem en ordre contrari (subclau16 a la primera iteració, subclau15 a la segona iteració, etc.), resultant-nos finalment el missatge original.
"
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
