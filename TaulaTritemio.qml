import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Cifrados 1.0
import "qrc:/Items"

PageClassica {
    id: pageAtbash


    XifratsRenaixement{
        id: xifrats
    }

    ColumnCifrados{
        id: columnaCifrados
        tTitulo.text: "La taula de Tritemio"
        tDescripccion.text: "Johan von Heidenberg, també conegut com Johannes Thrithemius, va ser un monge alemany fundador de Sodalitas Celticas, societat dedicada al estudi de diverses matèries, com les llengües o les matemàtiques. Va ser el creador de la primera taula de substitució polialfabètica, o tabula recta com ell anomenava. Aquesta es la taula de Tritemio. Per conèixer el funcionament del xifrat fes click <a href='http://www.kde.org'>aquí</a> "
        tCifrado.text: tNoCifrado.text === "" ? "" : (comprobacionCifrado) ? xifrats.cifradoTritemio(tNoCifrado.text) : xifrats.descifradoTritemio(tNoCifrado.text)

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
                    TextoInformacion{
                        text: "El mètode consisteix en una taula 26x26, com la següent imatge: "
                    }
                    Image{
                        id: imagenExplicacion1
                        Layout.preferredHeight: 375
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredWidth: pInformacion.width/1.5
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaTritemio.jpg"
                    }

                    TextoInformacion{
                        text: "Si ens fixem, podríem definir aquesta taula com un conjunt de xifrats Cèsar, on a la primera fila ens trobem el alfabet original, i segon aquestes avancen, l’alfabet es va avançant 1 posició. El xifrat consistiria en anar avançant l’alfabet a utilitzar segons avança la frase. Diguem-ne que volem xifrar <<TABULA RECTA>>. Amb la primera lletra, la T, mirem la lletra del primer alfabet que correspon a aquesta, altre T. La primera lletra sempre serà la mateixa. Ara, amb la A, mirem, en la seva columna, quina es la lletra que li correspon amb al segon alfabet, sent la B."
                    }

                    Image{
                        id: imagenExplicacion2
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 200
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaTritemio2.png"
                    }


                }

            }
        }

        Component.onCompleted: {
            pInformacion.Layout.row = 2
            tNoCifrado.Layout.row = 3
        }

    }

}

