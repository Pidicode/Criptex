import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3

Flickable{
    anchors.fill: parent
    contentHeight: columnaLayout.implicitHeight
    contentWidth: columnaLayout.implicitWidth
    boundsBehavior: Flickable.StopAtBounds
    ScrollIndicator.vertical: ScrollIndicator { }
    clip: true
}
