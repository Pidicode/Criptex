import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.2

ApplicationWindow {
    id: window
    visible: true
    width: Screen.width/1.5
    height: Screen.height/1.5
    minimumHeight: 500
    minimumWidth: 800
    title: qsTr("Cripto")



    header: ToolBar{
        id: toolBarPrincipal
        height: 50


        background: Rectangle {
            color: "#a6eaf1"
        }

        ToolButton{
            text: stackView.depth>1 ?  "‹" : "\u2630"
            height: parent.height
            onClicked: {
                if(stackView.depth>1){
                    stackView.pop()
                    tituloToolBar.text = "Criptografia"
                }
                stackViewClassica.clear()
            }
        }

        Text{
            id: tituloToolBar
            text: "Criptografia"
            font.family: "Georgia"
            anchors.centerIn: parent
            font.pixelSize: 20
        }
    }

    StackView{
        id: stackView
        anchors.fill: parent
        initialItem: "CriptografiaMenu.qml"

    }
}
