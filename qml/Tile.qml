import QtQuick 2.2
import VPlay 2.0

EntityBase{

    id: tile
    entityType: "Tile"

    width: gridWidth / gridSizeGame
    height: width // square so height=width

    property int tileIndex // is responsible for the position of the tile
    property int animationDuration: system.desktopPlatform ? 500 : 250

    // tile rectangle
    Rectangle {
        id: innerRect

        anchors.centerIn: parent
        width: parent.width-60
        height: width

        Image {
            source: "../assets/gopher.png"
            anchors.fill: parent
            x: 0
            y: 0
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                 scene.score++
            }
        }
    }

    // startup position calculation
    Component.onCompleted: {
        x = (width) * (tileIndex % gridSizeGame) // we get the current row and multiply with the width to get the current position
        y = (height) * Math.floor(tileIndex / gridSizeGame) // we get the current column and multiply with the width to get the current position
    }
}
