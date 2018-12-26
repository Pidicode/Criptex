import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Cifrados 1.0
import "qrc:/Items"

PageClassica {
    id: pagePlayFair
    x: stackViewClassica.x
    width: stackViewClassica.width
    height: stackViewClassica.height

    XifratsXIX{
        id:sxifrats
    }

    ColumnCifrados{
        id: columnaCifrados
        tTitulo.text: "Xifrat Playfair"
        tCifrado.text: (tNoCifrado.text === "" || tPalabraClave.text === "") ? "" : (comprobacionCifrado) ? sxifrats.cifradoPlayfair(tNoCifrado.text,tPalabraClave.text) : sxifrats.descifradoPlayfair(tNoCifrado.text,tPalabraClave.text)
        tDescripccion.text: "El xifrat Playfair va ser el primer xifrat on es va utilitzar la substitució poligràmica, o sigui, una substitució on els caràcters no es substitueixen un per un si no que per pars. Va ser creat per Charles Wheatstone, l’any 1854, amb la finalitat d’utilitzar-lo per xifrar missatges que s’enviarien per el telègraf. Per conèixer el funcionament del xifrat fes click <a href='http://www.kde.org'>aquí</a>"
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
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.maximumWidth: 200
            Layout.maximumHeight: 50
            text: qsTr("")
            placeholderText: "Introdueixi la paraula clau"
            selectByMouse: true
        }

        PageInformacion{
            id: pInformacion
            Layout.minimumHeight: window.height/3.5
            FlickableInformacion{
                ColumnLayoutInformacion{
                    id: columnaLayout
                    TextoInformacion{
                        text: "El xifrat consisteix en una taula 5x5, com la de Polibi, on introduïm l’alfabet, amb la I-J juntes. Una vegada tenim la taula, introduïm una paraula clau al principi d’aquesta, evitant que es repeteixin els caràcters. Diguem-ne que volem utilitzar com a paraula clau <<TECLA>>. Així quedarien les taules:"
                    }
                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 400
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaPlayfair1.png"
                    }

                    TextoInformacion{
                        text: "La segona taula serà la que utilitzarem per realitzar el xifrat. Abans de començar a xifrar cap frase, hem de conèixer quines son les normes que regeixen el xifrat. Recordem que al ser un xifrat de substitució poligràmica, agafem en parells els caràcters de la frase a xifrar. Anomenarem a aquests m1 i m2. Aquestes són les regles: <ol>
    <li>Si m1 i m2 són de la mateixa fila, s'agafen c1 i c2 de la seva dreta (circularment)</li>
    <li>Si m1 i m2 són de la mateixa columna, s'agafen c1 i c2 de sota (circularment)</li>
    <li>Si m1 i m2 són de diferents files i columnes, s'agafen c1 i c2 de la diagonal oposada</li>
    <li>Si m1 i m2, són iguals, s'insereix un caràcter sense significat entre m1 i m2 per tal d'evitar la seva repetició</li>
    <li>Si el nombre de lletres és senar, s'afegeix una lletra sense significat al final del text.</li>
    </ol><br/>Per entendre en que consisteixen, les explicarem una a una. Agafem com a frase a xifrar &lt;&lt;ATAQUEM DEMÀ AL MATI JUNTS&gt;&gt;. Primer de tot, separem la frase en pars de lletres, resultant en &lt;&lt;AT AQ UE MD EM AA LM AT I&gt;&gt;. Si ens fixem, ens trobem amb 2 lletres en un mateix paquet de parells iguals, per tant hem d’aplicar la regla 4 e inserir un caràcter entre mig, resultant en &lt;&lt;AT AQ UE MD EM AX AL MA TI JU NT S&gt;&gt; Com la frase ara és imparell, trobant-se la S final sola, aplicarem la regla 5 i afegirem una lletra extra al final de la frase, normalment la X. Ens quedaria com &lt;&lt;AT AQ UE MD EM AX AL MA TI JU NT SX&gt;&gt;.
A continuació, agafem el primer parell de lletres &lt;&lt;AT&gt;&gt;. Si ens fixem, la A i la T es troben a la mateixa fila, per tant apliquem la primera regla. Com ens indica aquesta, substituïm les lletres per els caràcters que es troben a la dreta, circularment, és a dir, si la lletra a xifrar es troba a la dreta del tot, passaria a ser la primera per l’esquerra. Ho podem veure a la següent taula:
"
                    }
                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 300
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaPlayfair2.png"
                    }

                    TextoInformacion{
                        text: "La A es substituiria per una T i la T per una E. Seguint xifrant la frase, ara tindríem AQ. A i Q no es troben ni a la mateixa fila ni a la mateixa columna, per tant aplicaríem la regla 3. Aquesta regla es pot ser la més complexa de les 3. Tindríem que trobar les diagonals oposades. Veiem la taula:"
                    }

                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 400
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaPlayfair3.png"
                    }

                    TextoInformacion{
                        text: "Com veiem a la taula, les dues lletres, al no estar a la mateixa columna o fila, formen una diagonal. Les lletres que les substituirien serien les diagonals oposades: "
                    }

                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 400
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaPlayfair4.png"
                    }

                    TextoInformacion{
                        text: "Resultant la A en una E i la Q en una U. Seguiríem amb UE, on es tindria que aplicar la regla 3 altre vegada, moltes lletres després, ens trobaríem amb TI, on hem d’aplicar la regla 2 ja que es troben a la mateixa columna. La segona regla consisteix en substituir les lletres del parell de la frase per les que tenen a sota a la columna. Com veiem a la taula següent:"
                    }

                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 400
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaPlayfair5.png"
                    }

                    TextoInformacion{
                        text: "Resultant la T com una B i la I com una P. A partir d’aquí, amb les regles explicades, les aplicaríem amb la combinació que pertocarà. La frase xifrada resultaria en:"
                    }

                    Image{
                        Layout.alignment: Qt.AlignTop
                        Layout.preferredHeight: 400
                        Layout.preferredWidth: pInformacion.width
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/assets/tablaPlayfair6.png"
                    }

                    TextoInformacion{
                        text: "A continuació, tenim un video que no es propi, pero visualitza molt bé el xifrat PlayFair, link al original: <a href='https://www.youtube.com/watch?v=Bfsj4AZhmCM&t'>https://www.youtube.com/watch?v=Bfsj4AZhmCM&t</a> https://www.youtube.com/watch?v=Bfsj4AZhmCM&t"
                        onLinkActivated: Qt.openUrlExternally("https://www.youtube.com/watch?v=Bfsj4AZhmCM&t")
                    }

                    VideoInformacion{
                        source: "qrc:/videos/videoPlayfair.mp4"
                        onVideoBoolChanged: {
                            if(!videoBool){
                                pInformacion.Layout.minimumHeight = window.height/2
                            }
                            else{
                                pInformacion.Layout.minimumHeight = window.height/3.5
                            }
                        }
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

