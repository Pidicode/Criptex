import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.0
import "qrc:/Items"
import QtQuick.Window 2.2

ListView{
    id: areaCifrados
    clip: true
    width: columntest.width

    state: "invisible"
    boundsBehavior: Flickable.StopAtBounds
    model: modeloSistemasDeCifrado

    states: [
        State {
            name: "visible"
            PropertyChanges {
                target: areaCifrados
                height: window.height===1080 ? 50*areaCifrados.count : 58*areaCifrados.count
            }
        },
        State {
            name: "invisible"
            PropertyChanges {
                target: areaCifrados
                height: 0
            }
        }
    ]
    transitions: [
        Transition {
            from: "visible"
            to: "invisible"
            NumberAnimation{
                target: areaCifrados
                duration: 500
                property: "height"
                easing.type: Easing.InOutSine
            }

        },
        Transition {
            from: "invisible"
            to: "visible"
            NumberAnimation{
                target: areaCifrados
                duration: 500
                property: "height"
                easing.type: Easing.InOutSine
            }
        }
    ]
}
