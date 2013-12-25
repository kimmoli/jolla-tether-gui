import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"
import "cover"

ApplicationWindow
{

    initialPage: WifiTether
    {
        id: wifiTether
    }

    //cover: Qt.resolvedUrl( "cover/CoverPage.qml" )
    cover: CoverPage
    {
        id: cover
    }

    property alias passPhraseOk : wifiTether.passPhraseOk
    property alias ssidOk : wifiTether.ssidOk
    property alias isWlan: wifiTether.isWlan
    property alias ssidName : wifiTether.ssidName

    Connections
    {
        target: cover
        onEnableTether: wifiTether.enableTether()
        onDisableTether: wifiTether.disableTether()
    }
}


