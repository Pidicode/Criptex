import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.0
import "qrc:/Items"

ItemDelegate {  
    property alias backgroundRoot: backgroundRoot
    property alias canvasListItem: canvasListItem
    signal listItemClick()
    onClicked: listItemClick()

    id: root
    clip: true
    width: columntest.width
    font.family: fixedFont.name
    font.pointSize: getFontSize(window.width/135)

    FontLoader{
        id: fixedFont
        source: "qrc:/assets/OpenSans-Light.ttf"
    }

    contentItem: Text{
        text: root.text
        font: root.font
        color: "#adadad"
    }

    background: Rectangle{
        id: backgroundRoot
        color: "#17242F"
        border.color: "#233546"
        border.width: 1
    }

    function getFontSize(width){
        return (width === 0 || (typeof width === 'undefined' || width === null)) ? 1 : width
    }

    indicator: Canvas {
        visible: false
        id: canvasListItem
        x: root.width - width - root.rightPadding
        y: root.topPadding + (root.availableHeight - height) / 2
        width: 12
        height: 8
        contextType: "2d"
        Connections {
            target: root
            onPressedChanged: canvasListItem.requestPaint()
        }
        onPaint: {
            context.fillStyle = "#adadad"
            context.moveTo(0, 0);
            context.lineTo(width, 0);
            context.lineTo(width / 2, height);
            context.closePath();
            context.fill();
        }
    }


}
