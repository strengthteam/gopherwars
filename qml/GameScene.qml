import VPlay 2.0
import QtQuick 2.0

SceneBase {
    id: scene

    property int score: 0
    property int life: 5

    property bool gameIsRunning: false

    property alias entityContainer: holesContainer

    property var emptyCells

    signal menuPressed

    Component.onCompleted: {
        // fill the main array with empty spaces
        for (var i = 0; i < gridSizeGameSquared; i++)
            gopherItems[i] = null

        // collect empty cells positions
        updateEmptyCells()
    }

    Background {
        anchors.horizontalCenter: scene.gameWindowAnchorItem.horizontalCenter
        anchors.bottom: scene.gameWindowAnchorItem.bottom
    }
    Item {
        id: holesContainer
        width: gridWidth
        height: gridWidth
        anchors.centerIn: parent
        Holes {
            id: gameholes
        }
    }
    Timer {
        id: create_gopher
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            if (emptyCells.length !== 0)
                createNewgopher()
        }
    }
    Text {
        id: gamescore
        text: "Score " + scene.score
        color: "blue"
        font.pointSize: 20
        x: 360
        y: 240
        opacity: 0
        visible: opacity === 0 ? false : true
        enabled: visible
    }
    Image {
        id: gamelife
        x: 30
        y: 240
        opacity: 0
        visible: opacity === 0 ? false : true
        enabled: visible
        source: "../assets/life.png"
    }

    // overlay on game over
    GameOverScreen {
        id: gameOverStats

        onPlayPressed: scene.state = "wait"
    }

    // get-ready screen
    WaitScreen {
        id: waitToPlay
        onClicked: {
            scene.state = "play"
            create_gopher.start()
        }
    }

    onBackButtonPressed: {
        if (scene.state == "gameOver")
            mainItem.state = "menu"
        scene.state = "gameOver"
    }

    function enterScene() {
        scene.state = "wait"
    }

    function exitScene() {
        menuPressed()
    }

    function initGame() {
        updateEmptyCells()
        create_gopher.stop()
        score = 0
        life = 5
    }

    function startGame() {
        create_gopher.start()
    }

    function stopGame() {
        removegopher()
        create_gopher.stop()
    }

    function gameOver() {
        stopGame()
    }

    function updateEmptyCells() {
        emptyCells = []
        for (var i = 0; i < gridSizeGameSquared; i++) {
            if (gopherItems[i] === null)
                emptyCells.push(i)
        }
    }

    function createNewgopher() {
        updateEmptyCells()
        var randomCellId = emptyCells[Math.floor(
                                          Math.random(
                                              ) * emptyCells.length)] // get random emptyCells

        var gopherId = entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("Gophers.qml"), {
                        gopherIndex: randomCellId
                    }) // create new gopher with a referenceID
        gopherItems[randomCellId] = entityManager.getEntityById(
                    gopherId) // paste new gopher to the array

        gopherItems[randomCellId].clicked.connect(handleClick)
        gopherItems[randomCellId].life.connect(lifechanged)
        emptyCells.splice(emptyCells.indexOf(randomCellId),
                          1) // remove the taken cell from emptyCell array
    }

    function removegopher() {
        for (var i = 0; i < gridSizeGameSquared; i++) {
            if (gopherItems[i] !== null) {
                entityManager.removeEntityById(gopherItems[i].entitiyId)
                gopherItems[i] = null
            }
        }
    }

    // handle user clicks
    function handleClick() {
        // ...
        score += 1
    }
    function lifechanged() {
        life -= 1
        gamelife.opacity -= 0.2
        if (life === 0)
            scene.state = "gameOver"
    }

    state: "wait"

    states: [
        State {
            name: "wait"
            PropertyChanges {
                target: waitToPlay
                opacity: 1
            }
            PropertyChanges {
                target: gameholes
                opacity: 1
            }
            PropertyChanges {
                target: gamescore
                opacity: 1
            }
            PropertyChanges {
                target: gamelife
                opacity: 1
            }
            StateChangeScript {
                script: {
                    initGame()
                }
            }
        },
        State {
            name: "play"
            PropertyChanges {
                target: scene
                gameIsRunning: true
            }
            PropertyChanges {
                target: gameholes
                opacity: 1
            }
            PropertyChanges {
                target: gamescore
                opacity: 1
            }
            PropertyChanges {
                target: gamelife
                opacity: 1
            }

            StateChangeScript {
                script: {
                    startGame()
                }
            }
        },
        State {
            name: "gameOver"
            PropertyChanges {
                target: gameOverStats
                opacity: 1
            }
            PropertyChanges {
                target: gameholes
                opacity: 0
            }
            PropertyChanges {
                target: gamescore
                x: 200
                y: 160
                opacity: 1
            }
            PropertyChanges {
                target: gamelife
                opacity: 0
            }
            StateChangeScript {
                script: {
                    gameOver()
                }
            }
        }
    ]
}
