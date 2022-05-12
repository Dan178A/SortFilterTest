import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

Window {
    width: 1920
    height: 1000
    visible: true

    Table{
        id: tableView
        x: parent.width*0
        y: parent.height*0.68
        width: parent.width*0.8
        height: parent.height*0.32
        model: ModelTable{}

    }

    SidePanel {
        id: sidepanel
        x: parent.width*0.805
        y: parent.height*0
        width: parent.width*0.195
        height: parent.height
        model: ModelTable{}
        onItemClicked: text1.text
        
    }

    Text {
        id: text1
        x: 340
        y: 186
        width: 482
        height: 138
        text: qsTr("Text")
        font.pixelSize: 25
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}
}
##^##*/
