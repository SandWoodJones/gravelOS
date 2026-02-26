import QtQuick
import QtQuick.Shapes

Item {
    id: root
    required property real radius
    required property real progress
    property color color
    property real strokeWidth: 4

    implicitWidth: radius * 2
    implicitHeight: radius * 2

    Shape {
        anchors.fill: parent
        layer {
            enabled: true
            samples: 8
            smooth: true
        }

        ShapePath {
            strokeColor: "#55000000"
            strokeWidth: root.strokeWidth

            PathAngleArc {
                centerX: root.width / 2
                centerY: root.height / 2
                radiusX: (root.width / 2) - root.strokeWidth / 2
                radiusY: (root.height / 2) - root.strokeWidth / 2
                startAngle: 0
                sweepAngle: 360
            }
        }

        ShapePath {
            strokeColor: root.color
            strokeWidth: root.strokeWidth
            capStyle: ShapePath.RoundCap

            PathAngleArc {
                centerX: root.width / 2
                centerY: root.height / 2
                radiusX: (root.width / 2) - root.strokeWidth / 2
                radiusY: (root.height / 2) - root.strokeWidth / 2
                startAngle: -90
                sweepAngle: root.progress * 360
            }
        }
    }
}
