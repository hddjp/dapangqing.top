var container = document.getElementsByClassName("container")[0];
var arrowLeft = document.getElementsByClassName("arrow_left")[0];
var arrowRight = document.getElementsByClassName("arrow_right")[0];
var wrap = document.getElementsByClassName("wrap")[0];
var buttons = document.getElementsByClassName("buttons")[0];
var order;
window.onload = function () {
    this.order = 1;
}
function move(num) {
    if (1 <= num && num <= 5) {
        buttons.children[order - 1].classList.remove("on");
        order = num;
        wrap.style.left = 600 - 600 * num + "px";
        buttons.children[order - 1].classList.add("on");
    }
    else if (num < 1) {
        move(num + 5);
    }
    else {
        move(num - 5);
    }
}
var tdgroup = document.querySelectorAll("td");

arrowLeft.addEventListener("click", function () { move(order - 1) }, false);
arrowRight.addEventListener("click", function () { move(order + 1) }, false);

var play = setInterval(function () { move(order + 1); }, 2000);
container.addEventListener("mouseover", function () {
    clearInterval(play);
});
container.addEventListener("mouseout", function () {
    play = setInterval(function () { move(order + 1); }, 2000);
});

for (let i = 0; i < 5; i++) {
    buttons.children[i].addEventListener("click", function () {
        move(i + 1);
    });
}