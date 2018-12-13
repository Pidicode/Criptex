import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Cifrados 1.0
import QtAV 1.6
import "qrc:/Items"

PageClassica {
    id: pageAtbash


    XifratsAntiga{
        id: xifrats
    }

    ColumnCifrados{
        id: columnaCifrados
        tTitulo.text: "La escitala"
        tDescripccion.text: "Esparta, com a una de les majors potencies militars de l’antiga Grècia, feia ús de la escítala per la transmissió de missatges secrets. El sistema es basava en dos vares de grossor molt similar que es repartien entre emissor i receptor. Per conèxier el funcionament fes click <a href='http://www.kde.org'>aquí</a>"
        imagenCifrado.source: "qrc:/assets/escitala.png"
        imagenCifrado.visible: true
        heightImagen: 100
        widthImagen: 500
        tDescripccion.onLinkActivated: {
            pInformacion.state = (pInformacion.state === "visible") ? "invisible" : "visible"
            pInformacion.visible = (pInformacion.visible === true) ? false : true
        }
        tCifrado.text: tNoCifrado.text === "" ? "" : (comprobacionCifrado) ? xifrats.cifradoEscitala(tNoCifrado.text, spinBox.value) : xifrats.descifradoEscitala(tNoCifrado.text, spinBox.value)

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
                from: 1
            }

            Text {
                id: tSpinBox
                text: qsTr("Nombre de columnes de l'escítala")
                font.pixelSize: stackViewClassica.width/50
            }
        }

        PageInformacion{
            id: pInformacion
            Layout.minimumHeight: window.height/3.5
            FlickableInformacion{
                ColumnLayoutInformacion{
                    id: columnaLayout
                    spacing: 20
                    TextoInformacion{
                        text: "L’emissor agafava una de les vares i enrotllava una cinta al voltant d’aquesta, com podem veure en la següent imatge. Una vegada la cinta estava enrotllada, l’emissor escrivia lletra per lletra la frase que volia xifrar, horitzontalment per les columnes. Una vegada la frase s’havia escrit a la cinta, aquesta es retirava de l’escítala i es tornava illegible, llevat que es tornes a col·locar en una escítala del mateix grossor. Aquí és on entra la segona escítala, a mans del receptor, qui rep la cinta i la col·loca en aquesta, llegint així el missatge. Aquest procés el podem visualitzar a partir d’una matriu. Diguem-ne que volem xifrar <<EXEMPLE TREBALL DE RECERCA>>"
                        clip: true
                    }

                    Image{
                        id: imagenExplicacion1
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 250
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaEscitala1.png"
                    }

                    TextoInformacion{
                        text: "Aquesta matriu llegida horitzontalment és el que veuríem si estigués col·locada en la escítala. Llegida verticalment si no tinguéssim la cinta col·locada. En aquest cas, hem simulat una escítala força prima, amb una gran quantitat de columnes. Si l’escítala tingués un major grossor, tindríem menys columnes. Per tant, el nombre de columnes és la variable que simula el grossor d’aquesta. Amb els valors escollits, la frase quedaria xifrada com <<EBRXA CELAML PDLEE RTERC EE>>."
                        Layout.minimumHeight: lineCount * 30
                    }

                    VideoInformacion{
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
            filaSpinBox.Layout.row = 5
        }
    }
}
