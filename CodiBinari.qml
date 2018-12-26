import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Cifrados 1.0
import "qrc:/Items"

PageClassica {
    id: pageBinari


    XifratsModerna{
        id: xifrats
    }

    ColumnCifrados{
        tTitulo.text: "Codi Binari"
        tDescripccion.text: "Aquest codi presenta simplement una sencilla conversió de text a binari i viceversa, basant-se en la taula ASCII."
        tCifrado.text: tNoCifrado.text === "" ? "" : (comprobacionCifrado) ? xifrats.cifradoBinario(tNoCifrado.text) : xifrats.descifradoBinario(tNoCifrado.text, tCifrado.text)


    }
}
