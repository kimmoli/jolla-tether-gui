#ifndef TETHERING_H
#define TETHERING_H
#include <QObject>

class Tethering : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString passPhrase READ readPassPhrase() NOTIFY passPhraseChanged())


public:
    explicit Tethering(QObject *parent = 0);
    ~Tethering();

    QString readPassPhrase();
    QString connectionType();

    Q_INVOKABLE void enableTethering(QString SSID, QString passPhrase);
    Q_INVOKABLE void disableTethering();
    Q_INVOKABLE void generatePassPhrase();

signals:
    void passPhraseChanged();
    void connectionTypeChanged();

private:
    QChar randChar();
    QString m_passPhrase;

};


#endif // TETHERING_H
