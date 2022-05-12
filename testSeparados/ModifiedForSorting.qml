import QtQuick 2.15
import QtQuick.Controls 2.12

FocusScope {
    id: focusScope
    width: 250; height: 28
    Text {
        id: typeSomething
        anchors.fill: parent; anchors.leftMargin: 8
        verticalAlignment: Text.AlignVCenter
        text: "Type here..."
        color: "gray"
        font.italic: true
    }

    MouseArea {
        anchors.fill: parent
        onClicked: { focusScope.focus = true; textInput.openSoftwareInputPanel(); }
    }

    TextInput {
        id: textInput
        anchors { left: parent.left; leftMargin: 8;rightMargin: 8; verticalCenter: parent.verticalCenter }
        focus: true
        selectByMouse: true

        onTextChanged: {
            //update list as per input from user
            container.getSortedItems(textInput.text);
            color = "red"
        }
    }
    states: State {
        name: "hasText"; when: textInput.text != ''
        PropertyChanges { target: typeSomething; opacity: 0 }
    }

    transitions: [
        Transition {
            from: ""; to: "hasText"
            NumberAnimation { exclude: typeSomething; properties: "opacity" }
        },
        Transition {
            from: "hasText"; to: ""
            NumberAnimation { properties: "opacity" }
        }
    ]

    Rectangle {
        id: container
        width: 500; height: 400
        color: "#343434"
        anchors.top: textInput.bottom
        ListModel {
            id: filteredModel

            ListElement {
                title: "Mumbai"
            }
            ListElement {
                title: "Pune"
            }
            ListElement {
                title: "Bangalore"
            }
            ListElement {
                title: "Kolkata"
            }
            ListElement {
                title: "Hyderabad"
            }
            ListElement {
                title: "Nagpur"
            }
            ListElement {
                title: "Thane"
            }
        }

        // The delegate for each item in the model:
        Component {
            id: listDelegate

            Item {
                id: delegateItem
                width: listView.width; height: 55
                clip: true

                Row {
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 10
                    Column {
                        anchors.verticalCenter: parent.verticalCenter

                        Text {
                            text: title
                            font.pixelSize: 15
                            color: "white"
                        }
                    }
                }
            }
        }

        function showAll() {
            var filteredItems = "";
            for (var i = 0; i < filteredModel.count; i++) {

                filteredItems = filteredItems + filteredModel.get(i).title;
            }
            listView.model = filteredItems;
            //filteredModel = filteredItems;
        }



    function getSortedItems(searchTerm) {

        // Clear the aux model
        filteredModel.clear();

        // Add fitting items to the aux model
        for (var i = 0; i < filteredModel.count; i++) {
            if (searchTerm === "" || filteredModel.get(i).title.indexOf(searchTerm) === 0) {
                filteredModel.append(filteredModel.get(i));
            }
        }

    }


        // The ListView:
        ListView {
            id: listView
            anchors.fill: parent; anchors.margins: 20
            model: filteredModel
            delegate: listDelegate
        }
    }
}