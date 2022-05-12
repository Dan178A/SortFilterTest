import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import "controls"
import "components"
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3

Image {

    id: img_containerbtnsidemenu
    width: parent.width
    height: parent.height
    horizontalAlignment: Image.AlignLeft
    source: "images/Sin título-1.png"
    z: 0

    fillMode: Image.Stretch
    FontLoader { id: fixedFont; name: "Roboto" }


    Loader {
        id: tabbar
        x: 710
        width: parent.width * 0.817
        height: parent.height * 0.04
        anchors.top: parent.top
        source: "Tabbar.qml"
        anchors.topMargin: parent.height * 0.129
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Rectangle {
        id: content
        width: img_containerbtnsidemenu.width
        height: img_containerbtnsidemenu.height
        color: "#00000000"

        Image {
            id: img_rectangle166
            x: parent.width * 0 
            y: parent.height * 0.234
            width: parent.width * 1.035
            height: parent.height * 0.07

            source: "images/png_images/Rectángulo 166.png"
            fillMode: Image.Stretch

            CheckBox {
                id: cbAll
                x: parent.width * 0.105
                width: parent.width * 0.06

                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 34
                anchors.topMargin: 26
                indicator: Rectangle {
                    implicitWidth: 15
                    implicitHeight: 15
                    x: cbAll.leftPadding
                    y: parent.height / 2 - height / 2
                    radius: 4
                    color: "#e6e4e4"
                    border.color: "#707070"
                    Image {
                        anchors.fill: parent
                        source: "qrc:/qt-project.org/imports/QtQuick/Controls.2/images/check.png"
                        width: 14
                        height: 14
                        x: 6
                        y: 6
                        visible: cbAll.checked
                    }
                }
            }

            Custom_button_open {
                id: btn_create
                x: parent.width * 0.582
                y: parent.height * 0.13
                width: parent.width * 0.107
                height: parent.height * 0.62
                text: qsTr("Button")
                iconWidth: parent.width * 0.044
                iconHeight: parent.height * 0.24
                btnIconSource: "images/png_images/crear documento.png"
                btnColorClicked: "#00000000"
                btnColorDefault: "#00000000"

                activeMenuColorRight: "#00000000"
                activeMenuColor: "#00000000"
                btnColorMouseOver: "#00000000"
            }

            Custom_button_open {
                id: btn_add
                x: parent.width * 0.645
                y: parent.height * 0.13
                width: parent.width * 0.107
                height: parent.height * 0.62
                iconWidth: parent.width * 0.044
                iconHeight: parent.height * 0.24
                text: qsTr("Button")
                btnColorClicked: "#00000000"
                btnIconSource: "images/png_images/crear.png"
                btnColorDefault: "#00000000"

                activeMenuColorRight: "#00000000"
                activeMenuColor: "#00000000"
                btnColorMouseOver: "#00000000"
            }
            Custom_button_open {
                id: btn_delete
                x: parent.width * 0.703
                y: parent.height * 0.13
                width: parent.width * 0.107
                height: parent.height * 0.62
                iconWidth: parent.width * 0.044
                iconHeight: parent.height * 0.24
                text: qsTr("Button")
                btnIconSource: "images/png_images/eliminar1.png"
                btnColorClicked: "#00000000"
                btnColorDefault: "#00000000"

                activeMenuColorRight: "#00000000"
                activeMenuColor: "#00000000"
                btnColorMouseOver: "#00000000"
            }

            Custom_button_open {
                id: btn_download
                x: parent.width * 0.765
                y: parent.height * 0.13
                width: parent.width * 0.107
                height: parent.height * 0.62
                iconWidth: parent.width * 0.044
                iconHeight: parent.height * 0.24
                text: qsTr("Button")
                btnColorClicked: "#00000000"
                btnIconSource: "images/png_images/descargar.png"
                btnColorDefault: "#00000000"

                activeMenuColorRight: "#00000000"
                activeMenuColor: "#00000000"
                btnColorMouseOver: "#00000000"
            }

            Text {
                id: text1
                y: parent.height * 0.35
                width: parent.width * 0.169
                height: parent.height * 0.3
                text: qsTr("Select All")
                anchors.left: cbAll.right

                font.pixelSize: parent.width * 0.035
                horizontalAlignment: Text.AlignHCenter
                anchors.leftMargin: 6
            }
        }

        Image {
            id: img_line1
            x: 26
            y: parent.height * 0.173
            width: parent.width * 0.817
            height: parent.height * 0.003
            source: "images/png_images/Rectángulo 167.png"
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.Stretch
        }

        Image {
            id: img_line3
            x: 26
            y: parent.height * 0.373
            width: parent.width * 0.75
            height: parent.height * 0.002
            source: "images/png_images/Rectángulo 169.png"
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: container_sidemenu
            x: parent.width*0.01
            y: parent.height * 0.0565
            width: parent.width
            height: parent.height * 0.07
            source: "images/png_images/Rectángulo 178.png"
            fillMode: Image.PreserveAspectCrop

            Custom_button_open {
                id: btn_open_file
                x: parent.width * 0.087
                y:  parent.height * 0.14
                width: parent.width * 0.077
                height:  parent.height * 0.65
                text: qsTr("Button")
                iconWidth: parent.width * 0.077
                iconHeight: parent.height * 0.65
                btnColorMouseOver: "#00000000"
                btnColorDefault: "#00000000"
                btnColorClicked: "#00000000"
                activeMenuColorRight: "#00000000"
                activeMenuColor: "#00000000"
                btnIconSource: "images/png_images/abrir.png"
                FileDialog {
                    id: fileOpen1
                    onAccepted: {
                        backend.openFile(fileOpen.fileUrl)
                    }
                    selectMultiple: false
                    title: "Please choose a file"
                }
                onPressed: {
                    fileOpen.open()
                }

            }
            Custom_button_open {
                id: btnprint
                x: parent.width * 0.266
                y:  parent.height * 0.14
                width: parent.width * 0.077
                height: parent.height * 0.65
                text: qsTr("Button")
                iconWidth: parent.width * 0.077
                iconHeight: parent.height * 0.65
                btnIconSource: "images/png_images/imprimir.png"
                btnColorMouseOver: "#00000000"
                btnColorDefault: "#00000000"
                btnColorClicked: "#00000000"
                activeMenuColorRight: "#00000000"
                activeMenuColor: "#00000000"
            }

            Custom_button_open {
                id: btn_pdf
                x: parent.width * 0.356
                y:  parent.height * 0.14
                width: parent.width * 0.077
                height: parent.height * 0.65
                text: qsTr("Button")
                iconWidth: parent.width * 0.077
                iconHeight: parent.height * 0.41
                btnIconSource: "images/png_images/pdf.png"
                btnColorMouseOver: "#00000000"
                btnColorDefault: "#00000000"
                btnColorClicked: "#00000000"
                activeMenuColorRight: "#00000000"
                activeMenuColor: "#00000000"
            }

            Custom_button_open {
                id: btn_export
                x: parent.width * 0.448
                y:  parent.height * 0.15
                width: parent.width * 0.077
                height: parent.height * 0.65
                text: qsTr("Button")
                iconWidth: parent.width * 0.077
                iconHeight: parent.height * 0.78
                btnColorClicked: "#00000000"
                btnIconSource: "images/png_images/archivo.png"
                btnColorDefault: "#00000000"
                activeMenuColorRight: "#00000000"
                activeMenuColor: "#00000000"

                btnColorMouseOver: "#00000000"
            }

            Custom_button_open {
                id: btn_rotate
                x: parent.width * 0.537
                y:  parent.height * 0.14
                width: parent.width * 0.144
                height: parent.height * 0.65
                text: qsTr("Button")
                iconWidth: parent.width * 0.144
                iconHeight: parent.height * 0.65
                btnIconSource: "images/png_images/rotar.png"
                btnColorClicked: "#00000000"
                btnColorDefault: "#00000000"
                activeMenuColorRight: "#00000000"
                activeMenuColor: "#00000000"

                btnColorMouseOver: "#00000000"
            }

            Custom_button_open {
                id: btn_zoom_in_and_out
                x: parent.width * 0.696
                y:  parent.height * 0.15
                width: parent.width * 0.144
                height:parent.height * 0.65
                text: qsTr("Button")
                iconWidth: parent.width * 0.144
                iconHeight: parent.height * 0.5
                btnColorClicked: "#00000000"
                btnIconSource: "images/png_images/acercar.png"
                btnColorDefault: "#00000000"
                activeMenuColorRight: "#00000000"
                activeMenuColor: "#00000000"

                btnColorMouseOver: "#00000000"

            }

            Custom_button_open {
                id: btn_save
                x: parent.width * 0.17
                y: parent.height * 0.14
                width: parent.width * 0.077
                height: parent.height * 0.65
                text: qsTr("Button")
                iconWidth: parent.width * 0.077
                iconHeight: parent.height * 0.4
                btnIconSource: "images/png_images/guardar.png"
                btnColorMouseOver: "#00000000"
                btnColorDefault: "#00000000"
                btnColorClicked: "#00000000"
                activeMenuColorRight: "#00000000"
                activeMenuColor: "#00000000"
                FileDialog {
                    id: fileSave
                    onAccepted: {
                        //backend.getTextField(actualPage.getText)
                        backend.writeFile(fileSave.fileUrl)
                    }
                    selectExisting: false
                    title: "Save file"
                }
                onPressed: {
                    fileSave.open()
                }


            }
        }
        /*Column {
            id: columnData
            x: 37
            y: 335
            width: 69
            height: 99
            Repeater {
                id: repeater
                model: ["Documnents 1", "Documents 2 ", "Documents 3"]
                Button {
                    id: ratioII

                    width: 46
                    height: 23
                    text: " " + modelData
                    property bool isBlue: true
                    background: Rectangle {
                        opacity: enabled ? 1 : 0.3
                        radius: 2
                        border.color: "#0021be2b"
                        border.width: 1
                        anchors.fill: parent
                        implicitHeight: 40
                        implicitWidth: 100
                    }
                    contentItem: Text {
                        opacity: enabled ? 1.0 : 0.3
                        color: ratioII.isBlue ? "#707070": "#000000"
                        text: ratioII.text
                        font.pixelSize: 15
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: {
                        ratioII.isBlue = !ratioII.isBlue
                    }


                }


            }

        }*/

        Image {
            id: img_document1
            x: parent.width * 0.067
            y: parent.height * 0.31
            width: parent.width * 0.218
            height:  parent.height * 0.0189

            source: "images/png_images/Documents 1.png"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: img_document2
            x: parent.width * 0.067
            y: parent.height * 0.346
            height:  parent.height * 0.0189
            width: parent.width * 0.218
            source: "images/png_images/Documents 2.png"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: img_document3
            x: parent.width * 0.067
            y: parent.height * 0.382
            height: parent.height * 0.0189
            width: parent.width * 0.218
            source: "images/png_images/Documents 3.png"
            fillMode: Image.PreserveAspectFit
        }

        CustomtextfieldSearchS {
            id: textField
            x: parent.width * 0.066
            y:  parent.height * 0.188
            width: parent.width * 0.88
            height: parent.height * 0.033
            font.pixelSize: parent.width * 0.035
            horizontalAlignment: Text.AlignLeft
            placeholderText: qsTr("Search")
        }

        Image {
            id: img_line2
            x: parent.width * 0.11
            y: parent.height * 0.336
            width: parent.width * 0.75
            height: parent.height * 0.002

            source: "images/png_images/Rectángulo 168.png"
            fillMode: Image.PreserveAspectFit
        }
    }










}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.75}
}
##^##*/
