import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Cifrados 1.0
import "qrc:/Items"

PageClassica {
    id: pageMorse

    XifratsXIX{
        id: xifrats
    }

    ColumnCifrados{
        id: columnaCifrados
        tTitulo.text: "Codi Morse"
        tDescripccion.text: "Alfred Vail junt amb Samuel Morse, investigant el telègraf elèctric creen el codi Morse, codi que patentaria posteriorment Samuel Morse, junt amb el telègraf elèctric. Funcionava mitjançant impulsos elèctrics del telègraf i segons la durada d'aquests, es representaba amb rayes (—) o punts (.).  Per conèixer més sobre la història i el seu alfabet fes click <a href='http://www.kde.org'>aquí</a>"
        imagenCifrado.visible: true
        imagenCifrado.source: "qrc:/assets/Morse.jpg"
        widthImagen: 325
        heightImagen: 150
        tCifrado.text: (tNoCifrado.text === "") ? "" : (comprobacionCifrado) ? xifrats.cifradoMorse(tNoCifrado.text) : xifrats.descifradoMorse(tNoCifrado.text)
        tDescripccion.onLinkActivated: {
            pInformacion.state = (pInformacion.state === "visible") ? "invisible" : "visible"
            pInformacion.visible = (pInformacion.visible === true) ? false : true
        }
        PageInformacion{
            id: pInformacion
            Layout.minimumHeight: window.height/3
            FlickableInformacion{
                ColumnLayoutInformacion{
                    id: columnaLayout
                    RowLayout{
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.preferredWidth: pInformacion.width
                        Layout.maximumHeight: pInformacion.height+50
                        spacing: 10
                        TextoInformacion{
                            text: "El codi Morse es va utilitzar com a sistema per la primera tranmissió pel telègraf. La telegrafia és el sistema de comunicació que permet la transmissió d’informació a llarga distància a través d’impulsos elèctrics y utilitzant un codi de signes preestablert. Els primers telègrafs no eren elèctrics si no que òptics, per exemple, els senyals de fum. A cada lletra del alfabet li correspon un conjunt de sons curts i llargs, representats amb punts (.) o ralles (—). El punt te la mínima duració possible, mentre que la ralla té la duració d’aproximadament 3 punts. \nEl codi de l'alfabet la imatge de la dreta."
                        }
                        Image{
                            id: imagenExplicacion2
                            Layout.alignment: Qt.AlignTop
                            Layout.preferredHeight: 400
                            Layout.preferredWidth: pInformacion.width
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            fillMode: Image.PreserveAspectFit
                            source: "qrc:/assets/tablaMorse.png"
                        }
                    }
                    TextoInformacion{
                        text: "Cal mencionar que el codi Morse no es podria considerar un mètode criptogràfic en si mateix, ja que el seu objectiu no es l’ocultació del missatge, si no una representació del alfabet en ralles y punts per ser llegida per el telègraf. Per proporcionar seguretat, el missatge que es proporcionava al telegrafista, qui enviaria el missatge en codi morse, s’enviava pròpiament xifrat, evitant possibles manques en la seguretat."
                    }

                    RowLayout{
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.preferredWidth: pInformacion.width
                        Image{
                            Layout.alignment: Qt.AlignRight
                            Layout.preferredHeight: 350
                            Layout.preferredWidth: pInformacion.width/3
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            fillMode: Image.PreserveAspectFit
                            source: "qrc:/assets/Morse.jpg"
                        }
                        Image{
                            Layout.alignment: Qt.AlignLeft
                            Layout.preferredHeight: 350
                            Layout.preferredWidth: pInformacion.width/3
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            fillMode: Image.PreserveAspectFit
                            source: "qrc:/assets/telegraf.jpg"
                        }
                    }

                }
            }
        }
        Component.onCompleted: {
            pInformacion.Layout.row = 2
            tNoCifrado.Layout.row = 6
        }
    }
}
