pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData

            screen: modelData
            anchors {
                top: true
                left: true
                right: true
            }
            implicitHeight: 30

            RowLayout {
                id: bar

                anchors {
                    fill: parent
                    leftMargin: 10
                    rightMargin: 10
                }

                RowLayout {}

                Item {
                    Layout.fillWidth: true
                }

                RowLayout {}

                Item {
                    Layout.fillWidth: true
                }

                RowLayout {
                    ClockWidget {}
                    BatteryWidget {
                        parentRightMargin: bar.anchors.rightMargin
                    }
                }
            }
        }
    }
}
