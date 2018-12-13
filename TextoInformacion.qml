import QtQuick 2.0
import QtQuick.Layouts 1.3

Text{
    text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim."
    Layout.preferredWidth: pInformacion.width
    Layout.minimumHeight: lineCount * 20
    lineHeight: 1.5
    Layout.fillHeight: true
    Layout.fillWidth: true
    wrapMode: Text.WordWrap
    horizontalAlignment: Text.AlignJustify
    font.pixelSize: columnaCifrados.width/65
    clip: true
}
