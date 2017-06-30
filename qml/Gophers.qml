import QtQuick 2.2
import VPlay 2.0

EntityBase {

    id: gophers
    entityType: "gophers"

    width: gridWidth / gridColumnSizeGame
    height: gridWidth / gridRowSizeGame // square so height=width

    property int gopherIndex
    // emit a signal when block is clicked
    signal clicked
    signal life

    // gopher rectangle
    Item {
        id: innerRect

        anchors.centerIn: parent
        width: parent.width / 2
        height: width

        Image {
            id: gopherImage
            opacity: 0
            source: "../assets/gopher.png"
            anchors.fill: parent
        }
        Image {
            id: gopher_yun_image
            opacity: 0
            source: "../assets/gopher_yun.png"
            anchors.fill: parent
        }
        Image {
            id: gopher_out_image
            opacity: 1
            source: "../assets/gopher_out.png"
            anchors.fill: parent
        }
        Image {
            id: hammer
            width: parent.width
            height: width
            x: 20
            y: -20
            opacity: 0
            source: "../assets/hammer.png"
        }

        // handle click event on blocks (trigger clicked signal)
        MouseArea {
            anchors.fill: parent
            onClicked: {
                gophers.clicked()
                gopherImage.opacity = 0
                gopher_yun_image.opacity = 1
                hammer.opacity = 1
                removegopher.start()
                autoremove.stop()
            }
        }

        //        Timer {
        //            id: usehammer
        //            interval: 300
        //            running: false
        //            onTriggered: {
        //                hammer.opacity = 1
        //            }
        //        }
        Timer {
            interval: 300
            running: true
            onTriggered: {
                gopher_out_image.opacity = 0
                gopherImage.opacity = 1
            }
        }
        Timer {
            id: removegopher
            interval: 500
            running: false
            onTriggered: {
                gophers.removeEntity(gopherIndex)
                gopherItems[gopherIndex] = null
            }
        }
    }

    Timer {
        id: autoremove
        interval: 1500
        running: true
        onTriggered: {
            gophers.removeEntity(gopherIndex)
            gopherItems[gopherIndex] = null
            life()
        }
    }

    //startup position calculation
    Component.onCompleted: {
        x = (width) * (gopherIndex % gridColumnSizeGame) // we get the current row and multiply with the width to get the current position
        y = (height) * (gopherIndex % gridRowSizeGame)
                + 30 // we get the current column and multiply with the width to get the current position
    }
}
