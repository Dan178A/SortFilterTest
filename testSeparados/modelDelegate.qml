import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQml.Models 2.1
import QtQuick.Layouts 1.12
import QtPositioning 5.12

Window {
    id: root
    visible:  true
    width: 300; height: 400
    function listModelSort(listModel, compareFunction) {
        let indexes = [ ...Array(listModel.count).keys() ]
        indexes.sort( (a, b) => compareFunction( listModel.get(a), listModel.get(b) ) )
        let sorted = 0
        while ( sorted < indexes.length && sorted === indexes[sorted] ) sorted++
        if ( sorted === indexes.length ) return
        for ( let i = sorted; i < indexes.length; i++ ) {
            listModel.move( indexes[i], listModel.count - 1, 1 )
            listModel.insert( indexes[i], { } )
        }
        listModel.remove( sorted, indexes.length - sorted )
    }

Item {
    anchors.fill: parent
    ColumnLayout {
        anchors.fill: parent

        ListView {
            id: listView
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: ListModel {
                id: listModel
                Component.onCompleted: {
                    add( "Hawaii", 21.289373, -157.917480 )
                    add( "Los Angeles", 34.052235, -118.243683 )
                    add( "New York City", 40.730610, -73.935242 )
                    add( "Redlands", 34.0555700, -117.1825400 )
                    add( "Seattle", 47.608013, -122.335167 )
                }
                function add(city, lon, lat) {
                    const esri = QtPositioning.coordinate( 34.0572522, -117.1945814 )
                    const coord = QtPositioning.coordinate( lon, lat )
                    const distance = coord.distanceTo( esri )
                    append( { city, coord, distance } )
                }
            }

            delegate: ItemDelegate {
                text: `${city} ${(distance / 1000).toFixed(2)} km`
            }
        }

        Button {
            text: qsTr("  City  ")
            onClicked: listModelSort( listModel,
                                      (a, b) => a.city.localeCompare(b.city) )
        }

        Button {
            text: qsTr("  City (Desc)  ")
            onClicked: listModelSort( listModel,
                                      (a, b) => - a.city.localeCompare(b.city) )
        }

        Button {
            text: qsTr("  Distance to Esri  ")
            onClicked: listModelSort( listModel,
                                      (a, b) => (a.distance - b.distance) )
        }

        Button {
            text: qsTr("  Distance to Esri (Desc)  ")
            onClicked: listModelSort( listModel,
                                      (a, b) => - (a.distance - b.distance) )
        }
    }


}
     /* Component {
        id: dragDelegate

        MouseArea {
            id: dragArea

            property bool held: false

            anchors { left: parent.left; right: parent.right }
            height: content.height

            enabled: visualModel.sortOrder == visualModel.lessThan.length

            drag.target: held ? content : undefined
            drag.axis: Drag.YAxis

            onPressAndHold: held = true
            onReleased: held = false

            Rectangle {
                id: content

                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }
                width: dragArea.width; height: column.implicitHeight + 4

                border.width: 1
                border.color: "lightsteelblue"

                color: dragArea.held ? "lightsteelblue" : "white"
                Behavior on color { ColorAnimation { duration: 100 } }

                radius: 2

                Drag.active: dragArea.held
                Drag.source: dragArea
                Drag.hotSpot.x: width / 2
                Drag.hotSpot.y: height / 2

                states: State {
                    when: dragArea.held

                    ParentChange { target: content; parent: root }
                    AnchorChanges {
                        target: content
                        anchors { horizontalCenter: undefined; verticalCenter: undefined }
                    }
                }

                Column {
                    id: column
                    anchors { fill: parent; margins: 2 }

                    Text { text: 'Name: ' + name }
                    Text { text: 'Type: ' + type }
                    Text { text: 'Age: ' + age }
                    Text { text: 'Size: ' + size }
                }
            }

            DropArea {
                anchors { fill: parent; margins: 10 }

                onEntered: {
                    visualModel.items.move(
                            drag.source.DelegateModel.itemsIndex,
                            dragArea.DelegateModel.itemsIndex)
                }
            }
        }
    }
//![0]
    DelegateModel {
        id: visualModel
//![4]
        property var lessThan: [
            function(left, right) { return left.name < right.name },
            function(left, right) { return left.type < right.type },
            function(left, right) { return left.age < right.age },
            function(left, right) {
                if (left.size == "Small")
                    return true
                else if (right.size == "Small")
                    return false
                else if (left.size == "Medium")
                    return true
                else
                    return false
            }
        ]
//![4]
//![6]

        property int sortOrder: orderSelector.selectedIndex
        onSortOrderChanged: items.setGroups(0, items.count, "unsorted")

//![6]
//![3]
        function insertPosition(lessThan, item) {
            var lower = 0
            var upper = items.count
            while (lower < upper) {
                var middle = Math.floor(lower + (upper - lower) / 2)
                var result = lessThan(item.model, items.get(middle).model);
                if (result) {
                    upper = middle
                } else {
                    lower = middle + 1
                }
            }
            return lower
        }

        function sort(lessThan) {
            while (unsortedItems.count > 0) {
                var item = unsortedItems.get(0)
                var index = insertPosition(lessThan, item)

                item.groups = "items"
                items.move(item.itemsIndex, index)
            }
        }
//![3]

//![1]
        items.includeByDefault: false
//![5]
        groups: DelegateModelGroup {
            id: unsortedItems
            name: "unsorted"

            includeByDefault: true
//![1]
            onChanged: {
                if (visualModel.sortOrder == visualModel.lessThan.length)
                    setGroups(0, count, "items")
                else
                    visualModel.sort(visualModel.lessThan[visualModel.sortOrder])
            }
//![2]
        }
//![2]
//![5]
        model: PetsModel {}
        delegate: dragDelegate
    }
//![0]
    ListView {
        id: view

        anchors {
            left: parent.left; top: parent.top; right: parent.right; bottom: orderSelector.top;
            margins: 2
        }

        model: visualModel

        spacing: 4
        cacheBuffer: 50
    }

    ListSelector {
        id: orderSelector

        anchors { left: parent.left; right: parent.right; bottom: parent.bottom; margins: 2 }

        label: "Sort By"
        list: [ "Name", "Type", "Age", "Size", "Custom" ]
    }  */
}

