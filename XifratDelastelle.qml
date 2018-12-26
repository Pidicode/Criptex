import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Cifrados 1.0
import "qrc:/Items"

PageClassica {
    id: pageDelastelle

    XifratsXIX{
        id:xifrats
    }

    ColumnCifrados{
        id: columnaCifrados
        tTitulo.text: "Xifrat de Delastelle"
        tCifrado.text: (tNoCifrado.text === "" || tPalabraClave.text === "") ? "" : (comprobacionCifrado) ? xifrats.cifradoDelastelle(tNoCifrado.text,tPalabraClave.text, spinBoxDelastelle.value) : xifrats.descifradoDelastelle(tNoCifrado.text,tPalabraClave.text, spinBoxDelastelle.value)
        tDescripccion.text: "La xifra de Delastelle, també coneguda com la xifra bífida, creada per Félix-Marie Delastelle, publicada per primera vegada en la Revue du Génie civil en 1895 amb el nom de Cryptographie nouvelle, o nova criptografia, es tracta d’una xifra que barreja la transposició i la substitució, dividint parts del missatge. Per conèixer el funcionament del xifrat fes click <a href='http://www.kde.org'>aquí</a>"
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

        RowLayout {
            id: rowLayout
            Layout.fillHeight: true
            Layout.fillWidth: true

            TextField {
                id: tPalabraClave
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.maximumWidth: 200
                Layout.maximumHeight: 50
                placeholderText: "Introdueixi la 1ª paraula clau"
                selectByMouse: true
            }

            SpinBox {
                id: spinBoxDelastelle
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.maximumWidth: 200
                Layout.maximumHeight: 50
                from: 1

            }
        }

        PageInformacion{
            id: pInformacion
            Layout.minimumHeight: window.height/3
            FlickableInformacion{
                ColumnLayoutInformacion{
                    id: columnaLayout
                    TextoInformacion{
                        text: "Primer, fem la ja típica taula 5x5, introduint una paraula clau, i evitant la repetició de lletres en aquesta. Com a paraula clau <<TECLA>>."
                    }
                    Image{
                        Layout.preferredHeight: 350
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaDelastelle1.png"
                    }

                    TextoInformacion{
                        text: "Ara, escollint com a frase a xifrar <<NECESSITEM AJUDA>>, la separem en blocs a partir d’una longitud pactada prèviament, diguem-ne cada 5 lletres, resultant en <<NECES SITEM AJUDA>>. Una vegada la tenim dividida en blocs, xifrem les lletres de cada bloc, segons la línia-columna de les lletres a la taula, però en comptes de posar els nombres horitzontalment (per exemple la N com 33 o la E com 12), els posem verticalment."
                    }

                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 250
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaDelastelle2.png"
                    }

                    TextoInformacion{
                        text: "Ara, ajuntem el nombre de la fila de sota de cada bloc amb el de la fila de dalt, el dividim en pars, i trobem de les combinacions de números donades les lletres corresponents a la taula:"
                    }

                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 250
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaDelastelle3.png"
                    }

                    TextoInformacion{
                        text: "Obtenint com a frase xifrada <<IJTSFFSQNLDCRAAH>>"
                    }

                    VideoInformacion{
                        source: "qrc:/videos/videoDelastelle.mp4"
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
            rowLayout.Layout.row = 5

        }
    }
}
