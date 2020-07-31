var pics=document.getElementsByClassName("pics");
var picperpage=6;
var page=1;
var pages=Math.ceil(pics.length/picperpage);

window.onload=function(){
    for(let i=0;i<pics.length;i++){
        pics[i].classList.add(Math.floor(i/picperpage)+1);
    }
    let a=document.getElementsByClassName(page);
    for(let pic of pics){
       pic.style.display="none";
    }
    for(let pic of a){
        pic.style.display="";
    }
    num[page-1].style.fontSize="28px"
}

function move(i){
    for(let pic of pics){
        pic.style.display="none";
    }
    for(let n of num){
        n.style.fontSize="20px";
    }
    page=i;
    let a=document.getElementsByClassName(page);
    for(let pic of a){
        pic.style.display="";
    }
    num[i-1].style.fontSize="28px";
    let Reg=/#anchor/;
    if(!Reg.test(window.location.href)){
        window.location.href=window.location.href+"#anchor#anchor";
        window.location.href=window.location.href.replace("#anchor","");
        window.location.href=window.location.href+"#anchor";
    }else{
        window.location.href=window.location.href.replace("#anchor","");
        window.location.href=window.location.href+"#anchor";
    }
}

var left=document.getElementById("turnleft");
var right=document.getElementById("turnright");
var num=document.getElementsByClassName("pagenum");

left.addEventListener("click",function(){
    if(page==1){
        move(1);
    }else{
        move(page-1);
    }
})
right.addEventListener("click",function(){
    if(page==pages){
        move(pages);
    }else{
        move(page+1);
    }
})
for(let i=0;i<pages;i++){
    num[i].addEventListener("click",function(){
        move(i+1);
    })
}