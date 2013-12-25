#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <sailfishapp.h>
#include <QtQml>
#include <QScopedPointer>
#include <QQuickView>
#include <QQmlEngine>
#include <QGuiApplication>
#include <QQmlContext>
#include "tethering.h"
#include <QCoreApplication>

int main(int argc, char *argv[])
{
    QCoreApplication::setOrganizationDomain("KimmoLi");
    QCoreApplication::setOrganizationName("KimmoLi");
    QCoreApplication::setApplicationName("Tether");
    QCoreApplication::setApplicationVersion("0.1-1");

    qmlRegisterType<Tethering>("tether.Tethering", 1, 0, "Tethering");

    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));
    QScopedPointer<QQuickView> view(SailfishApp::createView());
    view->setSource(SailfishApp::pathTo("qml/tether.qml"));
    view->show();

    return app->exec();
}

