import QtQuick 2.0
import QtQuick.Layouts 1.3
import FuncionesBasicas 1.0

Rectangle{
    clip: true

    FB{
        id:fb
    }

    property int realHeight: rectanguloFrecuencias.Layout.preferredHeight
    property int aux: rectanguloFrecuencias.Layout.preferredHeight
    id: rectanguloFrecuencias
    Layout.alignment: Qt.AlignBottom
    Layout.fillWidth: true 
    Layout.preferredHeight: fb.contarLetrasFrecuencias(columnaCifrados.tNoCifrado.text, modelData)
    Layout.minimumHeight: 15
    Layout.maximumWidth: rowFrecuencias.width
    Layout.maximumHeight: rowFrecuencias.height
    color: "#141414"
}
