import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "qrc:/Items"

Page{
    id: pMenuClassica
    objectName: "MenuClassica"
    property int contador: 0

    ColumnLayout{
        id: layout
        anchors.fill:parent
        anchors.rightMargin: 20
        anchors.bottomMargin: 20
        spacing: 15

        Text {
            id: tTitulo
            text: qsTr("Criptografia Clàssica")
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
                text: "La criptografia no és una eina moderna, ha estat emprada durant cents d’anys per protegir informació classificada o privada. L’entrada de la computació al voltant dels anys 60-70 va revolucionar completament la criptografia, deixant pràcticament obsoleta la criptografia darrera. Per aquest motiu, hem de diferenciar la criptografia clàssica de la moderna."
                font.pixelSize: layout.width/50
            }
            Image{
                id: imagenCifrado
                Layout.fillWidth: true
                Layout.preferredHeight: tDescripccion.height
                Layout.preferredWidth: 600
                fillMode: Image.PreserveAspectFit
                source: "qrc:/assets/escitala.png"
            }
        }

        Text {
            id: tDescripccion2
            Layout.fillWidth: true
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignJustify
            text: "Els xifrats clàssics es solien dividir en xifrats de substitució i de transposició. En un missatge on s’aplica un sistema de transposició les lletres del missatge original no es substitueixen si no que es desordenen. En canvi, quan apliquem un sistema de substitució per xifrar un missatge substituïm les lletres d’aquest per unes altres.\n\nPer una millor classificació, hem dividit els xifrats cronològicament."
            font.pixelSize: layout.width/50
            clip: true
        }

        GridLayout{
            id: layoutBotones
            columns: 3
            rows: 2
            Repeater{
                id: repeaterButton
                model: ["Sistemes de xifrat", "Edat antiga", "Edat medieval", "Renaixement i edat moderna", "S.XIX", "S.XX"]
                Button{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.preferredWidth: layout.width/3
                    Layout.preferredHeight: 200
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
