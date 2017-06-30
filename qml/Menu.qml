import VPlay 2.0
import QtQuick 2.0

Row {
    signal playPressed

    spacing: 18
    anchors.horizontalCenter: parent.horizontalCenter
    height: menuItem.height
    ImageButton {
        id: menuItem
        onClicked: {
            playPressed()
        }
        source: "../assets/playAgain.png"
    }
}
