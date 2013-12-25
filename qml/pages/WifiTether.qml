
import QtQuick 2.0
import Sailfish.Silica 1.0
import tether.Tethering 1.0

Page
{
    id: page

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        Column
        {
            id: column

            width: page.width
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
                EnterKey.onClicked:
                {
                    ssid.focus = false
                }

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
                EnterKey.onClicked:
                {
                    passphrase.focus = false
                }

            }

            Button
            {
                text: "Generate passpharse"
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: tether.generatePassPhrase()
            }

            Button
            {
                text: "Enable"
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: tether.enableTethering(ssid.text, passphrase.text)
            }
            Button
            {
                text: "Disable"
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: tether.disableTethering()
            }

        }
    }
    Tethering
    {
        id: tether
        onPassPhraseChanged: passphrase.text = tether.passPhrase
    }
}


