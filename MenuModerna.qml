import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "qrc:/Items"

Page{
    id: pMenuClassica
    objectName: "MenuModerna"
    property int contador: 0

    ColumnLayout{
        id: layout
        anchors.fill:parent
        anchors.rightMargin: 20
        anchors.bottomMargin: 20
        spacing: 15

        Text {
            id: tTitulo
            text: qsTr("Criptografia Moderna")
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: parent.width/20
            font.family: ("Georgia")

        }

        RowLayout{
            spacing: 20
            Text {
                id: tDescripccion
                Layout.fillWidth: true
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignJustify
                text: "Amb l’entrada de la computació després de la Segona Guerra Mundial, la criptologia es va convertir en una ciència complexa determinada per ciències auxiliars com les matemàtiques, la telemàtica, la informàtica, entre d’altres. A partir d’aquest moment els criptògrafs i els criptoanalistes farien ús de les noves tecnologies per desenvolupar aquesta ciència, deixant molts dels algorismes clàssics en desús i donant pas així a noves formes de criptografia."
                font.pixelSize: layout.width/50
            }
            Image{
                id: imagenCifrado
                Layout.fillWidth: true
                Layout.preferredHeight: tDescripccion.height
                Layout.preferredWidth: 1000
                fillMode: Image.PreserveAspectFit
                source: "qrc:/assets/computadorIBM.jpg"
            }
        }

        Text {
            id: tDescripccion2
            Layout.fillWidth: true
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignJustify
            text: "En aquest punt observarem tres dels xifrats moderns amb més rellevància i importància fins l’actualitat. Veurem quines són les característiques i propietats que tenen i aporten els xifrats moderns, amb l’entrada de la computació, a diferència dels xifrats clàssics. S’explicaran dos xifrats simètrics, el DES i el RC4, sent el DES per blocs i el RC4 en flux, així com un xifrat asimètric com seria el RSA. Cal destacar també una simple implementació del codi binari, passant d'ASCII a binari i viceversa. La llista de xifrats moderns, amb el pas del temps, s'anirà actualitzant."
            font.pixelSize: layout.width/50
            clip: true
        }

        GridLayout{
            id: layoutBotones
            columns: 4
            rows: 1
            Repeater{
                id: repeaterButton
                model: ["Binari", "DES", "RSA", "RC4"]
                Button{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.preferredWidth: layout.width/3
                    Layout.maximumHeight: 150
                    Text{
                        id: textBEpocas
                        anchors.centerIn: parent
                        text: qsTr(modelData)
                        font.family: ("Georgia")
                        opacity: 0.85
                        font.pointSize: parent.width/25 === 0 ? 1 : parent.width/25
                    }
                    onClicked:{
                        switch(modelData){
                            case "Sistemes de xifrat": contador = 0;break;
                            case "Edat antiga": contador = 1;break;
                            case "Edat medieval": contador = 2;break;
                            case "Renaixement i edat moderna": contador = 3;break;
                            case "S.XIX": contador = 4;break;
                            case "S.XX": contador = 5;break;
                        }
                    }
                }
            }
        }

        Rectangle{
            color: "#ff5e5e"
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.maximumHeight: 5
        }
    }
}
