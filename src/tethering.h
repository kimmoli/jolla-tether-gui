#ifndef TETHERING_H
#define TETHERING_H
#include <QObject>
#include <QNetworkConfiguration>

class Tethering : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString passPhrase READ readPassPhrase() WRITE writePassPhrase(QString) NOTIFY passPhraseChanged())
    Q_PROPERTY(QString ssid READ readSsid WRITE writeSsid(QString) NOTIFY ssidChanged())
    Q_PROPERTY(QString ipAddress READ readIpAddress() NOTIFY ipAddressChanged())
    Q_PROPERTY(QString interfaceName READ readInterfaceName() NOTIFY interfaceNameChanged())
    Q_PROPERTY(bool wlanIsUp READ readWlanStatus() NOTIFY wlanStatusChanged())


public:
    explicit Tethering(QObject *parent = 0);
    ~Tethering();

    QString readPassPhrase();
    QString readSsid();
    void writeSsid(QString);
    void writePassPhrase(QString s);
    QString connectionType();
    QString readIpAddress();
    QString readInterfaceName();
    bool readWlanStatus();

    Q_INVOKABLE void enableTethering(QString SSID, QString passPhrase);
    Q_INVOKABLE void disableTethering();
    Q_INVOKABLE void generatePassPhrase();
    Q_INVOKABLE void updateNetworkInfo();
    Q_INVOKABLE void readInitParams();

signals:
    void passPhraseChanged();
    void ssidChanged();
    void connectionTypeChanged();
    void ipAddressChanged();
    void interfaceNameChanged();
    void wlanStatusChanged();

private:
    QChar randChar();

    QString m_passPhrase;
    QString m_ssid;
    QString m_ipAddress;
    QString m_interfaceName;
    bool m_wlanIsUp;

    QString m_sSettingsFile;

};


#endif // TETHERING_H
