window.addEventListener('DOMContentLoaded', init, false);

function init() {
    var acceptedBars = document.getElementsByClassName('toggle');
    for (var i = 0; i < acceptedBars.length; i++) {
        acceptedBars[i].addEventListener('click', toggleTable, false);
    }
    var lines = document.getElementsByClassName('lineToggle');
    for (var i = 0; i < lines.length; i++) {
        lines[i].addEventListener('click', toggleLine, false);
    }
    var heatRec = document.getElementsByClassName('heatRec');
    for (var i = 0; i < heatRec.length; i++) {
        heatRec[i].addEventListener('click', showHide, false)
    }
}

function toggleTable() {
    var year = this.id.slice(-4);
    // get year from target
    var allTables = document.getElementsByClassName('table');
    // hide all tables, most of them redundantly
    for (var i = 0, length = allTables.length; i < length; i++) {
        allTables[i].style.display = 'none';
    }
    var activeTable = document.getElementById('accettati' + year);
    // show selected table
    activeTable.style.display = 'block';
}

function toggleLine() {
    alert('come back later!');
}

function hide_table() {
    tbody.style.display == "table-row-group";
}

function showHide() {
    var recId = this.id;
    var allHeatTables = document.getElementsByClassName("heatToggle");
    for (var i = 0, length = allHeatTables.length; i < length; i++) {
    allHeatTables[i].style.display = "none";
    }
    var onTable = document.getElementById('tbody-' + recId);
    onTable.style.display = 'table-row-group';
}