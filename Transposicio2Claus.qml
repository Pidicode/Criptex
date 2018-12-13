import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import SistemasDeCifrados 1.0
import "qrc:/Items"

PageClassica {
    id: pageTrans2Claus

    SistemesXifrat{
        id:sxifrats
    }

    ColumnCifrados{
        id: columnaCifrados
        tCifrado.text: (tNoCifrado.text === "" || tPalabraClave1.text === "" || tPalabraClave2 === "") ? "" : (comprobacionCifrado) ? sxifrats.cifradoTransposicion2Claves(tNoCifrado.text, tPalabraClave1.text, tPalabraClave2.text) : sxifrats.descifradoTransposicion2Claves(tNoCifrado.text, tPalabraClave1.text, tPalabraClave2.text)
        tTitulo.text: "Mètode de transposició amb 2 claus"
        tDescripccion.text: "Amb la utilització de dues claus, podem xifrar el missatge amb un mecanisme més complex. Per xifrar i desxifrar el missatge, tant el receptor como l'emisor han d'utilitzar les mateixes claus. El mecanisme es força extens, si vol conèixer el procediment, fes click <a href='http://www.kde.org'>aquí</a> "
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
                Layout.maximumWidth: 200
                Layout.maximumHeight: 50
                placeholderText: "Introdueixi la 1ª paraula clau"
                selectByMouse: true
            }

            TextField {
                id: tPalabraClave2
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.maximumWidth: 200
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
                        id: imagenExplicacion1
                        Layout.preferredHeight: 100
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredWidth: pInformacion.width/1.5
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tabla2claves1.png"
                    }

                    TextoInformacion{
                        text: "Una vegada tenim la primera clau assignada a la taula, afegim a la taula la frase a xifrar, en aquest cas <<EXEMPLE TREBALL DE RECERCA>>"
                    }

                    Image{
                        id: imagenExplicacion2
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 350
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tabla2claves2.png"
                    }

                    TextoInformacion{
                        text: "A continuació, llegiríem les columnes en vertical seguint els nombres asignats a la paraula clau de més petit a més gran, per exemple, en aquest cas, començaríem llegint en vertical per el nombre 0 corresponent a la lletra A, donant <<PEDE>>. Obtindríem <<PEDE ETALEA XEARC MRLC ELBER>>. Una vegada obtenim aquesta frase, repetim el mateix procés amb l’altra clau ara introduint la frase ja xifrada."
                    }

                    Image{
                        id: imagenExplicacion3
                        Layout.preferredHeight: 400
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredWidth: pInformacion.width/1.5
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tabla2claves3.png"
                    }

                    TextoInformacion{
                        text: "Obtenint <<ETARLB ELEMER DAXCCE PEEARL>>. Per desxifrar el missatge el receptor tindria que saber quines son les paraules clau utilitzades (tecla i sala en aquest cas) i fer el procés a la inversa. "
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
