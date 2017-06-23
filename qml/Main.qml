import VPlay 2.0
import QtQuick 2.0

GameWindow {
    id: gameWindow
    screenWidth: 960
    screenHeight: 640

    property int gridWidth: 300
    property int gridSizeGame: 3
    property int gridSizeGameSquared: gridSizeGame*gridSizeGame
    property var emptyCells
    property var tileItems: new Array(gridSizeGameSquared)

    Rectangle {
        width: gameWindow.width
        height: gameWindow.height
    }


    EntityManager {
        id: entityManager
        entityContainer: gameContainer
    }


    Scene {
        id: scene
        width: 480
        height: 320

        Component.onCompleted: {
            // fill the main array with empty spaces
            for(var i = 0; i < gridSizeGameSquared; i++)
                tileItems[i] = null

            // collect empty cells positions
            updateEmptyCells()

            // create 2 random tiles
            createNewTile()
            //createNewTile()
        }

        Image {
            source: "../assets/grassland.jpg"
            anchors.fill: scene.gameWindowAnchorItem
            x: 0
            y: 0
        }

        Item {
            id: gameContainer
            width: gridWidth
            height: gridWidth
            anchors.centerIn: parent

            GameBackground {}

        }
        Timer {
            id: moveRelease
            interval: 300
        }

        MouseArea {
            id:mouseArea
            anchors.fill: scene.gameWindowAnchorItem

            onPressed: {

                createNewTile()
                moveRelease.start()
            }
            onReleased: {
                removeTile()
                moveRelease.start()
            }
        }

    }

    function updateEmptyCells() {
        emptyCells = []
        for (var i = 0; i < gridSizeGameSquared; i++) {
            if(tileItems[i] === null)
                emptyCells.push(i)
        }
    }

    function createNewTile() {
        var randomCellId = emptyCells[Math.floor(Math.random() * emptyCells.length)] // get random emptyCells
        var tileId = entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Tile.qml"), {"tileIndex": randomCellId}) // create new Tile with a referenceID
        tileItems[randomCellId] = entityManager.getEntityById(tileId) // paste new Tile to the array
        emptyCells.splice(emptyCells.indexOf(randomCellId), 1) // remove the taken cell from emptyCell array
    }

    function removeTile() {

        for(var i=0; i < gridSizeGameSquared; i++) {

            if(tileItems[i] !== null)
                entityManager.removeEntityById(tileItems[i])
        }

    }

}
