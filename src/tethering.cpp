#include "tethering.h"
#include <QProcess>
#include <QTime>

Tethering::Tethering(QObject *parent) :
    QObject(parent)
{
}

Tethering::~Tethering()
{
}

QChar Tethering::randChar()
{
    int d = qrand() % 26 + 97;
    QChar c(d);
    return c;
}

QString Tethering::readPassPhrase()
{
    return m_passPhrase;
}

void Tethering::generatePassPhrase()
{
    m_passPhrase = "";

    for (int i=0 ; i<8 ; i++)
        m_passPhrase += randChar();

    emit passPhraseChanged();
}


void Tethering::enableTethering(QString SSID, QString passPhrase)
{
    QProcess p;

    QString cmd = "/usr/lib/connman/test/enable-tethering wifi " + SSID + " " + passPhrase;

    p.start("sh", QStringList() << "-c" << cmd);
    p.waitForFinished(-1);

    qWarning(p.readAll());

}

void Tethering::disableTethering()
{
    QProcess p;

    p.start("sh", QStringList() << "-c" << "/usr/lib/connman/test/disable-tethering wifi");
    p.waitForFinished(-1);

    qWarning(p.readAll());
}
