import VPlay 2.0
import QtQuick 2.0

Item {
    width: gridWidth
    height: gridWidth / gridColumnSizeGame * gridRowSizeGame // square so height = width
    y: 60
    opacity: 0
    visible: opacity === 0 ? false : true
    enabled: visible

    Grid {
        id: tileGrid
        anchors.centerIn: parent
        rows: gridRowSizeGame
        columns: gridColumnSizeGame

        Repeater {
            id: cells
            model: gridSizeGameSquared
            Item {
                width: gridWidth / gridColumnSizeGame
                height: gridWidth / gridRowSizeGame

                Image {
                    source: "../assets/hole.png"
                    anchors.fill: parent
                }
            }
        }
    }
}
