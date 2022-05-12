/* import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtQml.Models 2.3
Window {
    visible: true
    width: 640
    height: 480
    property bool toggle: true


    ListModel{
        id: rootModel
        onCountChanged: visualModel.setGroups()
    }

    DelegateModel {
        id: visualModel
        model: rootModel
        filterOnGroup: toggle ? 'items' : 'myGroup'
        groups: [DelegateModelGroup { id: myGroup; name: 'myGroup' }]

        function setGroups() {
            var newItem = rootModel.get(rootModel.count - 1)
            var groups;
            if (newItem.width == 80){
                groups = ['items', 'myGroup'];
            }else{
                groups = ['items'];
            }
            items.setGroups(rootModel.count - 1, 1, groups)
        }

        delegate: Rectangle {
            width: model.width
            height: model.height
            color: model.color
            border.width: 1
        }
    }

    ListView {
        width: 300
        height: 480
        model: visualModel
    }

    Rectangle {
        id: b1
        x: 350
        width: 100
        height: 50
        color: 'lightsteelblue'
        Text {
            anchors.centerIn: parent
            text: 'add 80'
        }

        MouseArea {
            anchors.fill: parent
            onClicked: rootModel.append( { width: 80, height: 30, color: 'steelblue' })
        }
    }

    Rectangle {
        id: b2
        x: 350
        y: 70
        width: 100
        height: 50
        color: 'violet'
        Text {
            anchors.centerIn: parent
            text: 'add 50'
        }

        MouseArea {
            anchors.fill: parent
            onClicked: rootModel.append( { width: 50, height: 30, color: 'violet' })
        }
    }
    Rectangle {
        id: b3
        x: 350
        y: 140
        width: 100
        height: 50
        color: 'green'
        Text {
            anchors.centerIn: parent
            text: 'filter'
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                toggle = !toggle
            }
        }
    }
} */
import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Model-View-Delegate Demo")
    id: mainWindowId
    color: "#9FA8DA"
    
    ListModel {
        id: bikeModelId
        
        ListElement {
            name: "Cube Stereo"
            type: "Fullsuspension MTB"
        }
        
        ListElement {
            name: "Trek Fuel"
            type: "Fullsuspension MTB"
        }
        
        ListElement {
            name: "Trek Slash"
            type: "Fullsuspension MTB"
        }
        
        ListElement {
            name: "Cube Nuroad"
            type: "Gravelbike"
        }
        
        ListElement {
            name: "Cube Elite"
            type: "Hardtail"
        }
    }
    
    Component {
        id: bikeDelegateId
        Rectangle {
            width: parent.width
            height: 50
            color: "#F3E5F5"
            border.color: "#4A148C"
            RowLayout {
                spacing: 2
                anchors.fill: parent
                
                Text {
                    text: name
                    font.pixelSize: 32
                    Layout.alignment: Qt.AlignLeft
                    Layout.margins: 5
                }
                Text {
                    text: type
                    font.pixelSize: 32
                    Layout.alignment: Qt.AlignCenter
                    Layout.margins: 5
                }
                
                Button {
                    text: "Delete"
                    Layout.alignment: Qt.AlignRight
                    Layout.margins: 5
                    onClicked: {
                        if (index < bikeModelId.count) {
                            bikeModelId.remove(index, 1);
                        }
                    }
                    
                }
            }
        }
    }
    
    Component {
        id: headerDelegateId
        Rectangle {
            width: parent.width; height: 50
            color: "#7B1FA2"
            RowLayout {
                spacing: 2
                anchors.fill: parent
                Text {
                    text: "Bike Model"
                    font.pixelSize: 32
                    Layout.alignment: Qt.AlignLeft
                    Layout.margins: 5
                }
                Text {
                    text: "Type"
                    font.pixelSize: 32
                    Layout.alignment: Qt.AlignRight
                    Layout.margins: 5
                }
            }
        }
    }
    
    Component {
        id: footerDelegateId
        Rectangle {
            width: parent.width; height: 50
            color: "#7B1FA2"
            Text {
                text: "Count: " + bikeModelId.count
                font.pixelSize: 32
            }
        }
    }
    
    ColumnLayout {
        anchors.fill: parent
        
        ListView {
            id: bikeViewId
            model: bikeModelId
            delegate: bikeDelegateId
            header: headerDelegateId
            footer: footerDelegateId
            
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
        
        Rectangle {
            width: parent.width
            height: 50
            color: "#F3E5F5"
            Layout.fillWidth: true
            RowLayout {
                spacing: 2
                anchors.fill: parent
                TextInput {
                    id: bikeModelInputId
                    text: "Bike Model"
                    cursorVisible: true
                    Layout.alignment: Qt.AlignLeft
                    font.pixelSize: 32
                    focus: true
                }
                ComboBox {
                    id: bikeTypeInputId
                    width: 200
                    model: [ "Fullsuspension MTB", "Gravelbike", "Hardtail" ]
                    Layout.alignment: Qt.AlignRight
                }
            }
            
            Keys.onReturnPressed: {
                bikeModelId.append({"name" : bikeModelInputId.text, "type" : bikeTypeInputId.currentText })
                bikeModelInputId.clear()
            }
        }
        
    }
    
}