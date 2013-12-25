
import QtQuick 2.0
import Sailfish.Silica 1.0
import tether.Tethering 1.0

Page
{
    id: wifiTether

    property alias passPhraseOk : passphrase.acceptableInput
    property alias ssidOk : ssid.acceptableInput


    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        Column
        {
            id: column

            width: wifiTether.width
            spacing: Theme.paddingLarge
            PageHeader
            {
                title: "WiFi tethering"
            }

            TextField
            {
                id: ssid
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - 20
                placeholderText: "Enter SSID here"
                text: "JollaSpot"
                font.pixelSize: Theme.fontSizeLarge
                horizontalAlignment: TextInput.AlignHCenter
                inputMethodHints: Qt.ImhPreferLowercase | Qt.ImhNoAutoUppercase | Qt.ImhSensitiveData | Qt.ImhNoPredictiveText
                validator: RegExpValidator { regExp: /^[a-zA-Z0-9]{3,}$/ }
                EnterKey.onClicked: ssid.focus = false
            }

            TextField
            {
                id: passphrase
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - 20
                placeholderText: "Enter passphrase here"
                font.pixelSize: Theme.fontSizeLarge
                horizontalAlignment: TextInput.AlignHCenter
                inputMethodHints: Qt.ImhPreferLowercase | Qt.ImhNoAutoUppercase | Qt.ImhSensitiveData | Qt.ImhNoPredictiveText
                validator: RegExpValidator { regExp: /^[a-zA-Z0-9]{8,}$/ }
                EnterKey.onClicked: passphrase.focus = false
            }

            Button
            {
                text: "Generate passphrase"
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: tether.generatePassPhrase()
            }

            Button
            {
                text: "Enable"
                enabled: ssidOk && passPhraseOk
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: enableTether()
            }
            Button
            {
                text: "Disable"
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: disableTether()
            }

        }
    }
    Tethering
    {
        id: tether
        onPassPhraseChanged: passphrase.text = tether.passPhrase
    }

    function enableTether()
    {
        if (ssidOk && passPhraseOk)
            tether.enableTethering(ssid.text, passphrase.text)
    }

    function disableTether()
    {
        tether.disableTethering()
    }
}


