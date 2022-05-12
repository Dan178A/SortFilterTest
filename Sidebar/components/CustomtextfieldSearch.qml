import QtQuick 2.15
import QtQuick.Controls 2.15


TextField {
        id: textField
        height: 40
        implicitHeight: 40

        //Custom Properties
        property color  colorDefault: "#E6E4E4"
        property color  colorOnfocus: "#ffffff"
        property color  colorMouseover: "#ffffff"
        property color  colorBorderOnFocus: "#ffffff"

        width: 300
        placeholderText: qsTr("Search")
        color: "#000000"
        clip: true
        placeholderTextColor: "#000000"
        font.family: "Poppins"
        font.pixelSize: 10
        leftPadding: 42
        rightPadding: 35

        //Create Background
        background: Rectangle{
            id:bgColor
            color: colorDefault
            radius: 10
            border.color: colorDefault
            border.width: 2
            //image search
            Image {
                id: iconSearch
                width: height
                height: parent.height / 2
                anchors.left: parent.left
                anchors.top: parent.top
                source: "../images/Capa 2.png"
                anchors.topMargin: textField.height * 0.25
                sourceSize.width: 20
                anchors.leftMargin: parent.width * 0.03
                fillMode: Image.PreserveAspectFit
                sourceSize.height: 20



            }

        }

        Image {
            id: image
            y: 0
            width: 3
            height: 40
            anchors.left: parent.left
            source: "../images/Rectángulo 114.png"
            anchors.leftMargin: parent.width * 0.1
            fillMode: Image.Stretch
        }

    }



/*##^##
Designer {
    D{i:0;formeditorColor:"#c0c0c0";formeditorZoom:3;height:40;width:300}D{i:2}D{i:3}
}
##^##*/
