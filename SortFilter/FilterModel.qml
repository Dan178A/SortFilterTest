import QtQuick 2.13
import QtQml.Models 2.13

DelegateModel{
    property var filter: function(item) { return true; }
    function update() {
        if (items.count > 0) {
            items.setGroups(0, items.count, "items");
        }
        var visible = [];
        for (var i = 0; i < items.count; ++i) {
            var item = items.get(i);
            if (filter(item.model)) {
                visible.push(item);
            }
        }
        for(var i in visible){
            item = visible[i];
            item.inVisible = true;
        }
    }
    items.onChanged: update()
    onFilterChanged: update()
    groups: DelegateModelGroup {
        id: visibleItems
        name: "visible"
        includeByDefault: false
    }
    filterOnGroup: "visible"
}