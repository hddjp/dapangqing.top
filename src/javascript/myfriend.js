var tdone=document.getElementsByClassName("one")[0];
var tdtwo=document.getElementsByClassName("two")[0];
var tdthree=document.getElementsByClassName("three")[0];
var divone=document.getElementsByClassName("one")[1];
var divtwo=document.getElementsByClassName("two")[1];
var divthree=document.getElementsByClassName("three")[1];

window.onload=function(){
    var a=window.location.href;
    if(a.charAt(a.length-1)==1){
        tdone.classList.add("choose");
        divtwo.style.display="none";
        divthree.style.display="none";
    }else if(a.charAt(a.length-1)==2){
        tdtwo.classList.add("choose");
        divone.style.display="none";
        divthree.style.display="none";
    }else if(a.charAt(a.length-1)==3){
        tdthree.classList.add("choose");
        divone.style.display="none";
        divtwo.style.display="none";
    }else{
        tdone.classList.add("choose");
        divtwo.style.display="none";
        divthree.style.display="none";
    }
}

tdone.addEventListener("click",function(){
    document.getElementsByClassName("choose")[0].classList.remove("choose");
    tdone.classList.add("choose");
    divone.style.display="";
    divtwo.style.display="none";
    divthree.style.display="none";
});

tdtwo.addEventListener("click",function(){
    document.getElementsByClassName("choose")[0].classList.remove("choose");
    tdtwo.classList.add("choose");
    divone.style.display="none";
    divtwo.style.display="";
    divthree.style.display="none";
});

tdthree.addEventListener("click",function(){
    document.getElementsByClassName("choose")[0].classList.remove("choose");
    tdthree.classList.add("choose");
    divone.style.display="none";
    divtwo.style.display="none";
    divthree.style.display="";
});