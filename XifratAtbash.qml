import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Cifrados 1.0
import "qrc:/Items"

PageClassica {
    id: pageAtbash


    XifratsAntiga{
        id: xifrats
    }

    ColumnCifrados{
        layoutBotones.visible: false
        tTitulo.text: "Xifrat Atbash"
        tDescripccion.text: "El xifrat Atbash consisteix en la substitució de les lletres del missatge original en aquelles que estan a la mateixa distància del final de l’alfabet que l’original del principi de l’alfabet, o viceversa. La A per la Z, la B per la Y, així consecutivament. "
        tCifrado.text: xifrats.cifradoDescifradoAtbash(tNoCifrado.text);
    }
}
