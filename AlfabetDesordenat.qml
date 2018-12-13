import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import SistemasDeCifrados 1.0
import "qrc:/Items"

PageClassica {
    id: pageAlfabetDesordenat
    x: stackViewClassica.x
    width: stackViewClassica.width
    height: stackViewClassica.height

    SistemesXifrat{
        id:sxifrats
    }

    ColumnCifrados{
        id: columnaCifrados
        tTitulo.text: "Alfabet desordenat"
        tCifrado.text: (tNoCifrado.text === "" || tPalabraClave.text === "") ? "" : (comprobacionCifrado) ? sxifrats.cifradoAlfabetoDesordenado(tNoCifrado.text,tPalabraClave.text) : sxifrats.descifradoAlfabetoDesordenado(tNoCifrado.text,tPalabraClave.text)
        tDescripccion.text: "El següent xifrat, a partir d'una paraula clau, substitueix l'alfabet tradicional per un altre desordenat, utilizant aquest per l'encriptació de la frase. Per conèixer el funcionament del xifrat fes click <a href='http://www.kde.org'>aquí</a>"
        tDescripccion.onLinkActivated: {
            pInformacion.state = (pInformacion.state === "visible") ? "invisible" : "visible"
            pInformacion.visible = (pInformacion.visible === true) ? false : true
        }

        tNoCifrado.onTextChanged: {
            if(tPalabraClave.text === ""){
                error.textoDialogo = "Clau no introduïda."
                error.open()
                tNoCifrado.clear()
            }

        }

        DialogoError{
            id: error
        }


        TextField {
            id: tPalabraClave
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.maximumWidth: 200
            Layout.maximumHeight: 50
            text: qsTr("")
            placeholderText: "Introdueixi la paraula clau"
            selectByMouse: true
        }

        PageInformacion{
            id: pInformacion
            Layout.minimumHeight: window.height/3.5
            FlickableInformacion{
                ColumnLayoutInformacion{
                    id: columnaLayout
                    RowLayout{
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.preferredWidth: pInformacion.width
                        spacing: 10
                        TextoInformacion{
                            text: "Diguem-ne que volem xifrar <<ENVIAR AJUDA>>. Primer de tot, afegim a l'inici del nostre alfabet la paraula clau escollida, en aquest cas <<TECLA>>, i continuem l'alfabet evitant les lletres que la paraula clau ja conté, resultant amb el següent alfabet <<TECLABDFGHIJKMNOPQRSUVWXYZ>>. Ara, amb el nou alfabet desordenat, el que abans era la A ara es la T, la B per la E, aixi amb totes les lletres. La nostra frase, després de xifrar-la, resultaria en "
                            wrapMode: Text.WordWrap
                        }
                        Image{
                            Layout.preferredHeight: 300
                            Layout.preferredWidth: columnaLayout.width/2
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectFit
                            source: "qrc:/assets/tablaAlfabetoDesordenado.png"
                        }
                    }
                }
            }
        }

        Component.onCompleted: {
            pInformacion.Layout.row = 2
            tNoCifrado.Layout.row = 3
            layoutBotones.Layout.row = 6
            tPalabraClave.Layout.row = 5

        }
    }
}
