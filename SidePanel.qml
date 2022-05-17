import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.0
import QtQuick.Window 2.12
Item{
    id: root
    property string filterText: filterField.text
    property var model
    property var modelSelected
    
    signal itemClicked(var string);
    signal suggest(string query);
    signal search(string query);

    ColumnLayout {
        id: columnLayout
        anchors.fill: parent
        ListModel { id: todoModel }

        CustomtextfieldSearchS {
            id: filterField
            font.pixelSize: parent.width * 0.035
            horizontalAlignment: Text.AlignLeft
            Layout.topMargin: 100
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.preferredHeight: 33

            Layout.fillWidth: true
            placeholderText: qsTr("Search")
            //onTextChanged: sortFilterModel.update()
            Keys.onReturnPressed: {
                //console.log(filterField.text)
                todoModel.append({ content: filterField.text })
                filterField.text = ''
            }
        }

        RowLayout {
            id: rowLayout
            Layout.preferredHeight: 33
            Layout.fillWidth: true

            ComboBox {
                id: comboBox
                model: root.modelSelected
                Layout.preferredHeight: 23
                Layout.fillHeight: false
                Layout.preferredWidth: 200
            }


        }



        ListView {
            id: todoList
            height: 500
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop

            // use the model we defined above to render list
            model: todoModel

            Layout.fillWidth: true
            Layout.fillHeight: true

            delegate: ColumnLayout {
                width: todoList.width
                height: 55

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 15

                    // allow editing, so we could also store it on change in the future
                    TextField {
                        color: "#000000"
                        background: Item {}
                        // render data - you can write just 'content' instead of 'model.content'
                        text: model.content
                        Layout.fillWidth: true
                    }

                    RoundButton {
                        text: "\u2796" // unicode heavy minus sign
                        // remove this element from model by index
                        // each delegate inside has access to "self" index property so we
                        // can know which element this is
                        onClicked: todoModel.remove(model.index)
                        height: parent.height
                    }
                }
                Rectangle { color: "#666"; height: 1; Layout.fillWidth: true }
            }
        }






    
}
}
/*
        Connections {
            target: client
            onSuggestResultReady: setSuggestResult(query, results)
        }
    function sendQuerySuggest() {
        var suggest = searchText.text

        searchField.suggest(suggest)
    }

    function setSuggestResult(query, results) {
        suggestListModel.clear()
        for (var i = 0; i < results.length; ++i) {
            var result = results[i]

            suggestListModel.append({
                                        result: result
                                    })
        }
    }

    function sendQuerySearch(search) {
        suggestListModel.clear()
        searchField.search(search)
    }
*/ 
/*##^##
Designer {
    D{i:0;height:1000;width:374.40000000000003}
}
##^##*/
