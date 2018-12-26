import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.2
Page {
    id: page
    width: window.width
    height: window.heigth
    title: qsTr("Home")

    AnimatedImage{
        anchors.fill: parent
        source: "qrc:/assets/fondoCriptografia.gif"
        fillMode: Image.PreserveAspectCrop
        opacity: 0.3
    }

    ColumnLayout {
        anchors.topMargin: 65
        anchors.fill: parent
        anchors.leftMargin: 65
        anchors.rightMargin: 65
        spacing: 20

        Text {
            id: tCriptografia
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: ("Georgia")
            text: qsTr("Criptografia")
            font.pixelSize: parent.width/15
        }

        Text {
            id: tCriptografiaFrase
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: ("Georgia")
            text: qsTr("L'art d'escriure de forma enigmàtica al llarg de l'història")
            font.pixelSize: parent.width/40
        }

        RowLayout {
            id: rowCriptoMenu
            spacing: 5
            Layout.fillWidth: true

            Button{
                id: bClassica
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.maximumHeight: 300
                Layout.minimumHeight: 150
                Layout.preferredHeight: 150
                Layout.preferredWidth: 300

                Text{
                    id: textBClassica
                    anchors.centerIn: parent
                    text: qsTr("Criptografia Clàssica")
                    font.pixelSize: rowCriptoMenu.width/35
                    font.family: ("Georgia")

                    opacity: 0.85
                }
                Text{
                    anchors.centerIn: parent
                    anchors.topMargin: 1000
                    text: qsTr("Des de l'edat antiga fins l'entrada de la computació")
                    font.pixelSize: rowCriptoMenu.width/75
                    font.family: ("Georgia")
                    anchors.verticalCenterOffset: textBClassica.height
                    opacity: 0.85

                }

                onClicked: {
                    stackView.push("CriptografiaClassica.qml")
                    tituloToolBar.text = "Criptografia Clàssica"
                }
            }

            Button {
                id: bModerna
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.maximumHeight: 300
                Layout.minimumHeight: 150
                Layout.preferredHeight: 150
                Layout.preferredWidth: 301

                Text{
                    id: textBModerna
                    anchors.centerIn: parent
                    text: qsTr("Criptografia Moderna")
                    font.pixelSize: rowCriptoMenu.width/35
                    font.family: ("Georgia")
                    opacity: 0.85
                }

                Text{
                    anchors.centerIn: parent
                    anchors.topMargin: 1000
                    text: qsTr("Des de l'entrada de la computació fins l'actualitat")
                    font.pixelSize: rowCriptoMenu.width/75
                    font.family: ("Georgia")
                    anchors.verticalCenterOffset: textBModerna.height
                    opacity: 0.85

                }

                onClicked: {
                    stackView.push("CriptografiaModerna.qml")
                    tituloToolBar.text = "Criptografia Moderna"
                }
            }
        }
    }
}
