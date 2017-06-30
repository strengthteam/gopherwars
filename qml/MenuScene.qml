import QtQuick 2.0
import VPlay 2.0

SceneBase {
    id: scene

    signal gamePressed
    Background {
        anchors.horizontalCenter: scene.gameWindowAnchorItem.horizontalCenter
        anchors.bottom: scene.gameWindowAnchorItem.bottom
    }

    Menu {
        anchors.centerIn: parent

        onPlayPressed: gamePressed()
    }

    onEnterPressed: {
        gamePressed()
    }
}
