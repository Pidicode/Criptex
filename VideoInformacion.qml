import QtQuick 2.0
import QtQuick.Window 2.3
import QtAV 1.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import "qrc:/"

Video{
    property bool videoBool: true
    id:root
    Layout.fillHeight: true
    Layout.fillWidth: true
    Layout.preferredHeight: 325
    source: "qrc:/videos/Tauler Polibi.mp4"

    Image{
        id: play
        state: "visible"
        width: root.width/2
        height: root.height/2
        fillMode: Image.PreserveAspectFit
        source: "qrc:/assets/play.png"
        anchors.centerIn: parent

        states: [
            State {
                name: "visible"
                PropertyChanges {
                    target: play
                    opacity: 1
                }
            },
            State {
                name: "invisible"
                PropertyChanges {
                    target: play
                    opacity: 0
                }
            }
        ]
        transitions: [
            Transition {
                from: "visible"
                to: "invisible"
                NumberAnimation{
                    target: play
                    duration: 250
                    property: "opacity"
                    easing.type: Easing.InOutSine
                }

            },
            Transition {
                from: "invisible"
                to: "visible"
                NumberAnimation{
                    target: play
                    duration: 250
                    property: "opacity"
                    easing.type: Easing.InOutSine
                }
            }
        ]
    }

    Image{
        id: pause
        state: "invisible"
        height: (root.height/2)+3
        fillMode: Image.PreserveAspectFit
        source: "qrc:/assets/pause.png"
        anchors.centerIn: parent

        states: [
            State {
                name: "visible"
                PropertyChanges {
                    target: pause
                    opacity: 1
                }
            },
            State {
                name: "invisible"
                PropertyChanges {
                    target: pause
                    opacity: 0
                }
            }
        ]
        transitions: [
            Transition {
                from: "visible"
                to: "invisible"
                NumberAnimation{
                    target: pause
                    duration: 250
                    property: "opacity"
                    easing.type: Easing.InOutSine
                }

            },
            Transition {
                from: "invisible"
                to: "visible"
                NumberAnimation{
                    target: pause
                    duration: 250
                    property: "opacity"
                    easing.type: Easing.InOutSine
                }
            }
        ]
    }

    Timer{
        id: playTimer
        interval: 1000
        onTriggered: play.state = "invisible"
        running: false
    }

    Timer{
        id: pauseTimer
        interval: 1000
        onTriggered: pause.state = "invisible"
        running: false
    }

    MouseArea{
        hoverEnabled: true
        anchors.fill: parent
        onClicked: {
            if(videoBool){
                parent.play()
                videoBool = false
                pause.state = "visible"
                play.state = "invisible"
                pauseTimer.running = true;
            }
            else{
                parent.pause()
                videoBool = true
                pause.state = "invisible"
                play.state = "visible"
                playTimer.running = true;
            }
        }

        RowLayout{
            spacing: 0
            anchors.bottom: parent.bottom
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: root.width-10
            Slider{
                id: sliderTiempo
                anchors.bottom: parent.bottom
                Layout.fillWidth: true
                Layout.preferredWidth: root.width-layoutSliderVolumen.width-10
                from: 0
                to: root.duration
                value: root.position
                onMoved: {
                    root.seek(sliderTiempo.value)
                }
            }

            RowLayout{
                spacing: 0
                id: layoutSliderVolumen
                Layout.preferredWidth: root.width/6.75
                Image{
                    source:"qrc:/assets/simboloAudio.png"
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    fillMode: Image.PreserveAspectFit
                    Layout.maximumHeight: 25
                    Layout.maximumWidth: 20
                }

                Slider{
                    id: sliderVolumen
                    anchors.bottom: parent.bottom
                    Layout.fillWidth: true
                    from: 0
                    to: 1
                    value: root.volume
                    onMoved: {
                        root.volume = sliderVolumen.value
                    }
                }
                Image{
                    source:"qrc:/assets/simboloExpandir.png"
                    Layout.fillWidth: true
                    fillMode: Image.PreserveAspectFit
                    Layout.maximumHeight: 25
                    Layout.maximumWidth: 20

                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            var component = Qt.createComponent("VideoVentana.qml")
                            var window    = component.createObject(root);
                            window.show()
                            root.pause()
                        }
                    }
                }
            }
        }
        onDoubleClicked: {
            var component = Qt.createComponent("VideoVentana.qml")
            var window    = component.createObject(root);
            window.show()
        }
    }
}







