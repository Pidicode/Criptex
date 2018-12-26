#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include "funcionesbasicas.h"
#include "xifratsantiga.h"
#include "sistemesxifrat.h"
#include "xifratsrenaixement.h"
#include "xifratsxix.h"
#include "xifratsxx.h"
#include "xifratsmoderna.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    qputenv("QSG_RENDER_LOOP", "windows");
    qmlRegisterType<FuncionesBasicas>("FuncionesBasicas", 1, 0, "FB");
    qmlRegisterType<XifratsAntiga>("Cifrados", 1, 0, "XifratsAntiga");
    qmlRegisterType<XifratsRenaixement>("Cifrados", 1, 0, "XifratsRenaixement");
    qmlRegisterType<XifratsXIX>("Cifrados", 1, 0, "XifratsXIX");
    qmlRegisterType<XifratsXX>("Cifrados", 1, 0, "XifratsXX");
    qmlRegisterType<XifratsModerna>("Cifrados", 1, 0, "XifratsModerna");
    qmlRegisterType<SistemesXifrat>("SistemasDeCifrados", 1, 0, "SistemesXifrat");
    QQuickStyle::setStyle("Material");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
