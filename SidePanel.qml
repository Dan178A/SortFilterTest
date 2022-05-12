import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtQml.Models 2.3
import "Sidebar/components"
import "SortFilter"

Item{
    id: root
    property string filterText: filterField.text
    property var model
    signal itemClicked(var string);
    signal suggest(string query);
    signal search(string query);
    ListModel {
        id: nameModel
        ListElement { name: "Alice"; team: "Crypto" }
        ListElement { name: "Bob"; team: "Crypto" }
        ListElement { name: "Jane"; team: "QA" }
        ListElement { name: "Victor"; team: "QA" }
        ListElement { name: "Wendy"; team: "Graphics" }
    }
    DelegateModel {
        id: delegateModel

        //model: ModelTable {}
        model: root.model

        delegate: ItemDelegate {
            id:dele
            width: delegateModel.width

             text: `${number} + ${elevation_Max} +  ${elevation_Min} +  ${length} +  ${depth} ` 
            ///text: modelData
            onClicked: {
                    text1.text = dele.text
                }
            
             
        }

        groups: DelegateModelGroup {
            id: filterGroup
            name: "filter"
        }

        filterOnGroup: filterText.length > 0 ? "filter" : "items"

    }

    onFilterTextChanged:{
        let needleRegExp = new RegExp(filterText.replace(/[-[\]{}()*+?.,\\^$|#\s]/g, "\\$&"), "ig");

        for(let i = 0; i < delegateModel.items.count; i ++) {
            let row = delegateModel.items.get(i);
            let regNumber = needleRegExp.test(row.model.number)
            let elevation_Max = needleRegExp.test(row.model.elevation_Max)
            let elevation_Min = needleRegExp.test(row.model.elevation_Min)
            let length = needleRegExp.test(row.model.length)
            let depth = needleRegExp.test(row.model.depth)
            if(regNumber || elevation_Max || elevation_Min || length || depth){
                row.inFilter = true;
            } else {
                row.inFilter = false;
            }
        }
    }
/*     SortFilterModel {
        id: sortFilterModel
        model: nameModel
        filterAcceptsItem: function(item) {
            return item.name.includes(filterField.text)
        }
         lessThan: function(left, right) {
            if (sortByName.checked) {
                var leftVal = left.name;
                var rightVal = right.name;
            } else {
                leftVal = left.team;
                rightVal = right.team;
            }
            return leftVal < rightVal ? -1 : 1;
        } 
        delegate: Text {
            text: name + " (" + team + ")"
        }
    } */
    CustomtextfieldSearchS {
        id: filterField
        x: parent.width * 0.066
        y:  parent.height * 0.188
        width: parent.width * 0.88
        height: parent.height * 0.033
        font.pixelSize: parent.width * 0.035
        horizontalAlignment: Text.AlignLeft
        placeholderText: qsTr("Search")
        onTextChanged: sortFilterModel.update()
    }
    Row{
        id: sortFilter
        x: parent.width *0.05
        y: parent.height * 0.25
        width: parent.width *0.9
        height: parent.height*02
        anchors.horizontalCenter: parent.horizontalCenter

    RadioButton{
        text: qsTr("by number")
        width: parent.width*0.4
        height:parent.height*0.2
    }
    RadioButton{
        text: qsTr("by elevation min")
        x: parent.width *0.5
        width: parent.width*0.4
        height:parent.height*0.2
    }

    }

    ListView {
        id: rectangle
        y: parent.height *0.5
        height: parent.height*0.45
        width: parent.width*0.8
        anchors.horizontalCenter: parent.horizontalCenter
        clip: true

        model: delegateModel
//        model:sortFilterModel
        delegate: Rectangle{
            id: bg
            width:rectangle.width
            height:rectangle.height
            color:"gray"
            Text{
                id:txtbg
                font.pixelSize:12
                text: modelData
            }

        }

        ScrollIndicator.vertical: ScrollIndicator { }
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
