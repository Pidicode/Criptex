import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import SistemasDeCifrados 1.0
import "qrc:/Items"

PageClassica {
    id: pageSustitucioNumerica

    SistemesXifrat{
        id:sxifrats
    }

    ColumnCifrados{
        tTitulo.text: "Mètode de sustitució numèrica"

        tCifrado.text: (tNoCifrado.text === "" || tPalabraClave.text === "") ? "" : (comprobacionCifrado) ? sxifrats.cifradoSustitucionNumerica(tNoCifrado.text, tPalabraClave.text) : sxifrats.descifradoSustitucionNumerica(tNoCifrado.text, tPalabraClave.text)

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

        Component.onCompleted: {
            layoutBotones.Layout.row = 6
            tPalabraClave.Layout.row = 5
        }
    }
}
