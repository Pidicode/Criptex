import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Cifrados 1.0
import "qrc:/Items"

PageClassica {
    id: pageRailFence

    XifratsXIX{
        id:xifrats
    }

    ColumnCifrados{
        id: columnaCifrados
        tTitulo.text: "La xifra Rail Fence"
        tCifrado.text: (tNoCifrado.text === "") ? "" : (comprobacionCifrado) ? xifrats.cifradoRailFence(tNoCifrado.text, spinBoxRailFence.value) : xifrats.descifradoRailFence(tNoCifrado.text, spinBoxRailFence.value)
        tDescripccion.text: "La xifra Rail Fence, xifrat de transposició molt utilitzat a la guerra de Secessió (1861 – 1865), codifica les frases d’una manera força particular, simulant una tanca, de forma escalonada. Per conèixer el funcionament del xifrat fes click <a href='http://www.kde.org'>aquí</a>"
        tDescripccion.onLinkActivated: {
            pInformacion.state = (pInformacion.state === "visible") ? "invisible" : "visible"
            pInformacion.visible = (pInformacion.visible === true) ? false : true
        }


        SpinBox {
            id: spinBoxRailFence
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.maximumWidth: 200
            Layout.maximumHeight: 50
            from: 1
        }


        PageInformacion{
            id: pInformacion
            Layout.minimumHeight: window.height/3
            FlickableInformacion{
                ColumnLayoutInformacion{
                    id: columnaLayout
                    TextoInformacion{
                        text: "Diguem-ne que volem xifrar <<PREPARAR TROPES>>. Primer de tot, hem d’assignar un nombre de rails imaginaris a la tanca, per exemple 3."
                    }
                    Image{
                        Layout.preferredHeight: 150
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaRailFence1.png"
                    }

                    TextoInformacion{
                        text: "Ara, la tanca la llegim horitzontalment i obtenim el xifrat <<PATERPRRRPSEAO>>.
En canvi, si volem xifrar la frase amb tan sols 2 rails imaginaris:"
                    }

                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 150
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaRailFence2.png"
                    }

                    TextoInformacion{
                        text: "Obtindríem <<PEAATOERPRRRPS>>."
                    }
                }
            }
        }
        Component.onCompleted: {
            pInformacion.Layout.row = 2
            tNoCifrado.Layout.row = 3
            layoutBotones.Layout.row = 6
            spinBoxRailFence.Layout.row = 5

        }
    }
}
