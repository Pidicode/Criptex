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
        tDescripccion.text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. "
        tCifrado.text: tNoCifrado.text === "" ? "" : (comprobacionCifrado) ? xifrats.cifradoBinario(tNoCifrado.text) : xifrats.descifradoBinario(tNoCifrado.text, tCifrado.text)


    }
}
