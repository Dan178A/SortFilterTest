import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.4
import QtQml.Models 2.3
import QtQuick.Layouts 1.3
Window {
    id:appFramework
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10 * appFramework.displayScaleFactor

        spacing: 10 * appFramework.displayScaleFactor

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
}