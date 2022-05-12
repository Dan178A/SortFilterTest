/* import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.4
import QtQml.Models 2.3
import QtQuick.Layouts 1.3

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    ListModel {
        id: nameModel
        ListElement { name: "Alice"; team: "Crypto" }
        ListElement { name: "Bob"; team: "Crypto" }
        ListElement { name: "Jane"; team: "QA" }
        ListElement { name: "Victor"; team: "QA" }
        ListElement { name: "Wendy"; team: "Graphics" }
    }

    RowLayout {
        id: controls

        anchors {
            left: parent.left
            top: parent.top
            right: parent.right
        }

        TextField {
            id: nameFilter
            placeholderText: qsTr("Search by name...")
            Layout.fillWidth: true
            onTextChanged: sortFilterModel.update()
        }

        RadioButton {
            id: sortByName
            checked: true
            text: qsTr("Sort by name")
            onCheckedChanged: sortFilterModel.update()
        }

        RadioButton {
            text: qsTr("Sort by team")
        }
    }

    SortFilterModel {
        id: sortFilterModel
        model: nameModel
        filterAcceptsItem: function(item) {
            return item.name.includes(nameFilter.text)
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
    }

    ListView {
        anchors {
            left: parent.left
            top: controls.bottom
            right: parent.right
            bottom: parent.bottom
        }
        model: sortFilterModel
    }
} */
import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.4
import QtQml.Models 2.3
import QtQuick.Layouts 1.3

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    SortFilterModel {
        id: delegateModel

        lessThan: function(left, right) {
            if (view.sortLexically) {
                return left.modelData.toString() < right.modelData.toString();
            } else {
                return left.modelData < right.modelData;
            }
        }

        filterAcceptsItem: function(item) {
            return item.modelData % 2 == view.remainder;
        }

        model: numberOfItems.value
        delegate: Text {
            id: item

            text: qsTr("This is item #%1").arg(modelData)
        }
    }

    ListView {
        id: view

        property int remainder: 0
        property bool sortLexically: true

        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: controls.top
        }

        model: delegateModel
        onRemainderChanged: delegateModel.update()
        onSortLexicallyChanged: delegateModel.update()
    }

    RowLayout {
        id: controls

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        Button {
            text: qsTr("Toggle odd/even")
            onClicked: view.remainder = (view.remainder + 1) % 2;
        }

        Button {
            text: qsTr("Toggle sort")
            onClicked: view.sortLexically = !view.sortLexically
        }

        Slider {
            id: numberOfItems
            from: 10
            to: 1000
            value: 100
            Layout.fillWidth: true
        }
    }
}