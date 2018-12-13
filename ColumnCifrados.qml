import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3


GridLayout{
    id: layout
    anchors.fill:parent
    anchors.rightMargin: 20
    anchors.bottomMargin: 20
    rows: 6
    rowSpacing: 15
    columns: 1

    property alias layout: layout
    property alias tTitulo: tTitulo
    property alias tDescripccion: tDescripccion
    property alias tNoCifrado: tNoCifrado
    property alias tCifrado: tCifrado
    property alias bCifrar: bCifrar
    property alias bDescifrar: bDescifrar
    property alias bDescifrarTexto: bDescifrarTexto
    property alias bCifrarTexto: bCifrarTexto
    property alias layoutBotones: layoutBotones
    property alias imagenCifrado: imagenCifrado
    property alias lineaRoja: lineaRoja
    property bool comprobacionCifrado: comprobacionCifrado = true
    property int heightImagen: heightImagen = tDescripccion.height
    property int widthImagen: widthImagen

    Text {
        id: tTitulo
        text: qsTr("Xifrat Cèsar")
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: parent.width/20
        font.family: ("Georgia")

    }

    RowLayout{
        Text {
            id: tDescripccion
            Layout.fillWidth: true
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignJustify
            text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim."
            font.pixelSize: layout.width/50
        }
        Image{
            id: imagenCifrado
            Layout.fillWidth: true
            Layout.preferredHeight: heightImagen
            Layout.preferredWidth: widthImagen
            fillMode: Image.PreserveAspectFit
            visible: false
        }
    }

    TextField {
        id: tNoCifrado
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.maximumHeight: 250
        Layout.minimumHeight: 50
        wrapMode: Text.WrapAnywhere
        placeholderText: qsTr("Introdueixi el text a xifrar")
        selectByMouse: true
    }

    TextField {
        id: tCifrado
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.maximumHeight: 250
        Layout.minimumHeight: 15
        wrapMode: Text.WrapAnywhere
        placeholderText: qsTr("")
        selectByMouse: true
    }

    ColumnLayout{
        id: layoutBotones
        RowLayout{
            Layout.fillHeight: true
            Layout.fillWidth: true
            Button{
                id:bCifrar
                Layout.fillHeight: true
                Layout.fillWidth: true
                flat:true
                Text{
                    id: bCifrarTexto
                    anchors.centerIn: parent
                    color: "#ff5e5e"
                    text: "Xifrar"
                    font.pixelSize: layout.width/50
                }
                onClicked: {
                    tNoCifrado.clear()
                    bCifrarTexto.color = "#ff5e5e"
                    bDescifrarTexto.color = "gray"
                    comprobacionCifrado = true
                }
            }

            Button{
                id: bDescifrar
                Layout.fillHeight: true
                Layout.fillWidth: true
                flat:true
                Text{
                    id: bDescifrarTexto
                    anchors.centerIn: parent
                    color: "gray"
                    text: "Desxifrar"
                    font.pixelSize: parent.width/25
                }

                onClicked: {
                    tNoCifrado.clear()
                    bDescifrarTexto.color = "#ff5e5e"
                    bCifrarTexto.color = "gray"
                    comprobacionCifrado = false
                }
            }
        }
    }

    Rectangle{
        id: lineaRoja
        color: "#ff5e5e"
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.maximumHeight: 5
    }
}



