var container=document.getElementsByClassName("big")[0];
var big=document.getElementsByClassName("big")[1];
var pic=document.getElementsByClassName("picture")[1];
pic.addEventListener("click",function(){
    container.style.display="flex";
    document.body.style.position="fixed";
}) 
container.addEventListener("click",function(){
    container.style.display="none";
    document.body.style.position="";
})

var mirror=document.getElementById("mirror");
var biggest=document.getElementsByClassName("biggest")[0];

big.addEventListener("mouseover",function(e){
    moving(e)
})

function moving(e){
    var x = e.clientX;
    var y = e.clientY;
    var mirrorHeight = mirror.offsetHeight;
    var mirrorWidth = mirror.offsetWidth;
    mirror.style.left = x - mirrorWidth/2 + "px";
    mirror.style.top = y - mirrorHeight/2 + "px";

    biggest.style.left=-2*x+2*big.offsetLeft+mirrorWidth/2+"px";
    biggest.style.top=-2*y+2*big.offsetTop+mirrorHeight/2+"px";
}


