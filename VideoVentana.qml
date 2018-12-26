import QtQuick 2.9
import QtQuick.Window 2.3
import QtAV 1.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

Window {
    visible: true
    id: roota
    width: 1600; height: 900

    property bool videoBool: true



    Video{
        id: video

        anchors.fill: parent
        Layout.preferredHeight: 500
        volume: 0.2
        source: root.source

        Image{
            id: play
            state: "visible"
            width: roota.width/2
            height: roota.height/2
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
            height: (roota.height/2)+3
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
                Layout.preferredWidth: video.width-10
                Slider{
                    id: sliderTiempo
                    anchors.bottom: parent.bottom
                    Layout.fillWidth: true
                    Layout.preferredWidth: video.width-layoutSliderVolumen.width-10
                    from: 0
                    to: video.duration
                    value: video.position
                    onMoved: {
                        video.seek(sliderTiempo.value)
                    }
                }

                RowLayout{
                    spacing: 0
                    id: layoutSliderVolumen
                    Layout.preferredWidth: roota.width/6.75
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
                        value: video.volume
                        onMoved: {
                            video.volume = sliderVolumen.value
                        }
                    }
                    Image{
                        source:"qrc:/assets/simboloMinimizar.png"
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        Layout.maximumHeight: 25
                        Layout.maximumWidth: 20

                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                roota.close()
                            }
                        }
                    }
                }
            }
        }
        onStopped: {
            videoBool = true
        }
    }
    onClosing: {
        video.stop()
    }

}
