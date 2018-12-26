import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Cifrados 1.0
import "qrc:/Items"

PageClassica {
    id: pageAlfabetDesordenat

    XifratsRenaixement{
        id:xifrats
    }

    ColumnCifrados{
        id: columnaCifrados
        tTitulo.text: "Xifrat de Vigenère"
        tCifrado.text: (tNoCifrado.text === "" || tPalabraClave.text === "") ? "" : (comprobacionCifrado) ? xifrats.cifradoVigenere(tNoCifrado.text,tPalabraClave.text) : xifrats.descifradoVigenere(tNoCifrado.text,tPalabraClave.text)
        tDescripccion.text: "Es podria dir que el xifrat de Vigenère es l’evolució de la taula de Tritemio. Va ser creat per Giovan Battista Belasso, tot i que va ser atribuït falsament a Blaise de Vigenère, d’aquí el seu nom, que encara es conserva. Per conèixer el funcionament del xifrat fes click <a href='http://www.kde.org'>aquí</a>"
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
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.maximumWidth: 200
            Layout.maximumHeight: 50
            text: qsTr("")
            placeholderText: "Introdueixi la paraula clau"
            selectByMouse: true
        }

        PageInformacion{
            id: pInformacion
            Layout.minimumHeight: window.height/3.5
            FlickableInformacion{
                ColumnLayoutInformacion{
                    id: columnaLayout
                    TextoInformacion{
                        text: "El xifrat consisteix en altre taula 26x26, exactament igual que la del xifrat de Tritemi, però aquesta vegada, l’ús d’una clau regularà el xifrat: "
                    }
                    RowLayout{
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.preferredWidth: pInformacion.width
                        Layout.maximumHeight: pInformacion.height+50
                        spacing: 10
                        TextoInformacion{
                            text: "Diguem-ne que escollim com a paraula clau <<NORIA>>, i volem xifrar la paraula <<DIURN>>. Començant el xifrat, agafem la primera lletra de la frase a xifrar, en aquest cas la D, i la busquem a l’alfabet de la primera fila de la taula. Una vegada trobem la D, la prolonguem verticalment. Ara, agafem la primera lletra de la paraula clau, la N en aquest cas, y la busquem a la primera columna, prolongant-la horitzontalment. La lletra resultant a la intersecció serà la lletra xifrada. Aquest procés es pot veure clarament a la imatge de la dreta. Si repetim el procés tindríem <<QWICN>>."

                        }
                        Image{
                            id: imagenExplicacion1
                            Layout.preferredHeight: 500
                            Layout.alignment: Qt.AlignTop
                            Layout.preferredWidth: pInformacion.width/1.5
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            fillMode: Image.PreserveAspectFit
                            source: "qrc:/assets/tablaVigenere.png"
                        }
                    }
                    TextoInformacion{
                        text: "En el cas en que la frase a xifrar sigues més llarga que la paraula clau, repetiríem la paraula clau fins que ocupés tota la frase a xifrar, com podem veure aquí, com a clau <<DIURN>>:"

                    }
                    Image{
                        id: imagenExplicacion2
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 100
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaVigenere2.png"
                    }
                    VideoInformacion{
                        source: "qrc:/videos/videoVigenere.mp4"
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
