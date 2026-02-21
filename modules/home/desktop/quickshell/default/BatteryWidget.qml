import QtQuick
import QtQuick.Effects
import Quickshell
import QtQuick.Layouts

Item {
    id: root
    property int size: 30
    readonly property color color: Qt.hsla(BatterySingleton.percentage * 0.33, 1.0, 0.5, 1.0)
    property alias iconName: icon.iconName

    implicitHeight: size
    implicitWidth: icon.paintedWidth

    Image {
        id: icon
        readonly property int index: Math.min(8, Math.max(0, Math.round(BatterySingleton.percentage * 8)))
        readonly property bool isCharging: BatterySingleton.state === "Charging" || BatterySingleton.state === "Fully Charged"
        readonly property string iconName: "battery_" + (isCharging ? "c" : "") + index + ".svg"

        height: parent.height
        visible: false
        source: Qt.resolvedUrl("assets/battery/" + iconName)
        fillMode: Image.PreserveAspectFit
        sourceSize.height: parent.height
    }

    MultiEffect {
        id: iconEffect

        anchors.fill: icon
        source: icon
        colorization: 1
        colorizationColor: parent.color
    }

    HoverHandler {
        id: hoverHandler
    }

    PopupWindow {
        visible: hoverHandler.hovered
        implicitWidth: popupContainer.width
        implicitHeight: popupContainer.height
        color: "transparent"

        anchor {
            item: root
            edges: Edges.Bottom | Edges.Right
            margins.bottom: -5
        }

        Item {
            id: popupContainer
            implicitWidth: foobar.implicitWidth
            implicitHeight: foobar.implicitHeight + popupIndicator.height - popupIndicator.tipOffset

            Rectangle {
                id: popupIndicator
                readonly property real tipOffset: height / Math.sqrt(2) / 2

                width: 18
                height: 18
                rotation: 45
                radius: 2
                anchors.verticalCenter: foobar.top
                x: (popupContainer.width - root.width / 2) - width / 2 - tipOffset
            }

            Rectangle {
                id: foobar

                implicitWidth: popupLayout.implicitWidth + 10
                implicitHeight: popupLayout.implicitHeight + 10
                radius: 5
                anchors.bottom: parent.bottom

                ColumnLayout {
                    id: popupLayout

                    anchors.centerIn: parent
                    Text {
                        text: Math.round(BatterySingleton.percentage * 100) + "%"
                    }
                }
            }
        }
    }
}
