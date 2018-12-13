import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Cifrados 1.0
import FuncionesBasicas 1.0
import "qrc:/Items"

PageClassica {
    id: pageDES

    XifratsModerna{
        id:xifrats
    }

    FB{
        id:fb
    }

    ColumnCifrados{
        id: columnaCifrados
        tCifrado.text: (tNoCifrado.text === "" || tPalabraClave.text === "") ? "" : (comprobacionCifrado) ? xifrats.cifradoDES(tNoCifrado.text, tPalabraClave.text) : xifrats.descifradoDES(tNoCifrado.text, tPalabraClave.text)
        tTitulo.text: "DES"
        tDescripccion.text: "A principi de la dècada dels 70, el Comitè d’Estàndards Estatunidenc (NBS), després de veure la necessitat d’un estàndard per a xifrar informació confidencial i després de consultar amb la National Security Agency (NSA), va sol·licitar propostes d’algorismes que complissin aquests requisits. Una de les propostes va ser un sistema basat en l’algorisme Lucifer, presentat per IBM, i anomenat DES.  Per conèixer més sobre el funcionament fes click <a href='http://www.kde.org'>aquí</a>"

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
            else if(fb.contarLetras(tPalabraClave.text)!==8){
                error.textoDialogo = "La clau no es de 64 bits (8 lletres)."
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
                        text: "Aquest xifrat, des del principi presentava queixes per la seva curta longitud de la clau (56 bits), entre altres, evidenciant interferències per part de la NSA. El fet és que la NSA va pressionar perquè es reduís la mida de la clau del sistema a un nombre suficientment gran perquè cap ordinador pogués atacar el sistema DES a excepció dels de la pròpia NSA. Malgrat tot, el DES va ser aprovat com a estàndard governamental l’any 1976.
DES consisteix en un sistema simètric per blocs, agafant, operant i xifrant el text clar en grups de 64 bits (8 lletres), a partir d’una paraula clau també de 64 bits.
Abans de començar pròpiament el xifrat, hem de crear setze subclaus generades a partir de la clau del sistema. Diguem-ne que com a paraula clau de 64 bits tenim <<TRCRIPTO>>. Primer passarem aquesta paraula clau a sistema binari obtenint: <<01010100 01010010 01000011 01010010 01001001 01010000 01010100 01001111>>.
Aquesta seqüència binaria, ara, l’hem de permutar, reordenar, seguint la taula següent:
"
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
