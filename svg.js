window.addEventListener('DOMContentLoaded', init, false);

function init(){
    var acceptedBars = document.getElementsByClassName('toggle');
    for (var i = 0; i < acceptedBars.length; i++) {
        acceptedBars[i].addEventListener('click', toggleTable, false);
    }
}

function toggleTable() {
alert('Hi!');
}