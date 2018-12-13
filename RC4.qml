import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Cifrados 1.0
import FuncionesBasicas 1.0
import "qrc:/Items"

PageClassica {
    id: pageADFGVX

    XifratsModerna{
        id:xifrats
    }

    ColumnCifrados{
        id: columnaCifrados
        tCifrado.text: (tNoCifrado.text === "" || tPalabraClave.text === "") ? "" : (comprobacionCifrado) ? xifrats.cifradoRC4(tNoCifrado.text, tPalabraClave.text) : xifrats.descifradoRC4(tNoCifrado.text, tPalabraClave.text)
        tTitulo.text: "RC4"
        tDescripccion.text: "El sistema RC4 és un dels sistemes més utilitzats e importants dels xifrats en flux, sinó el més utilitzat. Va ser dissenyat pel criptògraf Ron Rivest l’any 1897, sent inicialment un secret comercial però filtrat l’any 1994 a través d’una llista de correu. És utilitzat en protocols de xifrat populars com ara el TLS (Transport Layer Security) o el WEP (Wired Equivalent Privacy), protocol totalment insegur avui en dia.  Per conèixer més sobre el funcionament fes click <a href='http://www.kde.org'>aquí</a>"

        tDescripccion.onLinkActivated: {
            pInformacion.state = (pInformacion.state === "visible") ? "invisible" : "visible"
            pInformacion.visible = (pInformacion.visible === true) ? false : true
        }

        tNoCifrado.onTextChanged: {
            if(tPalabraClave.text === ""){
                error.textoDialogo = "Clau no introduïda."
                error.open()
                tNoCifrado.clear()
            }
        }

        DialogoError{
            id: error
        }

        TextField {
            id: tPalabraClave
            hoverEnabled: true
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.maximumWidth: 225
            Layout.maximumHeight: 50
            placeholderText: "Introdueixi la paraula clau"
            selectByMouse: true
        }

        PageInformacion{
            id: pInformacion
            Layout.minimumHeight: window.height/3
            FlickableInformacion{
                ColumnLayoutInformacion{
                    id: columnaLayout
                    TextoInformacion{
                        text: "Primer de tot, hem de crear una taula 6x6, introduint un alfabet aleatori dins d’aquesta. Al ser 6x6 tenim 36 elements, per tant, a més de les lletres de l’alfabet, hem d’afegir els números del 0 al 9. Com a exemple de taula:"
                    }
                    Image{
                        Layout.preferredHeight: 400
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaADFGVX1.png"
                    }

                    TextoInformacion{
                        text: "A continuació, diguem-ne que volem xifrar <<ATAC URGENT>>. Substituiríem cada lletra del text pla per les corresponents a la fila-columna. Per exemple, la A la substituiríem per AV ja que la seva fila correspon a la fila ‘A’ i la seva columna a la columna ‘V’. Xifrant tota la paraula tindríem <<AV AA AV AF GF GA DF AD FF AA>>.
Una vegada tenim la frase xifrada per la taula (si ens fixem hem fet un xifrat per substitució), agafem una paraula clau per realitzar la segona part del xifrat, diguem-ne la paraula <<SALA>>. El procés consistirà en crear una nova taula, de tantes columnes com lletres tingui la paraula clau, e introduir horitzontalment la frase xifrada:
"
                    }

                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 350
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaADFGVX2.png"
                    }

                    TextoInformacion{
                        text: "Ara, amb la nova taula creada, reordenem les columnes per ordre alfabètic:"
                    }

                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 350
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaADFGVX3.png"
                    }

                    TextoInformacion{
                        text: "A continuació, llegiríem la taula verticalment per columnes i obtindríem la frase xifrada: <<VVFFFAFADAAAGAAAAGDF>>. Pel que fa el programa, cal introduir un alfabet de 36 caràcters (l'alfabet normal + els números del 0 al 9) i la paraula clau."
                    }
                }
            }
        }
        Component.onCompleted: {
            pInformacion.Layout.row = 2
            tNoCifrado.Layout.row = 3
            layoutBotones.Layout.row = 6
            tPalabraClave.Layout.row = 5
        }
    }
}
