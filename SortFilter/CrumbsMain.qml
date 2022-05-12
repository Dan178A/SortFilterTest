import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.13
import QtQml.Models 2.13

ApplicationWindow {
    id: mainWindowId
    visible: true
    width: 960
    height: 540
    title: qsTr("Breadcrumbs Test")

    Rectangle {
        width: parent.width
        height: parent.height

        ColumnLayout {
            width: parent.width
            height: parent.height
            spacing: 6

            TextField {
                id: filterTextFieldId
                Layout.fillWidth: true
                Layout.preferredHeight: 40
                font {
                    family: "SF Pro Display"
                 pixelSize: 22
                }
                placeholderText: "Type Filter Expression"
                color: "dodgerblue"
                onTextChanged: filtermodel.update()
            }

            ToolBar {
                background: Rectangle {
                    color: "transparent"
                }
                RowLayout {
                    anchors.fill: parent
                    spacing: 10
                    Repeater{
                        model: navigation_manager.headers
                        ToolButton {
                            Layout.preferredHeight: 20
                            contentItem: Text {
                                text: model.modelData[1]
                                color: "#FFFFFF"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            background: Rectangle {
                                radius: 12
                                color:  "#40e0d0"
                            }
                            onClicked: navigation_manager.rootIndex = model.modelData[0]
                        }
                    }
                }
            }
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "dodgerblue"

                ListView{
                    id: view
                    anchors.fill: parent
                    anchors.margins: 12
                    model: FilterModel {
                        id: filtermodel
                        filter: function(item) {
                            return navigation_manager.filter(item.display, filterTextFieldId.text)
                        }
                        model: navigation_manager.model
                        rootIndex: navigation_manager.rootIndex
                        delegate: Rectangle {
                            height: 25
                            color:"transparent"
                            Text { 
                                text: model.display
                                color:"white"
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        if (model.hasModelChildren){
                                            navigation_manager.rootIndex = view.model.modelIndex(index)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}