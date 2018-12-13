import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Cifrados 1.0
import "qrc:/Items"

PageClassica {
    id: pageAtbash
    property int contador: 0

    ColumnCifrados{
        id: columnaCifrados
        layoutBotones.visible: false
        tCifrado.visible: false
        lineaRoja.visible: false
        tTitulo.text: "Anàlisi de freqüències"
        tDescripccion.text: "Consisteix en l’estudi de la freqüència de les lletres d’un text xifrat, determinant quines lletres o quins grups de lletres apareixen més sovint que altres. Aquesta distribució de freqüències està estretament relacionada amb la del idioma original del text xifrat. Per conèixer la història i el funcionament més detalladament fes click <a href='http://www.kde.org'>aquí</a>"
        tDescripccion.onLinkActivated: {
            pInformacion.state = (pInformacion.state === "visible") ? "invisible" : "visible"
            pInformacion.visible = (pInformacion.visible === true) ? false : true
        }
        clip: true
        RowLayout{
            id: rowFrecuencias
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 10
            Layout.preferredHeight: 350
            Layout.minimumHeight: columnaCifrados.height/1.75
            clip: true
            Repeater{
                model: ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","ñ","o","p","q","r","s","t","u","v","w","x","y","z"]
                delegate: RectanguloFrecuencias{
                    Text{
                        id: textotest
                        color: "#ffffff"
                        text: modelData
                        anchors.centerIn: parent
                    }
                }
            }
        }


        Rectangle{
            anchors.fill: rowFrecuencias
            color: "gray"
            opacity: 0.1
        }

        PageInformacion{
            id: pInformacion
            Layout.minimumHeight: window.height/3.5
            FlickableInformacion{
                ColumnLayoutInformacion{
                    id: columnaLayout
                    spacing: 20
                    TextoInformacion{
                        text: "Fins l’entrada de la Edat Mitjana, els xifrats monoalfabètics es consideraven suficientment segurs per evitar el criptoanàlisi. Això va canviar al segle IX, on Al-Kindi, filòsof, matemàtic,  astrònom i metge àrab, va publicar <i> Un manuscrit per al desxifratge de missatges criptogràfics </i>, basat en l’estudi de l’Alcorà, que facilitaria el trencament dels xifratges que coneixíem fins ara, donant-nos l’anàlisi de freqüències.<br/><br/>Per exemple, si sabem que a l’espanyol les lletres mes repetides són la E, seguida de la A i de la O, podríem deduir que una lletra d’una frase xifrada qualsevol provinent del espanyol, per exemple la A de, &lt;&lt;AEAWCA&gt;&gt;, que es repeteix, és més propensa a ser una E realment i no una altra lletra.<br/><br/>Tot i així, l’efectivitat d’aquesta tècnica és directament proporcional a la longitud del text a desxifrar. En l’anterior exemple, tot i que la A era la lletra més repetida, al ser un text molt petit, és molt probable que sigui qualsevol altra lletra i no una E. En canvi, si tinguéssim un text espanyol de moltes més paraules, diguem-ne 100, on hi ha una lletra que clarament es repeteix més que les altres, les possibilitats que sigui la lletra E són molt més grans. A més, hi ha petits detalls que ens ajuden a identificar lletres d’un xifrat. Un d’ells és la presència de dos lletres iguals juntes, per exemple &lt;&lt;WCQQO&gt;&gt;. Al català, les úniques lletres que poden estar juntes són la doble S, la LL i la doble R. Sabent això i que el xifrat prové del català, podem assegurar al 100% que aquesta Q del exemple és o una R, o una L, o una S. <br/><br/>Amb tot això, sembla que l’anàlisi de freqüències va ser una tècnica excepcional per el desxifrat de missatges, i realment sí ho va ser, semblava que tots els xifrats estaven condemnats a ser inútils enfront un exhaustiu anàlisi del missatge. No obstant, van començar a sorgir els primers xifrats polialfabètics, millorant la protecció dels missatges. El següent programa et mostra l'anàlisi de freqüències del que escriguis. Veurás com un mateix patró es repeteix depenent l'idioma. A continuació, dos imatges de l'anàlisi de freqüéncies de l'espanyol i l'anglès respectivament."
                        clip: true
                    }

                    RowLayout{
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.preferredWidth: pInformacion.width
                        Layout.topMargin: 5
                        spacing: 0
                        Image{
                            Layout.preferredHeight: 450
                            Layout.preferredWidth: parent.width/2
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectFit
                            source: "qrc:/assets/tablaAnalisisFrecuencias.jpg"
                        }
                    }
                }
            }
        }

        Component.onCompleted: {
            tNoCifrado.Layout.row = 3
            tNoCifrado.Layout.minimumHeight = 100
            pInformacion.Layout.row = 2

        }
    }
}
