import VPlay 2.0
import QtQuick 2.0

Item {
    id: mainItem
    property alias entityManager: entityManager

    // for easier reference from GameOverScreen
    property int coins

    MenuScene {
        id: menuScene
        onGamePressed: {
            mainItem.state = "game"
        }
        onBackButtonPressed: {
            nativeUtils.displayMessageBox("Really quit the game?", "", 2)
        }

        Connections {
            // nativeUtils should only be connected, when this is the active scene
            target: window.activeScene === menuScene ? nativeUtils : null
            onMessageBoxFinished: {
                if (accepted) {
                    Qt.quit()
                }
            }
        }
    }

    GameScene {
        id: gameScene

        onMenuPressed: {
            mainItem.state = "menu"
        }
    }

    EntityManager {
        id: entityManager
        // entities shall only be created in the gameScene
        entityContainer: gameScene.entityContainer
    }

    state: "menu"

    states: [
        State {
            name: "menu"
            PropertyChanges {
                target: menuScene
                opacity: 1
            }
            PropertyChanges {
                target: window
                activeScene: menuScene
            }
        },
        State {
            name: "game"
            PropertyChanges {
                target: gameScene
                opacity: 1
            }
            PropertyChanges {
                target: window
                activeScene: gameScene
            }
            StateChangeScript {
                script: {
                    gameScene.enterScene()
                }
            }
        }
    ]
}
