import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import Cifrados 1.0

import "qrc:/Items"

PageClassica {
    id: pageCesar

    XifratsAntiga{
        id: xifrats
    }

    ColumnCifrados{
        id: columnaCifrados
        imagenCifrado.visible: true
        imagenCifrado.source: "qrc:/assets/imagenJulioCesar.jpg"
        tDescripccion.text: "El xifrat cèsar és una de les tècniques de xifratge més senzilles i conegudes, sent aquest un xifratge per substitució. Deu el seu nom a Juli Cèsar i consisteix en la substitució de les lletres del text pla en altres desplaçades un nombre determinat de posicions a l'alfabet. Per conèixer més fes click <a href='http://www.kde.org'>aquí</a>"
        tDescripccion.onLinkActivated: {
            pInformacion.state = (pInformacion.state === "visible") ? "invisible" : "visible"
            pInformacion.visible = (pInformacion.visible === true) ? false : true
        }
        RowLayout {
            anchors.topMargin: 20
            id: filaSpinBox
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 10
            SpinBox {
                id: spinBox
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.maximumWidth: 150
                Layout.maximumHeight: 50
                editable: true
                from: -99
            }

            Text {
                id: tSpinBox
                text: qsTr("Valors a avançar o endarrerir l'alfabet")
                font.pixelSize: stackViewClassica.width/50
            }
        }

        PageInformacion{
            id: pInformacion
            Layout.minimumHeight: tInformacion.height
            FlickableInformacion{
                ColumnLayoutInformacion{
                    id: columnaLayout
                    RowLayout{
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.preferredWidth: pInformacion.width
                        spacing: 10
                        TextoInformacion{
                            id: tInformacion
                            text: "Per explicar el funcionament del xifrat Cèsar, agafarem primer de tot l'alfabet clàssic,  <<ABCDEFGHIJKLMNÑOPQRSTUVWXYZ>>. A continuació, l'avancem o l'endarrerim x posicions, diguem-ne 3, donant el següent alfabet, <<DEFGHIJKLMNÑOPQRSTUVWXYZ>>. Una vegada tenim el nou alfabet, agafem la frase que volem xifrar, <<EXEMPLE>>, i substituïm les seves lletres per la del nou alfabet (si tinguéssim una A ara seria una D, si tinguéssim una B tindríem una E, així successivament), resultant en <<HAHOSÑH>>. Aquest és el procés que segueix el següent programa per xifrar la informació, pots avançar o endarrer l'alfabet a la posició que vulguis"
                        }
                        Image{
                            Layout.preferredHeight: 200
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectFit
                            source: "qrc:/assets/imagenCesar.png"
                        }
                    }
                    Image{
                        Layout.preferredHeight: 200
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/imagenCesar3Posiciones.jpg"
                    }
                    Text{
                        lineHeight: 1.5

                        Layout.alignment: Qt.AlignHCenter
                        wrapMode: Text.WrapAnywhere
                        font.pixelSize: columnaCifrados.width/65
                        clip: true
                        horizontalAlignment: Text.AlignJustify
                        text: "Per exemple, a la següent imatge, podem veure un alfabet avançat 3 posicions"
                    }
                    VideoInformacion{
                        source: "qrc:/videos/videoCesar.mp4"
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

        tCifrado.text: (comprobacionCifrado) ? xifrats.cifradoCesar(tNoCifrado.text, spinBox.value) : xifrats.descifradoCesar(tNoCifrado.text, spinBox.value)


        Component.onCompleted: {
            pInformacion.Layout.row = 2
            tNoCifrado.Layout.row = 3
            layoutBotones.Layout.row = 6
            filaSpinBox.Layout.row = 5
        }
    }
}

