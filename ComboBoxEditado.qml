import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3


ComboBox {
      id: control
      Layout.fillWidth: true
      Layout.maximumWidth: 300
      model: ["Sistemes de Xifrat", "Edat antiga", "Edat mitjana", "Renaixement i edat moderna", "S.XIX", "S.XX"]

      popup: Popup {
            id: groupPopup
            clip: true
            y: control.height
            width: parent.width
            height: parent.height*listview.count
            contentItem: ListView {
                id: listview
                anchors.fill: parent
                model: control.model
                boundsBehavior: Flickable.StopAtBounds
                highlight: Rectangle { color: "#e2e2e2" }
                spacing: 0
                highlightFollowsCurrentItem: true
                currentIndex: control.highlightedIndex
                delegate: control.delegate
                ScrollIndicator.vertical: ScrollIndicator { }
            }

      }

      delegate: ItemDelegate {
          width: control.width
          contentItem: Text {
              text: modelData
              font: control.font
              elide: Text.ElideRight
              verticalAlignment: Text.AlignVCenter
          }

          highlighted: control.highlightedIndex === index

          onClicked: {
              switch(control.highlightedIndex){
                  case 0: listaCifrados.model = modeloSistemasDeCifrado; break;
                  case 1: listaCifrados.model = modeloAntiga; break;
                  case 2: listaCifrados.model = modeloMedieval; break;
                  case 3: listaCifrados.model = modeloRenacimientoModerna; break;
                  case 4: listaCifrados.model = modeloSXIX; break;
                  case 5: listaCifrados.model = modeloSXX; break;
              }
          }
      }
/*
      indicator: Canvas {
          id: canvas
          x: control.width - width - control.rightPadding
          y: control.topPadding + (control.availableHeight - height) / 2
          width: 12
          height: 8
          contextType: "2d"
          Connections {
              target: control
              onPressedChanged: canvas.requestPaint()
          }
          onPaint: {
              context.reset();
              context.moveTo(0, 0);
              context.lineTo(width, 0);
              context.lineTo(width / 2, height);
              context.closePath();
              context.fill();
          }
      }
*/
      background: Rectangle {
          implicitWidth: 185
          implicitHeight: 40

          border.width: control.visualFocus ? 2 : 1
          opacity: 0.3
      }
}
