import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import SistemasDeCifrados 1.0
import "qrc:/Items"

PageClassica {
    id: pageInversion

    SistemesXifrat{
        id: sxifrats
    }

    ColumnCifrados{
        tTitulo.text: "Mètode de Inversió"
        tDescripccion.text: "El mètode d'inversió és un dels sistemes de transposició més sencills. Consisteix en l'inversió de la frase a xifrar, com el seu propi nom indica. Si tenim <<EXEMPLE>> com a frase, resultarà en <<ELPMEXE>>. Cal destacar l'ausència de botons de 'xifrar' o 'desxifrar' en aquest xifrat per la simetria en ambdós casos."

        layoutBotones.visible: false
        tCifrado.text: sxifrats.cifradoInversion(tNoCifrado.text)
    }
}
