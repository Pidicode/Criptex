import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Cifrados 1.0
import FuncionesBasicas 1.0
import "qrc:/Items"

PageClassica {
    id: pageRSA
    property bool rellenar: false

    XifratsModerna{
        id:xifrats
    }

    FB{
        id: fb
    }


    ColumnCifrados{
        id: columnaCifrados
        tCifrado.text: (tNoCifrado.text === "") ? "" : (comprobacionCifrado) ? xifrats.cifradoRSA(tNoCifrado.text, e.text, n.text) : xifrats.descifradoRSA(tNoCifrado.text, d.text, n.text)
        tTitulo.text: "RSA"
        tDescripccion.text: "El RSA és un sistema asimètric o de clau pública, és a dir, un sistema que utilitza diferents claus pel seu xifrat i desxifrat. Va ser un dels primers xifrats asimètrics, així com el més utilitzat i senzill d’implementar. Per conèixer més sobre el funcionament fes click <a href='http://www.kde.org'>aquí</a>"

        tDescripccion.onLinkActivated: {
            pInformacion.state = (pInformacion.state === "visible") ? "invisible" : "visible"
            pInformacion.visible = (pInformacion.visible === true) ? false : true
        }

        tNoCifrado.onTextChanged: {
            if(n.text === "" && e.text === "" && d.text === "" && nPrivada.text === ""){
                error.textoDialogo = "Generi la clau introduint els nombres primer q i p."
                error.open()
                tNoCifrado.clear()
            }
        }

        DialogoError{
            id: error
        }

        ColumnLayout {
            id: rowLayout
            Layout.fillHeight: true
            Layout.fillWidth: true

            RowLayout{
                spacing: 12
                Text{
                    text: "Generador de claus RSA (seleccioni abans 2 nombres primers, q i p)"
                    font.pixelSize: columnaCifrados.width/65
                }
                Button{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.maximumWidth: 125
                    Layout.maximumHeight: 50

                    Text{
                        id: textBClassica
                        anchors.centerIn: parent
                        text: qsTr("Generar clau")
                        font.pixelSize: columnaCifrados.width/65
                        opacity: 0.85
                    }

                    onClicked: {
                        if(q.text === "" && p.text === ""){
                            error.textoDialogo = "Introdueixi els dos nombres primers"
                            error.open()
                        }
                        else if(q.text === ""){
                            error.textoDialogo = "Introdueixi q"
                            error.open()
                        }
                        else if(p.text === ""){
                            error.textoDialogo = "Introdueixi p"
                            error.open()
                        }
                        else if(!fb.comprobarPrimo(p.text) && !fb.comprobarPrimo(q.text)){
                            error.textoDialogo = "Els nombres p i q no són primers"
                            error.open()
                        }
                        else if(!fb.comprobarPrimo(p.text)){
                            error.textoDialogo = "El nombre q no és primer"
                            error.open()
                        }
                        else if(!fb.comprobarPrimo(q.text)){
                            error.textoDialogo = "El nombre p no és primer"
                            error.open()
                        }

                        if(fb.comprobarPrimo(p.text)&&fb.comprobarPrimo(q.text)){
                            if(rellenar){
                                n.clear()
                                e.clear()
                                d.clear()
                                nPrivada.clear()
                            }
                            n.text = xifrats.generarClaveRSA(q.text, p.text, e.text, n.text, d.text)
                            e.text = xifrats.generarClaveRSA(q.text, p.text, e.text, n.text, d.text)
                            d.text = xifrats.generarClaveRSA(q.text, p.text, e.text, n.text, d.text)
                            nPrivada.text = n.text
                            rellenar = true
                        }
                    }
                }
            }

            RowLayout{
                Text{
                    text: qsTr("q: ")
                    font.pixelSize: columnaCifrados.width/65
                    opacity: 0.85
                }
                TextField {
                    id: q
                    selectByMouse: true
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.maximumWidth: 50
                    Layout.maximumHeight: 50
                }
                Text{
                    text: qsTr(" Clau publica (e,n): ")
                    font.pixelSize: columnaCifrados.width/65
                    opacity: 0.85
                }
                Text{
                    text: qsTr("(")
                    font.pixelSize: columnaCifrados.width/50
                    opacity: 0.85
                }
                TextField {
                    id: e
                    readOnly: true
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.maximumWidth: 50
                    Layout.maximumHeight: 50
                }
                Text{
                    text: qsTr(",")
                    font.pixelSize: columnaCifrados.width/65
                    opacity: 0.85
                }
                TextField {
                    id: n
                    readOnly: true
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.maximumWidth: 50
                    Layout.maximumHeight: 50
                }
                Text{
                    text: qsTr(")")
                    font.pixelSize: columnaCifrados.width/50
                    opacity: 0.85
                }
            }

            RowLayout{
                Text{
                    text: qsTr("p: ")
                    font.pixelSize: columnaCifrados.width/65
                    opacity: 0.85
                }
                TextField {
                    id: p
                    selectByMouse: true
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.maximumWidth: 50
                    Layout.maximumHeight: 50
                }
                Text{
                    text: qsTr(" Clau privada (d,n): ")
                    font.pixelSize: columnaCifrados.width/65
                    opacity: 0.85
                }
                Text{
                    text: qsTr("(")
                    font.pixelSize: columnaCifrados.width/50
                    opacity: 0.85
                }
                TextField {
                    id: d
                    readOnly: true
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.maximumWidth: 50
                    Layout.maximumHeight: 50
                }
                Text{
                    text: qsTr(",")
                    font.pixelSize: columnaCifrados.width/65
                    opacity: 0.85
                }
                TextField {
                    id: nPrivada
                    readOnly: true
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.maximumWidth: 50
                    Layout.maximumHeight: 50
                }
                Text{
                    text: qsTr(")")
                    font.pixelSize: columnaCifrados.width/50
                    opacity: 0.85
                }
            }
        }

        PageInformacion{
            id: pInformacion
            Layout.minimumHeight: window.height/3
            FlickableInformacion{
                ColumnLayoutInformacion{
                    id: columnaLayout

                    RowLayout{
                        spacing: 20
                        Layout.preferredWidth: pInformacion.width
                        ColumnLayout{
                            TextoInformacion{
                                text: "El RSA és un sistema asimètric o de clau pública, és a dir, un sistema que utilitza diferents claus pel seu xifrat i desxifrat. Va ser un dels primers xifrats asimètrics, així com el més utilitzat i senzill d’implementar.

El seu nom està format a partir de la lletra inicial dels cognoms dels seus autors: Ronald Rivest, Adi Shamir i Len Adleman. Aquests tres científics van publicar el xifrat per primera vegada l’any 1977, tot i que la idea d’un sistema asimètric és atribuïda a Whitfield Diffie i Martin Hellman, publicant aquest concepte al 1976."
                            }
                        }
                        Image{
                            Layout.preferredHeight: 250
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            anchors.top: parent.top
                            fillMode: Image.PreserveAspectFit
                            source: "qrc:/assets/ronaldRivest.jpg"
                        }
                    }


                    TextoInformacion{
                        textFormat: Text.RichText
                        text: "Aquest sistema de xifrat es basa en el problema de la factorització de nombres enters i la multiplicació de dos nombres primers molt grans, al voltant de 10200. N’hi han diverses formes de descompondre un nombre en els seus factors, però quan estem parlant de nombres gegants (d’entre 1.024 i 4.096 bits), computacionalment és impossible, o com a mínim extremadament ineficient, tot i la potència computacional que tenim avui dia. Tot i així, a mesura que la potència computacional augmenti, la grandària de les claus també anirà augmentant. Com a curiositat, la clau factoritzada més gran del RSA fins ara és de 768 bits, factoritzada l’any 2009, durant el transcurs de 2 anys.<br><br>Així, el sistema RSA consta de dues claus, una clau privada i altre clau pública. Aquesta clau pública l’emissor l’agafa del receptor i xifra el seu missatge, el qual tan sols podrà ser desxifrat pel receptor amb la seva clau privada. La clau pública contindrà la multiplicació de dos nombres primers, així com un valor auxiliar, mentre que la clau privada tindrà també aquesta multiplicació i un altre valor relacionat amb els nombres primers factors de la multiplicació.<br><br>A continuació, veurem els passos que segueix el sistema RSA per generar les claus pública i privada: <ol>
    <li>Agafem dos nombres primers a l’atzar, p i q, i calculem el seu producte n = p · q.</li>
    <li>Calculem, amb p i q, la funció φ d’Euler: φ(n) = (p-1)·(q-1), seguint les propietats de la funció d’Euler on φ(p) = p-1 si p és primer, així com φ(pq) = φ(p)· φ(q), resultant efectivament en φ(n) = (p-1)·(q-1).
    <li>Escollim un valor e, major a 1 i menor a φ(n), o sigui, 1≤e≤φ(n), que sigui coprimer amb φ(n). Recordem que perquè sigui coprimer, el mcd(e, φ(n)) = 1.
    <li>Calculem el valor d, sabent que e·d ≡ 1 mod (φ(n)), sent d per tant l’invers multiplicatiu en mòdul φ(n) del nombre e. Aquest valor es podrà trobar fàcilment mitjançant l’algorisme d’Euclides ampliat.</li>
    <li>La clau pública consistirà en (e,n), mentre que la clau privada serà (d,n).</li>
    </ol><br/> Amb les claus creades podem realitzar el xifrat i desxifrat del missatge. Si per exemple tenim A i B, i A vol enviar-li un missatge xifrat mitjançant el sistema RSA a B, el primer que farà A serà agafar la clau pública de B per xifrar el seu missatge, amb els valors (e,n). El xifrat consisteix en X = M<sup>e</sup> mod(n), sent X el valor xifrat i M el missatge a xifrar (en valor numèric). Si ara B vol desxifrar i llegir aquest missatge, agafarà la seva clau privada, amb (d,n), i mitjançant M = X<sup>d</sup> mod(n), trobarà el missatge original.<br><br>Per entendre-ho millor, repetirem el procés amb un exemple numèric. Abans dir que els nombres a utilitzar seran ínfims comparats amb els que s’utilitzarien en un cas real per qüestions obvies.<br><br>Comencem calculant les claus. El primer pas és calcular el producte de dos nombres primers n i q aleatoris, amb n = p·q. Diguem-ne que els nombres primers escollits són 19 i 17, amb p = 19 i q = 17. Calcularíem n = 19·17 = 323. Ara, calcularíem la funció phi d’Euler, on φ(n) = (p-1)·(q-1), per tant, φ(323) = (19-1)·(17-1) = 288. Amb la φ(n), hem d’escollir un valor e, on 1≤e≤288 i que mcd(e,288) = 1. Un coprimer possible seria el 41, per tant e = 41. A continuació, calcularíem d, sent d com hem vist l’invers multiplicatiu d’e en mòdul φ(n), o sigui 41·d ≡ 1 mod (288). L’invers, en aquest cas, seria 281, per tant d = 281. Amb els valors calculats, ja tindríem la clau pública (41,323) i la clau privada (281, 323).<br><br>Si ara volguéssim xifrar per exemple la paraula &lt;&lt;SALA&gt;&gt;, passaríem primer els valors de cada lletra a la seva correspondència a la taula ASCII &lt;&lt;83 65 76 65&gt;&gt;, i començaríem el xifrat a partir de X = M<sup>e</sup> mod(n), obtenint n i e de la clau pública del receptor. Pel primer valor, 83, tindríem X = 83<sup>41</sup> mod(323) = 49, per tant el 83 es xifraria com 49. Realitzaríem la mateixa operació amb la resta de nombres, resultant finalment: &lt;&lt;49 88 76 65&gt;&gt;.<br><br>Ara, si volguéssim desxifrar el missatge, el receptor agafaria la seva clau privada i aplicaria M = X<sup>d</sup>. Amb el primer valor 49, M = 49<sup>281</sup> mod(323) = 83, obtenint el nombre original. Si realitzem el procés amb els altres nombres obtindrem finalment el missatge original.<br><br>Ara bé, com funciona realment el xifrat RSA? Com és possible que, si xifrem el missatge a partir de X = M<sup>e</sup> (mod n), puguem desxifrar-lo amb M = X<sup>d</sup> (mod n)? Per demostrar el xifrat RSA, entraran en joc diversos teoremes.<br><br>Nosaltres coneixem el petit teorema de Fermat, el qual estableix que, si p és un nombre primer, aleshores, per cada nombre natural a coprimer amb p, a<sup>p-1</sup> ≡ 1 (mod p). Bé, si ara introduïm la funció φ d’Euler (si p és un nombre enter positiu, llavors φ(p) es defineix com el nombre d'enters positius menors o iguals a p i coprimers amb p), tenim que, φ(p), si p no és 1 i és primer, φ(p) = p – 1 (si p = 1, φ(p) = 1 ja que el 1 només té 1 coprimer, que és ell mateix). Si relacionem els dos teoremes, tenim l’anomenada generalització Fermat-Euler, amb a<sup>φ(p)</sup> = 1 (mod p).<br><br>A l’algoritme RSA, nosaltres tenim n on n = p·q, sent p i q dos nombres primers, per tant, podem expressar segons el petit teorema de Fermat que aφ(p) = 1 (mod p) així com aφ(n) = 1 (mod n). Ara bé, que fem amb n? Si mirem la propietat de la funció d’Euler, φ(p) = p – 1 si p és primer, però n, com a multiplicació de 2 primers, no té per què ser primer. Això es soluciona fàcilment ja que φ és una funció multiplicativa, i per tant compleix la propietat φ(n) = φ(pq) = φ(p)· φ(p) = (p-1)·(q-1).<br><br>Ara, si continuem l’algorisme, aquest ens demanarà un nombre e que sigui coprimer amb φ(n) per tal de tindre un invers multiplicatiu d en mòdul φ(n), o sigui, e·d ≡ 1 (mod φ(n)). Aquest producte el podem expressar també com ed = 1 + kφ(n), sent k qualsevol nombre enter. A continuació, agafaríem el missatge M, i l’elevaríem a e, elevant M<sup>e</sup> a la n, o sigui M<sup>e</sup><sup>d</sup>. Ara si desenvolupem algebraicament l’expressió, tindríem que M<sup>e</sup><sup>d</sup> = M<sup>ed</sup> = M<sup>1+kφ(n)</sup> = M<sup>kφ(n)</sup> · M =  M<sup>φ(n)</sup><sup>k</sup> · M. Aquesta última expressió M<sup>φ(n)</sup><sup>k</sup> · M, si apliquem la generalització Fermat-Euler amb a<sup>φ(p)</sup> = 1 (mod p), tindríem 1<sup>k</sup> k · M (mod n) i per tant, M (mod n). Amb tot això hem demostrat que M<sup>ed</sup> = M (mod n), però, que ens indica?<br><br>Nosaltres sabem que per realitzar el xifrat operem X = M<sup>e</sup> (mod n). Si ara volem realitzar el desxifrat, realment estem fent M<sup>d</sup> = M<sup>ed</sup> (mod n), i per tant, com M<sup>ed</sup> = M, M<sup>d</sup> = M (mod n), o el que és el mateix, M = X<sup>d</sup> (mod n), demostrant així el xifrat RSA.
"
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
