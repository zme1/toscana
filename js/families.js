window.addEventListener('DOMContentLoaded', init, false);

function init(){
    var families = document.getElementsByClassName('link');
        for (var i = 0; i < families.length; i++) {
        families[i].addEventListener('click', toggleFam, false);
        }
}
function toggleFam(){
    var name = this.id;
    var paras = document.getElementsByClassName('famWrite');
        for (var i = 0, length = paras.length; i < length; i++) {
    paras[i].style.display = "none";
    }
    var onPara = document.getElementById('para-' + name);
    onPara.style.display = 'block';
}