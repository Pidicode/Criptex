import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Dialog {
    property alias textoDialogo: labelError.text

    id: error
    title: "Error"
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    standardButtons: Dialog.Ok

    Label {
        id: labelError
        text: "Cal seleccionar una paraula clau (3 caràcters)"
    }
}
