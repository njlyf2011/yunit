import QtQuick 2.3
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3

Item {
    id: root

    property alias title: _title.text
    property alias component: loader.sourceComponent

    signal goPrevious

    Rectangle {
        anchors.fill: parent
        color: "#1B1B1B"
        opacity: 0.85
    }

    RowLayout {
        id: row
        anchors {
            left: parent.left
            right: parent.right
        }
        anchors.verticalCenter: parent.verticalCenter
        anchors.margins: units.gu(2)
        spacing: units.gu(2)

        // eater
        AbstractButton {
            id: navigationButton
            objectName: "navigationButton"
            Layout.preferredWidth: units.gu(3)
            Layout.preferredHeight: units.gu(3)
            Layout.alignment: Qt.AlignVCenter

            Icon {
                anchors.fill: parent
                name: "go-previous"
                color: "#F3F3E7"
            }

            onTriggered: {
                root.goPrevious();
            }
        }

        Label {
            id: _title
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter
            elide: Text.ElideRight
            color: "#F3F3E7"
        }

        Loader {
            id: loader
            Layout.alignment: Qt.AlignVCenter
            Layout.preferredHeight: units.gu(3)
        }
    }
}
