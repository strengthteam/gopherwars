import VPlay 2.0
import QtQuick 2.0

Item {
    width: parent.width
    height: parent.height
    y: -30
    opacity: 0
    visible: opacity === 0 ? false : true
    enabled: visible

    signal playPressed
    signal networkPressed
    signal useCoinsPressed

    MultiResolutionImage {
        source: "../assets/gameOver.png"
        anchors.centerIn: parent
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 30
    }

    Menu {
        x: 240
        y: 240
        onPlayPressed: parent.playPressed()
    }
}
