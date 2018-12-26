import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3

Page{
    id: pInformacion
    Layout.fillHeight: true
    Layout.fillWidth: true
    visible: false
    state: "invisible"

    scale: visible ? 1.0 : 0.1
     Behavior on scale {
       NumberAnimation  { duration: 100  }
    }



}
