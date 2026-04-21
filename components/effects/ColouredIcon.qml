pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Widgets
import Caelestia

IconImage {
    id: root

    required property color colour
    property bool colorize: true   // <-- new property, default to old behaviour

    asynchronous: true

    layer.enabled: colorize        // <-- only enable when colorize is true
    layer.effect: Colouriser {
        sourceColor: analyser.dominantColour
        colorizationColor: root.colour
    }

    layer.onEnabledChanged: {
        if (layer.enabled && status === Image.Ready)
            analyser.requestUpdate()
    }

    onStatusChanged: {
        if (layer.enabled && status === Image.Ready)
            analyser.requestUpdate()
    }

    ImageAnalyser {
        id: analyser
        sourceItem: root
    }
}
