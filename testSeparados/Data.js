function showSearch(searchedText) {
    var db = LocalStorage.openDatabaseSync("test_db", "", "", 1000000)
    db.transaction(function(tx) {
        var results = tx.executeSql('SELECT * FROM test')
        var i, haystack, needle = searchedText.toUpperCase()

        model.clear()

        for (i = 0; i < results.rows.length; i++) {
            haystack = results.rows.item(i).title.toUpperCase()
            if (haystack.indexOf(needle) > -1) {
                model.append({
                    number: results.rows.item(i).number,
                    title: results.rows.item(i).title,
                    star: results.rows.item(i).star
                })
            }
        }
    })
}

function init() {
    var db = LocalStorage.openDatabaseSync("test_db", "", "", 1000000)
    try {
        db.transaction(function(tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS test (number INTEGER, title TEXT, star INTEGER)');

            var r = tx.executeSql('SELECT * FROM test');
            if (r.rows.length === 0) {
                tx.executeSql('INSERT INTO test VALUES (?, ?, ?)', [1, 'First', false]);
                tx.executeSql('INSERT INTO test VALUES (?, ?, ?)', [2, 'Second', false]);
                tx.executeSql('INSERT INTO test VALUES (?, ?, ?)', [3, 'Third', false]);
                tx.executeSql('INSERT INTO test VALUES (?, ?, ?)', [4, 'Fourth', false]);
                tx.executeSql('INSERT INTO test VALUES (?, ?, ?)', [5, 'Fifth', false]);
                tx.executeSql('INSERT INTO test VALUES (?, ?, ?)', [99, 'Ninety-ninth', false]);
            }

        })
    } catch (err) {
        console.log("Error creating table in database: " + err)
    };
}