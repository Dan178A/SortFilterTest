from PySide2 import QtCore, QtQuick, QtGui, QtWidgets, QtQml
from PySide2.QtCore import Property, QObject
import sys

crumbs_data = {
    "books": {
        "web": {
            "front-end": {
                "html": ["the missing manual", "core html5 canvas"],
                "css": ["css pocket reference", "css in depth"],
                "js": ["you don't know js", "eloquent javascript"],
            },
            "back-end": {
                "php": ["modern php", "php web services"],
                "python": [
                    "dive into python",
                    "python for everybody",
                    "Think Python",
                    "Effective Python",
                    "Fluent Python",
                ],
            },
        },
        "database": {
            "sql": {
                "mysql": ["mysql in a nutshell", "mysql cookbook"],
                "postgresql": ["postgresql up and running", "practical postgresql"],
            },
            "nosql": {
                "mongodb": ["mongodb in action", "scaling mongodb"],
                "cassandra": ["practical cassandra", "mastering cassandra"],
            },
        },
    }
}


def dict_to_model(item, d):
    if isinstance(d, dict):
        for k, v in d.items():
            it = QtGui.QStandardItem(k)
            item.appendRow(it)
            dict_to_model(it, v)
    elif isinstance(d, list):
        for v in d:
            dict_to_model(item, v)
    else:
        item.appendRow(QtGui.QStandardItem(str(d)))


class NavigationManager(QtCore.QObject):
    headersChanged = QtCore.Signal()
    rootIndexChanged = QtCore.Signal("QModelIndex")

    def __init__(self, json_data, parent=None):
        super().__init__(parent)

        self.m_model = QtGui.QStandardItemModel(self)
        dict_to_model(self.m_model.invisibleRootItem(), json_data)

        self.m_headers = []
        self.m_rootindex = QtCore.QModelIndex()
        self.rootIndexChanged.connect(self._update_headers)

        self.rootIndex = self.m_model.index(0, 0)

    def _update_headers(self, ix):
        self.m_headers = []
        while ix.isValid():
            self.m_headers.insert(0, [ix, ix.data()])
            ix = ix.parent()
        self.headersChanged.emit()

    def model(self):
        return self.m_model
    model = Property(QtCore.QObject, constant=True)

    @QtCore.Property("QVariantList", notify=headersChanged)
    def headers(self):
        return self.m_headers

    def get_root_index(self):
        return self.m_rootindex

    def set_root_index(self, ix):
        if self.m_rootindex != ix:
            self.m_rootindex = ix
            self.rootIndexChanged.emit(ix)

    rootIndex = QtCore.Property(
        "QModelIndex", fget=get_root_index, fset=set_root_index, notify=rootIndexChanged
    )

    @QtCore.Slot(str, str, result=bool)
    def filter(self, word, wilcard):
        rx = QtCore.QRegExp(wilcard)
        rx.setPatternSyntax(QtCore.QRegExp.Wildcard)
        return rx.indexIn(word) != -1


if __name__ == "__main__":
    import os
    import sys

    navigation_manager = NavigationManager(crumbs_data)

    model = QtGui.QStandardItemModel()
    app = QtWidgets.QApplication(sys.argv)
    engine = QtQml.QQmlApplicationEngine()
    engine.rootContext().setContextProperty("navigation_manager", navigation_manager)
    current_dir = os.path.dirname(os.path.realpath(__file__))
    filename = os.path.join(current_dir, "CrumbsMain.qml")
    engine.load(QtCore.QUrl.fromLocalFile(filename))
    if not engine.rootObjects():
        sys.exit(-1)
    engine.quit.connect(app.quit)
    sys.exit(app.exec_())