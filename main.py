

import os
from pathlib import Path
import sys

from PySide2.QtCore import QCoreApplication, Qt, QUrl
from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine


if __name__ == "__main__":
    app = QGuiApplication(sys.argv)

    QCoreApplication.setOrganizationName("MySoft")
    QCoreApplication.setOrganizationDomain("mysoft.com")
    QCoreApplication.setApplicationName("Star Runner")

    engine = QQmlApplicationEngine()
    filename = os.fspath(Path(__file__).resolve().parent / "Main.qml")
    url = QUrl.fromLocalFile(filename)

    def handle_object_created(obj, obj_url):
        if obj is None and url == obj_url:
            QCoreApplication.exit(-1)

    engine.objectCreated.connect(handle_object_created, Qt.QueuedConnection)
    engine.load(url)

    sys.exit(app.exec_())
