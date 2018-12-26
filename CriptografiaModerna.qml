import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import FuncionesBasicas 1.0
import QtQuick.Window 2.3
import QtGraphicalEffects 1.0
import "qrc:/Items"


Page {

    property string xifrats: ""

    id: pageClassica
    anchors.fill: parent

    FB{ //Funciones basicas C++
        id: fb
    }

    function seleccionarCifrado(pathCifrado){
        if(stackViewClassica.depth==0){
            stackViewClassica.push(pathCifrado),stackViewClassica.replace(pathCifrado)
            stackViewClassica.replaceEnter
            stackViewClassica.replaceExit
            console.log(stackViewClassica.depth)
        }
        else if(stackViewClassica.depth>=1){
            stackViewClassica.replace(pathCifrado)
            stackViewClassica.replaceEnter
            stackViewClassica.replaceExit
        }
    }

    RowLayout {

        anchors.fill: parent
        spacing: 50
        ColumnLayout{
            id: columntest
            Layout.fillWidth: true
            Layout.preferredWidth: 175
            Rectangle{
                anchors.fill: parent
                color: "#283C50"
                z: -2
            }

            ListView {
                spacing: 0
                Layout.topMargin: 20
                id: listaSistemes
                anchors.topMargin: 50
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredWidth: 175
                clip: true
                boundsBehavior: Flickable.StopAtBounds
                model: VisualItemModel{

                    ListItem{
                        height: -1
                        backgroundRoot.color: "#283C50"

                    }

                    ListItem{
                        backgroundRoot.color: "#283C50"
                        backgroundRoot.border.color: "#395671"
                        text: "Codi Binari"
                        onListItemClick: {
                            seleccionarCifrado("Moderna/CodiBinari.qml")
                        }
                    }

                    ListItem{
                        text: "RSA"
                        backgroundRoot.color: "#283C50"
                        backgroundRoot.border.color: "#395671"
                        onListItemClick: {
                            seleccionarCifrado("Moderna/XifratRSA.qml")
                        }
                    }

                    ListItem{
                        text: "RC4"
                        backgroundRoot.color: "#283C50"
                        backgroundRoot.border.color: "#395671"
                        onListItemClick: {
                            seleccionarCifrado("Moderna/RC4.qml")
                        }
                    }

                    ListItem{
                        text: "DES"
                        backgroundRoot.color: "#283C50"
                        backgroundRoot.border.color: "#395671"
                        onListItemClick: {
                            seleccionarCifrado("Moderna/DES.qml")
                        }
                    }

                }

                delegate: ListItem{
                    width: parent.width
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                }
                ScrollIndicator.vertical: ScrollIndicator { }
            }

        }

        StackView{
            Layout.topMargin: 20
            id: stackViewClassica
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredHeight: Screen.height/3
            Layout.preferredWidth: Screen.width/3
            initialItem: "MenuModerna.qml"

            replaceEnter: Transition {
                PropertyAnimation {
                    property: "y"
                    from: 1000
                    to:0
                    duration: 250
                }
            }

            replaceExit: Transition {
                PropertyAnimation{
                    property: "y"
                    from: 1000
                    to: 0
                    duration: 250
                }
            }
        }
    }
}
