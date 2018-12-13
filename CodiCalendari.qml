import QtQuick 2.9
import QtQuick.Controls 1.4
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import SistemasDeCifrados 1.0
import "qrc:/Items"

PageClassica {
    id: pageInversion

    SistemesXifrat{
        id: sxifrats
    }

    ColumnCifrados{
        id: columnaCifrados
        tTitulo.text: "El codi calendari"
        tDescripccion.text:"El mètode calendari es un mètode de substitució força curiós i diferent. Consisteix en la utilització d'un calendari i dels seus dies del mes per realitzar el xifrat. Per conèixer el funcionament del xifrat fes click <a href='http://www.kde.org'>aquí</a> "
        tDescripccion.onLinkActivated: {
            pInformacion.state = (pInformacion.state === "visible") ? "invisible" : "visible"
            pInformacion.visible = (pInformacion.visible === true) ? false : true
        }
        function getFrase(frase, mes, ano){
            var comprobar = frase === ""
            if(comprobar === false){
                return (bDescifrarTexto.color = "gray") ? sxifrats.cifradoCodigoCalendario(frase, mes, ano) : sxifrats.descifradoCodigoCalendario(frase, mes, ano)
            }else{
                return ""
            }
        }
        tCifrado.text: getFrase(tNoCifrado.text, calendarCodiCalendari.visibleMonth, calendarCodiCalendari.visibleYear)

        Calendar {
            id: calendarCodiCalendari
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.maximumHeight: 200
            weekNumbersVisible: false
            dayOfWeekFormat: 1
            navigationBarVisible: true
            frameVisible: false
            clip: false
        }

        PageInformacion{
            id: pInformacion
            Layout.minimumHeight: window.height/3
            FlickableInformacion{
                ColumnLayoutInformacion{
                    id: columnaLayout
                    TextoInformacion{
                        text: "Diguem-ne que volem xifrar la següent frase <<ENVIAR TROPES URGENT>>. Nosaltres sabem que la E ocupa la 5ª posició a l’alfabet, la N la 14, així consecutivament. A continuació, agafem el calendari i seleccionem un mes i un any, per exemple juny de 2018."
                    }
                    RowLayout{
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.preferredWidth: pInformacion.width
                        spacing: 20
                        TextoInformacion{
                            id: test
                            text: "Amb aquest calendari, agafem la primera lletra de la nostra frase a xifrar, la E, la qual, mencionat prèviament, correspon en l’alfabet a la posició 5, i busquem a quin dia de la setmana correspon el següent nombre respecte el mes i l’any escollit. En aquest cas el 5 correspon al primer dimarts del mes, per tant podem xifrar la E com Dimarts1. Si aquest 5 en altre calendari hagués sigut el segon i no el primer dimarts del mes, tindríem Dimarts2 en comptes de Dimarts1. Per fer la nomenclatura més senzilla assignarem lletres als dies de la setmana, sent el dilluns L, el dimarts N, el dimecres M, el dijous J, el divendres V, el dissabte S i el diumenge D. Per tant, fent el mateix procés amb tota la frase obtenim <<N1 J2 V4 S2 V1 L3 M3 L3 V3 S3 N1 N3 J3 L3 J1 N1 J2 M3>>. Si el receptor vol desxifrar el missatge, té que conèixer el mes i l’any que l’emissor a utilitzat per l’encriptació."
                        }
                        Image{
                            Layout.preferredHeight: 400
                            Layout.topMargin: -50
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            fillMode: Image.PreserveAspectFit
                            source: "qrc:/assets/calendarioJunio.jpg"
                        }
                    }
                }
            }
        }

        Component.onCompleted: {
            pInformacion.Layout.row = 2
            tNoCifrado.Layout.row = 3
            layoutBotones.Layout.row = 6
            calendarCodiCalendari.Layout.row = 5
        }
    }
}
