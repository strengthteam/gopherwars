import QtQuick 2.2
import VPlay 2.0


Rectangle {
    id: gameBackground
    width: gridWidth
    height: width // square so height = width
    color: "#4A230B"
    radius: 5

    Grid {
        id: tileGrid
        anchors.centerIn: parent
        rows: gridSizeGame

        Repeater {
            id: cells
            model: gridSizeGameSquared
            Item {
                width: gridWidth/gridSizeGame
                height: width

                Rectangle {
                    anchors.centerIn: parent
                    width: parent.width
                    height: width // square so height = width
                    //color: "#E99C0A"
                    Image {
                        source: "../assets/hole.png"
                        anchors.fill: parent
                        x: 0
                        y: 0
                    }
//                    Rectangle {
//                        anchors.centerIn: parent
//                        width: parent.width-50
//                        height: width

////                        Image {
////                            source: "../assets/gopher.png"
////                            anchors.fill: parent
////                            x: 0
////                            y: 0
////                        }
//                    }


                }
            }
        }
    }
}
