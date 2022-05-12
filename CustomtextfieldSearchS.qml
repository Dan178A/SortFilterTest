import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.12



TextField {
        id: textField
        height: 40
        implicitHeight: 40

        //Custom Properties
        property color  colorDefault: "#F8B234"
        property color  colorOnfocus: "#ffffff"
        property color  colorMouseover: "#ffffff"
        property color  colorBorderOnFocus: "#ffffff"

        width: 300
        placeholderText: qsTr("Search")
         color: "#ffffff"
        clip: true
        placeholderTextColor: "#ffffff"
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
                source: "img/Capa 2.png"
                anchors.topMargin: textField.height * 0.25
                sourceSize.width: 20
                anchors.leftMargin: parent.width * 0.03
                fillMode: Image.PreserveAspectFit
                sourceSize.height: 20



            }
            ColorOverlay {
                anchors.fill: iconSearch
                source: iconSearch
                color: "#ffffff"
            }

        }

        Image {
            id: image
            y: 0
            width: 3
            height: 40
            anchors.left: parent.left
            source: "img/Rectángulo 114.png"
            anchors.leftMargin: parent.width * 0.1
            fillMode: Image.Stretch
        }

    }



/*##^##
Designer {
    D{i:0;formeditorColor:"#c0c0c0";formeditorZoom:3;height:40;width:300}D{i:2}D{i:3}
}
##^##*/
