window.addEventListener('DOMContentLoaded', init, false);

function init() {
    var acceptedBars = document.getElementsByClassName('toggle');
    for (var i = 0; i < acceptedBars.length; i++) {
        acceptedBars[i].addEventListener('click', toggleTable, false);
    }
}

function toggleTable() {
    var year = this.id.slice(-4); // get year from target
    var allTables = document.getElementsByClassName('table'); // hide all tables, most of them redundantly
    for (var i=0, length = allTables.length; i < length; i++) {
        allTables[i].style.display = 'none';
    }
    var activeTable = document.getElementById('accettati' + year); // show selected table
    activeTable.style.display = 'block';
}

