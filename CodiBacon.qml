import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Cifrados 1.0
import "qrc:/Items"

PageClassica {
    id: pageAtbash


    XifratsRenaixement{
        id: xifrats
    }

    ColumnCifrados{
        tTitulo.text: "Codi Bacon"
        tDescripccion.text: "El codi Bacon es un sistema disenyat per Francis Bacon, on cada lletra del alfabet es reemplaçada per un grup de 5 As o Bs, d'acord amb l'alfabet del codi Bacon. Presenta una curiosa similitud amb el codi binari. "
        tCifrado.text: tNoCifrado.text === "" ? "" : (comprobacionCifrado) ? xifrats.cifradoBacon(tNoCifrado.text) : xifrats.descifradoBacon(tNoCifrado.text, tCifrado.text)


    }
}
