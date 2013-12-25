import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"
import "cover"

ApplicationWindow
{

    property alias passPhraseOk : wifiTether.passPhraseOk
    property alias ssidOk : wifiTether.ssidOk

    initialPage: WifiTether
    {
        id: wifiTether
    }

    cover: Qt.resolvedUrl( "cover/CoverPage.qml" )

    Connections
    {
        target: coverpage
        onEnableTether: WifiTether.enableTether()
        onDisableTether: WifiTether.disableTether()
    }
}


