import sys
#https://stackoverflow.com/questions/4303561/pyqt-and-qml-how-can-i-create-a-custom-data-model
#https://stackoverflow.com/questions/58197429/pyside2-qml-populate-and-animate-gridview-model-delegate
from PySide2.QtCore import QAbstractListModel , QSortFilterProxyModel
from PySide2.QtGui import Qt
from PySide2.QtWidgets import QApplication, QWidget, QVBoxLayout, QLineEdit, QListView
class MyModel(QAbstractListModel):
    def __init__(self):
        QAbstractListModel.__init__(self)
        self.test_data = ['Test','abc', 'Test2', 'aaa', 'bbb']
        self.filtered_data = self.test_data

    def data(self, index, role):
        if role == Qt.DisplayRole:
            return self.filtered_data[index.row()]

    def rowCount(self, index):
        return len(self.filtered_data)


def text_changed():
    proxy.filter = le.text()


class SortFilterProxyModel(QSortFilterProxyModel):
    def __init__(self, parent=None):
        super().__init__(parent)
        self._filter = ""
    def filterAcceptsRow(self, sourceRow, sourceParent):
        index = self.sourceModel().index(sourceRow, 0, sourceParent)
        if self.filter:
            return self.filter in index.data()
        return True

    @property
    def filter(self):
        return self._filter
    
    @filter.setter
    def filter(self, f):
        self._filter = f
        self.invalidateFilter()


if __name__ == '__main__':
    app = QApplication(sys.argv)
    window = QWidget()

    le = QLineEdit()
    le.textChanged.connect(text_changed)
    model = MyModel()
    proxy = SortFilterProxyModel()
    proxy.setSourceModel(model)
    lv = QListView(model=proxy)

    layout = QVBoxLayout()
    layout.addWidget(le)
    layout.addWidget(lv)

    window.setLayout(layout)
    window.show()
    app.exec_()