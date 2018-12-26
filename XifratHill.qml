import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Cifrados 1.0
import FuncionesBasicas 1.0
import QtQuick.Controls.Material 2.2
import "qrc:/Items"

PageClassica {
    id: pageHill

    XifratsXX{
        id:xifrats
    }

    FB{
        id:fb
    }

    property bool comprobar: false
    property bool comprobarMatriz: false

    function getMatrizNumeros(){
        for(var i = 0; i<rango.value*rango.value;i++){
            repeaterMatriz.itemAt(i).text = xifrats.rellenarMatrizUI(fb.quitarNamespaces(tPalabraClave1.text),i)
            if(i===fb.quitarNamespaces(tPalabraClave1.text)-1) break
        }
    }

    function checkMatriz(){
        for(var i = 0; i<rango.value*rango.value;i++){
            if(repeaterMatriz.itemAt(i).text === "-1") repeaterMatriz.itemAt(i).text = ""
        }
    }

    ColumnCifrados{
        id: columnaCifrados
        tCifrado.text: (tNoCifrado.text === "" || tPalabraClave1.text === "") ? "" : (comprobacionCifrado) ? xifrats.cifradoHill(tNoCifrado.text, tPalabraClave1.text, rango.value) : xifrats.descifradoHill(tNoCifrado.text, tPalabraClave1.text, rango.value)
        tTitulo.text: "Xifrat Hill"
        tDescripccion.text: "Lester S. Hill, matemàtic nord-americà, va inventar la xifra Hill l’any 1929, consistint en l’operació de matrius per realitzar el xifrat. En el programa cal introduir una matriu on el seu determinant no sigui 0 i el mcd(det,26) = 1. Per conèixer més sobre el funcionament i els requisits fes click <a href='http://www.kde.org'>aquí</a>"

        tNoCifrado.onTextChanged: {
            if(!xifrats.comprobarMatriz(tPalabraClave1.text, rango.value)){
                tNoCifrado.clear()
                test.open()
            }
        }

        Dialog {
            id: test
            title: "Error"
            x: (parent.width - width) / 2
            y: (parent.height - height) / 2
            standardButtons: Dialog.Ok

            Label {
                text: "La matriu inserida no es invertible, provi amb una altra siusplau."
            }
        }

        tDescripccion.onLinkActivated: {
            pInformacion.state = (pInformacion.state === "visible") ? "invisible" : "visible"
            pInformacion.visible = (pInformacion.visible === true) ? false : true
        }

        RowLayout{
            id: rowLayout
            spacing: 25

            ColumnLayout{
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 25

                TextField {
                    id: tPalabraClave1
                    hoverEnabled: true
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.maximumWidth: 300
                    Layout.maximumHeight: 50
                    placeholderText: "Introdueixi la paraula clau"
                    onTextChanged: {
                        getMatrizNumeros()
                        checkMatriz()
                    }
                }
                RowLayout{
                    SpinBox{
                        id: rango
                        Layout.alignment: Qt.AlignBottom
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.preferredWidth: 100
                        Layout.maximumWidth: 100
                        Layout.minimumWidth: 50
                        Layout.maximumHeight: 25
                        from: 2
                    }

                    Text{
                        text: "Ordre de la matriu"
                        font.pixelSize: columnaCifrados.width/65
                    }
                }


            }

            GridLayout{
                Layout.alignment: Qt.AlignHCenter
                id: gridLayout
                rows: rango.value
                columns: rango.value
                Layout.fillHeight: true
                Layout.fillWidth: true
                Repeater{
                    id: repeaterMatriz
                    model: rango.value*rango.value
                    TextField {
                        hoverEnabled: false
                        selectByMouse: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.WrapAnywhere
                        Layout.preferredHeight: 25
                        Layout.maximumWidth:  50
                        Layout.minimumWidth:  50
                        Layout.minimumHeight: 40
                        Layout.maximumHeight: 50
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        background: Rectangle{
                            color: "transparent"
                            border.color: "gray"
                            clip: true
                            border.width: 1
                        }
                    }
                }
            }

            Button{
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.maximumWidth: 200
                Layout.maximumHeight: 50

                Text{
                    id: textBClassica
                    anchors.centerIn: parent
                    text: qsTr("Generar matriu vàlida")
                    font.pixelSize: columnaCifrados.width/65
                    opacity: 0.85
                    clip: true
                }

                onClicked: {
                    tPalabraClave1.text = xifrats.generarMatriz(rango.value)
                }
            }

        }

        PageInformacion{
            id: pInformacion
            Layout.minimumHeight: window.height/3
            FlickableInformacion{
                ColumnLayoutInformacion{
                    id: columnaLayout
                    TextoInformacion{
                        text: "Es farà ús d’una matriu com a clau del sistema que haurà de ser invertible, o sigui, amb determinant != 0. Cal mencionar que estarem treballant amb congruència modular 26 (les lletres de l’alfabet) i per tant, si volem trobar l’invers multiplicatiu de la matriu, ens hem d’assegurar que el determinant i 26 son coprimers, o sigui, mcd(|A|, 26) = 1. Si això no es compleix, no es podrà trobar l’invers multiplicatiu, i per tant, no podrem invertir la matriu, fet necessari per poder desxifrar el missatge."
                    }
                    TextoInformacion{
                        text: "Primer de tot, determinarem una matriu vàlida per el xifrat:"
                    }
                    Image{
                        Layout.preferredHeight: 250
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/matrizHill1.png"
                    }

                    TextoInformacion{
                        text: "Si ens fixem, el determinant de la matriu no es 0 ((8*3*2+2*4*8+5*9*3)-(5*3*8+9*2*2+8*4*3) = -5), un dels dos requisits de la matriu. Ara cal calcular el màxim comú divisor entre el determinant i 26, però abans hem de passar a positiu el determinant dins el mod 26, sumant-li 26 i resultant en 21. Per tant, mcd(21,26) = 1, complint l’altre requisit, podent dir que aquesta matriu es invertible en congruència modular 26."
                    }

                    TextoInformacion{
                        text: "Una vegada tenim la matriu clau, podem realitzar el xifrat. Diguem-ne que volem xifrar <<OPERACIONS AMB MATRIUS>>. Primer, hem de dividir el missatge en blocs de tantes lletres com l’ordre de la matriu. En aquest cas la matriu es 3x3, o sigui, ordre 3, per tant, dividim el missatge en blocs 3 lletres, resultant en <<OPE RAC ION SAM BMA TRI US>>. Si ens fixem, l’últim bloc es de 2, per evitar això podem afegir una X, resultant finalment en << OPE RAC ION SAM BMA TRI USX>>. Ara, anem agafant els blocs de lletres per xifrar el missatge."
                    }

                    TextoInformacion{
                        text: "Agafem el primer bloc de lletres, <<OPE>>, i el transcrivim segons l’índex d’aquestes a l’alfabet, com podem veure a la següent taula, en <<14 15 4>>:"
                    }

                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 100
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaHill.png"
                    }

                    TextoInformacion{
                        text: "Ara, aquests dos números els col·loquem en una columna i els multipliquem per la matriu clau:"
                    }

                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 200
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/matrizHill2.png"
                    }

                    TextoInformacion{
                        text: "Per multiplicar la columna per la matriu, realitzem la mateixa operació amb totes les files de la matriu clau, multiplicar el primer nombre d’aquesta per el primer de la matriu resultant, el segon per el segon, el tercer per el tercer, repetint l’operació amb les files restants."
                    }

                    TextoInformacion{
                        text: "Per exemple, l’operació de la primera fila seria:"
                    }

                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 250
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/matrizHill3.png"
                    }

                    TextoInformacion{
                        text: "Així amb les altres dues files, resultant en:"
                    }

                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 200
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/matrizHill4.png"
                    }

                    TextoInformacion{
                        text: "Però recordem que la matriu esta en congruència modular 26, per tant, el resultat l’hem de fer correspondre a aquest mòdul."
                    }

                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 200
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/matrizHill5.png"
                    }

                    TextoInformacion{
                        text: "Finalment, els nombres del resultat (6 5 9) els substituïm per la seva correspondència a l’alfabet, sent el número 11 l’índex de la lletra H a l’alfabet, el 5 l’índex de la F i el 17 l’índex de la J, resultant en <<HFJ>>."
                    }

                    TextoInformacion{
                        text: "Aquest procés el repetim amb els blocs restants de lletres i obtenim <<GFJQFKBKCWCMGTSSULZOA>>"
                    }

                    TextoInformacion{
                        text: "Deixem un link a un vídeo força explicatiu del xifrat Hill. No deixem la seva reproducció en el programa per la seva gran duració: <a href='https://www.youtube.com/watch?v=ZAXkmBq9Zl0'>https://www.youtube.com/watch?v=ZAXkmBq9Zl0</a>"
                        onLinkActivated: Qt.openUrlExternally("https://www.youtube.com/watch?v=ZAXkmBq9Zl0")
                    }

                }
            }
        }

        Component.onCompleted: {
            pInformacion.Layout.row = 2
            tNoCifrado.Layout.row = 3
            layoutBotones.Layout.row = 6
            rowLayout.Layout.row = 5

        }
    }
}
