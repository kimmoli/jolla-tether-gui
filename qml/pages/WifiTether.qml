
import QtQuick 2.0
import Sailfish.Silica 1.0
import tether.Tethering 1.0

Page
{
    id: wifiTether

    property alias passPhraseOk : passphrase.acceptableInput
    property alias ssidOk : ssid.acceptableInput
    property bool isWlan : true
    property alias ifName : tether.interfaceName
    property alias ssidName : ssid.text



    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        Column
        {
            id: column

            width: wifiTether.width
            spacing: Theme.paddingMedium
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
                font.pixelSize: Theme.fontSizeMedium
                horizontalAlignment: TextInput.AlignHCenter
                inputMethodHints: Qt.ImhPreferLowercase | Qt.ImhNoAutoUppercase | Qt.ImhSensitiveData | Qt.ImhNoPredictiveText
                validator: RegExpValidator { regExp: /^[a-zA-Z0-9]{3,}$/ }
                EnterKey.onClicked: ssid.focus = false
                onFocusChanged:
                {
                    if (ssid.focus == false)
                        tether.ssid = ssid.text
                }

            }

            TextField
            {
                id: passphrase
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - 20
                placeholderText: "Enter passphrase here"
                font.pixelSize: Theme.fontSizeMedium
                horizontalAlignment: TextInput.AlignHCenter
                inputMethodHints: Qt.ImhPreferLowercase | Qt.ImhNoAutoUppercase | Qt.ImhSensitiveData | Qt.ImhNoPredictiveText
                validator: RegExpValidator { regExp: /^[a-zA-Z0-9]{8,}$/ }
                EnterKey.onClicked:  passphrase.focus = false
                onFocusChanged:
                {
                    if (passphrase.focus == false)
                        tether.passPhrase = passphrase.text
                }
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
                enabled: ssidOk && passPhraseOk && !isWlan
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: enableTether()
            }
            Button
            {
                text: "Disable"
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: disableTether()
            }
            Label
            {
                text: "Interface is " + tether.interfaceName
                anchors.horizontalCenter: parent.horizontalCenter
                font.bold: false
            }
            Label
            {
                text: "IP address is " + tether.ipAddress
                anchors.horizontalCenter: parent.horizontalCenter
                font.bold: false
            }
            Label
            {
                visible: isWlan
                text: "please connect through\nmobile network\n(not wlan)"
                anchors.horizontalCenter: parent.horizontalCenter
                color: "red"
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
            }

        }
    }
    Tethering
    {
        id: tether
        onPassPhraseChanged: passphrase.text = tether.passPhrase
        onSsidChanged: ssid.text = tether.ssid
        onInterfaceNameChanged:
        {
            var s = "wlan"
            isWlan = (s.localeCompare(ifName.substring(0,4)) === 0)
        }
        Component.onCompleted:
        {
            tether.updateNetworkInfo()
            tether.readInitParams()
        }
    }

    Timer
    {
        interval: 1000
        running: true
        repeat: true
        onTriggered: tether.updateNetworkInfo()
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


