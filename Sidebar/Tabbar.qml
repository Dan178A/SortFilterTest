import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.0

Item{
    TabBar {
    id: tabBar
    x: 0
    y: 0
    width: parent.width
    height: 54
    currentIndex: tabBar.currentIndex
    background: Rectangle {
        color: "transparent"
        radius: 20
    }
    TabButton {
        id: display
        x: 0
        text: "Documents"
        font.pixelSize: parent.width * 0.05
        background: Rectangle {
            color: tabBar.currentIndex == 0 ? "#E6E4E4" : "white"
            radius: 20
            border.color: "#39000000"
        }
        contentItem: Text {
            text: display.text
            font: display.font
            opacity: enabled ? 1.0 : 0.3
            color: display.down ? "gray" : "gray"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
            
        }

    }
    TabButton {
        id: section
        x: 100
        text: "Laser Mapping"
        font.pixelSize: parent.width * 0.05
        background: Rectangle {
            color: tabBar.currentIndex == 1 ? "#E6E4E4" : "white"
            radius: 20
            border.color: "#39000000"
        }
        contentItem: Text {
            text: section.text
            font: section.font

            opacity: enabled ? 1.0 : 0.3
            color: section.down ? "gray" : "gray"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
            //font.pixelSize: 11
        }
        onClicked: {
                    inspection.source = "../NDT.qml"
                }

   }
}


}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.9;height:480;width:640}
}
##^##*/
