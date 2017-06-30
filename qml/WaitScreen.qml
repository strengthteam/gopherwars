import VPlay 2.0
import QtQuick 2.0

Item {
    width: parent.width
    height: parent.height
    y: -30
    opacity: 0
    visible: opacity === 0 ? false : true
    enabled: visible

    signal clicked

    MultiResolutionImage {
        source: "../assets/getReady.png"
        anchors.centerIn: parent
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 30
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            parent.clicked()
        }
    }
}
