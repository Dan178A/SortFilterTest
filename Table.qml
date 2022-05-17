import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.2

Item {
    id: root
    width: 500
    height: 400
    visible: true
    property var model
    property int maxHeight: 50
    //[!addrowdata]
    
    /////////////////////////////

    TableView{
        id :tableView
        anchors.fill: parent
        alternatingRowColors : false
        sortIndicatorVisible: true
        
        TableViewColumn {
            role: "number"
            title: "Number"
            width: tableView.viewport.width/tableView.columnCount
            horizontalAlignment: Text.AlignHCenter
        }
        TableViewColumn {
            role: "max"
            title: "Max"
            width: tableView.viewport.width/tableView.columnCount
            horizontalAlignment: Text.AlignHCenter
        }
        TableViewColumn {
            role: "min"
            title: "Min"
            width: tableView.viewport.width/tableView.columnCount
            
            horizontalAlignment: Text.AlignHCenter
        }
        TableViewColumn {
            role: "length"
            title: "Length"
            width: tableView.viewport.width/tableView.columnCount
            
            horizontalAlignment: Text.AlignHCenter
        }
        TableViewColumn {
            role: "depth"
            title: "Depth"
            width: tableView.viewport.width/tableView.columnCount
            
            horizontalAlignment: Text.AlignHCenter
        }
        //model: ModelTable{}
          model: root.model
        //Custom header proxy
        headerDelegate:Rectangle{
            color: "#0A1B2D"
            width: 100;
            height: 40
            border.color: "white"
            Text{
                anchors.centerIn : parent
                text: styleData.value
                color: "#ffffff"
                font.pixelSize: 15
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
        
        //The line agent can modify the line height information
        rowDelegate: Rectangle {
            height: maxHeight // problem text protrudes out of the row
            color: "#052641"
            anchors.leftMargin: 2
            
        }
        itemDelegate: Rectangle{
            id: rectangle
            border.color: "white"
            border.width: 1
            color : styleData.selected ? "#white": "#394755" //Extern
            Text {
                anchors.centerIn : parent
                anchors.leftMargin: 5
                color : "#ffffff"
                width: parent.width
                height: parent.height
                text: styleData.value
                font.pixelSize: 14
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.WordWrap
                
                onContentHeightChanged: {
                    if (contentHeight > maxHeight) maxHeight = contentHeight;
                }
            }
        }
        
        style: TableViewStyle{
            textColor: "white"
            highlightedTextColor: "#00CCFE" //Selected color
            backgroundColor : "#f5f5f5"
            frame: Rectangle {
                border{
                    color: "#00000000" // color of the border
                }
            }
            handle: Rectangle {
                implicitWidth: 10
                implicitHeight: 10
                radius:20
                color: "#052641"//indicador en movimiento
                border.color:"#00000000"
            }
            scrollBarBackground: Rectangle {
                implicitWidth: 10
                implicitHeight: 10
                color: "#00000000"
                border.color:"#00000000"
            }
            decrementControl: Rectangle {
                implicitWidth: 10
                implicitHeight: 10
                color: "#00000000"
                border.color:"#00000000"
            }
            incrementControl: Rectangle {
                implicitWidth: 10
                implicitHeight: 10
                color: "#00000000"
                border.color:"#00000000"
            }
            
        }
    }
}