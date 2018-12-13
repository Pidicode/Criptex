import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Cifrados 1.0
import FuncionesBasicas 1.0
import "qrc:/Items"

PageClassica {
    id: pageAtbash

    XifratsAntiga{
        id: xifrats
    }

    FB{
        id:fb
    }

    ColumnCifrados{
        id: columnaCifrados
        tTitulo.text: "El tauler de Polibio"
        tCifrado.text: (tNoCifrado.text === "") ? "" : (comprobacionCifrado) ? xifrats.cifradoPolibio(tNoCifrado.text) : xifrats.descifradoPolibio(tNoCifrado.text, tCifrado.text)
        tNoCifrado.text: comprobacionCifrado ? tNoCifrado.text : fb.anadirNamespaces(tNoCifrado.text,2)
        tDescripccion.text: "Creat cap 150 a.C, Polibi va dissenyar un sistema de transposició que seria utilitzat posteriorment per el nihilistes russos a les presons zaristes. Consisteix en un quadrat de 5x5 on es col·loca l’alfabet, amb la I i la J juntes. Per conèixer més fes click <a href='http://www.kde.org'>aquí</a>"
        imagenCifrado.source: "qrc:/assets/Polibi.jpg"
        imagenCifrado.visible: true
        widthImagen: 600
        heightImagen: tDescripccion.height+40
        tDescripccion.onLinkActivated: {
            pInformacion.state = (pInformacion.state === "visible") ? "invisible" : "visible"
            pInformacion.visible = (pInformacion.visible === true) ? false : true
        }

        PageInformacion{
            id: pInformacion
            Layout.minimumHeight: window.height/3.5
            FlickableInformacion{
                ColumnLayoutInformacion{
                    id: columnaLayout
                    spacing: 20
                    RowLayout{
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.preferredWidth: pInformacion.width
                        Layout.topMargin: 5
                        spacing: 10
                        TextoInformacion{
                            text: "Si volem xifrar el text, posem-ne com exemple <<ENS ATAQUEN>>, substituiríem cada lletra de la frase a xifrar per las posicions línia-columna del quadrat. En aquest cas, la E seria 15, la N 33, així amb totes les lletres. La frase xifrada quedaria com <<15 33 43 11 44 11 41 45 15 33>>. El següent programa ens retorna aquestes combinacions de nombres segons les lletres que escribim."
                            wrapMode: Text.WordWrap
                        }
                        Image{
                            Layout.preferredHeight: 375
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectFit
                            source: "qrc:/assets/tablaPolibio.png"
                        }
                    }
                    VideoInformacion{
                        source: "qrc:/videos/Tauler Polibi.mp4"
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
        }
    }
}
