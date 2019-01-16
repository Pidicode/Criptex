import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import FuncionesBasicas 1.0
import QtQuick.Window 2.3
import QtGraphicalEffects 1.0
import "qrc:/Items"


Page {

    property string xifrats: ""
    signal exit
    id: pageClassica
    anchors.fill: parent

    FB{ //Funciones basicas C++
        id: fb
    }

    property alias modeloSistemasDeCifrado: modeloSistemasDeCifrado
    property alias modeloAntiga: modeloAntiga
    property alias modeloMedieval: modeloMedievalModerna
    property alias modeloSXIX: modeloSXIX
    property alias modeloSXX: modeloSXX
    //property alias listaCifrados: listaCifrados

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



    VisualItemModel {
        id: modeloSistemasDeCifrado

        ListItem {
            text: "Metode de Inversió"
            onListItemClick: seleccionarCifrado("SistemesDeXifrat/MInversio.qml")
        }
        ListItem {
            text: "Mètode vertical paral·lel"
            onListItemClick: seleccionarCifrado("SistemesDeXifrat/MVerticalParal·lel.qml")
        }
        ListItem {
            text: "Transposició amb 2 claus"
            onListItemClick: seleccionarCifrado("SistemesDeXifrat/Transposicio2Claus.qml")
        }
        ListItem {
            text: "Els alfabets desordenats"
            onListItemClick: seleccionarCifrado("SistemesDeXifrat/AlfabetDesordenat.qml")
        }
        ListItem {
            text: "El codi calendari"
            onListItemClick: seleccionarCifrado("SistemesDeXifrat/CodiCalendari.qml")
        }
    }

    VisualItemModel{
        id: modeloAntiga
        ListItem {
            text: "La escitala"
            onListItemClick: seleccionarCifrado("EdatAntiga/Escitala.qml")
        }
        ListItem {
            text: "Xifrat Cesar"
            onListItemClick:{
                exit;
                seleccionarCifrado("EdatAntiga/XifratCesar.qml")
            }
        }
        ListItem {
            text: "Xifrat Atbash"
            onListItemClick: seleccionarCifrado("EdatAntiga/XifratAtbash.qml")
        }
        ListItem {
            text: "El tauler de Polibio"
            onListItemClick: seleccionarCifrado("EdatAntiga/TaulerPolibio.qml")
        }

    }

    VisualItemModel{
        id: modeloMedievalModerna
        ListItem {
            text: "Anàl·lisi de freqüències"
            onListItemClick: seleccionarCifrado("EdatMedieval/AnalisiFrecuencias.qml")
        }
        ListItem {
            text: "La taula de Tritemio"
            onListItemClick: seleccionarCifrado("Renaixement/TaulaTritemio.qml"), console.log(stackViewClassica.depth)
        }
        ListItem {
            text: "Xifrat de Vigenere"
            onListItemClick: seleccionarCifrado("Renaixement/XifratVigenere.qml")
        }
        ListItem {
            text: "Alfabet binari de Francis Bacon"
            onListItemClick: seleccionarCifrado("Renaixement/CodiBacon.qml")
        }
    }

    VisualItemModel{
        id: modeloSXIX
        ListItem {
            text: "La xifra de Rail Fence"
            onListItemClick: seleccionarCifrado("XIX/XifratRailFence.qml"), console.log(stackViewClassica.depth)
        }
        ListItem {
            text: "La xifra de Delastelle"
            onListItemClick: seleccionarCifrado("XIX/XifratDelastelle.qml")
        }
        ListItem {
            text: "La xifra de Playfair"
            onListItemClick: seleccionarCifrado("XIX/XifratPlayfair.qml")
        }
        ListItem {
            text: "La xifra dels Nihilistes Rusos"
            onListItemClick: seleccionarCifrado("XIX/XifratNihilista.qml")
        }
        ListItem {
            text: "Codi Morse"
            onListItemClick: seleccionarCifrado("XIX/CodiMorse.qml")
        }
    }

    VisualItemModel{
        id: modeloSXX
        ListItem {
            text: "La xifra ADFGVX"
            onListItemClick: seleccionarCifrado("XX/XifratADFGVX.qml"), console.log(stackViewClassica.depth)
        }
        ListItem {
            text: "La xifra Hill"
            onListItemClick: seleccionarCifrado("XX/XifratHill.qml")
        }
        ListItem {
            text: "La enigma"
            onListItemClick: seleccionarCifrado("XX/Enigma.qml")
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
                        text: "Sistemes de xifrat"
                        canvasListItem.visible: true
                        onListItemClick:  areaCifradosSistemas.state = (areaCifradosSistemas.state === "visible") ? "invisible" : "visible"
                    }

                    AreaCifrados{
                        id: areaCifradosSistemas
                        model: modeloSistemasDeCifrado
                    }

                    ListItem{
                        text: "Edat antiga"
                        backgroundRoot.color: "#283C50"
                        backgroundRoot.border.color: "#395671"
                        canvasListItem.visible: true
                        onListItemClick:  areaCifradosAntiga.state = (areaCifradosAntiga.state === "visible") ? "invisible" : "visible"
                    }

                    AreaCifrados{
                        id: areaCifradosAntiga
                        model: modeloAntiga

                    }

                    ListItem{
                        text: "Edat medieval i moderna"
                        backgroundRoot.color: "#283C50"
                        backgroundRoot.border.color: "#395671"
                        canvasListItem.visible: true
                        onListItemClick:  areaCifradosMedieval.state = (areaCifradosMedieval.state === "visible") ? "invisible" : "visible"
                    }

                    AreaCifrados{
                        id: areaCifradosMedieval
                        model: modeloMedievalModerna
                    }

                    ListItem{
                        text: "S.XIX"
                        backgroundRoot.color: "#283C50"
                        backgroundRoot.border.color: "#395671"
                        canvasListItem.visible: true
                        onListItemClick:  areaCifradosXIX.state = (areaCifradosXIX.state === "visible") ? "invisible" : "visible"
                    }

                    AreaCifrados{
                        id: areaCifradosXIX
                        model: modeloSXIX
                    }

                    ListItem{
                        text: "S.XX"
                        backgroundRoot.color: "#283C50"
                        backgroundRoot.border.color: "#395671"
                        canvasListItem.visible: true
                        onListItemClick:  areaCifradosXX.state = (areaCifradosXX.state === "visible") ? "invisible" : "visible"
                    }

                    AreaCifrados{
                        id: areaCifradosXX
                        model: modeloSXX
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
            initialItem: "MenuClassica.qml"


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
