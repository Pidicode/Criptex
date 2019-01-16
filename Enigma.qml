import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Cifrados 1.0
import FuncionesBasicas 1.0
import "qrc:/Items"

PageClassica {
    id: pageEnigma

    XifratsXX{
        id:xifrats
    }

    FB{
        id: fb
    }

    ColumnCifrados{
        id: columnaCifrados
        tCifrado.text: (tNoCifrado.text === "" || tPalabraClave1.text === "") ? "" : (comprobacionCifrado) ? xifrats.cifradoEnigma(tNoCifrado.text, tPalabraClave1.text, plugboard.text, cbPos1.currentIndex, cbPos2.currentIndex, cbPos3.currentIndex) : xifrats.cifradoEnigma(tNoCifrado.text, tPalabraClave1.text, plugboard.text, cbPos1.currentIndex, cbPos2.currentIndex, cbPos3.currentIndex)
        tTitulo.text: "Xifrat Enigma"
        tDescripccion.text: "La Enigma, màquina portable que permetia xifrar missatges a partir de rotors, va ser un dels mecanismes de xifrat més importants durant la 2ª Guerra Mundial. Va ser patentada l’any 1918 per l’enginyer Arthur Scherbius, posada a la venta a nivell comercial al 1923 i adoptada posteriorment el 1926 per l’exercit alemany. Per conèixer més sobre el funcionament i els requisits fes click <a href='http://www.kde.org'>aquí</a>"

        tDescripccion.onLinkActivated: {
            pInformacion.state = (pInformacion.state === "visible") ? "invisible" : "visible"
            pInformacion.visible = (pInformacion.visible === true) ? false : true
        }

        tNoCifrado.onTextChanged: {
            if(tPalabraClave1.text===""){
                labelError.text = "La paraula clau te més de 3 caràcters."
                error.open()
                tNoCifrado.clear()
            }
            else if(fb.contarLetras(tPalabraClave1.text)>3){
                labelError.text = "La paraula clau te més de 3 caràcters."
                error.open()
                tPalabraClave1.clear()
                tNoCifrado.clear()
            }
        }

        Dialog {
            id: error
            title: "Error"
            x: (parent.width - width) / 2
            y: (parent.height - height) / 2
            standardButtons: Dialog.Ok

            Label {
                id: labelError
                text: "Cal seleccionar una paraula clau (3 caràcters)"
            }
        }

        RowLayout {
            id: rowLayout
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 20
            TextField {
                id: tPalabraClave1
                hoverEnabled: true
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.maximumWidth: 125
                Layout.maximumHeight: 50
                placeholderText: "Clau (3 caràcters)"
                selectByMouse: true
            }

            TextField{
                id:plugboard
                hoverEnabled: true
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.maximumWidth: 200
                Layout.maximumHeight: 50
                placeholderText: "Introdueixi el plugboard"
                selectByMouse: true
            }

            Text{
                text: "Introdueixi el ordre dels rotors"
                font.pixelSize: columnaCifrados.width/65
            }

            Text{
                text: "1: "
                font.pixelSize: columnaCifrados.width/65
            }

            ComboBox{
                id: cbPos1
                Layout.maximumWidth: 75
                model: ListModel {
                    ListElement { text: "I"; value: 1 }
                    ListElement { text: "II"; value: 2 }
                    ListElement { text: "III"; value: 3 }
                }
                textRole: 'text'

            }

            Text{
                text: "2: "
                font.pixelSize: columnaCifrados.width/65
            }

            ComboBox{
                id: cbPos2
                Layout.maximumWidth: 75
                model: ListModel {
                    ListElement { text: "I"; value: 1 }
                    ListElement { text: "II"; value: 2 }
                    ListElement { text: "III"; value: 3 }
                }
                textRole: 'text'
            }

            Text{
                text: "3: "
                font.pixelSize: columnaCifrados.width/65
            }

            ComboBox{
                id: cbPos3
                Layout.maximumWidth: 75
                model: ListModel {
                    ListElement { text: "I"; value: 1 }
                    ListElement { text: "II"; value: 2 }
                    ListElement { text: "III"; value: 3 }
                }
                textRole: 'text'
            }

        }
        PageInformacion{
            id: pInformacion
            Layout.minimumHeight: window.height/3
            FlickableInformacion{
                ColumnLayoutInformacion{
                    id: columnaLayout
                    RowLayout{
                        spacing: 20
                        Layout.preferredWidth: pInformacion.width
                        ColumnLayout{
                            TextoInformacion{
                                text: "La maquina Enigma és una combinació de subsistemes elèctrics i mecànics, sent un dispositiu electromecànic. El sistema estava compost d’un teclat, 3 rotors que rotaven cada vegada que es prenia una tecla, d’un reflector (posteriorment s’explicarà que és i com funcionava), d’un plugboard i de diverses llums que indicarien el xifrat."
                            }
                        }
                        Image{
                            Layout.preferredHeight: 250
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectFit
                            source: "qrc:/assets/maquinaEnigma2.jpg"
                        }
                    }

                    TextoInformacion{
                        text: "Els rotors estaven compostos de 26 contactes elèctrics per les dos cares (les lletres de l’alfabet), connectats entre ells d’una forma determinada. Per exemple, si el primer rotor rebia per una cara l’impuls al 13, el podia retornar per l’altre cara a la posició 17, la qual estava connectada al segon rotor, que potser tornava aquest 17 en un 3. Cada vegada que es prenia una tecla, el primer rotor girava 1 posició, i cada vegada que el primer rotor girava 26 posicions, el segon girava 1 posició, el qual, si girava 26 posicions, feia girar el tercer 1 posició, assimilant-se a un rellotge. La posició inicial dels 3 rotors es determinava abans. Cal mencionar que normalment hi havien 5 rotors, però es seleccionaven 3 d’aquests i es col·locaven en un determinat ordre. A més dels rotors, hi havia un reflector, al costat de l’últim rotor, que retornava l’impuls elèctric per els rotors, fent el recorregut contrari.
"
                    }
                    TextoInformacion{
                        text: "Per altre banda, teníem el plugboard, component de l’enigma que permetia intercanviar les lletres. Aquest consistia en un segon teclat que, mitjançant cables, connectaves les lletres que volies que s’intercanviessin. Per exemple, si havies connectat la A i la J, quan prenies la lletra J al teclat, abans de començar el xifrat, s’intercanviava per la A, i viceversa. També, si després d’haver recorregut tot el sistema, aquest retornava una J, la canviava per una A. Aquest component proporcionava molta seguretat al sistema."
                    }
                    TextoInformacion{
                        text: "A continuació, podem veure una maquina enigma:"
                    }

                    Image{
                        Layout.preferredHeight: 400
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/maquinaEnigma.jpg"
                    }

                    TextoInformacion{
                        text: "El nombre 1 correspon al plugboard, amb les connexions corresponents. El 2 al teclat, que rebrà l’input de l’usuari. El 3 a les llums, cadascuna amb una lletra corresponent, indicant el xifrat. Finalment, el 4, indicant els rotors."
                    }

                    TextoInformacion{
                        text: "Per entendre millor el procés de l’Enigma, farem un exemple complet. Abans de començar l’exemple, cal mencionar quins rotors quin reflector utilitzarem. En aquest cas utilitzarem els rotors del model Enigma I (1930), i el reflector B que eren 3, cadascun amb un alfabet determinat:"
                    }

                    TextoInformacion{
                        text: "· Rotor I: <<EKMFLGDQVZNTOWYHXUSPAIBRCJ>>
· Rotor II: <<AJDKSIRUXBLHWTMCQGZNPYFVOE>>
· Rotor III: <<BDFHJLCPRTXVZNYEIWGAKMUSQO>>
· Reflector B: <<YRUHQSLDPXNGOKMIEBFZCWVJAT>>
"
                    }

                    TextoInformacion{
                        text: "L’ordre dels rotors serà I, II, III i la posició inicial d’aquests serà AAA, o sigui, en posició 0 els 3. A més, al plugboard connectarem la lletra E amb la N. Una vegada tenim tot configurat, podem realitzar el xifrat. "
                    }

                    TextoInformacion{
                        text: "Diguem-ne que volem xifrar la paraula <<ENIGMA>>. L’usuari, primer de tot, pressionaria la tecla E. Al pressionar-la, immediatament, el rotor més a la dreta, en el nostre cas el III (recordem l’ordre I, II, III) es mou una posició. A continuació, s’enviaria un impuls elèctric fins el rotor de la dreta, l’impuls aniria de dreta a esquerra. Per explicar com funcionen les connexions dins del rotor, tenim les següents taules:"
                    }

                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 175
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaEnigma1.png"
                    }

                    TextoInformacion{
                        text: "Primer de tot, es mira el plugboard, i si n’hi ha alguna connexió feta es realitza. En aquest cas, com vam mencionar prèviament, la E i la N estan connectades, per tant, la E passa a ser una N."
                    }

                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 300
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaEnigma2.png"
                    }

                    TextoInformacion{
                        text: "A continuació, com el rotor ja a girat 1 posició (just al pressionar la tecla), ens trobem amb l’alfabet avançat de posició. Primer, hem de trobar quina es la lletra a l’alfabet no modificat en l’índex de la N al alfabet avançat. Amb una taula, aquest procés es pot veure fàcilment i determinen que es la O. Ara, hem de veure quina es la lletra en l’alfabet del rotor que correspon a l’índex de la O al alfabet no modificat, com podem veure la Y. A continuació, trobem a que lletra correspon aquesta Y a l’alfabet modificat i determinem que es la X."
                    }

                    TextoInformacion{
                        text: "Ara, en el segon rotor, relacionem la X amb la V."
                    }

                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 125
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaEnigma3.png"
                    }

                    TextoInformacion{
                        text: "En el primer rotor, la V amb la I."
                    }

                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 125
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaEnigma4.png"
                    }

                    TextoInformacion{
                        text: "Finalment, en el reflector, la I amb la P. Ara, hem d’anar cap enrere i fer el procés contrari, de baix a dalt:"
                    }

                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 125
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaEnigma5.png"
                    }

                    TextoInformacion{
                        text: "Com podem veure, en el primer rotor, la P correspon a la T."
                    }

                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 125
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaEnigma6.png"
                    }

                    TextoInformacion{
                        text: "En el segon, la T correspon a la N."
                    }


                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 125
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaEnigma7.png"
                    }


                    TextoInformacion{
                        text: "Finalment, tornant al tercer rotor, el qual estava avançat 1 posició, hem de veure quin es la lletra corresponent a l’index de la N en l’alfabet modificat a l’alfabet normal, com podem veure la O. Seguidament, busquem la O al alfabet del rotor III i la relacionem amb l’alfabet normal, sent la Z, i aquesta Z relacionant-la a l’alfabet, obtenint una Y."
                    }

                    TextoInformacion{
                        text: "Com la Y no estava connectada al plugboard, podem determinar que el xifrat d’aquesta E es finalment una Y. Si realitzem aquest procés amb totes les lletres obtenim <<YLGAHW>>. Pel que fa el programa, cal introduir una clau de 3 lletres, per exemple (AAA), que ens donaria les posicions inicials dels rotors. El plugboard es opcional, per utilitzar-lo, s'escriuen les dos lletres que vols connectar juntes, amb un espai si vols connectar més, per exemple (AB CD). Per últim es selecciona els rotors a utilitzar i el seu ordre. Per exemple, rotor I, rotor I, rotor III."
                    }

                    TextoInformacion{
                        text: "Deixem un vídeo que visualitza molt bé el procés de l'Enigma així com les seves propietats en combinatoria: <a href='https://www.youtube.com/watch?v=G2_Q9FoD-oQ&t'>https://www.youtube.com/watch?v=G2_Q9FoD-oQ&t</a>. No ho introduïm al programa per el seu elevat pes."
                        onLinkActivated: Qt.openUrlExternally("https://www.youtube.com/watch?v=G2_Q9FoD-oQ&t")
                    }
                }
            }
        }
        Component.onCompleted: {
            pInformacion.Layout.row = 2
            tNoCifrado.Layout.row = 3
            layoutBotones.Layout.row = 6
            rowLayout.Layout.row = 5

        }
    }
}

