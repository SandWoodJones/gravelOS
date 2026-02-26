import QtQuick
import QtQuick.Effects
import Quickshell
import QtQuick.Layouts
import QtQuick.Controls

Item {
    id: root
    readonly property color color: Qt.hsla(BatterySingleton.percentage * 0.33, 1.0, 0.5, 1.0)
    readonly property bool isHovered: hoverHandler.hovered || popupHoverHandler.hovered
    property int size: 30
    property real parentRightMargin: 0
    property alias iconName: icon.iconName

    visible: BatterySingleton.display.isPresent
    implicitHeight: size
    implicitWidth: icon.paintedWidth

    onIsHoveredChanged: {
        if (isHovered) {
            hideTimer.stop()
        } else {
            hideTimer.restart()
        }
    }

    Timer {
        id: hideTimer
        interval: 100
    }    

    Image {
        id: icon
        readonly property int index: Math.min(8, Math.max(0, Math.round(BatterySingleton.percentage * 8)))
        readonly property string iconName: "battery_" + (BatterySingleton.isCharging ? "c" : "") + index + ".svg"

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
        visible: root.isHovered || hideTimer.running
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
            implicitWidth: popupRectangle.implicitWidth
            implicitHeight: popupRectangle.implicitHeight + popupIndicator.height - popupIndicator.tipOffset

            HoverHandler {
                id: popupHoverHandler
            }

            Rectangle {
                id: popupIndicator
                readonly property real size: 24
                readonly property real tipOffset: this.size / 4

                width: this.size
                height: this.size
                rotation: 45
                radius: 2

                anchors {
                    verticalCenter: popupRectangle.top
                    horizontalCenter: parent.right
                    horizontalCenterOffset: -root.width / 2 - root.parentRightMargin
                }
            }

            Rectangle {
                id: popupRectangle

                implicitWidth: popupLayout.implicitWidth + 10
                implicitHeight: popupLayout.implicitHeight + 10
                radius: 5
                anchors.bottom: parent.bottom

                ColumnLayout {
                    id: popupLayout

                    anchors.centerIn: parent
                    spacing: 10

                    RowLayout {
                        RadialProgressBarComponent {
                            color: root.color
                            radius: 26
                            progress: BatterySingleton.percentage

                            Text {
                                anchors.centerIn: parent
                                text: Math.round(BatterySingleton.percentage * 100) + "%"
                            }
                        }

                        ColumnLayout {
                            RowLayout {
                                visible: BatterySingleton.state !== "Fully Charged"

                                Text {
                                    text: BatterySingleton.isCharging ? "Time to full:" : "Remaining time:"
                                }

                                Item {
                                    Layout.fillWidth: true
                                }

                                Item {
                                    implicitWidth: timeText.width
                                    implicitHeight: timeText.height

                                    Text {
                                        id: timeText

                                        text: BatterySingleton.time
                                        opacity: BatterySingleton.isCalculatingTime ? 0 : 1
                                    }

                                    BusyIndicator {
                                        id: loadingTimeIndicator

                                        anchors.centerIn: parent
                                        visible: BatterySingleton.isCalculatingTime
                                        running: visible
                                        width: 20
                                        height: 20

                                        contentItem: Rectangle {
                                            color: "blue"
                                            radius: 7
                                            anchors.centerIn: parent

                                            RotationAnimator on rotation {
                                                running: loadingTimeIndicator.running
                                                from: 0
                                                to: 360
                                                loops: Animation.Infinite
                                                duration: 1000
                                            }
                                        }
                                    }
                                }
                            }

                            RowLayout {
                                Text {
                                    text: "Battery health:"
                                }

                                Item {
                                    Layout.fillWidth: true
                                }

                                Text {
                                    text: Math.round(BatterySingleton.health) + "%"
                                }
                            }
                        }
                    }

                    RowLayout {
                        Text {
                            text: "Manually block idling"
                            Layout.fillWidth: true
                        }

                        Switch {}
                    }
                }
            }
        }
    }
}
