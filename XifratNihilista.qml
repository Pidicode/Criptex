import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Cifrados 1.0
import "qrc:/Items"

PageClassica {
    id: pageNihilista

    XifratsXIX{
        id:xifrats
    }

    ColumnCifrados{
        id: columnaCifrados
        tCifrado.text: (tNoCifrado.text === "" || tPalabraClave1.text === "" || tPalabraClave2 === "") ? "" : (comprobacionCifrado) ? xifrats.cifradoNihilista(tNoCifrado.text, tPalabraClave1.text, tPalabraClave2.text) : xifrats.descifradoNihilista(tNoCifrado.text, tPalabraClave1.text, tPalabraClave2.text)
        tTitulo.text: "Xifrat Nihilista"
        tDescripccion.text: "El nihilisme és un corrent filosòfic que nega tota creença, norma o principi. Aquest corrent es va estendre molt a la societat russa de la segona meitat del segle XX. Va derivar en un mitjà per la lluita dels treballadors, amb revelacions que suposarien la presó per part dels zaristes. A aquestes presons va néixer el següent xifrat, en la dècada de 1880, utilitzat pels nihilistes per comunicar-se. El mecanisme es força extens, si vol conèixer el procediment, fes click <a href='http://www.kde.org'>aquí</a> "
        tDescripccion.onLinkActivated: {
            pInformacion.state = (pInformacion.state === "visible") ? "invisible" : "visible"
            pInformacion.visible = (pInformacion.visible === true) ? false : true
        }

        tNoCifrado.onTextChanged: {
            if(tPalabraClave1.text === "" && tPalabraClave2.text === ""){
                error.textoDialogo = "Claus no introduïdes."
                error.open()
                tNoCifrado.clear()
            }
            else if(tPalabraClave1.text === ""){
                error.textoDialogo = "Clau 1 no introduïda."
                error.open()
                tNoCifrado.clear()
            }
            else if(tPalabraClave2.text === ""){
                error.textoDialogo = "Clau 2 no introduïda."
                error.open()
                tNoCifrado.clear()
            }
        }

        DialogoError{
            id: error
        }


        RowLayout {
            id: rowLayout
            Layout.fillHeight: true
            Layout.fillWidth: true

            TextField {
                id: tPalabraClave1
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.maximumWidth: 225
                Layout.maximumHeight: 50
                placeholderText: "Introdueixi la 1ª paraula clau"
                selectByMouse: true
            }

            TextField {
                id: tPalabraClave2
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.maximumWidth: 225
                Layout.maximumHeight: 50
                placeholderText: "Introdueixi la 2ª paraula clau"
                selectByMouse: true
            }
        }
        PageInformacion{
            id: pInformacion
            Layout.minimumHeight: window.height/3
            FlickableInformacion{
                ColumnLayoutInformacion{
                    id: columnaLayout
                    TextoInformacion{
                        text: "Diguem-ne que les nostres dues claus son <<TECLA>> i <<SALA>>.  A continuació, agafem la primera paraula clau i la col·loquem en una tabla, assignant cada lletra de la paraula clau la seva posició en el alfabet, començant per 0. Per exemple la T seria el 20, la E el 4, així successivament."
                    }
                    Image{
                        Layout.preferredHeight: 400
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaNihilista1.png"
                    }

                    TextoInformacion{
                        text: "Una vegada tenim la taula, agafem una nova paraula clau, per exemple <<SALA>>, i la xifrem amb la taula. Recordant la taula de Polibi, es xifrava substituint cada lletra per las posicions línia-columna d’aquestes en el quadrat. Per exemple la S correspon a la fila 4 columna 4, donant-nos 43. Xifrant tota la paraula tindríem <<44 15 14 15>>
Ara, fem una nova taula, on introduirem la frase a xifrar, per exemple <<NECESSITEM MUNICIÓ>>, la seva encriptació, el xifrat de la paraula clau anterior i la suma vertical d’aquests dos.
"
                    }

                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 300
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaNihilista2.png"
                    }

                    TextoInformacion{
                        text: "A la primera fila tenim el text pla, a la segona el text xifrat, a la tercera el xifrat de la paraula clau, i a la quarta la suma dels dos. A la fila de la paraula clau, repetim el xifrat fins que ocupi totes les columnes. A més, si la suma dels dos nombres donés més de 100, tindríem que restar 100 i deixar el número que donés. Per exemple, si tinguéssim 110 deixariem 10, o si tinguéssim 105, deixaríem 05. El resultat de les sumes seria el xifrat, per tant, si enviem el missatge en paquets de 5 en 5 , tindríem <<78272 72788 59452 65648 47894 94528 7550>>."
                    }        
                }
            }
        }
        Component.onCompleted: {
            pInformacion.Layout.row = 2
            tNoCifrado.Layout.row = 3
            layoutBotones.Layout.row = 6
            rowLayout.Layout.row = 5

        }
    }
}
