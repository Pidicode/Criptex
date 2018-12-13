import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Cifrados 1.0
import "qrc:/Items"

PageClassica {
    id: pageRSA
    property bool rellenar: false
    XifratsModerna{
        id:xifrats
    }

    ColumnCifrados{
        id: columnaCifrados
        tCifrado.text: (tNoCifrado.text === "") ? "" : (comprobacionCifrado) ? xifrats.cifradoRSA(tNoCifrado.text, e.text, n.text) : xifrats.descifradoRSA(tNoCifrado.text, d.text, n.text)
        tTitulo.text: "Xifrat RSA"
        tDescripccion.text: "El RSA és un sistema asimètric o de clau pública, és a dir, un sistema que utilitza diferents claus pel seu xifrat i desxifrat. Va ser un dels primers xifrats asimètrics, així com el més utilitzat i senzill d’implementar. Per conèixer més sobre el funcionament fes click <a href='http://www.kde.org'>aquí</a>"

        tDescripccion.onLinkActivated: {
            pInformacion.state = (pInformacion.state === "visible") ? "invisible" : "visible"
            pInformacion.visible = (pInformacion.visible === true) ? false : true
        }


        ColumnLayout {
            id: rowLayout
            Layout.fillHeight: true
            Layout.fillWidth: true

            RowLayout{
                spacing: 12
                Text{
                    text: "Generador de claus RSA (seleccioni abans 2 nombres primers, q i p)"
                    font.pixelSize: columnaCifrados.width/65
                }
                Button{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.maximumWidth: 125
                    Layout.maximumHeight: 50

                    Text{
                        id: textBClassica
                        anchors.centerIn: parent
                        text: qsTr("Generar clau")
                        font.pixelSize: columnaCifrados.width/65
                        opacity: 0.85
                    }

                    onClicked: {
                        if(rellenar){
                            n.clear()
                            e.clear()
                            d.clear()
                            nPrivada.clear()
                        }
                        n.text = xifrats.generarClaveRSA(q.text, p.text, e.text, n.text, d.text)
                        e.text = xifrats.generarClaveRSA(q.text, p.text, e.text, n.text, d.text)
                        d.text = xifrats.generarClaveRSA(q.text, p.text, e.text, n.text, d.text)
                        nPrivada.text = n.text
                        rellenar = true

                    }
                }
            }

            RowLayout{
                Text{
                    text: qsTr("q: ")
                    font.pixelSize: columnaCifrados.width/65
                    opacity: 0.85
                }
                TextField {
                    id: q
                    selectByMouse: true
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.maximumWidth: 50
                    Layout.maximumHeight: 50
                }
                Text{
                    text: qsTr(" Clau publica (e,n): ")
                    font.pixelSize: columnaCifrados.width/65
                    opacity: 0.85
                }
                Text{
                    text: qsTr("(")
                    font.pixelSize: columnaCifrados.width/50
                    opacity: 0.85
                }
                TextField {
                    id: e
                    readOnly: true
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.maximumWidth: 50
                    Layout.maximumHeight: 50
                }
                Text{
                    text: qsTr(",")
                    font.pixelSize: columnaCifrados.width/65
                    opacity: 0.85
                }
                TextField {
                    id: n
                    readOnly: true
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.maximumWidth: 50
                    Layout.maximumHeight: 50
                }
                Text{
                    text: qsTr(")")
                    font.pixelSize: columnaCifrados.width/50
                    opacity: 0.85
                }
            }

            RowLayout{
                Text{
                    text: qsTr("p: ")
                    font.pixelSize: columnaCifrados.width/65
                    opacity: 0.85
                }
                TextField {
                    id: p
                    selectByMouse: true
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.maximumWidth: 50
                    Layout.maximumHeight: 50
                }
                Text{
                    text: qsTr(" Clau privada (d,n): ")
                    font.pixelSize: columnaCifrados.width/65
                    opacity: 0.85
                }
                Text{
                    text: qsTr("(")
                    font.pixelSize: columnaCifrados.width/50
                    opacity: 0.85
                }
                TextField {
                    id: d
                    readOnly: true
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.maximumWidth: 50
                    Layout.maximumHeight: 50
                }
                Text{
                    text: qsTr(",")
                    font.pixelSize: columnaCifrados.width/65
                    opacity: 0.85
                }
                TextField {
                    id: nPrivada
                    readOnly: true
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.maximumWidth: 50
                    Layout.maximumHeight: 50
                }
                Text{
                    text: qsTr(")")
                    font.pixelSize: columnaCifrados.width/50
                    opacity: 0.85
                }
            }
        }

        Component.onCompleted: {
            layoutBotones.Layout.row = 6
            rowLayout.Layout.row = 5
        }
    }

}
