#include "tethering.h"
#include <QProcess>
#include <QTime>
#include <QNetworkInterface>
#include <QSettings>
#include <QCoreApplication>

Tethering::Tethering(QObject *parent) :
    QObject(parent)
{
    m_ipAddress = "Unknown";
    m_interfaceName = "Unknown";
    m_wlanIsUp = false;

    QTime time = QTime::currentTime();
    qsrand((uint)time.msec());

    m_ssid = "Spotless";
    m_passPhrase = "???";
}

void Tethering::readInitParams()
{
    qWarning() << "Reading initial parameters";

    QSettings settings;
    m_ssid = settings.value("ssid", "").toString();
    m_passPhrase = settings.value("passphrase", "").toString();

    qWarning() << "using " << m_ssid << " and " << m_passPhrase;

    emit passPhraseChanged();
    emit ssidChanged();

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

void Tethering::writePassPhrase(QString s)
{
    m_passPhrase = s;
}


QString Tethering::readSsid()
{
    return m_ssid;
}

void Tethering::writeSsid(QString s)
{
    m_ssid = s;
}

void Tethering::generatePassPhrase()
{
    m_passPhrase = "";

    for (int i=0 ; i<8 ; i++)
        m_passPhrase += randChar();

    qWarning() << "Generated new random passphrase " << m_passPhrase;

    emit passPhraseChanged();
}


void Tethering::enableTethering(QString SSID, QString passPhrase)
{
    QProcess p;
    QSettings settings;

    QString cmd = "/usr/lib/connman/test/enable-tethering wifi " + SSID + " " + passPhrase;

    p.start("sh", QStringList() << "-c" << cmd);
    p.waitForFinished(-1);

    qWarning() << p.readAll();

    settings.setValue("ssid", m_ssid);
    settings.setValue("passphrase", m_passPhrase);
}

void Tethering::disableTethering()
{
    QProcess p;
    QSettings settings;

    p.start("sh", QStringList() << "-c" << "/usr/lib/connman/test/disable-tethering wifi");
    p.waitForFinished(-1);

    qWarning() << p.readAll();

    settings.setValue("ssid", m_ssid);
    settings.setValue("passphrase", m_passPhrase);

}

QString Tethering::readInterfaceName()
{
    return m_interfaceName;
}

QString Tethering::readIpAddress()
{
    return m_ipAddress;
}

bool Tethering::readWlanStatus()
{
    return m_wlanIsUp;
}

void Tethering::updateNetworkInfo()
{
    m_ipAddress = "Unknown";
    m_interfaceName = "Unknown";
    m_wlanIsUp = false;

    foreach (const QHostAddress &address, QNetworkInterface::allAddresses())
    {
        if (address.protocol() == QAbstractSocket::IPv4Protocol && address != QHostAddress(QHostAddress::LocalHost))
            m_ipAddress = address.toString();
    }

    foreach (const QNetworkInterface &iface, QNetworkInterface::allInterfaces())
    {

        m_wlanIsUp = ((iface.name() == "wlan0") && iface.flags().testFlag(QNetworkInterface::IsUp));

        foreach (const QNetworkAddressEntry &entry, iface.addressEntries())
        {
            if (entry.ip().toString() == m_ipAddress)
                m_interfaceName = iface.name();
        }

    }

    qWarning() << "I got " << m_interfaceName << " ip " << m_ipAddress;

    emit interfaceNameChanged();
    emit ipAddressChanged();
    emit wlanStatusChanged();
}
