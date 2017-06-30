import VPlay 2.0
import QtQuick 2.0

GameWindow {
    id: window
    screenWidth: 960
    screenHeight: 640

    // You get free licenseKeys from https://v-play.net/licenseKey
    // With a licenseKey you can:
    //  * Publish your games & apps for the app stores
    //  * Remove the V-Play Splash Screen or set a custom one (available with the Pro Licenses)
    //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
    //licenseKey: "<generate one from https://v-play.net/licenseKey>"
    property alias window: window

    property int gridWidth: 270
    property int gridRowSizeGame: 3
    property int gridColumnSizeGame: 4
    property int gridSizeGameSquared: gridRowSizeGame * gridColumnSizeGame
    property var gopherItems: new Array(gridSizeGameSquared)

    activeScene: splash

    // show the splash and start the loading process as soon as the GameWindow is ready
    Component.onCompleted: {
        splash.opacity = 1
        mainItemDelay.start()
    }

    // since the splash has a fade in animation, we delay the loading of the game until the splash is fully displayed for sure
    Timer {
        id: mainItemDelay
        interval: 500
        onTriggered: {
            mainItemLoader.source = "MainItem.qml"
        }
    }

    // as soon as we set the source property, the loader will load the game
    Loader {
        id: mainItemLoader
        onLoaded: {
            if (item) {
                hideSplashDelay.start()
            }
        }
    }

    // give the game a little time to fully display before hiding the splash, just to be sure it looks smooth also on low-end devices
    Timer {
        id: hideSplashDelay
        interval: 200
        onTriggered: {
            splash.opacity = 0
        }
    }

    SplashScene {
        id: splash
    }
}
