import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.LocalStorage 2.0

import "Data.js" as Data

ApplicationWindow {
    id: window
    visible: true
    width: 360
    height: 480

    header: ToolBar {
        width: parent.width

        RowLayout {
            width: parent.width

            TextField {
                id: search
                Layout.fillWidth: true
                placeholderText: "Search..."

                onTextChanged: {
                    if (search.text.length > 0) {
                        Data.showSearch(search.text)
                    } else {
                        model.clear()
                    }
                }
            }

            ToolButton {
                icon.source: "icons/close.svg"
                onClicked: {
                    search.text = ""
                    search.focus = true
                }
            }
        }
    } // Header ends


    ListView {
        anchors.fill: parent

        model: ListModel {
            id: model
        }

        delegate: Row {
            width: parent.width

            Text {
                text: number
            }

            Text {
                text: title
            }
        }
    }

    Component.onCompleted: Data.init()
}